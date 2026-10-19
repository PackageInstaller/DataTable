using System;
using ACT.Battle;
using ACT.Sound;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractMovingPlatform")]
public class InteractMovingPlatform : StateObjectBase
{
	private enum PlatformPhase
	{
		Stopped,
		Waiting,
		Moving
	}

	[SerializeField]
	[Header("模型挂点")]
	private Transform _wrap;

	[SerializeField]
	[Header("交互提示位置")]
	private Transform _tipIconTransform;

	private AssetLoadHandle _modelHandle;

	private Rigidbody _rig;

	private InteractEntry _entry;

	private Animator _animator;

	private MovingPlatformData _data;

	private SystemTime _systemTime;

	private PlatformPhase _phase;

	private int _currentPointIndex;

	private int _targetPointIndex;

	private int _manualTargetPointIndex;

	private int _autoRunState;

	private bool _stopAfterArrival;

	private bool _platformAvailable;

	private float _waitElapsed;

	private uint _runLoopSoundId;

	private Vector3 _moveStartPosition;

	private Quaternion _moveStartRotation;

	private float _moveElapsedTime;

	private float _moveDuration;

	private float _rotateDuration;

	public override bool serviceSave => true;

	private bool CanUseManualEntry
	{
		get
		{
			if (_platformAvailable && _entry != null)
			{
				MovingPlatformData data = _data;
				if (data != null && data.runMode == MovingPlatformRunMode.Manual)
				{
					return _phase == PlatformPhase.Stopped;
				}
			}
			return false;
		}
	}

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is MovingPlatformData data)
		{
			_data = data;
			InitializePlatform(stateId);
			if (_data.runMode == MovingPlatformRunMode.Manual)
			{
				CreateEntry(compStateObject.StateWorldAssetData);
			}
			base.InitStateObject(stateId);
		}
	}

	private void InitializePlatform(int initStateId)
	{
		_systemTime = GameManager.timeSystem;
		if (_wrap == null)
		{
			Debug.LogError(name + " 的移动平台缺少模型挂点 Wrap。", this);
			return;
		}
		if (_data.modelAssetID == null || !_data.modelAssetID.RuntimeKeyIsValid())
		{
			Debug.LogError(name + " 的移动平台缺少有效的平台模型资源。", this);
			return;
		}
		_rig = GetComponent<Rigidbody>();
		_platformAvailable = _rig != null && _data.runningPoints.Length != 0;
		if (!_platformAvailable)
		{
			Debug.LogError(name + " 的移动平台模型需要 Rigidbody，且配置至少一个运行点位。", this);
			return;
		}
		_rig.interpolation = RigidbodyInterpolation.Interpolate;
		InitModel();
		int value = ((_data.runMode == MovingPlatformRunMode.Auto) ? _data.initialPointIndex : initStateId);
		_currentPointIndex = Mathf.Clamp(value, 0, _data.runningPoints.Length - 1);
		_targetPointIndex = _currentPointIndex;
		_manualTargetPointIndex = _currentPointIndex;
		_autoRunState = 0;
		_stopAfterArrival = false;
		_waitElapsed = 0f;
		ResetMoveProgress(_data.runningPoints[_currentPointIndex].position, _data.runningPoints[_currentPointIndex].position, 0f);
		SetPlatformPose(_data.runningPoints[_currentPointIndex].position);
		_phase = PlatformPhase.Stopped;
	}

	private void InitModel()
	{
		_modelHandle = AssetStationManager.BattleStation.Instantiate(_data.modelAssetID, _wrap);
		GameObject gameObject = _modelHandle.AsGameObject();
		_animator = ((gameObject != null) ? gameObject.GetComponentInChildren<Animator>() : null);
		if (gameObject != null)
		{
			PushImpetusGameObject componentInChildren = gameObject.GetComponentInChildren<PushImpetusGameObject>();
			if (componentInChildren != null)
			{
				componentInChildren.InitConfig(_data.PushImpetusData);
			}
		}
	}

	private void CreateEntry(StateWorldAssetData assetData)
	{
		if (_data.runMode != MovingPlatformRunMode.Manual || _data.entryConfig == null)
		{
			return;
		}
		InteractType interactType = _data.entryConfig.InteractType;
		if (interactType == InteractType.Button || interactType == InteractType.TriggerEnter)
		{
			_entry = new InteractEntry();
			_entry.Clone(_data.entryConfig);
			if (_tipIconTransform != null)
			{
				_tipIconTransform.position = _data.TipIconPos;
				_entry.ResetTipTransform(_tipIconTransform);
			}
			BoxCollider boxCollider = GetComponent<BoxCollider>();
			if (boxCollider == null)
			{
				boxCollider = gameObject.AddComponent<BoxCollider>();
			}
			boxCollider.size = _data.TriggerField.size;
			boxCollider.center = _data.TriggerField.center;
			boxCollider.isTrigger = true;
			InteractEntry entry = _entry;
			entry.onInteract = (Action<Entity>)Delegate.Combine(entry.onInteract, new Action<Entity>(OnEntryInteracted));
			_entry.BindInteractObjectBase(this);
			_entry.BindData(assetData);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (ApplyState(stateId))
		{
			_entry?.BindInteractState(stateId, 0);
			_entry?.HandleInit();
		}
		base.HandleInitState(stateId);
	}

	protected override void HandleUninitState(int stateId)
	{
		_entry?.HandleUninit();
		base.HandleUninitState(stateId);
	}

	private bool ApplyState(int stateId)
	{
		if (!_platformAvailable || _data == null)
		{
			return false;
		}
		if (!CheckStateIdValid(stateId))
		{
			string arg = ((_data.runMode == MovingPlatformRunMode.Auto) ? "0、1、2" : $"0 ~ {_data.runningPoints.Length - 1}");
			Debug.LogError($"{name} 的移动平台收到无效状态 {stateId}，当前模式仅支持状态 {arg}。", this);
			return false;
		}
		if (_data.runMode == MovingPlatformRunMode.Auto)
		{
			ApplyAutoState(stateId);
		}
		else
		{
			ApplyManualState(stateId);
		}
		return true;
	}

	private void ApplyAutoState(int stateId)
	{
		_autoRunState = stateId;
		if (stateId == 0)
		{
			if (_phase == PlatformPhase.Waiting)
			{
				_phase = PlatformPhase.Stopped;
			}
			else if (_phase == PlatformPhase.Moving)
			{
				_stopAfterArrival = true;
			}
		}
		else
		{
			_stopAfterArrival = false;
			if (_phase == PlatformPhase.Stopped)
			{
				StartMoveTo(GetNextPointIndex(IsReverse()));
			}
		}
	}

	private void ApplyManualState(int targetPointIndex)
	{
		_manualTargetPointIndex = targetPointIndex;
		if (_phase == PlatformPhase.Moving && IsInstantMoveTo(_manualTargetPointIndex))
		{
			StartMoveTo(_manualTargetPointIndex);
		}
		else if (_manualTargetPointIndex != _currentPointIndex)
		{
			if (_phase == PlatformPhase.Stopped)
			{
				StartManualMoveOrEnterWaiting();
			}
			else if (_phase == PlatformPhase.Waiting && IsNextManualPointInstant())
			{
				StartManualMoveOrEnterWaiting();
			}
		}
	}

	private void OnEntryInteracted(Entity entity)
	{
		if (CanUseManualEntry)
		{
			NetEnterState(GetNextClockwisePointIndex()).Forget();
		}
	}

	protected override void HandleEnterInteract()
	{
		_entry?.HandleEnter();
	}

	protected override void HandleExitInteract()
	{
		_entry?.HandleExit();
	}

	public override void Interact(int entryIndex, Entity entity, InteractAction.InteractSource interactSource)
	{
		if (CanUseManualEntry)
		{
			_entry?.HandleInteract(entity, interactSource);
		}
	}

	public override bool CanInteract()
	{
		if (CanUseManualEntry)
		{
			return base.CanInteract();
		}
		return false;
	}

	public override bool ShowInteractTip()
	{
		if (CanUseManualEntry)
		{
			return base.ShowInteractTip();
		}
		return false;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (!CanUseManualEntry)
		{
			return ShowType.Hide;
		}
		return base.GetInteractBtnShowType();
	}

	private void FixedUpdate()
	{
		if (_platformAvailable && MonoECS.instance.running)
		{
			switch (_phase)
			{
			case PlatformPhase.Waiting:
				UpdateWaiting();
				break;
			case PlatformPhase.Moving:
				UpdateMoving();
				break;
			}
		}
	}

	private void UpdateWaiting()
	{
		if (_data.runMode == MovingPlatformRunMode.Auto && _autoRunState == 0)
		{
			_phase = PlatformPhase.Stopped;
			return;
		}
		_waitElapsed += GetScaledFixedDeltaTime();
		if (!(_waitElapsed < _data.runningPoints[_currentPointIndex].waitingTime))
		{
			if (_data.runMode == MovingPlatformRunMode.Auto)
			{
				StartMoveTo(GetNextPointIndex(IsReverse()));
			}
			else if (_currentPointIndex == _manualTargetPointIndex)
			{
				_phase = PlatformPhase.Stopped;
			}
			else
			{
				StartMoveTo(GetNextManualPointIndex());
			}
		}
	}

	private void UpdateMoving()
	{
		float num = _moveElapsedTime + GetScaledFixedDeltaTime();
		MovingPlatformPoint obj = _data.runningPoints[_targetPointIndex];
		Vector3 b = obj.position;
		Quaternion rotate = obj.position.rotate;
		Vector3 position = Vector3.Lerp(_moveStartPosition, b, CalculateMoveProgress(num, _moveDuration));
		Quaternion rot = Quaternion.Slerp(_moveStartRotation, rotate, CalculateMoveProgress(num, _rotateDuration));
		_rig.MovePosition(position);
		_rig.MoveRotation(rot);
		_moveElapsedTime = num;
		if (_moveElapsedTime >= _moveDuration && _moveElapsedTime >= _rotateDuration)
		{
			OnArrivePoint();
		}
	}

	private void OnArrivePoint()
	{
		_currentPointIndex = _targetPointIndex;
		PlayStopMoveSounds();
		ApplyLinkageStateChanges(isStartMoving: false);
		ApplyArrivalStateChanges();
		if (_data.runMode == MovingPlatformRunMode.Auto)
		{
			if (_stopAfterArrival || _autoRunState == 0)
			{
				_stopAfterArrival = false;
				_phase = PlatformPhase.Stopped;
			}
			else
			{
				_waitElapsed = 0f;
				_phase = PlatformPhase.Waiting;
			}
		}
		else if (_currentPointIndex == _manualTargetPointIndex)
		{
			_phase = PlatformPhase.Stopped;
		}
		else
		{
			StartManualMoveOrEnterWaiting();
		}
	}

	private int GetNextClockwisePointIndex()
	{
		return GetNextPointIndex(reverse: false);
	}

	private int GetNextManualPointIndex()
	{
		if (!_data.manualSequentialMove)
		{
			return _manualTargetPointIndex;
		}
		return GetNextClockwisePointIndex();
	}

	private bool IsNextManualPointInstant()
	{
		return IsInstantMoveTo(GetNextManualPointIndex());
	}

	private bool IsInstantMoveTo(int pointIndex)
	{
		if (pointIndex == _manualTargetPointIndex)
		{
			return _data.runningPoints[pointIndex].moveInstantly;
		}
		return false;
	}

	private void StartManualMoveOrEnterWaiting()
	{
		int nextManualPointIndex = GetNextManualPointIndex();
		if (IsInstantMoveTo(nextManualPointIndex))
		{
			StartMoveTo(nextManualPointIndex);
			return;
		}
		_waitElapsed = 0f;
		_phase = PlatformPhase.Waiting;
	}

	private bool IsReverse()
	{
		return _autoRunState == 2;
	}

	private int GetNextPointIndex(bool reverse)
	{
		int num = _data.runningPoints.Length;
		if (!reverse)
		{
			return (_currentPointIndex + 1) % num;
		}
		return (_currentPointIndex - 1 + num) % num;
	}

	private void StartMoveTo(int targetPointIndex)
	{
		_targetPointIndex = targetPointIndex;
		MovingPlatformPoint movingPlatformPoint = _data.runningPoints[_currentPointIndex];
		MovingPlatformPoint movingPlatformPoint2 = _data.runningPoints[_targetPointIndex];
		float num = ((_data.runMode == MovingPlatformRunMode.Manual && IsInstantMoveTo(targetPointIndex)) ? 0f : movingPlatformPoint.nextPathTime);
		if (num <= 0f)
		{
			SetPlatformPose(movingPlatformPoint2.position);
		}
		ResetMoveProgress(movingPlatformPoint.position, movingPlatformPoint2.position, num);
		_phase = PlatformPhase.Moving;
		PlayStartMoveSounds();
		ApplyLinkageStateChanges(isStartMoving: true);
	}

	private void ResetMoveProgress(Pos startPoint, Pos targetPoint, float pathTime)
	{
		_moveStartPosition = startPoint;
		_moveStartRotation = startPoint.rotate;
		_moveElapsedTime = 0f;
		if (pathTime <= 0f)
		{
			_moveDuration = 0f;
			_rotateDuration = 0f;
		}
		else
		{
			_moveDuration = ((Vector3.Distance(startPoint, targetPoint) <= 0f) ? 0f : pathTime);
			_rotateDuration = ((Quaternion.Angle(startPoint.rotate, targetPoint.rotate) <= 0f) ? 0f : pathTime);
		}
	}

	private float CalculateMoveProgress(float elapsedTime, float duration)
	{
		if (!(duration <= 0f))
		{
			return Mathf.Clamp01(elapsedTime / duration);
		}
		return 1f;
	}

	private void ApplyLinkageStateChanges(bool isStartMoving)
	{
		MovingPlatformLinkObjects[] linkObjects = _data.LinkObjects;
		if (linkObjects == null || linkObjects.Length == 0)
		{
			return;
		}
		int num = 0;
		foreach (MovingPlatformLinkObjects movingPlatformLinkObjects in linkObjects)
		{
			if (isStartMoving ? movingPlatformLinkObjects.StartChangeState : movingPlatformLinkObjects.EndChangeState)
			{
				num++;
			}
		}
		if (num == 0)
		{
			return;
		}
		StateChangeInfo[] array = new StateChangeInfo[num];
		int num2 = 0;
		foreach (MovingPlatformLinkObjects movingPlatformLinkObjects2 in linkObjects)
		{
			if (!(isStartMoving ? (!movingPlatformLinkObjects2.StartChangeState) : (!movingPlatformLinkObjects2.EndChangeState)))
			{
				array[num2++] = new StateChangeInfo
				{
					uid = movingPlatformLinkObjects2.StateWorldUid,
					stateId = (isStartMoving ? movingPlatformLinkObjects2.StartState : movingPlatformLinkObjects2.EndState)
				};
			}
		}
		MonoECS.instance.ruleManager.SharedChangeStates(array);
	}

	private void ApplyArrivalStateChanges()
	{
		MovingPlatformStateChange[] arrivalStateChanges = _data.runningPoints[_currentPointIndex].arrivalStateChanges;
		if (arrivalStateChanges != null && arrivalStateChanges.Length != 0)
		{
			StateChangeInfo[] array = new StateChangeInfo[arrivalStateChanges.Length];
			for (int i = 0; i < arrivalStateChanges.Length; i++)
			{
				array[i] = new StateChangeInfo
				{
					uid = arrivalStateChanges[i].stateWorldUid,
					stateId = arrivalStateChanges[i].stateId
				};
			}
			MonoECS.instance.ruleManager.SharedChangeStates(array);
		}
	}

	private void PlayStartMoveSounds()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound(_data.AudioStartSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		StopRunLoopSound();
		_runLoopSoundId = Singleton<GameManager>.instance.audioManager.PlaySound(_data.AudioRunLoopSound, new AudioPlayOptions
		{
			attachTarget = transform,
			IsLoop = true
		});
	}

	private void PlayStopMoveSounds()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound(_data.AudioStopSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		StopRunLoopSound();
	}

	private void StopRunLoopSound()
	{
		Singleton<GameManager>.instance.audioManager.Stop(_runLoopSoundId);
	}

	private float GetScaledFixedDeltaTime()
	{
		return entity.GetCompTime().fixedDeltaTime * _systemTime.globalSpeed;
	}

	private void SetPlatformPose(Pos point)
	{
		_rig.position = point;
		_rig.rotation = point.rotate;
	}

	public override void ReleaseStateObject()
	{
		StopRunLoopSound();
		if (AssetLoadHandleExtensions.IsValid(_modelHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_modelHandle);
			_modelHandle = default;
		}
		_rig = null;
		_animator = null;
		_platformAvailable = false;
		base.ReleaseStateObject();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (_data != null)
		{
			return _data.IsValidStateId(stateId);
		}
		return false;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return _entry;
	}

	protected override bool NeedInteractTip()
	{
		if (_entry == null || _entry.TipIcon == -1)
		{
			return base.NeedInteractTip();
		}
		return true;
	}
}

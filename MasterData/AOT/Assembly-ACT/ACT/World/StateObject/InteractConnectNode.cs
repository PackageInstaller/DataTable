using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.EventTrack;
using ACT.Game;
using ACT.Sound;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractConnectNode : StateObjectBase
{
	private const int START_STATE_CLOSED = 0;

	private const int START_STATE_OPENED = 1;

	private const int START_STATE_LOCK = -1;

	private const int END_STATE_INACTIVE = 0;

	private const int END_STATE_ACTIVE = 1;

	private const int END_STATE_COMPLETED = 2;

	private const int TRANSFER_STATE_HIDE = -3;

	[SerializeField]
	private Transform _tipTransform;

	private ConnectNodeData _data;

	private InteractEntry _interactEntry;

	private bool _isRotating;

	private Coroutine _rotationCoroutine;

	private int _pendingStateId = -1;

	private AssetLoadHandle _modelHandle;

	private Animator _modelAnimator;

	private const string On = "On";

	private const string Connect = "Connect";

	private const string EndState = "EndState";

	private const string TransferActive = "TransferActive";

	private const string NormalNodeActivatedLoop = "event:/SFX/Interact/ConnectNode_Terminal_Loop";

	private const string TransNodeRotateSound = "event:/SFX/Interact/ConnectNode_Adapter_Turn";

	private const string TransNodeActiveSound = "event:/SFX/Interact/ConnectNode_Adapter_On";

	private const string TransNodeDeActiveSound = "event:/SFX/Interact/ConnectNode_Adapter_Off";

	private MaterialPropertyBlock _block;

	private Vector4 _flowEmissionTex_ST = new Vector4(0.4f, 1f, 3f, 0f);

	private uint _normalNodeShowLoopSoundEvent;

	private static readonly int OnHash = Animator.StringToHash("On");

	private static readonly int ConnectHash = Animator.StringToHash("Connect");

	private static readonly int OnEndState = Animator.StringToHash("EndState");

	private static readonly int OnTransferActive = Animator.StringToHash("TransferActive");

	public override bool serviceSave => true;

	private bool IsTransferLockedRotationState(int stateId)
	{
		if (_data?.TransferStates == null || _data.TransferStates.Length == 0)
		{
			return false;
		}
		int n = _data.TransferStates.Length;
		return Array.Exists(_data.TransferStates, (TransferStateConfig s) => s.stateId + n == stateId);
	}

	private bool IsTransferDeactivatedRotationState(int stateId)
	{
		if (_data?.TransferStates == null || _data.TransferStates.Length == 0)
		{
			return false;
		}
		int n = _data.TransferStates.Length;
		return Array.Exists(_data.TransferStates, (TransferStateConfig s) => s.stateId + 2 * n == stateId);
	}

	private bool IsTransferExtendedState(int stateId)
	{
		if (!IsTransferLockedRotationState(stateId))
		{
			return IsTransferDeactivatedRotationState(stateId);
		}
		return true;
	}

	private int GetTransferRotationStateId(int stateId)
	{
		if (_data?.TransferStates == null || _data.TransferStates.Length == 0)
		{
			return stateId;
		}
		int num = _data.TransferStates.Length;
		int baseId2 = stateId - 2 * num;
		if (Array.Exists(_data.TransferStates, (TransferStateConfig s) => s.stateId == baseId2))
		{
			return baseId2;
		}
		int baseId3 = stateId - num;
		if (Array.Exists(_data.TransferStates, (TransferStateConfig s) => s.stateId == baseId3))
		{
			return baseId3;
		}
		return stateId;
	}

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (!(compStateObject?.StateWorldAssetData is ConnectNodeData data))
		{
			return;
		}
		_data = data;
		_block = new MaterialPropertyBlock();
		YooAssetReference modelAsset = GameLoader.connectNodeModelConfig.GetModelAsset(_data.nodeType, _data.nodeShape);
		if (modelAsset != null && modelAsset.RuntimeKeyIsValid())
		{
			_modelHandle = AssetStationManager.BattleStation.Instantiate(modelAsset, transform);
			_modelAnimator = GetComponentInChildren<Animator>();
			if (_data.nodeType == ConnectNodeType.End)
			{
				GetComponentInChildren<InteractEndNodeAnimationEvent>().interactConnectNode = this;
			}
		}
		if (_data.nodeType == ConnectNodeType.Normal && _data.useScale)
		{
			_ = _modelHandle;
			MeshRenderer[] componentsInChildren = _modelHandle.As<GameObject>().GetComponentsInChildren<MeshRenderer>();
			if (componentsInChildren != null && componentsInChildren.Length > 0)
			{
				_flowEmissionTex_ST.x *= _data.initScale.x;
				_block.SetVector(BattleConsts.SHADER_EFFECT_FLOWEMISSIONTEX, _flowEmissionTex_ST);
				MeshRenderer[] array = componentsInChildren;
				foreach (MeshRenderer meshRenderer in array)
				{
					if (meshRenderer != null)
					{
						meshRenderer.SetPropertyBlock(_block);
					}
				}
			}
		}
		_interactEntry = InteractEntry.CreateButtonEntry(_data.name, _data.weight, _data.iconId, -1);
		InteractEntry interactEntry = _interactEntry;
		ConnectNodeType nodeType = _data.nodeType;
		interactEntry.OpenBoxAni = nodeType == ConnectNodeType.Start || nodeType == ConnectNodeType.End;
		InteractEntry interactEntry2 = _interactEntry;
		interactEntry2.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(interactEntry2.onInteractAsync, new Func<Entity, UniTask>(OnInteractAction));
		_interactEntry.BindInteractObjectBase(this);
		_interactEntry.BindData(compStateObject.StateWorldAssetData);
		BoxCollider component = GetComponent<BoxCollider>();
		BoxColliderParameters triggerField = _data.TriggerField;
		if (component != null && triggerField != null)
		{
			component.center = triggerField.center;
			component.size = triggerField.size;
		}
		if (_data.TipTransform != null)
		{
			_tipTransform.position = _data.TipTransform.value;
		}
		ApplyStateRotation(stateId, init: true);
		UpdateAnimatorState(stateId);
		base.InitStateObject(stateId);
		if (_data.nodeType == ConnectNodeType.End && stateId == 2)
		{
			OnEndOpeningAnimationFinished();
		}
		if (_data.nodeType == ConnectNodeType.Normal || _data.nodeType == ConnectNodeType.Transfer)
		{
			Singleton<ConnectNodeManager>.instance.UpdateActivated += OnTransferStateChangeHandler;
		}
		if (_data.nodeType == ConnectNodeType.Start)
		{
			Singleton<ConnectNodeManager>.instance.RegisterStartNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
		if (_data.nodeType == ConnectNodeType.Normal)
		{
			Singleton<ConnectNodeManager>.instance.RegisterNormalNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
		if (_data.nodeType == ConnectNodeType.Transfer)
		{
			Singleton<ConnectNodeManager>.instance.RegisterTransferNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
		if (_data.nodeType == ConnectNodeType.End)
		{
			Singleton<ConnectNodeManager>.instance.RegisterEndNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
		if (_data.nodeType == ConnectNodeType.Start || _data.nodeType == ConnectNodeType.Transfer)
		{
			Singleton<ConnectNodeManager>.instance.RefreshActivationMap();
		}
	}

	private async UniTask OnInteractAction(Entity entityBehave)
	{
		OnNodeInteract(entityBehave);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		switch (_data.nodeType)
		{
		case ConnectNodeType.Start:
			if (stateId != 0 && stateId != 1)
			{
				return stateId == -1;
			}
			return true;
		case ConnectNodeType.Normal:
			return stateId == 0;
		case ConnectNodeType.Transfer:
			if (stateId == -3)
			{
				return true;
			}
			if (_data.TransferStates == null || _data.TransferStates.Length == 0)
			{
				return false;
			}
			if (!Array.Exists(_data.TransferStates, (TransferStateConfig s) => s.stateId == stateId))
			{
				return IsTransferExtendedState(stateId);
			}
			return true;
		case ConnectNodeType.End:
			if (stateId >= 0)
			{
				return stateId <= 2;
			}
			return false;
		default:
			return false;
		}
	}

	protected override void HandleEnterInteract()
	{
		if (CanShowInteractButton())
		{
			ShowInteractButton();
		}
	}

	protected override void HandleExitInteract()
	{
		HideInteractButton();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (!_isRotating && CanShowInteractButton())
		{
			_interactEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	private bool CanShowInteractButton()
	{
		switch (_data.nodeType)
		{
		case ConnectNodeType.Start:
			return currentStateId == 0;
		case ConnectNodeType.Normal:
			return false;
		case ConnectNodeType.Transfer:
			if (_isRotating)
			{
				return false;
			}
			if (currentStateId == -3)
			{
				return false;
			}
			if (IsTransferExtendedState(currentStateId))
			{
				return false;
			}
			return true;
		case ConnectNodeType.End:
			return currentStateId == 1;
		default:
			return false;
		}
	}

	private void ShowInteractButton()
	{
		_interactEntry?.HandleEnter();
	}

	private void HideInteractButton()
	{
		_interactEntry?.HandleExit();
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (_data.nodeType == ConnectNodeType.End && fromStateId == 1 && toStateId == 2)
		{
			PipeConnectSuccessEvent evt = EventTrackSolver.Instance.GetEvt<PipeConnectSuccessEvent>();
			evt.areaId = (int)_data.mapArea;
			evt.subAreaId = (int)_data.mapSubArea;
			G.detailUserInfo.Attributes.TryGetValue(90, out var value);
			evt.playerLevel = (int)value;
			EventTrackSolver.Instance.Dispatch(evt);
			SetEndNodeLinkedStateObjs();
		}
	}

	private void OnNodeInteract(Entity eb)
	{
		switch (_data.nodeType)
		{
		case ConnectNodeType.Start:
			if (currentStateId == 0)
			{
				NetEnterState(1).Forget();
			}
			break;
		case ConnectNodeType.Transfer:
		{
			TransferStateConfig[] transferStates = _data.TransferStates;
			if (transferStates != null && transferStates.Length > 0)
			{
				int num = Array.FindIndex(_data.TransferStates, (TransferStateConfig s) => s.stateId == currentStateId);
				if (num >= 0)
				{
					int num2 = (num + 1) % _data.TransferStates.Length;
					PlayTransferRotationAnimation(_pendingStateId = _data.TransferStates[num2].stateId);
				}
			}
			break;
		}
		case ConnectNodeType.End:
			if (currentStateId == 1)
			{
				NetEnterState(2).Forget();
			}
			break;
		case ConnectNodeType.Normal:
			break;
		}
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		UpdateAnimatorState(stateId);
		switch (_data.nodeType)
		{
		case ConnectNodeType.Start:
			_interactEntry.BindInteractState(0, 0);
			break;
		case ConnectNodeType.Transfer:
			_interactEntry.BindInteractState(stateId, 0);
			break;
		case ConnectNodeType.End:
			_interactEntry.BindInteractState(1, 0);
			break;
		}
		ApplyStateRotation(stateId, init: false);
		if (_data.nodeType == ConnectNodeType.Start || _data.nodeType == ConnectNodeType.Transfer)
		{
			Singleton<ConnectNodeManager>.instance.RefreshActivationMap();
			if (_data.nodeType == ConnectNodeType.Transfer)
			{
				bool flag = Singleton<ConnectNodeManager>.instance.IsTransferNodeActivated(_data.stateWorldAssetUid);
				Singleton<GameManager>.instance.audioManager.PlaySound(flag ? "event:/SFX/Interact/ConnectNode_Adapter_On" : "event:/SFX/Interact/ConnectNode_Adapter_Off", new AudioPlayOptions
				{
					attachTarget = gameObject.transform
				});
			}
		}
		if (IsStay)
		{
			if (CanShowInteractButton())
			{
				ShowInteractButton();
			}
			else
			{
				HideInteractButton();
			}
		}
	}

	private void OnRotationStart()
	{
		Singleton<ConnectNodeManager>.instance.SetTransferRotating(_data.stateWorldAssetUid, rotating: true);
		Singleton<ConnectNodeManager>.instance.RefreshActivationMap();
	}

	private void OnRotationEnd()
	{
		Singleton<ConnectNodeManager>.instance.SetTransferRotating(_data.stateWorldAssetUid, rotating: false);
	}

	private void OnTransferStateChangeHandler(int swid, bool activated)
	{
		if (_data == null || swid != entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid)
		{
			return;
		}
		if (_modelAnimator != null)
		{
			_modelAnimator.SetBool(ConnectHash, activated);
		}
		if (_data.nodeType == ConnectNodeType.Normal)
		{
			if (activated)
			{
				_normalNodeShowLoopSoundEvent = Singleton<GameManager>.instance.audioManager.PlaySound("event:/SFX/Interact/ConnectNode_Terminal_Loop", new AudioPlayOptions
				{
					attachTarget = gameObject.transform
				});
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.Stop(_normalNodeShowLoopSoundEvent);
			}
		}
	}

	private void PlayTransferRotationAnimation(int targetStateId)
	{
		ConnectNodeData data = _data;
		if (data == null || data.nodeType != ConnectNodeType.Transfer || _data.TransferStates == null || _data.TransferStates.Length == 0)
		{
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/SFX/Interact/ConnectNode_Adapter_Turn", new AudioPlayOptions
		{
			attachTarget = gameObject.transform
		});
		int rotationStateId = GetTransferRotationStateId(targetStateId);
		TransferStateConfig transferStateConfig = Array.Find(_data.TransferStates, (TransferStateConfig s) => s.stateId == rotationStateId);
		if (transferStateConfig == null)
		{
			return;
		}
		if (_rotationCoroutine != null)
		{
			StopCoroutine(_rotationCoroutine);
			_rotationCoroutine = null;
		}
		Transform transform = _modelHandle.AsGameObject().transform;
		Vector3 eulerAngles = transform.eulerAngles;
		Vector3 rotation = transferStateConfig.rotation;
		if (_data.rotationDuration <= 0f)
		{
			transform.rotation = Quaternion.Euler(rotation);
			_isRotating = false;
			if (_pendingStateId >= 0)
			{
				NetEnterState(_pendingStateId).Forget();
				_pendingStateId = -1;
			}
		}
		else
		{
			OnRotationStart();
			Vector3 angleDelta = CalculateShortestRotation(eulerAngles, rotation);
			_rotationCoroutine = StartCoroutine(RotateByAngleWithStateChange(eulerAngles, angleDelta, rotation));
		}
	}

	private void ApplyStateRotation(int stateId, bool init)
	{
		ConnectNodeData data = _data;
		if (data == null || data.nodeType != ConnectNodeType.Transfer || _data.TransferStates == null || _data.TransferStates.Length == 0)
		{
			return;
		}
		int rotationStateId = GetTransferRotationStateId(stateId);
		TransferStateConfig transferStateConfig = Array.Find(_data.TransferStates, (TransferStateConfig s) => s.stateId == rotationStateId);
		if (transferStateConfig != null)
		{
			if (_rotationCoroutine != null)
			{
				StopCoroutine(_rotationCoroutine);
				_rotationCoroutine = null;
			}
			Transform transform = _modelHandle.AsGameObject().transform;
			Vector3 eulerAngles = transform.eulerAngles;
			Vector3 rotation = transferStateConfig.rotation;
			Vector3 angleDelta = CalculateShortestRotation(eulerAngles, rotation);
			if (Mathf.Approximately(angleDelta.x, 0f) && Mathf.Approximately(angleDelta.y, 0f) && Mathf.Approximately(angleDelta.z, 0f))
			{
				_isRotating = false;
			}
			else if ((_data.rotationDuration <= 0f) | init)
			{
				transform.rotation = Quaternion.Euler(rotation);
				_isRotating = false;
			}
			else
			{
				OnRotationStart();
				_rotationCoroutine = StartCoroutine(RotateByAngle(eulerAngles, angleDelta, rotation));
			}
		}
	}

	private IEnumerator RotateByAngle(Vector3 startEuler, Vector3 angleDelta, Vector3 finalTargetEuler)
	{
		_isRotating = true;
		if (IsStay)
		{
			HideInteractButton();
		}
		Transform modelTrans = _modelHandle.AsGameObject().transform;
		float duration = _data.rotationDuration;
		float elapsed = 0f;
		CompTime compTime = entity.GetCompTime();
		while (elapsed < duration)
		{
			elapsed += compTime.fixedDeltaTime;
			float t = elapsed / duration;
			float num = Mathf.SmoothStep(0f, 1f, t);
			Vector3 euler = startEuler + angleDelta * num;
			modelTrans.rotation = Quaternion.Euler(euler);
			yield return null;
		}
		modelTrans.rotation = Quaternion.Euler(finalTargetEuler);
		_isRotating = false;
		_rotationCoroutine = null;
		OnRotationEnd();
		Singleton<ConnectNodeManager>.instance.RefreshActivationMap();
		if (IsStay && CanShowInteractButton())
		{
			ShowInteractButton();
		}
	}

	private IEnumerator RotateByAngleWithStateChange(Vector3 startEuler, Vector3 angleDelta, Vector3 finalTargetEuler)
	{
		_isRotating = true;
		if (IsStay)
		{
			HideInteractButton();
		}
		Transform modelTrans = _modelHandle.AsGameObject().transform;
		float duration = _data.rotationDuration;
		float elapsed = 0f;
		CompTime compTime = entity.GetCompTime();
		while (elapsed < duration)
		{
			elapsed += compTime.fixedDeltaTime;
			float t = elapsed / duration;
			float num = Mathf.SmoothStep(0f, 1f, t);
			Vector3 euler = startEuler + angleDelta * num;
			modelTrans.rotation = Quaternion.Euler(euler);
			yield return null;
		}
		modelTrans.rotation = Quaternion.Euler(finalTargetEuler);
		_isRotating = false;
		_rotationCoroutine = null;
		OnRotationEnd();
		if (_pendingStateId >= 0)
		{
			NetEnterState(_pendingStateId).Forget();
			_pendingStateId = -1;
		}
		if (IsStay && CanShowInteractButton())
		{
			ShowInteractButton();
		}
	}

	private Vector3 CalculateShortestRotation(Vector3 currentEuler, Vector3 targetEuler)
	{
		float x = Mathf.DeltaAngle(currentEuler.x, targetEuler.x);
		float y = Mathf.DeltaAngle(currentEuler.y, targetEuler.y);
		float z = Mathf.DeltaAngle(currentEuler.z, targetEuler.z);
		return new Vector3(x, y, z);
	}

	private void SetEndNodeLinkedStateObjs()
	{
		if (_data.EndNodeLinkStateObjs == null || _data.EndNodeLinkStateObjs.Length == 0)
		{
			return;
		}
		List<StateChangeInfo> list = new List<StateChangeInfo>();
		EndNodeLinkStateObj[] endNodeLinkStateObjs = _data.EndNodeLinkStateObjs;
		foreach (EndNodeLinkStateObj endNodeLinkStateObj in endNodeLinkStateObjs)
		{
			if (endNodeLinkStateObj != null && endNodeLinkStateObj.targetInteractSwid != null && endNodeLinkStateObj.targetInteractSwid.value != 0)
			{
				list.Add(new StateChangeInfo
				{
					uid = endNodeLinkStateObj.targetInteractSwid.value,
					stateId = endNodeLinkStateObj.unInteractState
				});
			}
		}
		if (list.Count > 0)
		{
			MonoECS.instance.ruleManager.SharedChangeStates(list.ToArray());
		}
	}

	public void OnEndOpeningAnimationFinished()
	{
		if (_data == null || _data.nodeType != ConnectNodeType.End || _data.EndNodeLinkStateObjs == null || _data.EndNodeLinkStateObjs.Length == 0)
		{
			return;
		}
		List<StateChangeInfo> list = new List<StateChangeInfo>();
		EndNodeLinkStateObj[] endNodeLinkStateObjs = _data.EndNodeLinkStateObjs;
		foreach (EndNodeLinkStateObj endNodeLinkStateObj in endNodeLinkStateObjs)
		{
			if (endNodeLinkStateObj != null && endNodeLinkStateObj.targetInteractSwid != null && endNodeLinkStateObj.targetInteractSwid.value != 0)
			{
				list.Add(new StateChangeInfo
				{
					uid = endNodeLinkStateObj.targetInteractSwid.value,
					stateId = endNodeLinkStateObj.stateId
				});
			}
		}
		if (list.Count > 0)
		{
			MonoECS.instance.ruleManager.SharedChangeStates(list.ToArray());
		}
	}

	private void UpdateAnimatorState(int stateId)
	{
		if (!(_modelAnimator == null))
		{
			switch (_data.nodeType)
			{
			case ConnectNodeType.Start:
				_modelAnimator.SetBool(OnHash, stateId == 1);
				break;
			case ConnectNodeType.End:
				_modelAnimator.SetBool(OnHash, stateId == 1 || stateId == 2);
				_modelAnimator.SetInteger(OnEndState, stateId);
				break;
			case ConnectNodeType.Transfer:
				_modelAnimator.SetBool(OnTransferActive, stateId != -3);
				break;
			case ConnectNodeType.Normal:
				break;
			}
		}
	}

	public override void ReleaseStateObject()
	{
		if (_block != null)
		{
			_block.Clear();
		}
		if (_rotationCoroutine != null)
		{
			StopCoroutine(_rotationCoroutine);
			_rotationCoroutine = null;
		}
		_isRotating = false;
		if (AssetLoadHandleExtensions.IsValid(_modelHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_modelHandle);
		}
		ConnectNodeData data = _data;
		bool flag;
		if (data != null)
		{
			ConnectNodeType nodeType = data.nodeType;
			if ((uint)(nodeType - 1) <= 1u)
			{
				flag = true;
				goto IL_006f;
			}
		}
		flag = false;
		goto IL_006f;
		IL_006f:
		if (flag)
		{
			Singleton<ConnectNodeManager>.instance.UpdateActivated -= OnTransferStateChangeHandler;
		}
		CompStateObject compStateObject = entity.GetCompStateObject();
		data = _data;
		if (data != null && data.nodeType == ConnectNodeType.Start)
		{
			Singleton<ConnectNodeManager>.instance.UnregisterStartNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
		data = _data;
		if (data != null && data.nodeType == ConnectNodeType.Normal)
		{
			Singleton<ConnectNodeManager>.instance.UnregisterNormalNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
			Singleton<GameManager>.instance.audioManager.Stop(_normalNodeShowLoopSoundEvent);
		}
		data = _data;
		if (data != null && data.nodeType == ConnectNodeType.Transfer)
		{
			Singleton<ConnectNodeManager>.instance.UnregisterTransferNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
		data = _data;
		if (data != null && data.nodeType == ConnectNodeType.End)
		{
			Singleton<ConnectNodeManager>.instance.UnregisterEndNode(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
		base.ReleaseStateObject();
		_interactEntry?.HandleUninit();
	}

	public override Transform GetInteractTipTransform()
	{
		return _tipTransform;
	}
}

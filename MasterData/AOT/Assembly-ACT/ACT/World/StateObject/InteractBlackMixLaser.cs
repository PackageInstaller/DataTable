using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBlackMixLaser : StateObjectBase
{
	private struct LaserAnimState
	{
		public int laserIndex;

		public float elapsed;

		public bool isShowing;
	}

	private static readonly int State = Animator.StringToHash("state");

	private BlackMixLaserData _data;

	[SerializeField]
	[Header("激光配置(ConfigLaserObject)")]
	private ConfigLaserObject _laserConfig;

	[SerializeField]
	[Header("模型")]
	private Transform _modelTrans;

	private Entity _laserEntity;

	private Dictionary<int, RuntimeLaser> _runtimeLaserMap = new Dictionary<int, RuntimeLaser>();

	private HashSet<int> _activeLaserIndices = new HashSet<int>();

	private readonly List<LaserAnimState> _laserAnimStates = new List<LaserAnimState>();

	private bool _init;

	private IDisposable _syncAttackablePositionDisposable;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is BlackMixLaserData data)
		{
			_data = data;
			SpawnLaserEntity();
			base.InitStateObject(stateId);
			_init = true;
		}
	}

	private void SpawnLaserEntity()
	{
		if (_data.LaserTrans == null || _data.LaserTrans.Length == 0)
		{
			return;
		}
		_laserEntity = GameManager.entities.factory.CreatLaserEntity();
		MonoECS.instance.SpawnAttackInteractObject(_laserEntity, 6, _data.trapType, _data.defenceTowerType, _data.initPos, Alliance.Netural, Vector3.one, _data.initRotate);
		Entity eb = _laserEntity;
		eb.GetCompStateObject().StateWorldAssetData = _data;
		_syncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (_laserEntity.IsValid)
			{
				eb.GetRootTransform().position = transform.position;
			}
		});
	}

	private RuntimeLaser SpawnLaser(Vector3 configPosition, Quaternion configRotation)
	{
		Vector3 vector = ConvertToLaserRotateOffset(configRotation);
		Vector3 posOffset = ConvertToLaserPosOffset(configPosition, vector);
		MonoECS.LaserParams p = new MonoECS.LaserParams
		{
			alliance = _laserConfig.Alliance,
			filterEntityType = _laserConfig.FilterEntityType,
			canBeAttack = _laserConfig.CanBeAttack,
			onTriggerEnter = _laserConfig.OnTriggerEnter,
			onTriggerStay = _laserConfig.OnTriggerStay,
			onTriggerExit = _laserConfig.OnTriggerExit,
			size = new Vector2(_laserConfig.Radius, _laserConfig.Radius),
			owner = _laserEntity,
			ability = null,
			effectAsset = _data.LaserEffectAsset,
			posOffset = posOffset,
			directionOffset = vector,
			maxLength = _laserConfig.MaxLength,
			runtimeLength = _laserConfig.MaxLength,
			radius = _laserConfig.Radius,
			colliderLayer = _laserConfig.LayerMask
		};
		return MonoECS.instance.SpawnLaser(p);
	}

	private Vector3 ConvertToLaserPosOffset(Vector3 configPosition, Vector3 rotateOffset)
	{
		Vector3 vector = configPosition - transform.position;
		Vector3 vector2 = Quaternion.Inverse(transform.rotation) * vector;
		return Quaternion.Inverse(Quaternion.Euler(rotateOffset)) * Quaternion.Euler(0f, 90f, 0f) * vector2;
	}

	private Vector3 ConvertToLaserRotateOffset(Quaternion configRotation)
	{
		float num = (Quaternion.Inverse(_laserEntity.GetModelTrans().rotation) * configRotation).eulerAngles.z;
		if (num > 180f)
		{
			num -= 360f;
		}
		return new Vector3(num, 0f, 0f);
	}

	private void FixedUpdate()
	{
		if (!_init || _data == null)
		{
			return;
		}
		float num = GameManager.timeSystem.globalSpeed * Time.fixedDeltaTime;
		if (_laserAnimStates.Count > 0)
		{
			float animDuration = _laserConfig.AnimDuration;
			for (int num2 = _laserAnimStates.Count - 1; num2 >= 0; num2--)
			{
				LaserAnimState value = _laserAnimStates[num2];
				value.elapsed += num;
				float num3 = ((animDuration > 0f) ? Mathf.Clamp01(value.elapsed / animDuration) : 1f);
				float num4 = (value.isShowing ? _laserConfig.ShowCurve : _laserConfig.HideCurve).Evaluate(num3);
				if (_runtimeLaserMap.TryGetValue(value.laserIndex, out var value2))
				{
					value2.radius = _laserConfig.Radius * num4;
				}
				if (num3 >= 1f)
				{
					if (!value.isShowing && _runtimeLaserMap.TryGetValue(value.laserIndex, out var value3))
					{
						_laserEntity.GetCompLaser().RemoveLaser(value3);
						_runtimeLaserMap.Remove(value.laserIndex);
					}
					_laserAnimStates.RemoveAt(num2);
				}
				else
				{
					_laserAnimStates[num2] = value;
				}
			}
		}
		int num5 = currentStateId;
		if (num5 != 0 && num5 != -1 && Mathf.Abs(_data.Speed) > 0.001f)
		{
			float angle = _data.Speed * num;
			_laserEntity.GetRootTransform().Rotate(Vector3.forward, angle, Space.Self);
			_modelTrans.Rotate(Vector3.forward, angle);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (_data?.StateConfigs != null)
		{
			BlackMixLaserStateConfig[] stateConfigs = _data.StateConfigs;
			for (int i = 0; i < stateConfigs.Length; i++)
			{
				if (stateConfigs[i].StateId == stateId)
				{
					return true;
				}
			}
		}
		return true;
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		ApplyLaserState(stateId);
	}

	protected override void HandleUninitState(int stateId)
	{
	}

	private void ApplyLaserState(int stateId)
	{
		_modelTrans.gameObject.SetActive(stateId != -1);
		int[] activeLaserIndices = _data.GetActiveLaserIndices(stateId);
		HashSet<int> hashSet = new HashSet<int>(activeLaserIndices);
		List<int> list = new List<int>();
		foreach (int activeLaserIndex in _activeLaserIndices)
		{
			if (!hashSet.Contains(activeLaserIndex))
			{
				list.Add(activeLaserIndex);
			}
		}
		foreach (int item in list)
		{
			DeactivateLaser(item);
		}
		int[] array = activeLaserIndices;
		foreach (int num in array)
		{
			if (!_activeLaserIndices.Contains(num))
			{
				ActivateLaser(num);
			}
		}
		_activeLaserIndices = hashSet;
	}

	private void ActivateLaser(int laserIndex)
	{
		if (laserIndex >= 0 && laserIndex < _data.LaserTrans.Length)
		{
			if (!_runtimeLaserMap.ContainsKey(laserIndex))
			{
				Pos pos = _data.LaserTrans[laserIndex];
				Vector3 vector = pos.value - _data.initPos;
				Transform rootTransform = _laserEntity.GetRootTransform();
				Vector3 configPosition = rootTransform.position + vector;
				Quaternion quaternion = Quaternion.Inverse(_data.initRotate) * pos.rotate;
				Quaternion configRotation = rootTransform.rotation * quaternion;
				RuntimeLaser runtimeLaser = SpawnLaser(configPosition, configRotation);
				runtimeLaser.radius = 0f;
				_runtimeLaserMap[laserIndex] = runtimeLaser;
			}
			StartLaserAnim(laserIndex, isShowing: true);
		}
	}

	private void DeactivateLaser(int laserIndex)
	{
		if (_runtimeLaserMap.ContainsKey(laserIndex))
		{
			StartLaserAnim(laserIndex, isShowing: false);
		}
	}

	private void StartLaserAnim(int laserIndex, bool isShowing)
	{
		for (int num = _laserAnimStates.Count - 1; num >= 0; num--)
		{
			if (_laserAnimStates[num].laserIndex == laserIndex)
			{
				_laserAnimStates.RemoveAt(num);
				break;
			}
		}
		_laserAnimStates.Add(new LaserAnimState
		{
			laserIndex = laserIndex,
			elapsed = 0f,
			isShowing = isShowing
		});
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override void ReleaseStateObject()
	{
		OnDestroy();
		ReleaseLaserEntity().Forget();
		base.ReleaseStateObject();
	}

	private async UniTaskVoid ReleaseLaserEntity()
	{
		if (!_laserEntity.IsValid)
		{
			return;
		}
		Entity eb = _laserEntity;
		eb.GetCompLaser().RemoveAllLasers();
		_runtimeLaserMap.Clear();
		if (eb.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(_laserEntity);
			return;
		}
		await UniTask.WaitUntil(() => eb.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(_laserEntity);
	}

	private void OnDestroy()
	{
		_init = false;
		_syncAttackablePositionDisposable?.Dispose();
		_activeLaserIndices.Clear();
		_runtimeLaserMap.Clear();
		_laserAnimStates.Clear();
	}
}

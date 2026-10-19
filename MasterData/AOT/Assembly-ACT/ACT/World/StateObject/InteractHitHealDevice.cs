using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractHitHealDevice")]
public sealed class InteractHitHealDevice : StateObjectBase
{
	private static readonly int Hit = Animator.StringToHash("Hit");

	private static readonly int Idle = Animator.StringToHash("Idle");

	private static readonly int Die = Animator.StringToHash("Die");

	private const int DefaultAttackableId = 2;

	private readonly List<HitHealDeviceLightPoint> _ownedLightPoints = new List<HitHealDeviceLightPoint>();

	private HitHealDeviceManager _lightPointManager;

	private HitHealDeviceData _data;

	private Entity _attackEntity;

	private IDisposable _syncAttackablePosition;

	private CancellationTokenSource _cancellation;

	private float _hitCooldownRemaining;

	private int _generatedLightPointCount;

	private Animator _animator;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is HitHealDeviceData data)
		{
			_data = data;
			_lightPointManager = Singleton<HitHealDeviceManager>.instance;
			_lightPointManager.PreloadLightPointPrefab(_data.LightPointPrefab.GUID);
			_cancellation = new CancellationTokenSource();
			_animator = GetComponentInChildren<Animator>();
			SpawnAttackEntity().Forget();
			base.InitStateObject(stateId);
		}
	}

	private async UniTaskVoid SpawnAttackEntity()
	{
		_attackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity attackEntity = _attackEntity;
		MonoECS.instance.SpawnAttackInteractObject(attackEntity, 2, _data.trapType, _data.defenceTowerType, _data.initPos, Alliance.Netural, _data.HitBox.size, _data.initRotate);
		if (_cancellation.IsCancellationRequested)
		{
			return;
		}
		attackEntity.GetCompStateObject().StateWorldAssetData = _data;
		CompAbility? compAbility = attackEntity.GetCompAbility();
		compAbility.damageableHited = (Action<Entity>)Delegate.Combine(compAbility.damageableHited, new Action<Entity>(OnHitted));
		_syncAttackablePosition = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (attackEntity.IsValid)
			{
				attackEntity.GetRootTransform().position = transform.position;
			}
		});
	}

	private void OnHitted(Entity attacker)
	{
		if (currentStateId != 0 || !attacker.IsCharacter())
		{
			return;
		}
		if (_animator != null)
		{
			_animator.CrossFadeInFixedTime(Hit, 0f);
		}
		if (_hitCooldownRemaining > 0f || _data == null)
		{
			return;
		}
		int num = Mathf.Max(1, _data.MaxGeneratedLightPointCount);
		int num2 = num - _generatedLightPointCount;
		if (num2 > 0)
		{
			_hitCooldownRemaining = _data.HitInterval;
			_generatedLightPointCount += SpawnLightPoints(num2);
			if (_generatedLightPointCount >= num)
			{
				NetEnterState(1).Forget();
			}
		}
	}

	private int SpawnLightPoints(int remainingCount)
	{
		if (!_lightPointManager.IsLightPointPrefabReady())
		{
			return 0;
		}
		int requestedCount = Mathf.Min(_data.GetTotalLightPointCount(), remainingCount);
		int num = _lightPointManager.ReserveSlots(_data.stateWorldAssetUid, requestedCount);
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			int sectionIndexForPoint = _data.GetSectionIndexForPoint(i);
			if (CreateLightPoint(sectionIndexForPoint))
			{
				num2++;
			}
		}
		return num2;
	}

	private bool CreateLightPoint(int sectionIndex)
	{
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(_data.LightPointPrefab.GUID);
		GameObject gameObject = instanceHandle?.Result;
		if (gameObject == null || !gameObject.TryGetComponent<HitHealDeviceLightPoint>(out var component))
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(instanceHandle);
			Debug.LogError(string.Format("{0} is required on {1}.", "HitHealDeviceLightPoint", _data.LightPointPrefab), this);
			return false;
		}
		gameObject.transform.SetParent(transform, worldPositionStays: false);
		Vector3 randomDirection = _data.GetRandomDirection(sectionIndex);
		Vector3 vector = _data.StartPos;
		Vector3 scatterTarget = vector + randomDirection * UnityEngine.Random.Range(_data.ScatterDistance.x, _data.ScatterDistance.y);
		component.Initialize(instanceHandle, _lightPointManager, vector, scatterTarget, randomDirection, _data.ScatterMoveDuration, _data.ScatterSpeedCurve, _data.ArrivalWaitTime, _data.ChaseMaxSpeed, _data.ChaseAccelerationDuration, _data.ChaseSpeedCurve, GetLightPointChaseTargetPosition, OnLightPointArrive, RemoveOwnedPoint);
		component.node = _lightPointManager.Register(_data.stateWorldAssetUid, component);
		_ownedLightPoints.Add(component);
		return true;
	}

	private Vector3? GetLightPointChaseTargetPosition()
	{
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (!entity.IsLogicAvailable())
		{
			return null;
		}
		return entity.GetRootTransform().position + entity.GetCompTransform().center;
	}

	private Vector3? GetTargetRootPos()
	{
		Entity entity = MonoECS.instance?.mainEntity ?? default(Entity);
		if (!entity.IsLogicAvailable())
		{
			return null;
		}
		return entity.GetRootTransform().position;
	}

	private void FixedUpdate()
	{
		if (_attackEntity.IsValid)
		{
			float fixedDeltaTime = _attackEntity.GetCompTime().fixedDeltaTime;
			if (_hitCooldownRemaining > 0f)
			{
				_hitCooldownRemaining = Mathf.Max(0f, _hitCooldownRemaining - fixedDeltaTime);
			}
		}
	}

	private void OnLightPointArrive()
	{
		RecoverTeam();
		if (_data.RecoveryEffectAsset.RuntimeKeyIsValid() && GetTargetRootPos().HasValue)
		{
			EffectPoint point = new EffectPoint
			{
				type = EffectPoint.EffectPointType.Character,
				constPointPos = null,
				continueouslyFollow = true,
				rotateFollowLogicDir = false,
				offset = default,
				rotateOffset = default,
				useOwnerRot = false,
				oriRotX = 0f,
				oriRotY = 0f,
				oriRotZ = 0f,
				aimTarget = false
			};
			SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
			{
				target = FindTargetResult.EntityOnly(MonoECS.instance.mainEntity),
				patternAssetID = _data.RecoveryEffectAsset,
				constPointPos = default,
				removeWhenMotionExit = false,
				removeWhenConfigMotionExit = false,
				configMotionName = null,
				timescale = TimeScale.Owner,
				type = EffectDataType.Point,
				point1 = point,
				point2 = default,
				removeWhenStop = true,
				changeScale = false,
				effectRangeEnum = EffectRangeEnum.none,
				transformScaleMulBase = default,
				modelType = EffectModelType.Small,
				isChangeWithEntity = false,
				initRotation = default,
				isAttach = false,
				motioState = MotionState.None,
				xMirror = false,
				warningEffectTime = 0f,
				exclusivePriority = false,
				priority = 0,
				playSpace = SystemEffect.EffectPlaySpace.World,
				uiAnchor = SystemEffect.UIEffectAnchor.TopLeft,
				uiAnchoredOffset = default,
				uiRespectSafeArea = false,
				uiCustomAnchorPos = default,
				uiFollowRect = null,
				uiSiblingOrder = 0
			};
			GameManager.effectSystem.FireEffect(effectParams);
		}
	}

	private void RecoverTeam()
	{
		MPPlayer mPPlayer = MonoECS.instance?.localPlayer;
		if (mPPlayer == null)
		{
			return;
		}
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = mPPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.IsAlive())
			{
				CompAbility? compAbility = teamCharacter.GetCompAbility();
				compAbility.Recover(Mathf.CeilToInt((float)compAbility.maxHP * _data.RecoverMaxHpPercent), checkAlive: false);
			}
		}
	}

	private void RemoveOwnedPoint(HitHealDeviceLightPoint point)
	{
		_ownedLightPoints.Remove(point);
	}

	public override void ReleaseStateObject()
	{
		_cancellation?.Cancel();
		_cancellation?.Dispose();
		_syncAttackablePosition?.Dispose();
		ClearOwnedLightPoints();
		ReleaseAttackEntity().Forget();
		_lightPointManager = null;
		base.ReleaseStateObject();
	}

	private void ClearOwnedLightPoints()
	{
		while (_ownedLightPoints.Count > 0)
		{
			_ownedLightPoints[_ownedLightPoints.Count - 1].Dispose();
		}
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!_attackEntity.IsValid)
		{
			return;
		}
		if (!_attackEntity.CanRemove())
		{
			await UniTask.WaitUntil(() => _attackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		}
		MonoECS.instance.TryRemoveBehave(_attackEntity);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == 1;
		}
		return true;
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		switch (toStateId)
		{
		case 0:
			_generatedLightPointCount = 0;
			if (_animator != null)
			{
				_animator.CrossFadeInFixedTime(Idle, 0f);
			}
			break;
		case 1:
			if (_animator != null)
			{
				_animator.CrossFadeInFixedTime(Die, 0f);
			}
			break;
		}
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	protected override void HandleInitState(int stateId)
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}

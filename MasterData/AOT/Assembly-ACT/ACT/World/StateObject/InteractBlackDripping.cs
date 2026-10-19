using System;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBlackDripping : StateObjectBase
{
	private BlackDrippingData _data;

	private CancellationTokenSource _tokenSource;

	private float _timer;

	private bool _isFirstSpawn = true;

	private bool _isDripping;

	private bool _isSpawning;

	private Entity _attackEntity;

	private IDisposable _syncAttackablePositionDisposable;

	private bool _init;

	private AssetLoadHandle _waterStainHandle;

	private const int NeutralId = 6;

	[SerializeField]
	private ConfigTrajectoryObject _configTrajectoryObject;

	private GeneralTrajectory _trajectory;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is BlackDrippingData data))
		{
			return;
		}
		_data = data;
		_tokenSource = new CancellationTokenSource();
		_timer = 0f;
		_isFirstSpawn = true;
		_isDripping = false;
		_isSpawning = false;
		CoSpawnAttackEntity();
		_trajectory = _configTrajectoryObject.configTrajectory as GeneralTrajectory;
		if (_data.CreatStain)
		{
			YooAssetReference waterStainModel = _data.WaterStainModel;
			if (waterStainModel != null && waterStainModel.RuntimeKeyIsValid())
			{
				_waterStainHandle = AssetStationManager.BattleStation.Instantiate(waterStainModel, transform);
				GameObject gameObject = _waterStainHandle.AsGameObject();
				gameObject.transform.position = _data.WaterStainPos.value;
				gameObject.transform.rotation = _data.WaterStainPos.rotate;
			}
		}
		base.InitStateObject(stateId);
		_init = true;
	}

	private void CoSpawnAttackEntity()
	{
		_attackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = _attackEntity;
		MonoECS.instance.SpawnAttackInteractObject(eb, 6, _data.trapType, _data.defenceTowerType, _data.initPos, Alliance.Netural, Vector3.one, _data.initRotate);
		if (_tokenSource.IsCancellationRequested)
		{
			return;
		}
		eb.GetCompStateObject().StateWorldAssetData = _data;
		_syncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (_attackEntity.IsValid)
			{
				eb.GetRootTransform().position = transform.position;
			}
		});
	}

	private void FixedUpdate()
	{
		if (currentStateId != 0 || _data == null || !_init)
		{
			return;
		}
		float fixedDeltaTime = _attackEntity.GetCompTime().fixedDeltaTime;
		_timer += fixedDeltaTime;
		if (_isDripping)
		{
			if (_timer >= _data.DripDelayTime)
			{
				_timer = 0f;
				_isDripping = false;
				SpawnBullet();
			}
		}
		else if (_isFirstSpawn)
		{
			if (_timer >= _data.FirstDelayTime)
			{
				_isFirstSpawn = false;
				_timer = 0f;
				_isDripping = true;
				SpawnDripEffect();
			}
		}
		else if (_timer >= _data.IntervalTime)
		{
			_timer = 0f;
			_isDripping = true;
			SpawnDripEffect();
		}
	}

	private void SpawnDripEffect()
	{
		GameManager.effectSystem.FireEffect(_configTrajectoryObject.DrippingEffectAsset, _data.initPos, Quaternion.identity);
	}

	private void SpawnBullet()
	{
		if (!_isSpawning)
		{
			_isSpawning = true;
			SpawnBulletAsync(_tokenSource.Token).Forget();
		}
	}

	private GeneralTrajectory CreateDownwardTrajectory()
	{
		GeneralMovementPattern generalMovementPattern = _trajectory?.movementPattern as GeneralMovementPattern;
		GeneralHitPattern hitPattern = _trajectory?.hitPattern as GeneralHitPattern;
		GeneralLifePattern generalLifePattern = _trajectory?.lifePattern as GeneralLifePattern;
		GeneralMovementPattern movementPattern = new GeneralMovementPattern
		{
			initSpeed = new Vector3(0f, 0f, _data.Speed),
			initRotate = (generalMovementPattern?.initRotate ?? Vector3.zero),
			initVelocityMode = (generalMovementPattern?.initVelocityMode ?? InitVelocityMode.UseSelfCoordinate),
			useVelocityDir = (generalMovementPattern?.useVelocityDir ?? true),
			useRotate = (generalMovementPattern?.useRotate ?? false),
			angleDegreeSpeed = (generalMovementPattern?.angleDegreeSpeed ?? 0f),
			axis = (generalMovementPattern?.axis ?? Vector3.zero),
			velocityModifiers = generalMovementPattern?.velocityModifiers
		};
		GeneralLifePattern lifePattern = new GeneralLifePattern
		{
			lifetime = _data.DestroyTime,
			configLifeTime = generalLifePattern?.configLifeTime,
			onInit = generalLifePattern?.onInit,
			onLifeEnd = generalLifePattern?.onLifeEnd,
			onStopDie = (generalLifePattern?.onStopDie ?? true),
			onDie = generalLifePattern?.onDie,
			destroyDelay = (generalLifePattern?.destroyDelay ?? 0f)
		};
		return new GeneralTrajectory
		{
			movementPattern = movementPattern,
			hitPattern = hitPattern,
			lifePattern = lifePattern,
			clearHitCache = (_trajectory?.clearHitCache ?? false)
		};
	}

	private async UniTaskVoid SpawnBulletAsync(CancellationToken token)
	{
		try
		{
			if (!token.IsCancellationRequested)
			{
				MonoECS instance = MonoECS.instance;
				GeneralTrajectory trajectory = CreateDownwardTrajectory();
				MonoECS.FlexibleParams p = new MonoECS.FlexibleParams
				{
					shape = Shape.Sphere,
					boxSize = Vector3.zero,
					size = new Vector2(_data.Radius, _data.Radius),
					offest = _configTrajectoryObject.AttackBoundsOffset,
					type = AbilityEntityType.Normal,
					tag = (TrajectoryTag)0,
					checkEnvAndResolve = false,
					hp = 0,
					showUI = false,
					cantBeAttack = false,
					beHitFilter = (FilterEntityType.Character | FilterEntityType.Monster | FilterEntityType.Boss | FilterEntityType.Elite),
					aimPos = transform.position,
					aimRotation = Quaternion.Euler(90f, 0f, 0f),
					trajectory = trajectory,
					configTrajectoryObject = null,
					movementPattern = null,
					OverlapThreshold = 0.05f,
					VelocityOverlapDistance = 0.5f,
					onCreate = null
				};
				instance.SpawnFlexibleEntity(p, _attackEntity, null);
			}
		}
		finally
		{
			_isSpawning = false;
		}
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

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		if (stateId == 0)
		{
			_timer = 0f;
			_isFirstSpawn = true;
			_isDripping = false;
		}
		if (_waterStainHandle.IsValid)
		{
			BlackDrippingData data = _data;
			if (data != null && data.CreatStain)
			{
				_waterStainHandle.AsGameObject().SetActive(stateId == 0);
			}
		}
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

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!_attackEntity.IsValid)
		{
			return;
		}
		if (_attackEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(_attackEntity);
			return;
		}
		await UniTask.WaitUntil(() => _attackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(_attackEntity);
	}

	public override void ReleaseStateObject()
	{
		OnDestroy();
		ReleaseAttackEntity().Forget();
		if (AssetLoadHandleExtensions.IsValid(_waterStainHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_waterStainHandle);
		}
		base.ReleaseStateObject();
	}

	private void OnDestroy()
	{
		_tokenSource?.Cancel();
		_tokenSource?.Dispose();
		_tokenSource = null;
		_syncAttackablePositionDisposable?.Dispose();
	}
}

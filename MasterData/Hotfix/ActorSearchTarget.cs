using System.Collections.Generic;
using TrueSync;

public class ActorSearchTarget : LogicComponent, ILogicComponentVisualUpdate, ILogicComponent
{
	public delegate void EnterAlertHandler(List<LogicEntity> enterAlertActors);

	public enum SearchType
	{
		vAttackRange,
		vSearchRange,
		hAttackRange,
		hSearchRange,
		allRange
	}

	protected bool _forceSearhLock;

	private TrueSyncTransform _transform;

	private AdventureActor _actor;

	protected List<DeterministicCollider> enterAlertColliders;

	public FP _rotation;

	public FP actorRadius;

	public FP attackRange;

	protected FP _visionRange;

	public FP visionAttackRange;

	protected FP _visionDeg;

	protected bool isShowRng;

	protected FP _hearRange;

	public FP hearAttackRange;

	public FP aimRange;

	protected bool _enableVisionLogic;

	protected bool _enableHearingLogic;

	public FP monsterSearchRange;

	[ReadOnly]
	protected readonly List<LogicEntity> _enterVisionAlertActors = new List<LogicEntity>(10);

	[ReadOnly]
	protected readonly List<LogicEntity> _enterHearingAlertActors = new List<LogicEntity>(10);

	private readonly List<LogicEntity> _monsterTargetActors = new List<LogicEntity>(10);

	private LogicEntity _lastMonsterTarget;

	private bool _firstSearchMonsterTarget = true;

	protected CircleGraphicIndicator _hearingRngIndicator;

	protected FanGraphicIndicator _visionRngIndicator;

	protected bool isShowing;

	public FP originVisionRange { get; set; }

	public FP originVisionAttackRange { get; set; }

	public FP visionRange
	{
		get
		{
			return _visionRange;
		}
		set
		{
			_visionRange = value;
		}
	}

	public FP originVisionDeg { get; set; }

	public FP visionDeg
	{
		get
		{
			return _visionDeg;
		}
		set
		{
			_visionDeg = value;
		}
	}

	public bool IsShowRng
	{
		get
		{
			return isShowRng;
		}
		set
		{
			isShowRng = value;
		}
	}

	public FP originHearRange { get; set; }

	public FP originHearAttackRange { get; set; }

	public FP hearRange
	{
		get
		{
			return _hearRange;
		}
		set
		{
			_hearRange = value;
		}
	}

	public FP originAimRange { get; set; }

	public bool enableVisionLogic
	{
		get
		{
			return _enableVisionLogic;
		}
		set
		{
			_enableVisionLogic = value;
		}
	}

	public bool enableHearingLogic
	{
		get
		{
			return _enableHearingLogic;
		}
		set
		{
			_enableHearingLogic = value;
		}
	}

	public List<LogicEntity> enterVisionAlertActors => _enterVisionAlertActors;

	public List<LogicEntity> enterHearingAlertActors => _enterHearingAlertActors;

	public event EnterAlertHandler EnterAlertEvent;

	public void InitializeSearchTarget()
	{
		enterAlertColliders = new List<DeterministicCollider>(10);
	}

	public void ReleaseSearchTarget()
	{
	}

	public override void OnActive()
	{
		_actor = (AdventureActor)Entity;
		_transform = _actor.tsTransform;
		if (_actor.dtCollider != null)
		{
			actorRadius = _actor.dtCollider.Radius;
		}
	}

	public override void OnDeactive()
	{
		_actor = null;
		_transform = null;
		_firstSearchMonsterTarget = true;
	}

	public void AddSearchRange(FP range, SearchType sType)
	{
		switch (sType)
		{
		case SearchType.vAttackRange:
			visionAttackRange += range;
			break;
		case SearchType.vSearchRange:
			visionRange += range;
			break;
		case SearchType.hAttackRange:
			hearAttackRange += range;
			break;
		case SearchType.hSearchRange:
			hearRange += range;
			break;
		case SearchType.allRange:
			visionAttackRange += range;
			visionRange += range;
			hearAttackRange += range;
			hearRange += range;
			break;
		}
		SceneSingleton<AdventureIndicatorController>.Instance.ShowIndicatorN(showIndicator: true, this, _transform);
	}

	public void ResetSearchRange(SearchType sType)
	{
		switch (sType)
		{
		case SearchType.vAttackRange:
			visionAttackRange = originVisionAttackRange;
			break;
		case SearchType.vSearchRange:
			visionRange = originVisionRange;
			break;
		case SearchType.hAttackRange:
			hearAttackRange = originHearAttackRange;
			break;
		case SearchType.hSearchRange:
			hearRange = originHearRange;
			break;
		case SearchType.allRange:
			visionAttackRange = originVisionAttackRange;
			visionRange = originVisionRange;
			hearAttackRange = originHearAttackRange;
			hearRange = originHearRange;
			break;
		}
		SceneSingleton<AdventureIndicatorController>.Instance?.ShowIndicatorN(showIndicator: true, this, _transform);
	}

	public void ForceSearchLock(bool forceLock, bool _vision = true, bool _hearing = true)
	{
		if (forceLock)
		{
			EnableVisionLogic(_vision);
			EnableHearingLogic(_hearing);
		}
		_forceSearhLock = forceLock;
	}

	public void UpdatePlayerSearchTargetControl()
	{
		if (!(_actor is PlayerAdventureActor playerAdventureActor))
		{
			return;
		}
		if (!_actor.disableMove && SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
		{
			switch (playerAdventureActor.searchType)
			{
			case PlayerActorSearchType.Range:
				EnableVisionLogic();
				EnableHearingLogic();
				break;
			case PlayerActorSearchType.Melee:
				EnableVisionLogic();
				EnableHearingLogic(enable: false);
				break;
			}
		}
		else
		{
			switch (playerAdventureActor.searchType)
			{
			case PlayerActorSearchType.Range:
				EnableVisionLogic();
				EnableHearingLogic();
				break;
			case PlayerActorSearchType.Melee:
				EnableVisionLogic(enable: false);
				EnableHearingLogic();
				break;
			}
		}
		if (_actor.movementState == ActorState.Dodge || _actor.isInteractive)
		{
			EnableVisionLogic(enable: false);
			EnableHearingLogic(enable: false);
		}
	}

	public void EnableVisionLogic(bool enable = true)
	{
		if (!_forceSearhLock)
		{
			enableVisionLogic = enable;
		}
	}

	public void EnableHearingLogic(bool enable = true)
	{
		if (!_forceSearhLock)
		{
			enableHearingLogic = enable;
		}
	}

	public FP GetCurrentAttackRange()
	{
		return TSMath.Max(visionRange, hearRange);
	}

	public List<LogicEntity> GetEnterVisionAlertActors(bool useInputDirection = false, bool includeSelf = false)
	{
		_enterVisionAlertActors.Clear();
		if (enableVisionLogic)
		{
			TSVector2 tSVector = _transform.Forward;
			if (useInputDirection && SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
			{
				tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			}
			_rotation = tSVector.GetAngle();
			FP radius = visionRange + actorRadius;
			bool drawGizmos = false;
			if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckFanOverlap(visionDeg, radius, _transform.Position, _rotation, enterAlertColliders, 256, drawGizmos))
			{
				for (int i = 0; i < enterAlertColliders.Count; i++)
				{
					LogicEntity entity = enterAlertColliders.get_Item(i).Entity;
					if (null != entity)
					{
						if (includeSelf || !(entity == _actor))
						{
							_enterVisionAlertActors.Add(entity);
						}
						if (_actor != null && entity == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor && _actor.IsConfrontWith(entity))
						{
							SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor);
						}
					}
				}
			}
			AdventureActor actor = _actor;
			if ((object)actor != null)
			{
				actor.SearchEntityViewable(_enterVisionAlertActors, searchFirst: false);
			}
			EnterAlertEvent?.Invoke(_enterVisionAlertActors);
		}
		return _enterVisionAlertActors;
	}

	public void GetEnterVisionAlertActors(List<LogicEntity> entities, List<DeterministicCollider> colliders)
	{
		entities.Clear();
		colliders.Clear();
		if (!enableVisionLogic)
		{
			return;
		}
		_rotation = _transform.Forward.GetAngle();
		FP radius = visionRange + actorRadius;
		if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckFanOverlap(visionDeg, radius, _transform.Position, _rotation, colliders, 256))
		{
			for (int i = 0; i < colliders.Count; i++)
			{
				LogicEntity entity = colliders.get_Item(i).Entity;
				if (null != entity && entity != _actor && _actor.IsConfrontWith(entity))
				{
					entities.Add(entity);
				}
			}
		}
		AdventureActor actor = _actor;
		if ((object)actor != null)
		{
			actor.SearchEntityViewable(entities, searchFirst: false);
		}
	}

	public List<LogicEntity> GetEnterHearingAlertActors(bool includeSelf = false)
	{
		_enterHearingAlertActors.Clear();
		if (enableHearingLogic)
		{
			FP radius = hearRange + actorRadius;
			bool drawGizmos = false;
			if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(radius, _transform.Position, enterAlertColliders, 256, drawGizmos))
			{
				for (int i = 0; i < enterAlertColliders.Count; i++)
				{
					LogicEntity entity = enterAlertColliders.get_Item(i).Entity;
					if (!(null == entity))
					{
						if (includeSelf || !(entity == _actor))
						{
							_enterHearingAlertActors.Add(entity);
						}
						if (_actor != null && entity == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor && _actor.IsConfrontWith(entity))
						{
							SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor);
						}
					}
				}
			}
			EnterAlertEvent?.Invoke(_enterHearingAlertActors);
		}
		return _enterHearingAlertActors;
	}

	public LogicEntity GetLockingConfrontActor(bool useInputDirection, bool dontLostTarget = false, bool sortByAngle = false, bool onlyUseVision = false)
	{
		if (_actor == null)
		{
			return null;
		}
		if (_actor.isTaunt && !_actor.isTauntWeakened && _actor.tauntFromActor != null)
		{
			ActorHealthInfo actorHealthInfo = _actor.tauntFromActor.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && !_actor.tauntFromActor.IsSearchedImmunity())
			{
				return _actor.tauntFromActor;
			}
		}
		LogicEntity attackTarget = _actor.attackTarget;
		_enterVisionAlertActors.Clear();
		_enterHearingAlertActors.Clear();
		GetEnterVisionAlertActors(useInputDirection);
		CommonHelper.SearchEntityAlive(_enterVisionAlertActors);
		_actor.SearchEntityConfront(_enterVisionAlertActors);
		attackRange = visionAttackRange;
		if (_enterVisionAlertActors.Count <= 0)
		{
			if (onlyUseVision)
			{
				if (!dontLostTarget)
				{
					return null;
				}
				return attackTarget;
			}
			GetEnterHearingAlertActors();
			CommonHelper.SearchEntityAlive(_enterHearingAlertActors);
			_actor.SearchEntityConfront(_enterHearingAlertActors);
			attackRange = hearAttackRange;
		}
		if (_enterVisionAlertActors.Count > 0)
		{
			LogicEntity logicEntity = SceneSingleton<AdventurePlayerController>.Instance?.GetDefaultSelectTarget(_enterVisionAlertActors);
			if (logicEntity != null)
			{
				return logicEntity;
			}
			if (SceneSingleton<AdventurePlayerController>.Instance?._defaultSelect != null && !onlyUseVision)
			{
				GetEnterHearingAlertActors();
				CommonHelper.SearchEntityAlive(_enterHearingAlertActors);
				_actor.SearchEntityConfront(_enterHearingAlertActors);
			}
			if (_enterHearingAlertActors.Count > 0)
			{
				logicEntity = SceneSingleton<AdventurePlayerController>.Instance?.GetDefaultSelectTarget(_enterHearingAlertActors);
				if (logicEntity != null)
				{
					return logicEntity;
				}
			}
			if (sortByAngle)
			{
				_actor.SearchEntitySortByAngle(_enterVisionAlertActors);
			}
			else
			{
				_actor.SearchEntitySortByDistance(_enterVisionAlertActors);
			}
			return _enterVisionAlertActors.get_Item(0);
		}
		if (_enterHearingAlertActors.Count > 0)
		{
			LogicEntity logicEntity2 = SceneSingleton<AdventurePlayerController>.Instance?.GetDefaultSelectTarget(_enterHearingAlertActors);
			if (logicEntity2 != null)
			{
				return logicEntity2;
			}
			if (sortByAngle)
			{
				_actor.SearchEntitySortByAngle(_enterHearingAlertActors);
			}
			else
			{
				_actor.SearchEntitySortByDistance(_enterHearingAlertActors);
			}
			return _enterHearingAlertActors.get_Item(0);
		}
		if (!dontLostTarget)
		{
			return null;
		}
		return attackTarget;
	}

	public LogicEntity GetSwitchConfrontActor()
	{
		if (_actor.isTaunt && !_actor.isTauntWeakened && _actor.tauntFromActor != null)
		{
			ActorHealthInfo actorHealthInfo = _actor.tauntFromActor.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && !_actor.tauntFromActor.IsSearchedImmunity())
			{
				return _actor.tauntFromActor;
			}
		}
		_enterVisionAlertActors.Clear();
		_enterHearingAlertActors.Clear();
		GetEnterVisionAlertActors();
		CommonHelper.SearchEntityAlive(_enterVisionAlertActors);
		_actor.SearchEntityConfront(_enterVisionAlertActors);
		bool flag = SceneSingleton<AdventurePlayerController>.Instance.CheckAlreadySearch(_enterVisionAlertActors);
		LogicEntity logicEntity = null;
		if (flag)
		{
			logicEntity = getVisionAlertActor();
			if (logicEntity != null)
			{
				return logicEntity;
			}
		}
		GetEnterHearingAlertActors();
		CommonHelper.SearchEntityAlive(_enterHearingAlertActors);
		_actor.SearchEntityConfront(_enterHearingAlertActors);
		if (SceneSingleton<AdventurePlayerController>.Instance.CheckAlreadySearch(_enterHearingAlertActors, isH: true))
		{
			logicEntity = getHearingAlertActor();
		}
		else if (_enterVisionAlertActors.Count > 0)
		{
			logicEntity = getVisionAlertActor();
			if (logicEntity == null)
			{
				logicEntity = getHearingAlertActor();
			}
		}
		else
		{
			logicEntity = getHearingAlertActor();
		}
		if (_enterVisionAlertActors.Count <= 0 && _enterHearingAlertActors.Count <= 0)
		{
			SceneSingleton<AdventurePlayerController>.Instance._defaultSelect = null;
			SceneSingleton<AdventurePlayerController>.Instance.ClearSwitchTargetLs();
		}
		return logicEntity;
	}

	private LogicEntity getVisionAlertActor()
	{
		int num = -1;
		if (_enterVisionAlertActors.Count > 0)
		{
			FP fP = 999;
			if (_enterVisionAlertActors.Count == 1 && _enterVisionAlertActors.get_Item(0) != _actor.attackTarget)
			{
				num = 0;
			}
			else
			{
				for (int i = 0; i < _enterVisionAlertActors.Count; i++)
				{
					if (!(_actor.attackTarget != null) || !(_enterVisionAlertActors.get_Item(i) == _actor.attackTarget))
					{
						FP fP2 = _actor.DistanceWithRadius(_enterVisionAlertActors.get_Item(i));
						if (fP2 < fP)
						{
							num = i;
							fP = fP2;
						}
					}
				}
			}
			if (num >= 0)
			{
				SceneSingleton<AdventurePlayerController>.Instance.AddToSearchList(_enterVisionAlertActors.get_Item(num));
				return _enterVisionAlertActors.get_Item(num);
			}
		}
		return null;
	}

	private LogicEntity getHearingAlertActor()
	{
		int num = -1;
		if (_enterHearingAlertActors.Count > 0)
		{
			FP fP = 360;
			if (_enterHearingAlertActors.Count == 1)
			{
				num = 0;
			}
			else
			{
				for (int i = 0; i < _enterHearingAlertActors.Count; i++)
				{
					if (!(_actor.attackTarget != null) || !(_enterHearingAlertActors.get_Item(i) == _actor.attackTarget))
					{
						FP fP2 = TSVector2.Angle((_enterHearingAlertActors.get_Item(i).tsTransform.Position - _actor.tsTransform.Position).normalized, _actor.tsTransform.Forward);
						if (fP2 < fP)
						{
							fP = fP2;
							num = i;
						}
					}
				}
			}
			if (num >= 0)
			{
				SceneSingleton<AdventurePlayerController>.Instance.AddToSearchList(_enterHearingAlertActors.get_Item(num));
				return _enterHearingAlertActors.get_Item(num);
			}
		}
		return null;
	}

	public LogicEntity GetMonsterAttackTarget()
	{
		LogicEntity logicEntity = null;
		if (_actor == null)
		{
			return logicEntity;
		}
		if (_actor.isTaunt && !_actor.isTauntWeakened && _actor.tauntFromActor != null)
		{
			ActorHealthInfo actorHealthInfo = _actor.tauntFromActor.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && !_actor.tauntFromActor.IsSearchedImmunity())
			{
				logicEntity = _actor.tauntFromActor;
			}
		}
		if (logicEntity == null)
		{
			_monsterTargetActors.Clear();
			if (_actor.lastAttackMonster != null && _actor.lastAttackMonster.actorHealthInfo.isAlive && !_actor.lastAttackMonster.IsSearchedImmunity())
			{
				_monsterTargetActors.Add(_actor.lastAttackMonster);
			}
			if (SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor != null && !SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.IsSearchedImmunity())
			{
				_monsterTargetActors.Add(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor);
			}
			bool drawGizmos = false;
			if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(monsterSearchRange, _transform.Position, enterAlertColliders, 256, drawGizmos))
			{
				for (int i = 0; i < enterAlertColliders.Count; i++)
				{
					LogicEntity entity = enterAlertColliders.get_Item(i).Entity;
					if (!(entity == null))
					{
						AdventureActor adventureActor = entity as AdventureActor;
						if (!(adventureActor == null) && !_monsterTargetActors.Contains(entity) && adventureActor.IsSearchableByEnemy(_actor) && adventureActor.actorHealthInfo.isAlive)
						{
							_monsterTargetActors.Add(entity);
						}
					}
				}
			}
			if (_monsterTargetActors.Count > 0)
			{
				_actor.SearchEntitySortByDistance(_monsterTargetActors);
				logicEntity = _monsterTargetActors.get_Item(0);
			}
			if (logicEntity == null && SceneSingleton<AdventurePlayerController>.Instance.dynamicActor != null)
			{
				logicEntity = SceneSingleton<AdventurePlayerController>.Instance.dynamicActor;
			}
		}
		if (_lastMonsterTarget != logicEntity && !_firstSearchMonsterTarget)
		{
			AdventureMonsterTargetChangedEvent adventureMonsterTargetChangedEvent = AdventureMonsterTargetChangedEvent.Generate();
			adventureMonsterTargetChangedEvent.sender = _actor;
			adventureMonsterTargetChangedEvent.newTarget = logicEntity;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterTargetChangedEvent);
		}
		_lastMonsterTarget = logicEntity;
		if (_firstSearchMonsterTarget)
		{
			_firstSearchMonsterTarget = false;
		}
		return logicEntity;
	}

	public void InitAlertRngComponent()
	{
		if (isShowRng)
		{
			_hearingRngIndicator = SceneSingleton<AdventureIndicatorController>.Instance.SpawnCircleGraphicIndicator();
			if (null != _hearingRngIndicator)
			{
				_hearingRngIndicator.size = (float)(_hearRange * 2);
				_hearingRngIndicator.gameObject.SetActive(value: false);
			}
			_visionRngIndicator = SceneSingleton<AdventureIndicatorController>.Instance.SpawnFanGraphicIndicator();
			if (null != _visionRngIndicator)
			{
				_visionRngIndicator.size = (float)_visionRange;
				_visionRngIndicator.angle = (float)_visionDeg;
				_visionRngIndicator.gameObject.SetActive(value: false);
			}
			isShowing = false;
		}
	}

	public void EnableAlertRng()
	{
		if (isShowRng)
		{
			isShowing = true;
			UpdateAlearRng();
			if (null != _visionRngIndicator)
			{
				_visionRngIndicator.gameObject.SetActive(value: true);
			}
			if (null != _hearingRngIndicator)
			{
				_hearingRngIndicator.gameObject.SetActive(value: true);
			}
		}
	}

	public void DisableAlertRng()
	{
		if (isShowRng)
		{
			isShowing = false;
			if (null != _visionRngIndicator)
			{
				_visionRngIndicator.gameObject.SetActive(value: false);
			}
			if (null != _hearingRngIndicator)
			{
				_hearingRngIndicator.gameObject.SetActive(value: false);
			}
		}
	}

	protected void UpdateAlearRng()
	{
		if (!isShowing)
		{
			return;
		}
		TrueSyncTransform trueSyncTransform = _actor?.tsTransform;
		if (!(null == trueSyncTransform))
		{
			if (null != _hearingRngIndicator)
			{
				_hearingRngIndicator.position = trueSyncTransform.Position.ToVector2();
				_hearingRngIndicator.rotation = (float)trueSyncTransform.Rotation;
				_hearingRngIndicator.progress = 1f;
			}
			if (null != _visionRngIndicator)
			{
				_visionRngIndicator.position = trueSyncTransform.Position.ToVector2();
				_visionRngIndicator.rotation = (float)trueSyncTransform.Rotation;
				_visionRngIndicator.progress = 1f;
			}
		}
	}

	public void OnVisualUpdate()
	{
		UpdateAlearRng();
	}
}

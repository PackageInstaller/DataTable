using Nova.Hotfix;
using TrueSync;
using UnityEngine;

[RequireComponent(typeof(AdventureObstacle))]
public class DestructibleStateSingle : AdventureActor
{
	[Space]
	public FP _minHpPercent;

	public bool forbbeddenBeHurt;

	public GameObject endFx;

	[HideInInspector]
	public AdventureObstacle obstacle;

	private bool iActive;

	private int configID;

	private bool _initData;

	private DestructibleObject _destructibleObject;

	private long lockHp;

	private long _fixdeHp;

	private bool useFixHp;

	public AdventureInteractableEventTriggerGizmo adventureTriggerTask;

	protected override void OnInit()
	{
		actorInfo = AddOrGetLogicComponent<ActorInfo>();
		actorHealthInfo = AddOrGetLogicComponent<ActorHealthInfo>();
		actorElementInfo = AddOrGetLogicComponent<ActorElementInfo>();
		logicVariable = AddOrGetLogicComponent<LogicVariable>();
		AddOrGetLogicComponent<TrueSyncTransform>();
		InitializeMovementBehaviour();
		gameObject.layer = 8;
		if (obstacle == null)
		{
			obstacle = GetComponent<AdventureObstacle>();
		}
		obstacle.initData();
	}

	public void setDc(DeterministicCollider dc)
	{
		dtCollider = dc;
		tsTransform.transformSyncEnabled = false;
	}

	public void SetActiveSate(bool _active)
	{
		ActiveSelf = _active;
		if (iActive != _active)
		{
			iActive = _active;
			if (_active)
			{
				adventureTriggerTask?.Active(uniqueness: false, null, gameObject);
			}
		}
	}

	public void OnTriggerFx()
	{
		if (endFx != null)
		{
			AdventureFXPlayer.PlayFX(endFx, 1f, transform.position, Quaternion.identity);
		}
	}

	public override bool CurrentStepCanbeHurt()
	{
		if (_destructibleObject.beKill)
		{
			return false;
		}
		if (forbbeddenBeHurt)
		{
			return false;
		}
		return IsCurrentState();
	}

	public bool IsCurrentState()
	{
		if (iActive)
		{
			if (_minHpPercent <= 0 || lockHp <= 0)
			{
				return false;
			}
			if (_destructibleObject.LockHp)
			{
				return actorHealthInfo.hp > lockHp;
			}
			return actorHealthInfo.hp >= lockHp;
		}
		return false;
	}

	public void FixHp(long hp)
	{
		useFixHp = true;
		_fixdeHp = hp;
	}

	public HeightClass getHeight()
	{
		return obstacle.heightClass;
	}

	public LogicEntity GetOwner()
	{
		return _destructibleObject;
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
		iActive = true;
		actorHealthInfo.isAlive = true;
		OnLoadData();
		lockHp = (long)(actorHealthInfo.hpMax * _minHpPercent / 100f);
		if (useFixHp)
		{
			actorHealthInfo.hp = _fixdeHp;
			useFixHp = false;
		}
		if (_destructibleObject.LockHp)
		{
			if (lockHp >= actorHealthInfo.hp)
			{
				lockHp = actorHealthInfo.hp - 1;
			}
			LockHpAbs(lockHp);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
	}

	protected override void OnDeactive()
	{
		iActive = false;
		useFixHp = false;
		_fixdeHp = 0L;
		UnlockHp();
		if (actorHealthInfo != null)
		{
			actorHealthInfo.isAlive = false;
		}
		if (tsTransform != null)
		{
			tsTransform.transformSyncEnabled = false;
		}
		_initData = false;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
	}

	protected override void OnLogicUpdateEnabled()
	{
	}

	protected override void OnLogicUpdateDisabled()
	{
	}

	protected override void OnLogicUpdatePaused()
	{
	}

	protected override void OnLogicUpdateResumed()
	{
	}

	protected override void OnLogicTimeScaleChanged()
	{
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.to != null && adventureActorReceiveDamageEvent.to == this)
		{
			_destructibleObject?.FixHp(actorHealthInfo.hp);
			_destructibleObject?.CheckBeHitClear();
		}
	}

	public void OnKill()
	{
		_destructibleObject?.OnKill();
	}

	public void InitData(int _configID, DestructibleObject destructibleObject)
	{
		_destructibleObject = destructibleObject;
		configID = _configID;
		if (_initData)
		{
			OnLoadData();
		}
	}

	protected void OnLoadData()
	{
		if (configID <= 0)
		{
			_initData = true;
			return;
		}
		DestroyObject destroyObject = Singleton<HotfixDataController>.Instance.GetDestroyObject(configID);
		if (destroyObject == null)
		{
			Debug.LogError($"GetDestroyObject  config not exist, id:{configID}，objName:{gameObject.name}");
			return;
		}
		attributeList.Init();
		actorInfo.factionID = destroyObject.Faction;
		HotfixEnum.worldLevelType? worldLevelType = ModuleController<AdventureModuleController>.Instance?.levelType;
		FDP one = FDP.One;
		AdventureModuleLevelLoadParams levelLoadParams = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(destroyObject.Templete);
		if (monsterValueTempleteAdjust == null)
		{
			Debug.LogError($"DestructibleAdventureActor templeteInfo config not exist, TempleteId:{destroyObject.Templete}, spawnerInfo.level:{destroyObject.Lv}, levelDifficult:{levelLoadParams.levelDifficultLv}");
			return;
		}
		int monsterLevel = ModuleController<AdventureModuleController>.Instance.levelLoadParams.monsterLevel;
		if (worldLevelType == HotfixEnum.worldLevelType.StarTower)
		{
			long num = (long)monsterValueTempleteAdjust.TemplateId * 1000L + monsterLevel * 10 + levelLoadParams.levelDifficultLv;
			MonsterValueTemplete monsterValueTemplete = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(num);
			if (monsterValueTemplete == null)
			{
				Debug.LogError($"DestructibleAdventureActor templeteInfo config not exist, attrId:{num}, spawnerInfo.level:{destroyObject.Lv}, levelDifficult:{levelLoadParams.levelDifficultLv}");
				return;
			}
			actorHealthInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, one);
			actorInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, one);
			actorElementInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, one);
		}
		else
		{
			long num2 = (long)monsterValueTempleteAdjust.TemplateId * 1000L + monsterLevel * 10 + 1;
			MonsterValueTemplete monsterValueTemplete2 = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(num2);
			if (monsterValueTemplete2 == null)
			{
				Debug.LogError($"DestructibleAdventureActor templeteInfo config not exist, attrId:{num2}, spawnerInfo.level:{destroyObject.Lv}, levelDifficult:{levelLoadParams.levelDifficultLv}");
				return;
			}
			actorHealthInfo.SetOriginAttributeData(monsterValueTemplete2, monsterValueTempleteAdjust, one);
			actorInfo.SetOriginAttributeData(monsterValueTemplete2, monsterValueTempleteAdjust, one);
			actorElementInfo.SetOriginAttributeData(monsterValueTemplete2, monsterValueTempleteAdjust, one);
		}
	}

	public void AddTrigger()
	{
		Transform transform = base.transform.FindInChildren("triggerE");
		if (transform != null)
		{
			adventureTriggerTask = transform.GetComponent<AdventureInteractableEventTriggerGizmo>();
			return;
		}
		GameObject gameObject = new GameObject("triggerE");
		adventureTriggerTask = gameObject.AddComponent<AdventureInteractableEventTriggerGizmo>();
		gameObject.transform.SetParent(base.transform);
	}
}

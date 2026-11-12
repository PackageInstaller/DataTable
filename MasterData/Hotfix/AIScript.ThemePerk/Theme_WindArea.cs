#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.ThemePerk;

public class Theme_WindArea : BaseTheme
{
	private static readonly int areaTag = CommonHelper.StringToHash("OnlyZone");

	private static readonly int windAreaTag = CommonHelper.StringToHash("WindArea");

	private readonly FP searchTargetRadius = 10;

	private const string windBulletPath = "Misc/FateCard/Theme_WindBullet";

	private static readonly int damageTag_WindBullet = CommonHelper.StringToHash("WindBullet");

	private readonly Dictionary<int, string> windAreaEffectPathDic = new Dictionary<int, string>
	{
		[1] = "Misc/FateCard/Theme_WindArea_1",
		[2] = "Misc/FateCard/Theme_WindArea_2",
		[3] = "Misc/FateCard/Theme_WindArea_3",
		[4] = "Misc/FateCard/Theme_WindArea_4"
	};

	private const int maxAreaLevel_Default = 3;

	private readonly FP cumulativeValueForUpgrade = 60;

	private readonly FP timeForDowngrade = 10;

	private const int perkId_1 = 501201;

	private readonly FP triggerPercentage_1 = 100;

	private readonly FP cd_1 = 3;

	private readonly FP provideCumulativeValue_1 = 15;

	private const int hitDamageId_1 = 501201;

	private const int perkId_2 = 501202;

	private readonly FP triggerPercentage_2 = 100;

	private readonly FP cd_2 = 3;

	private readonly FP provideCumulativeValue_2 = 15;

	private const int hitDamageId_2 = 501202;

	private const int perkId_3 = 501203;

	private readonly FP triggerPercentage_3 = 100;

	private readonly FP cd_3 = 3;

	private readonly FP provideCumulativeValue_3 = 15;

	private const int hitDamageId_3 = 501203;

	private const int perkId_4 = 501204;

	private readonly FP triggerPercentage_4 = 100;

	private readonly FP cd_4 = 3;

	private readonly FP provideCumulativeValue_4 = 15;

	private const int hitDamageId_4 = 501204;

	private const int perkId_8 = 501208;

	private readonly Dictionary<int, int> additionalAttrIdDic_8 = new Dictionary<int, int>
	{
		[1] = 8,
		[2] = 16,
		[3] = 24,
		[4] = 6,
		[5] = 7
	};

	private readonly Dictionary<int, int> maxAttrCountDic_8 = new Dictionary<int, int>
	{
		[1] = 10,
		[2] = 10,
		[3] = 10,
		[4] = 3,
		[5] = 3
	};

	private const int perkId_9 = 501209;

	private readonly Dictionary<int, int> additionalAttrIdDic_9 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 25,
		[5] = 30
	};

	private readonly Dictionary<int, FP> addCumulativeValueDic_9 = new Dictionary<int, FP>
	{
		[1] = 5,
		[2] = 10,
		[3] = 15,
		[4] = 12,
		[5] = 15
	};

	private const int perkId_10 = 501210;

	private readonly Dictionary<int, int> buffIdDic_10 = new Dictionary<int, int>
	{
		[1] = 121011,
		[2] = 121021,
		[3] = 121031,
		[4] = 121041,
		[5] = 121051
	};

	private const int perkId_11 = 501211;

	private readonly FP triggerCumulativeValue_11 = 40;

	private readonly Dictionary<int, string> hitFxPathDic_11 = new Dictionary<int, string>
	{
		[1] = "FX/Perk/fx_perk_base_wind_wind_area_small_flash_11",
		[2] = "FX/Perk/fx_perk_base_wind_wind_area_small_flash_11",
		[3] = "FX/Perk/fx_perk_base_wind_wind_area_small_flash_11",
		[4] = "FX/Perk/fx_perk_base_wind_wind_area_big_flash_11"
	};

	private const string hittedFxPath_11 = "FX/ActorCommon/fx_common_hit_wind_magic";

	private const int hitDamageId_11 = 501211;

	private const int perkId_12 = 501212;

	private const int buffId_12 = 121211;

	private readonly Dictionary<int, FP> airBorneForceDic_12 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5
	};

	private readonly FP strenth_12 = 3;

	private const int perkId_13 = 501213;

	private readonly Dictionary<int, int> buffIdDic_13 = new Dictionary<int, int>
	{
		[1] = 121311,
		[2] = 121321,
		[3] = 121331,
		[4] = 121341,
		[5] = 121351
	};

	private const int perkId_14 = 501214;

	private const int buffId_14 = 121411;

	private readonly Dictionary<int, FP> triggerIntervalDic_14 = new Dictionary<int, FP>
	{
		[1] = 10,
		[2] = 10,
		[3] = 10,
		[4] = 7,
		[5] = 6
	};

	private readonly Dictionary<int, int> shootBulletCountDic_14 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 3,
		[5] = 3
	};

	private readonly FP shootInterval_14 = 0.5;

	private readonly FP provideCumulativeValue_14 = 15;

	private const int hitDamageId_14 = 501214;

	private const int perkId_15 = 501215;

	private const string windBulletPath_15 = "Misc/FateCard/Theme_WindBullet_15";

	private static readonly int windBulletTag_15 = CommonHelper.StringToHash("WindBullet_15");

	private readonly Dictionary<int, int> additionalAttrIdDic_15 = new Dictionary<int, int>
	{
		[1] = 50,
		[2] = 100,
		[3] = 150,
		[4] = 25,
		[5] = 30
	};

	private const int perkId_Task1 = 501216;

	private const int triggerCount_Task1 = 3;

	private const string windBulletPath_Task1 = "Misc/FateCard/Theme_WindBullet_16";

	private static readonly int windBulletTag_Task1 = CommonHelper.StringToHash("WindBullet_16");

	private readonly FP provideCumulativeValue_Task1 = 15;

	private readonly FP hitRadius_Task1 = 2.5;

	private const string hitFxPath_Task1 = "FX/Perk/fx_perk_base_wind_wind_area_explosion_high";

	private const int hitDamageId_Task1 = 501216;

	private const int perkId_Task2 = 501217;

	private readonly FP triggerInterval_Task2 = 3;

	private readonly FP provideCumulativeValue_Task2 = 5;

	private const int hitDamageId_Task2 = 501217;

	private const int perkId_Task3 = 501218;

	private const int buffId_Task3 = 2011;

	private CommomAreaHitConfig _areaHitConfig;

	private FP _totalCumulativeValue;

	private int _minAreaLevel;

	private int _maxAreaLevel;

	private int _nowAreaLevel;

	private AreaEffectEntity _windAreaEntity;

	private DeterministicShape _checkAreaShape;

	private FP _cumulativeValue_11;

	private HashSet<long> _triggerSet_11;

	private int _triggerCount_Task1;

	private CoroutineNode _downgradeCor;

	private CoroutineNode _perkCor_14;

	private CoroutineNode _perkCor_Task2;

	private FP CumulativeValue_11
	{
		get
		{
			return _cumulativeValue_11;
		}
		set
		{
			_cumulativeValue_11 = value;
			if (_cumulativeValue_11 >= triggerCumulativeValue_11)
			{
				AreaHit_Perk11();
				_cumulativeValue_11 -= triggerCumulativeValue_11;
			}
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		Clear();
		_minAreaLevel = 0;
		_maxAreaLevel = 3;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501215, out var _))
		{
			_minAreaLevel++;
			_maxAreaLevel++;
			_nowAreaLevel = _minAreaLevel;
			UpdateWindArea();
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501201, out var _) && CheckPerkCDTimeout(501201, cd_1) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_1 && GenerateWindBullet(GetWindBulletPath(), 501201, provideCumulativeValue_1))
		{
			TriggerPerk(501201);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501202, out var _) && CheckPerkCDTimeout(501202, cd_2) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_2 && GenerateWindBullet(GetWindBulletPath(), 501202, provideCumulativeValue_2))
		{
			TriggerPerk(501202);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501203, out var _) && CheckPerkCDTimeout(501203, cd_3) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_3 && GenerateWindBullet(GetWindBulletPath(), 501203, provideCumulativeValue_3))
		{
			TriggerPerk(501203);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501204, out var _) && CheckPerkCDTimeout(501204, cd_4) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_4 && GenerateWindBullet(GetWindBulletPath(), 501204, provideCumulativeValue_4))
		{
			TriggerPerk(501204);
		}
	}

	protected string GetWindBulletPath(bool isSuper = false)
	{
		if (isSuper)
		{
			return "Misc/FateCard/Theme_WindBullet_16";
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501215, out var _))
		{
			return "Misc/FateCard/Theme_WindBullet_15";
		}
		return "Misc/FateCard/Theme_WindBullet";
	}

	protected bool GenerateWindBullet(string bulletPath, int hitDamageId, FP provideCumulativeValue, bool randomTarget = false)
	{
		if (string.IsNullOrEmpty(bulletPath))
		{
			return false;
		}
		LogicEntity target = _actor.attackTarget;
		if (randomTarget)
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, searchTargetRadius, (List<LogicEntity> result) =>
			{
				target = ((result.Count > 0) ? result.get_Item(TSRandom.Range(0, result.Count)) : null);
			}, isConfront: true);
		}
		else
		{
			target = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchTargetRadius);
		}
		if (target == null)
		{
			return false;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501216, out var perkLevel) && _triggerCount_Task1 >= 3)
		{
			bulletPath = "Misc/FateCard/Theme_WindBullet_16";
			provideCumulativeValue = provideCumulativeValue_Task1;
			_triggerCount_Task1 = 0;
		}
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bulletPath, _actor, default, target: target, position: _actor.tsTransform.Position, positionY: default, targetPosition: default, aimType: AimType.Target, bulletDirectionType: BulletDirectionType.BulletToTarget);
		if (adventureBulletBase == null)
		{
			return false;
		}
		adventureBulletBase.hitDamageId = hitDamageId;
		adventureBulletBase.hitBox.hitDamageId = hitDamageId;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501209, out var perkLevel2))
		{
			provideCumulativeValue += addCumulativeValueDic_9.get_Item(perkLevel2);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501211, out perkLevel))
		{
			CumulativeValue_11 += provideCumulativeValue;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501216, out perkLevel) && !adventureBulletBase.CheckBulletTag(windBulletTag_Task1))
		{
			_triggerCount_Task1++;
		}
		FP fP = _totalCumulativeValue + provideCumulativeValue;
		if (fP >= cumulativeValueForUpgrade)
		{
			TryUpgradeWindArea(fP - cumulativeValueForUpgrade);
		}
		else
		{
			_totalCumulativeValue = fP;
		}
		return true;
	}

	protected void TryUpgradeWindArea(FP totalCumulativeValue)
	{
		if (_nowAreaLevel >= _maxAreaLevel)
		{
			_totalCumulativeValue = cumulativeValueForUpgrade;
			return;
		}
		_nowAreaLevel++;
		_totalCumulativeValue = totalCumulativeValue;
		UpdateWindArea();
	}

	protected void UpdateWindArea()
	{
		string value;
		if (_nowAreaLevel <= 0 && _windAreaEntity != null)
		{
			ILRuntimeAPI.StopAreaEffect(_windAreaEntity.Id);
		}
		else if (windAreaEffectPathDic.TryGetValue(_nowAreaLevel, out value))
		{
			long num = ILRuntimeAPI.PlayAreaEffect(_actor, value, _actor.tsTransform.Position, default, ModifyWindAreaParameter);
			if (num > 0)
			{
				_windAreaEntity = ILRuntimeAPI.GetAreaEffect(num);
				if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501214, out var perkLevel) && _perkCor_14 == null)
				{
					_perkCor_14 = StartLogicCoroutine(PerkLogic_14(triggerIntervalDic_14.get_Item(perkLevel), shootBulletCountDic_14.get_Item(perkLevel)));
				}
				if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501217, out var _) && _perkCor_Task2 == null)
				{
					_perkCor_Task2 = StartLogicCoroutine(PerkLogic_Task2());
				}
				if (_downgradeCor != null)
				{
					StopLogicCoroutine(_downgradeCor);
				}
				_downgradeCor = null;
				if (_nowAreaLevel > _minAreaLevel)
				{
					_downgradeCor = StartLogicCoroutine(AreaDowngradeLogic());
				}
			}
			else
			{
				NovaLogger.Error("风之领域释放失败,区域效果到达标签总数量或超过总限制数量");
			}
		}
		else
		{
			NovaLogger.Error($"未配置等级{_nowAreaLevel}的风之领域预制体路径");
		}
	}

	protected void ModifyWindAreaParameter(AreaEffectEntity windAreaEntity)
	{
		if (windAreaEntity == null)
		{
			return;
		}
		AreaEffect_BuffComponent[] components = windAreaEntity.GetComponents<AreaEffect_BuffComponent>();
		AreaEffect_BuffComponent areaEffect_BuffComponent = ((components.Length > 1) ? components[1] : null);
		AreaEffect_BuffComponent areaEffect_BuffComponent2 = ((components.Length > 2) ? components[2] : null);
		if (areaEffect_BuffComponent == null || areaEffect_BuffComponent2 == null)
		{
			NovaLogger.Error("风之领域区域效果未配置程序用Buff组件");
			return;
		}
		areaEffect_BuffComponent.addInterval = 0;
		areaEffect_BuffComponent.removeInterval = 0;
		areaEffect_BuffComponent.executeImmediately = false;
		areaEffect_BuffComponent.triggerEnterCriteriaInfo = new TargetFilterCriteriaInfo
		{
			filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
			{
				new TargetFilterCriteriaInfo.TargetFilterCriteria
				{
					targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
				}
			}
		};
		if (areaEffect_BuffComponent.addBuffIdList == null)
		{
			areaEffect_BuffComponent.addBuffIdList = new List<int>(2);
		}
		else
		{
			areaEffect_BuffComponent.addBuffIdList.Clear();
		}
		areaEffect_BuffComponent2.addInterval = 0;
		areaEffect_BuffComponent2.removeInterval = 0;
		areaEffect_BuffComponent2.executeImmediately = false;
		areaEffect_BuffComponent.triggerExitCriteriaInfo = new TargetFilterCriteriaInfo
		{
			filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
			{
				new TargetFilterCriteriaInfo.TargetFilterCriteria
				{
					targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
				}
			}
		};
		if (areaEffect_BuffComponent2.removeBuffIdList == null)
		{
			areaEffect_BuffComponent2.removeBuffIdList = new List<int>(2);
		}
		else
		{
			areaEffect_BuffComponent2.removeBuffIdList.Clear();
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501210, out var perkLevel))
		{
			areaEffect_BuffComponent.addBuffIdList.Add(buffIdDic_10.get_Item(perkLevel));
			areaEffect_BuffComponent2.removeBuffIdList.Add(buffIdDic_10.get_Item(perkLevel));
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501212, out var _))
		{
			areaEffect_BuffComponent.addBuffIdList.Add(121211);
			areaEffect_BuffComponent2.removeBuffIdList.Add(121211);
		}
		areaEffect_BuffComponent.triggerEnter = areaEffect_BuffComponent.addBuffIdList.Count > 0;
		areaEffect_BuffComponent2.triggerExit = areaEffect_BuffComponent2.removeBuffIdList.Count > 0;
	}

	protected IEnumerator PerkLogic_14(FP checkInterval, int shootCount)
	{
		FP interval_Check = 0;
		FP interval_Shoot = 0;
		int bulletCount = 0;
		while (_windAreaEntity != null)
		{
			if (interval_Check > 0)
			{
				interval_Check -= LogicDeltaTime;
			}
			else
			{
				if (_actor.buffComponent.CheckBuffByBuffID(121411))
				{
					bulletCount += shootCount;
				}
				_actor.buffComponent?.AddBuff(121411, _actor);
				interval_Check = checkInterval;
			}
			if (bulletCount > 0)
			{
				if (interval_Shoot > 0)
				{
					interval_Shoot -= LogicDeltaTime;
				}
				else if (GenerateWindBullet(GetWindBulletPath(), 501214, provideCumulativeValue_14))
				{
					bulletCount--;
					interval_Shoot = shootInterval_14;
				}
				else
				{
					interval_Shoot = 0;
				}
			}
			yield return null;
		}
	}

	protected IEnumerator PerkLogic_Task2()
	{
		FP triggerInterval = 0;
		while (_windAreaEntity != null)
		{
			if (!(triggerInterval > 0))
			{
				triggerInterval = ((!GenerateWindBullet(GetWindBulletPath(), 501217, provideCumulativeValue_Task2, randomTarget: true)) ? ((FP)0) : triggerInterval_Task2);
			}
			else
			{
				triggerInterval -= LogicDeltaTime;
			}
			yield return null;
		}
	}

	protected IEnumerator AreaDowngradeLogic()
	{
		FP time = timeForDowngrade;
		while (_windAreaEntity != null && _nowAreaLevel > _minAreaLevel)
		{
			if (time > 0)
			{
				time -= LogicDeltaTime;
			}
			else if (_totalCumulativeValue >= cumulativeValueForUpgrade)
			{
				_totalCumulativeValue = 0;
				time = timeForDowngrade;
			}
			else
			{
				_nowAreaLevel--;
				UpdateWindArea();
				time = timeForDowngrade;
			}
			yield return null;
		}
	}

	protected void OnAreaEffectBegin(IEvent evt)
	{
		AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = evt as AdventureAreaEffectBeginEvent;
		if (adventureAreaEffectBeginEvent.owner is PlayerAdventureActor)
		{
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(adventureAreaEffectBeginEvent.entityID);
			if (areaEffect.CheckTag(areaTag) && !areaEffect.CheckChildTag(windAreaTag))
			{
				ClearForAreaReplace();
			}
		}
	}

	protected void OnAreaEffectFinish(IEvent evt)
	{
		if (!(_windAreaEntity == null))
		{
			AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
			if (adventureAreaEffectFinishEvent.owner is PlayerAdventureActor && adventureAreaEffectFinishEvent.entityID == _windAreaEntity.Id)
			{
				_windAreaEntity = null;
			}
		}
	}

	protected void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		AdventureActor adventureActor = adventureActorReceiveDamageBeforeHitEvent.from as AdventureActor;
		AdventureActor adventureActor2 = adventureActorReceiveDamageBeforeHitEvent.to as AdventureActor;
		int perkLevel4;
		if (adventureActor is PlayerAdventureActor && adventureActor2 is MonsterAdventureActor)
		{
			if (!CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, damageTag_WindBullet))
			{
				return;
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501208, out var perkLevel))
			{
				int targetCountInArea = GetTargetCountInArea();
				if (targetCountInArea > 0)
				{
					int num = maxAttrCountDic_8.get_Item(perkLevel);
					int count = ((targetCountInArea < num) ? targetCountInArea : num);
					AdventureActor.AddFromAttr(additionalAttrIdDic_8.get_Item(perkLevel), _actor, count);
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501209, out var perkLevel2))
			{
				AdventureActor.AddFromAttr(additionalAttrIdDic_9.get_Item(perkLevel2), _actor);
			}
			if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501215, out var perkLevel3))
			{
				return;
			}
			AdventureBulletBase adventureBulletBase = adventureActorReceiveDamageBeforeHitEvent.weapon as AdventureBulletBase;
			if (adventureBulletBase != null && adventureBulletBase.CheckBulletTag(windBulletTag_15))
			{
				if (_triggerSet_11 == null)
				{
					_triggerSet_11 = new HashSet<long>();
				}
				if (_triggerSet_11.Add(adventureBulletBase.Id))
				{
					AdventureActor.AddFromAttr(additionalAttrIdDic_15.get_Item(perkLevel3), _actor);
				}
			}
		}
		else if (adventureActor2 is PlayerAdventureActor && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501214, out perkLevel4) && adventureActorReceiveDamageBeforeHitEvent.attackType == DamageType.Range && adventureActor2.buffComponent.CheckBuffByBuffID(121411))
		{
			adventureActor2.buffComponent.RemoveBuffByBuffId(121411);
			AdventureActor.SetToForceMissDamage(val: true);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		AdventureActor adventureActor = adventureActorReceiveDamageEvent.to as AdventureActor;
		if (adventureActor is MonsterAdventureActor)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501212, out var perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_WindBullet) && CheckTargetInArea(adventureActor))
			{
				adventureActor.AirBorne(airBorneForceDic_12.get_Item(perkLevel), strenth_12, HitBox.HurtAnimType.None, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501213, out var perkLevel2) && adventureActorReceiveDamageEvent.elementType == HotfixEnum.elementType.AE && CheckTargetInArea(adventureActor))
			{
				adventureActor.buffComponent?.AddBuff(buffIdDic_13.get_Item(perkLevel2), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501218, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_WindBullet) && CheckTargetInArea(adventureActor))
			{
				adventureActor.buffComponent?.AddBuff(2011, _actor);
			}
		}
	}

	protected override void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		base.OnBulletFinish(_evt);
		if (object.Equals(_evt.tag, windBulletTag_Task1))
		{
			AreaHit_PerkTask1(_evt.bulletPosition);
		}
	}

	protected List<LogicEntity> GetTargetsInArea()
	{
		if (_windAreaEntity == null)
		{
			return null;
		}
		_checkAreaShape.shapeType = DeterministicShape.ShapeType.Circle;
		_checkAreaShape.radius = _windAreaEntity.hitBoxRadius;
		_checkAreaShape.innerRadius = _windAreaEntity.hitBoxInnerRadius;
		_checkAreaShape.position = _windAreaEntity.tsTransform.Position;
		_checkAreaShape.rotation = _windAreaEntity.tsTransform.Rotation;
		List<LogicEntity> targetsFromShape = ILRuntimeAPI.GetTargetsFromShape(_checkAreaShape);
		ILRuntimeAPI.SearchActorConfront(_actor, targetsFromShape);
		return targetsFromShape;
	}

	protected int GetTargetCountInArea()
	{
		return GetTargetsInArea()?.Count ?? 0;
	}

	protected bool CheckTargetInArea(LogicEntity target)
	{
		List<LogicEntity> targetsInArea = GetTargetsInArea();
		if (targetsInArea == null)
		{
			return false;
		}
		for (int i = 0; i < targetsInArea.Count; i++)
		{
			if (targetsInArea.get_Item(i).Id == target.Id)
			{
				return true;
			}
		}
		return false;
	}

	protected void AreaHit_Perk11()
	{
		if (!(_windAreaEntity == null))
		{
			if (_areaHitConfig == null)
			{
				_areaHitConfig = new CommomAreaHitConfig();
			}
			_areaHitConfig.position = _windAreaEntity.tsTransform.Position;
			hitFxPathDic_11.TryGetValue(_nowAreaLevel, out _areaHitConfig.fxAlias);
			_areaHitConfig.hitDamageId = 501211;
			_areaHitConfig.hittedEffectAlias = "FX/ActorCommon/fx_common_hit_wind_magic";
			_areaHitConfig.damageImmuneDuration = -1;
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, _windAreaEntity.hitBoxRadius, _windAreaEntity.hitBoxInnerRadius);
		}
	}

	protected void AreaHit_PerkTask1(TSVector2 position)
	{
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.position = position;
		_areaHitConfig.fxAlias = "FX/Perk/fx_perk_base_wind_wind_area_explosion_high";
		_areaHitConfig.hitDamageId = 501216;
		_areaHitConfig.damageImmuneDuration = -1;
		ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, hitRadius_Task1, 0);
	}

	protected void ClearForAreaReplace()
	{
		if (_downgradeCor != null)
		{
			StopLogicCoroutine(_downgradeCor);
		}
		_downgradeCor = null;
		if (_perkCor_14 != null)
		{
			StopLogicCoroutine(_perkCor_14);
		}
		_perkCor_14 = null;
		if (_perkCor_Task2 != null)
		{
			StopLogicCoroutine(_perkCor_Task2);
		}
		_perkCor_Task2 = null;
		_totalCumulativeValue = 0;
		_nowAreaLevel = _minAreaLevel;
		_cumulativeValue_11 = 0;
		_triggerCount_Task1 = 0;
		_windAreaEntity = null;
	}

	protected void Clear()
	{
		if (_downgradeCor != null)
		{
			StopLogicCoroutine(_downgradeCor);
		}
		_downgradeCor = null;
		if (_perkCor_14 != null)
		{
			StopLogicCoroutine(_perkCor_14);
		}
		_perkCor_14 = null;
		if (_perkCor_Task2 != null)
		{
			StopLogicCoroutine(_perkCor_Task2);
		}
		_perkCor_Task2 = null;
		_totalCumulativeValue = 0;
		_nowAreaLevel = 0;
		_cumulativeValue_11 = 0;
		_triggerSet_11?.Clear();
		_triggerCount_Task1 = 0;
		_windAreaEntity = null;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		Clear();
	}
}

#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.ThemePerk;

public class Theme_WindEagle : BaseTheme
{
	private readonly FP searchTargetRadius = 7;

	private const string fxPath_AreaTrigger = "FX/Perk/fx_perk_base_wind_sickleweasel_atk_1";

	private readonly FP hitDelay = 0.4;

	private readonly FP duration_AreaEffect = 1.45;

	private const string areaEffectPath_Base = "Misc/FateCard/Theme_WindEagle";

	private readonly FP hitTimes_Base = 3;

	private static readonly int damageTag_WindEagle = CommonHelper.StringToHash("WindEagle");

	private static readonly int windMarkTag = CommonHelper.StringToHash("WindTag");

	private const int perkId_1 = 501101;

	private readonly FP triggerPercentage_1 = 100;

	private readonly FP cd_1 = 4;

	private const int hitDamageId_1 = 501101;

	private const int perkId_2 = 501102;

	private readonly FP triggerPercentage_2 = 100;

	private readonly FP cd_2 = 4;

	private const int hitDamageId_2 = 501102;

	private const int perkId_3 = 501103;

	private readonly FP triggerPercentage_3 = 100;

	private readonly FP cd_3 = 4;

	private const int hitDamageId_3 = 501103;

	private const int perkId_4 = 501104;

	private readonly FP triggerPercentage_4 = 100;

	private readonly FP cd_4 = 4;

	private const int hitDamageId_4 = 501104;

	private const int perkId_8 = 501108;

	private readonly Dictionary<int, int> additionalAttrDic_8 = new Dictionary<int, int>
	{
		[1] = 40,
		[2] = 80,
		[3] = 120,
		[4] = 25,
		[5] = 30
	};

	private const int perkId_9 = 501109;

	private const string fxPath_AreaTrigger_9 = "FX/Perk/fx_perk_base_wind_sickleweasel_atk_9";

	private const string areaEffectPath_Large = "Misc/FateCard/Theme_WindEagle_9";

	private readonly Dictionary<int, FP> triggerHPPercentDic_9 = new Dictionary<int, FP>
	{
		[1] = 80,
		[2] = 80,
		[3] = 80,
		[4] = 80,
		[5] = 80
	};

	private readonly Dictionary<int, int> additionalAttrDic_9 = new Dictionary<int, int>
	{
		[1] = 50,
		[2] = 100,
		[3] = 150,
		[4] = 25,
		[5] = 30
	};

	private const int perkId_10 = 501110;

	private readonly Dictionary<int, int> triggerTimesDic_10 = new Dictionary<int, int>
	{
		[1] = 3,
		[2] = 3,
		[3] = 3,
		[4] = 2,
		[5] = 1
	};

	private readonly Dictionary<int, int> buffIdDic_10 = new Dictionary<int, int>
	{
		[1] = 111011,
		[2] = 111021,
		[3] = 111031,
		[4] = 111041,
		[5] = 111051
	};

	private const int perkId_11 = 501111;

	private readonly Dictionary<int, int> addHitTimesDic_11 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5
	};

	private const int perkId_12 = 501112;

	private const int buffId_12_A = 111211;

	private const int buffId_12_B = 111212;

	private const int count_12_BuffAToB = 10;

	private readonly Dictionary<int, int> additionalAttrDic_9_A = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 10,
		[3] = 15,
		[4] = 25,
		[5] = 30
	};

	private readonly Dictionary<int, int> additionalAttrDic_9_B = new Dictionary<int, int>
	{
		[1] = 111211,
		[2] = 111221,
		[3] = 111231,
		[4] = 111241,
		[5] = 111251
	};

	private const int perkId_13 = 501113;

	private readonly FP cd_13 = 1;

	private readonly FP triggerPercentage_13 = 30;

	private const int hitDamageId_13 = 501113;

	private const string hittedFxPath_13 = "FX/ActorCommon/fx_common_hit_wind_magic";

	private readonly Dictionary<int, FP> airBorneForceDic_13 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5
	};

	private readonly FP hitStrenth_13 = 3;

	private const int perkId_14 = 501114;

	private readonly FP hitRadius_14 = 1.5;

	private const int hitDamageId_14 = 501114;

	private const string hitFxPath_14 = "FX/Perk/fx_perk_base_wind_sickleweasel_14_lv1";

	private const string hittedFxPath_14 = "FX/ActorCommon/fx_common_hit_wind_magic";

	private readonly Dictionary<int, FP> cdDic_14 = new Dictionary<int, FP>
	{
		[1] = 0.5,
		[2] = 0.5,
		[3] = 0.5,
		[4] = 0.5,
		[5] = 0.5
	};

	private const int perkId_15 = 501115;

	private const int hitDamageId_15 = 501115;

	private const string hittedFxPath_15 = "FX/Perk/fx_perk_base_wind_sickleweasel_15";

	private readonly Dictionary<int, int> triggerTimesDic_15 = new Dictionary<int, int>
	{
		[1] = 7,
		[2] = 5,
		[3] = 3,
		[4] = 2,
		[5] = 1
	};

	private const int perkId_Task_1 = 501116;

	private readonly Dictionary<int, int> buffIdDic_Task_1 = new Dictionary<int, int>
	{
		[1] = 111611,
		[2] = 111611,
		[3] = 111611,
		[4] = 111611,
		[5] = 111611
	};

	private readonly Dictionary<int, FP> triggerIntervalDic_Task_1 = new Dictionary<int, FP>
	{
		[1] = 5,
		[2] = 5,
		[3] = 5,
		[4] = 4,
		[5] = 2
	};

	private const int hitDamageId_Task_1 = 501116;

	private const int perkId_Task_2 = 501117;

	private const string areaEffectPath_Base_Task_2 = "Misc/FateCard/Theme_WindEagle_17";

	private const string areaEffectPath_Large_Task_2 = "Misc/FateCard/Theme_WindEagle_9_17";

	private readonly FP hitDelay_Task_2 = 1.75;

	private const int hitDamageId_Task_2 = 501117;

	private const string hittedFxPath_Task_2 = "FX/ActorCommon/fx_common_hit_wind_magic";

	private static readonly int damageTag_Task_2 = CommonHelper.StringToHash("WindEagle_Task_2");

	private readonly Dictionary<int, int> additionalAttrIdDic_Task_2 = new Dictionary<int, int>
	{
		[0] = 50,
		[1] = 50,
		[2] = 50,
		[3] = 45,
		[4] = 40,
		[5] = 35,
		[6] = 30,
		[7] = 20,
		[8] = 10,
		[9] = 0
	};

	private readonly FP pullMoveSpeed_Task_2 = 10;

	private const int pullMoveLevel_Task_2 = 99;

	private readonly FP pullStrenth_Task_2 = 4;

	private const int perkId_Task_3 = 501118;

	private readonly Dictionary<int, int> triggerTimesDic_Task_3 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 4,
		[3] = 3,
		[4] = 2,
		[5] = 1
	};

	private readonly FP hitRadius_Task_3 = 5;

	private const int hitDamageId_Task_3 = 501118;

	private const string hitFxPath_Task_3 = "FX/Perk/fx_perk_base_wind_sickleweasel_aoe_q3";

	private const string hittedFxPath_Task_3 = "FX/ActorCommon/fx_common_hit_wind_magic";

	private readonly FP hitStrenth_Task_3 = 4;

	private readonly FP stiffTime_Task_3 = 0.5;

	private PlayFX _playFX;

	private HitBox.HitBoxFeatureData _featureData;

	private CommomAreaHitConfig _areaHitConfig;

	private int _triggerTimes_10;

	private HashSet<long> _triggerSet_14;

	private Dictionary<long, int> _triggerDic_15;

	private int _triggerTimes_Task_3;

	private CoroutineNode _perkCor_Task_1;

	private List<FP> _pullDistanceList;

	public override void OnEnable()
	{
		base.OnEnable();
		Clear();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501116, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(buffIdDic_Task_1.get_Item(perkLevel), _actor);
			_perkCor_Task_1 = StartLogicCoroutine(CheckLogic_Task_1(triggerIntervalDic_Task_1.get_Item(perkLevel)));
		}
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501101, out var _) && CheckPerkCDTimeout(501101, cd_1) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_1 && GenerateWindEagle(501101))
		{
			TriggerPerk(501101);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501102, out var _) && CheckPerkCDTimeout(501102, cd_2) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_2 && GenerateWindEagle(501102))
		{
			TriggerPerk(501102);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501103, out var _) && CheckPerkCDTimeout(501103, cd_3) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_3 && GenerateWindEagle(501103))
		{
			TriggerPerk(501103);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501104, out var _) && CheckPerkCDTimeout(501104, cd_4) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_4 && GenerateWindEagle(501104))
		{
			TriggerPerk(501104);
		}
	}

	private IEnumerator CheckLogic_Task_1(FP checkInteval)
	{
		FP interval = 0;
		while (true)
		{
			if (!(interval > 0))
			{
				interval = ((!GenerateWindEagle(501116)) ? ((FP)0) : checkInteval);
			}
			else
			{
				interval -= LogicDeltaTime;
			}
			yield return null;
		}
	}

	protected bool GenerateWindEagle(int hitDamageId)
	{
		LogicEntity target = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchTargetRadius);
		if (target == null)
		{
			return false;
		}
		string windEaglgPrefabPath = GetWindEaglgPrefabPath();
		if (ILRuntimeAPI.PlayAreaEffect(_actor, windEaglgPrefabPath, target.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
		{
			if (areaEffect != null)
			{
				areaEffect.duration = duration_AreaEffect;
				AreaEffect_AttackComponent logicComponent = areaEffect.GetLogicComponent<AreaEffect_AttackComponent>();
				if (logicComponent != null)
				{
					logicComponent.hitDamageId = hitDamageId;
					logicComponent.hitDelay = hitDelay;
					logicComponent.damageImmuneDuration = -1;
					FP fP = duration_AreaEffect - hitDelay;
					if (hitTimes_Base > 0)
					{
						if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501111, out var perkLevel4))
						{
							logicComponent.hitInterval = fP / (hitTimes_Base + addHitTimesDic_11.get_Item(perkLevel4));
						}
						else
						{
							logicComponent.hitInterval = fP / hitTimes_Base;
						}
					}
					else
					{
						NovaLogger.Error("风鹰基础攻击次数配置有误");
					}
				}
				if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501117, out var _))
				{
					StartLogicCoroutine(AreaHit_PerkTask2(_actor, target.tsTransform.Position, areaEffect.hitBoxRadius));
				}
			}
		}) <= 0)
		{
			return false;
		}
		string text = "FX/Perk/fx_perk_base_wind_sickleweasel_atk_1";
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501109, out var _))
		{
			text = "FX/Perk/fx_perk_base_wind_sickleweasel_atk_9";
		}
		if (!string.IsNullOrEmpty(text))
		{
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			else
			{
				_playFX.Clear();
			}
			_playFX.Play(_actor, null, text, default, target.tsTransform.Position, default);
			_playFX.Clear();
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501110, out var perkLevel2))
		{
			_triggerTimes_10++;
			if (_triggerTimes_10 >= triggerTimesDic_10.get_Item(perkLevel2))
			{
				_actor.buffComponent.AddBuff(buffIdDic_10.get_Item(perkLevel2), _actor);
				_triggerTimes_10 = 0;
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501118, out var perkLevel3))
		{
			_triggerTimes_Task_3++;
			if (_triggerTimes_Task_3 >= triggerTimesDic_Task_3.get_Item(perkLevel3))
			{
				AreaHit_PerkTask3();
				_triggerTimes_Task_3 = 0;
			}
		}
		return true;
	}

	protected string GetWindEaglgPrefabPath()
	{
		bool themePerkLevel = ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501109, out var perkLevel);
		bool themePerkLevel2 = ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501117, out perkLevel);
		if (themePerkLevel & themePerkLevel2)
		{
			return "Misc/FateCard/Theme_WindEagle_9_17";
		}
		if (themePerkLevel)
		{
			return "Misc/FateCard/Theme_WindEagle_9";
		}
		if (themePerkLevel2)
		{
			return "Misc/FateCard/Theme_WindEagle_17";
		}
		return "Misc/FateCard/Theme_WindEagle";
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		_ = _evt.from;
		if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_WindEagle))
		{
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501108, out var perkLevel))
			{
				AdventureActor.AddFromAttr(additionalAttrDic_8.get_Item(perkLevel), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501109, out var perkLevel2) && (FP)monsterAdventureActor.actorHealthInfo.hpPercentage > triggerHPPercentDic_9.get_Item(perkLevel2) / 100L)
			{
				AdventureActor.AddFromAttr(additionalAttrDic_9.get_Item(perkLevel2), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501112, out var perkLevel3))
			{
				if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(111211))
				{
					AdventureActor.AddFromAttr(additionalAttrDic_9_A.get_Item(perkLevel3), _actor, monsterAdventureActor.buffComponent.GetBuffNumByID(111211));
				}
				else if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(111212))
				{
					AdventureActor.AddFromAttr(additionalAttrDic_9_B.get_Item(perkLevel3), _actor);
				}
			}
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501117, out var _) || !CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_Task_2))
		{
			return;
		}
		FP fP = (FP)monsterAdventureActor.actorHealthInfo.hpPercentage;
		if (fP < 100)
		{
			int key = TSMath.FloorToInt(fP * 10);
			if (additionalAttrIdDic_Task_2.TryGetValue(key, out var value) && value > 0)
			{
				AdventureActor.AddFromAttr(value, _actor);
			}
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null) || !CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_WindEagle))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501112, out var perkLevel) && !monsterAdventureActor.buffComponent.CheckBuffByBuffID(111212))
		{
			if (monsterAdventureActor.buffComponent.GetBuffNumByID(111211) + 1 >= 10)
			{
				monsterAdventureActor.buffComponent.RemoveBuffByBuffId(111211);
				monsterAdventureActor.buffComponent.AddBuff(111212, _actor);
			}
			else
			{
				monsterAdventureActor.buffComponent.AddBuff(111211, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501113, out var perkLevel2) && CheckPerkCDTimeout(501113, cd_13) && (CommonUtils.CheckElementMark(CommonDefine.Wind, monsterAdventureActor) || TSRandom.Range(FP.Zero, 100) <= triggerPercentage_13))
		{
			SingleHit_Perk13(monsterAdventureActor, airBorneForceDic_13.get_Item(perkLevel2));
			TriggerPerk(501113);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501114, out perkLevel))
		{
			if (_triggerSet_14 == null)
			{
				_triggerSet_14 = new HashSet<long>();
			}
			_triggerSet_14.Add(monsterAdventureActor.Id);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501115, out var perkLevel3))
		{
			if (_triggerDic_15 == null)
			{
				_triggerDic_15 = new Dictionary<long, int>(10);
			}
			if (_triggerDic_15.ContainsKey(monsterAdventureActor.Id))
			{
				_triggerDic_15.get_Item(monsterAdventureActor.Id)++;
			}
			else
			{
				_triggerDic_15.Add(monsterAdventureActor.Id, 1);
			}
			if (_triggerDic_15.get_Item(monsterAdventureActor.Id) >= triggerTimesDic_15.get_Item(perkLevel3))
			{
				SingleHit_Perk15(monsterAdventureActor);
				_triggerDic_15.set_Item(monsterAdventureActor.Id, 0);
			}
		}
	}

	protected override void OnMonsterKilled(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnMonsterKilled(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501114, out var perkLevel))
		{
			HashSet<long> triggerSet_ = _triggerSet_14;
			if (triggerSet_ != null && triggerSet_.Remove(monsterAdventureActor.Id) && CheckPerkCDTimeout(501114, cdDic_14.get_Item(perkLevel)))
			{
				AreaHit_Perk14(monsterAdventureActor.tsTransform.Position);
				TriggerPerk(501114);
			}
		}
	}

	protected void SingleHit_Perk13(AdventureActor target, FP airBorneForce)
	{
		if (!target.IsDead())
		{
			if (_featureData == null)
			{
				_featureData = new HitBox.HitBoxFeatureData();
			}
			_featureData.KnockBackForce = airBorneForce;
			_featureData.hitStrenth = hitStrenth_13;
			ILRuntimeAPI.HitActor(_actor, target, 501113, "FX/ActorCommon/fx_common_hit_wind_magic", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.AirBorne, _featureData);
		}
	}

	protected void AreaHit_Perk14(TSVector2 position)
	{
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.fxAlias = "FX/Perk/fx_perk_base_wind_sickleweasel_14_lv1";
		_areaHitConfig.position = position;
		_areaHitConfig.hitDamageId = 501114;
		_areaHitConfig.hittedEffectAlias = "FX/ActorCommon/fx_common_hit_wind_magic";
		ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, hitRadius_14, 0);
	}

	protected void SingleHit_Perk15(AdventureActor target)
	{
		if (!target.IsDead())
		{
			ILRuntimeAPI.HitActor(_actor, target, 501115, "FX/Perk/fx_perk_base_wind_sickleweasel_15");
		}
	}

	protected IEnumerator AreaHit_PerkTask2(AdventureActor actor, TSVector2 position, FP hitRadius)
	{
		yield return hitDelay_Task_2;
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.position = position;
		_areaHitConfig.hitDamageId = 501117;
		_areaHitConfig.hittedEffectAlias = "FX/ActorCommon/fx_common_hit_wind_magic";
		ILRuntimeAPI.CircleAreaHit(actor, _areaHitConfig, hitRadius, 0);
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, position, hitRadius, (List<LogicEntity> targets) =>
		{
			if (targets != null && targets.Count > 0)
			{
				if (_pullDistanceList == null)
				{
					_pullDistanceList = new List<FP>(5);
				}
				else
				{
					_pullDistanceList.Clear();
				}
				for (int i = 0; i < targets.Count; i++)
				{
					_pullDistanceList.Add(TSVector2.Distance(targets.get_Item(i).tsTransform.Position, position));
				}
				ILRuntimeAPI.ForceMoveToPosition(position, targets, pullMoveSpeed_Task_2, _pullDistanceList, isCoExist: true, isChangeForward: true, 99, pullStrenth_Task_2);
			}
		}, isConfront: true);
	}

	protected void AreaHit_PerkTask3()
	{
		if (_featureData == null)
		{
			_featureData = new HitBox.HitBoxFeatureData();
		}
		_featureData.StiffDuration = stiffTime_Task_3;
		_featureData.hitStrenth = hitStrenth_Task_3;
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.fxAlias = "FX/Perk/fx_perk_base_wind_sickleweasel_aoe_q3";
		_areaHitConfig.position = _actor.tsTransform.Position;
		_areaHitConfig.hitDamageId = 501118;
		_areaHitConfig.hitFlags = HitBox.FeatureFlag.Stiff;
		_areaHitConfig.hitFeatureData = _featureData;
		_areaHitConfig.hittedEffectAlias = "FX/ActorCommon/fx_common_hit_wind_magic";
		ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, hitRadius_Task_3, 0);
	}

	protected void Clear()
	{
		_triggerTimes_10 = 0;
		_triggerSet_14?.Clear();
		_triggerDic_15?.Clear();
		if (_perkCor_Task_1 != null)
		{
			StopLogicCoroutine(_perkCor_Task_1);
		}
		_perkCor_Task_1 = null;
		_triggerTimes_Task_3 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		Clear();
	}
}

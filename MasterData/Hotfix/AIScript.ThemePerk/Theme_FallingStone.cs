using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.ThemePerk;

public class Theme_FallingStone : BaseTheme
{
	private const string bulletPath = "Misc/FateCard/Theme_FallingStone";

	private static readonly int attackTag = CommonHelper.StringToHash("FallingStone");

	private static readonly int attackTag_enhance = CommonHelper.StringToHash("EnhanceFallingStone");

	private readonly FP targetSearchRange = 8;

	private const string bulletTag = "FallingStone";

	private const string triggerFxPath = "FX/Perk/fx_perk_base_fire_trigger_s";

	private static readonly int areaEffectTag = CommonHelper.StringToHash("stone_areaEffect");

	private readonly FP bulletAttackRadius = 2;

	private const int perkId_1 = 500301;

	private readonly FP cd_1 = 6;

	private readonly FP trigger_Percentage1 = 100;

	private const int hitDamageId_1 = 500301;

	private const int hitDamageId_1_enhance = 500319;

	private const int perkId_2 = 500302;

	private readonly FP cd_2 = 6;

	private readonly FP trigger_Percentage2 = 100;

	private const int hitDamageId_2 = 500302;

	private const int hitDamageId_2_enhance = 500320;

	private const int perkId_3 = 500303;

	private readonly FP cd_3 = 6;

	private readonly FP trigger_Percentage3 = 100;

	private const int hitDamageId_3 = 500303;

	private const int hitDamageId_3_enhance = 500321;

	private const int perkId_4 = 500304;

	private readonly FP cd_4 = 6;

	private readonly FP trigger_Percentage4 = 100;

	private const int hitDamageId_4 = 500304;

	private const int hitDamageId_4_enhance = 500322;

	private const int perkId_8 = 500308;

	private readonly Dictionary<int, int> buffIdDict_8 = new Dictionary<int, int>
	{
		[1] = 30811,
		[2] = 30821,
		[3] = 30831,
		[4] = 30841,
		[5] = 30851,
		[6] = 30861
	};

	private const int perkId_9 = 500309;

	private readonly Dictionary<int, int> buffIdDict_9 = new Dictionary<int, int>
	{
		[1] = 30911,
		[2] = 30921,
		[3] = 30931,
		[4] = 30941,
		[5] = 30951,
		[6] = 30961
	};

	private const int perkId_10 = 500310;

	private readonly Dictionary<int, int> buffIdDict_10 = new Dictionary<int, int>
	{
		[1] = 31011,
		[2] = 31021,
		[3] = 31031,
		[4] = 31041,
		[5] = 31051,
		[6] = 31061
	};

	private const int perkId_11 = 500311;

	private readonly string areaEffect_11 = "Misc/FateCard/Theme_FallingStone_11_Area";

	private readonly Dictionary<int, int> areaEffect_limit_dict = new Dictionary<int, int>
	{
		[1] = 3,
		[2] = 4,
		[3] = 5,
		[4] = 4,
		[5] = 4
	};

	private const int perkId_12 = 500312;

	private readonly FP attackRange_12 = 15;

	private readonly string attactEffectPath_12 = "FX/Perk/fx_perk_base_fire_meteorite_12";

	private readonly string attackTag_12 = "yunshi";

	private readonly Dictionary<int, int> hpPercentDict = new Dictionary<int, int>
	{
		[1] = 10,
		[2] = 15,
		[3] = 20,
		[4] = 35,
		[5] = 35
	};

	private readonly FP atkPercentForDamageLimit = 500;

	private readonly Dictionary<int, int> summonLimitDict = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 1,
		[3] = 2,
		[4] = 3,
		[5] = 3
	};

	private readonly FP damamgeDelay = 0.5;

	private const int perkId_13 = 500313;

	private readonly Dictionary<int, string> bulletPath_13_dict = new Dictionary<int, string>
	{
		[1] = "Misc/FateCard/Theme_FallingStone_13_lv1",
		[2] = "Misc/FateCard/Theme_FallingStone_13_lv2",
		[3] = "Misc/FateCard/Theme_FallingStone_13_lv3",
		[4] = "Misc/FateCard/Theme_FallingStone_13_lv3",
		[5] = "Misc/FateCard/Theme_FallingStone_13_lv3"
	};

	private const int perkId_14 = 500314;

	private static readonly int fireTag = CommonHelper.StringToHash("FireTag");

	private readonly FP cd_14 = 0;

	private readonly FP trigger_Percentage_14 = 50;

	private readonly Dictionary<int, int> additionalAttrIdDict_14 = new Dictionary<int, int>
	{
		[1] = 50,
		[2] = 100,
		[3] = 150,
		[4] = 35,
		[5] = 40,
		[6] = 45
	};

	private const int perkId_15 = 500315;

	private readonly string effectPath_15 = "FX/Perk/fx_perk_loop_fire_meteorite_15";

	private readonly FP duration_15 = 5;

	private readonly FP attackRange_15 = 10;

	private readonly string bulletPath_15 = "Misc/FateCard/Theme_FallingStone_15_bullet";

	private readonly Dictionary<int, FP> attackIntervalDict_15 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 0.65,
		[3] = 0.5,
		[4] = 0.5,
		[5] = 0.5
	};

	private const int perkId_intensive1 = 500316;

	private readonly int replaceCount = 3;

	private readonly Dictionary<int, string> bulletPath_intensive1_dict = new Dictionary<int, string>
	{
		[0] = "Misc/FateCard/Theme_FallingStone_16",
		[1] = "Misc/FateCard/Theme_FallingStone_16_13_lv1",
		[2] = "Misc/FateCard/Theme_FallingStone_16_13_lv2",
		[3] = "Misc/FateCard/Theme_FallingStone_16_13_lv3",
		[4] = "Misc/FateCard/Theme_FallingStone_16_13_lv3",
		[5] = "Misc/FateCard/Theme_FallingStone_16_13_lv3"
	};

	private readonly Dictionary<int, int> additionalAttrIdDict_intensive1 = new Dictionary<int, int>
	{
		[0] = 123,
		[1] = 123,
		[2] = 123,
		[3] = 123,
		[4] = 123,
		[5] = 123
	};

	private const int perkId_intensive2 = 500317;

	private const string bulletPath_instensive2_timeBoom = "Misc/FateCard/Theme_FallingStone_17";

	private const int perkId_intensive3 = 500318;

	private const string areaEffectPath_instensive3 = "Misc/FateCard/Theme_FallingStone_18_Area";

	private const int buffId_intensive3 = 31811;

	private readonly string areaEffect_11_intensive2 = "Misc/FateCard/Theme_FallingStone_17_11_Area";

	private const string bulletPath_11_instensive2_timeBoom = "Misc/FateCard/Theme_FallingStone_17_11";

	private Dictionary<long, FP> monsterHittedTimeDic;

	private List<int> _perkEffectIdList;

	private int summonLimit;

	private const string shootCountKey = "fallingStoneShootCount";

	private TSVector2 lastFallingStonePosition;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DIRECT_DAMAGE_KILL", OnDirectKill);
		_perkEffectIdList = new List<int>(10);
		monsterHittedTimeDic = new Dictionary<long, FP>();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DIRECT_DAMAGE_KILL", OnDirectKill);
		_perkEffectIdList.Clear();
		_perkEffectIdList = null;
		monsterHittedTimeDic.Clear();
		monsterHittedTimeDic = null;
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500301, out var _) && CheckPerkCDTimeout(500301, cd_1 * GetShootCDPercentAmend()) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage1 + GetShootRateAmend())
		{
			Shoot(500301, 500319);
			TriggerPerk(500301);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500302, out var _) && CheckPerkCDTimeout(500302, cd_2 * GetShootCDPercentAmend()) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage2 + GetShootRateAmend())
		{
			Shoot(500302, 500320);
			TriggerPerk(500302);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500303, out var _) && CheckPerkCDTimeout(500303, cd_3 * GetShootCDPercentAmend()) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage3 + GetShootRateAmend())
		{
			Shoot(500303, 500321);
			TriggerPerk(500303);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500304, out var _) && CheckPerkCDTimeout(500304, cd_4 * GetShootCDPercentAmend()) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage4 + GetShootRateAmend())
		{
			Shoot(500304, 500322);
			TriggerPerk(500304);
		}
	}

	protected override void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		if (_evt == null || !(_evt.tag == "FallingStone"))
		{
			return;
		}
		lastFallingStonePosition = _evt.bulletPosition;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500311, out var perkLevel) && ILRuntimeAPI.GetAreaEffectByTag(areaEffectTag).Count < areaEffect_limit_dict.get_Item(perkLevel))
		{
			string fxAlias = areaEffect_11;
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500317, out var _))
			{
				fxAlias = areaEffect_11_intensive2;
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _evt.bulletPosition);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500315, out var perkLevel3))
		{
			_actor.StartLogicCoroutine(Perk15ExtraAttack(_evt.bulletPosition, perkLevel3));
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500317, out var _))
		{
			string bulletAlias = "Misc/FateCard/Theme_FallingStone_17";
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500311, out var _))
			{
				bulletAlias = "Misc/FateCard/Theme_FallingStone_17_11";
			}
			ILRuntimeAPI.Shoot(bulletAlias, _actor, default, _evt.bulletPosition, 1, _evt.bulletPosition, null, AimType.Position);
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500318, out var _))
		{
			return;
		}
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, _evt.bulletPosition, bulletAttackRadius, (List<LogicEntity> result) =>
		{
			if (result.Contains(_actor))
			{
				_actor.buffComponent?.AddBuff(31811, _actor);
				ILRuntimeAPI.PlayAreaEffect(_actor, "Misc/FateCard/Theme_FallingStone_18_Area", _actor.tsTransform.Position);
			}
		}, isConfront: false, onlyAlive: true, includeSelf: true);
	}

	private IEnumerator Perk15ExtraAttack(TSVector2 position, int level)
	{
		PlayFX playFX = new PlayFX();
		playFX.Play(_actor, null, effectPath_15, _actor.tsTransform.PositionY, position, _actor.tsTransform.Forward);
		FP duration = duration_15;
		FP shootInterval = attackIntervalDict_15.get_Item(level);
		FP shootTimeCount = 0;
		while (duration > 0)
		{
			duration -= _actor.LogicDeltaTime;
			shootTimeCount += _actor.LogicDeltaTime;
			if (shootTimeCount >= shootInterval)
			{
				shootTimeCount = 0;
				shoot();
			}
			yield return null;
		}
		playFX.Stop();
		void shoot()
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, position, attackRange_15, (List<LogicEntity> result) =>
			{
				if (result.Count > 0)
				{
					foreach (LogicEntity item in result)
					{
						string bulletAlias = bulletPath_15;
						AdventureActor actor = _actor;
						TSVector2 position2 = position;
						FP positionY = 1;
						LogicEntity target = item;
						ILRuntimeAPI.Shoot(bulletAlias, actor, default, position2, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
					}
				}
			}, isConfront: true);
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		AdventureActor adventureActor = evt.to as AdventureActor;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, attackTag) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500310, out var perkLevel))
		{
			adventureActor.buffComponent?.AddBuff(buffIdDict_10.get_Item(perkLevel), _actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		AdventureActor target = evt.to as AdventureActor;
		_ = evt.from;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, attackTag) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500314, out var perkLevel) && CheckPerkCDTimeout(500314, cd_14))
		{
			if (CommonUtils.CheckElementMark(CommonDefine.Fire, target))
			{
				AdventureActor.AddFromAttr(additionalAttrIdDict_14.get_Item(perkLevel), _actor);
			}
			else if (TSRandom.Range(FP.Zero, 100) <= trigger_Percentage_14)
			{
				AdventureActor.AddFromAttr(additionalAttrIdDict_14.get_Item(perkLevel), _actor);
			}
			TriggerPerk(500314);
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, attackTag_enhance))
		{
			ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500313, out var perkLevel2);
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500316, out var _))
			{
				AdventureActor.AddFromAttr(additionalAttrIdDict_intensive1.get_Item(perkLevel2), _actor);
			}
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent evt)
	{
		_ = evt.to;
		if (_perkEffectIdList.Count > 0)
		{
			_actor.effectManage.RemoveEffectByAI(_perkEffectIdList);
		}
		for (int i = 0; i < evt.hitDamageTag.Count; i++)
		{
			if (object.Equals(evt.hitDamageTag.get_Item(i), attackTag))
			{
				if (evt.isKill)
				{
					summonAttack();
				}
				break;
			}
		}
	}

	private void OnDirectKill(IEvent evt)
	{
		if (evt is DirectDamageKillEvent directDamageKillEvent && directDamageKillEvent.tag == attackTag_12)
		{
			summonAttack();
		}
	}

	private void summonAttack()
	{
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500312, out var level_12) || summonLimit <= 0)
		{
			return;
		}
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, lastFallingStonePosition, attackRange_12, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				CommonHelper.SearchEntitySortByHP(result, compareByPercentage: true);
				AdventureActor adventureActor = result.get_Item(0) as AdventureActor;
				CommonUtils.PlayOneOffFx(adventureActor, attactEffectPath_12);
				_actor.StartLogicCoroutine(delayDamage(adventureActor));
				summonLimit--;
			}
		}, isConfront: true);
		IEnumerator delayDamage(AdventureActor target)
		{
			yield return damamgeDelay;
			if (target != null && target.actorHealthInfo.isAlive)
			{
				FP val = (float)target.actorHealthInfo.hpMax * ((float)hpPercentDict.get_Item(level_12) / 100f);
				FP val2 = (FP)_actor.actorInfo.atk * (atkPercentForDamageLimit / 100L);
				val = TSMath.Min(val, val2);
				target.DirectDamage((int)(long)val, attackTag_12, _actor.Id);
			}
		}
	}

	private void Shoot(int hitDamageId, int hitDamageIdEnhance)
	{
		LogicEntity shootTarget = GetShootTarget();
		if (!(shootTarget == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_fire_trigger_s");
			(bool, string) tuple = GetBulletPath();
			bool item = tuple.Item1;
			string item2 = tuple.Item2;
			AdventureActor actor = _actor;
			TSVector2 position = shootTarget.tsTransform.Position;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(item2, actor, default, default, default, position, null, AimType.Position);
			if (!item)
			{
				adventureBulletBase.hitBox.hitDamageId = hitDamageId;
			}
			else
			{
				adventureBulletBase.hitBox.hitDamageId = hitDamageIdEnhance;
			}
			adventureBulletBase.useOwnerActorInfo = true;
			AddKey("fallingStoneShootCount");
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500312, out var perkLevel))
			{
				summonLimit = summonLimitDict.get_Item(perkLevel);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500308, out var perkLevel2))
			{
				_actor.buffComponent?.AddBuff(buffIdDict_8.get_Item(perkLevel2), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500309, out var perkLevel3))
			{
				_actor.buffComponent?.AddBuff(buffIdDict_9.get_Item(perkLevel3), _actor);
			}
		}
	}

	private (bool, string) GetBulletPath()
	{
		bool item = false;
		string item2 = "Misc/FateCard/Theme_FallingStone";
		int perkLevel = 0;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500313, out perkLevel))
		{
			item2 = bulletPath_13_dict.get_Item(perkLevel);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500316, out var _) && GetKeyCount("fallingStoneShootCount") == replaceCount + 1)
		{
			ClearKey("fallingStoneShootCount");
			item2 = bulletPath_intensive1_dict.get_Item(perkLevel);
			item = true;
		}
		return (item, item2);
	}

	private LogicEntity GetShootTarget()
	{
		if (_actor.attackTarget != null)
		{
			return _actor.attackTarget;
		}
		LogicEntity target = null;
		ILRuntimeAPI.SearchByRange(_actor, targetSearchRange, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.SearchEntitySortByDistance(result);
				target = result.get_Item(0);
			}
		}, isConfront: true);
		return target;
	}

	private FP GetShootRateAmend()
	{
		return 0;
	}

	private FP GetShootCDPercentAmend()
	{
		return (FP)100 / (FP)100;
	}
}

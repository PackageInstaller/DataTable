using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_LightingChain : BaseTheme
{
	private const int baseBounceTime = 2;

	private readonly string hitFxPath = "FX/Perk/fx_perk_bullet_light_lightning_01";

	private const int damageReduceEffectId = 425;

	private static readonly int attackTag = CommonHelper.StringToHash("lightingChain");

	private readonly FP targetSearchRange = 15;

	private readonly FP linkCheckRange = 8;

	private readonly FP linkHitInterval = 0.2;

	private const string triggerFxPath = "FX/Perk/fx_perk_base_light_trigger_s";

	private static readonly int lightMaskTag = CommonHelper.StringToHash("LightTag");

	private readonly int lightMaskBuff = 10700001;

	private string hitFxPath_strong = "FX/Perk/fx_perk_bullet_light_lightning_15";

	private static readonly int hitTag_Strong = CommonHelper.StringToHash("StronglightingChain");

	private Dictionary<int, int> dicDamageId = new Dictionary<int, int>
	{
		[1] = 500505,
		[2] = 500506,
		[3] = 500507,
		[4] = 500508
	};

	private readonly FP delayTime = 0.5f;

	private const int perkId_1 = 500501;

	private readonly FP cd_1 = 4;

	private readonly FP trigger_Percentage1 = 100;

	private const int hitDamageId_1 = 500501;

	private const int perkId_2 = 500502;

	private readonly FP cd_2 = 4;

	private readonly FP trigger_Percentage2 = 100;

	private const int hitDamageId_2 = 500502;

	private const int perkId_3 = 500503;

	private readonly FP cd_3 = 4;

	private readonly FP trigger_Percentage3 = 100;

	private const int hitDamageId_3 = 500503;

	private const int perkId_4 = 500504;

	private readonly FP cd_4 = 4;

	private readonly FP trigger_Percentage4 = 100;

	private const int hitDamageId_4 = 500504;

	private const int perkId_8 = 500508;

	private readonly Dictionary<int, int> dicEff_8 = new Dictionary<int, int>
	{
		[1] = 35,
		[2] = 70,
		[3] = 105,
		[4] = 75,
		[5] = 100,
		[6] = 120
	};

	private const int perkId_9 = 500509;

	private readonly Dictionary<int, int> dicBuff_9 = new Dictionary<int, int>
	{
		[1] = 50911,
		[2] = 50921,
		[3] = 50931,
		[4] = 50941,
		[5] = 50951
	};

	private const int perkId_10 = 500510;

	private readonly FP cd_10 = 1;

	private const int targetNum = 3;

	private readonly Dictionary<int, int> difBuff_10 = new Dictionary<int, int>
	{
		[1] = 51011,
		[2] = 51021,
		[3] = 51031,
		[4] = 51041,
		[5] = 51051
	};

	private const int perkId_11 = 500511;

	private readonly FP cd_11 = 1;

	private Dictionary<int, int> dicProb_11 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 90,
		[5] = 100
	};

	private const int perkId_12 = 500512;

	private readonly FP cd_12 = 3;

	private FP radius_12 = 10;

	private int hitDamageId_12 = 500512;

	private string hitFxPath_12 = "FX/Perk/fx_perk_base_light_lightning_blue_12";

	private const int perkId_13 = 500513;

	private readonly FP cd_13 = 0;

	private Dictionary<int, FP> dicCd_13 = new Dictionary<int, FP>
	{
		[1] = 0.2f,
		[2] = 0.3f,
		[3] = 0.4f,
		[4] = 1f,
		[5] = 1f
	};

	private const int perkId_14 = 500514;

	private Dictionary<int, FP> dicPro_14 = new Dictionary<int, FP>
	{
		[1] = 20,
		[2] = 40,
		[3] = 60,
		[4] = 35,
		[5] = 50
	};

	private Dictionary<int, FP> dicCd_14 = new Dictionary<int, FP>
	{
		[1] = 4,
		[2] = 4,
		[3] = 4,
		[4] = 4,
		[5] = 4
	};

	private Dictionary<int, int> dicDmg_14 = new Dictionary<int, int>
	{
		[1] = 500514,
		[2] = 500514,
		[3] = 500514,
		[4] = 500514,
		[5] = 500514
	};

	private FP radius_14 = 10;

	private FP interval_14 = 0.5;

	private FP time_14 = 3;

	private readonly string hitFx_14 = "FX/Perk/fx_perk_bullet_light_lightning_01";

	private const int perkId_15 = 500515;

	private Dictionary<int, int> dicEff_15 = new Dictionary<int, int>
	{
		[1] = 20,
		[2] = 40,
		[3] = 50,
		[4] = 40,
		[5] = 45
	};

	private Dictionary<int, int> dicBuff_15 = new Dictionary<int, int>
	{
		[1] = 51511,
		[2] = 51521,
		[3] = 51531,
		[4] = 90026,
		[5] = 90026
	};

	private Dictionary<int, int> dicCount_15 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 2,
		[4] = 3,
		[5] = 3
	};

	private int perkId_16 = 500516;

	private FP delayTime_16 = 1;

	private readonly string bullut_16 = "Misc/FateCard/Theme_LightningBolt";

	private int perkId_17 = 500517;

	private int perkId_18 = 500518;

	private int count_18 = 5;

	private Dictionary<int, int> dicEff_18 = new Dictionary<int, int>
	{
		[1] = 80,
		[2] = 120,
		[3] = 160,
		[4] = 35,
		[5] = 40
	};

	private string tagCastCount = "CastCount_Chain";

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private bool canLinkOnSelf;

	private Dictionary<int, int> dicCount = new Dictionary<int, int>();

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		ClearKey(tagCastCount);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500501, out var _) && CheckPerkCDTimeout(500501, cd_1) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage1)
		{
			Shoot(500501, 1);
			TriggerPerk(500501);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500502, out var _) && CheckPerkCDTimeout(500502, cd_2) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage2)
		{
			Shoot(500502, 2);
			TriggerPerk(500502);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500503, out var _) && CheckPerkCDTimeout(500503, cd_3) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage3)
		{
			Shoot(500503, 3);
			TriggerPerk(500503);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500504, out var _) && CheckPerkCDTimeout(500504, cd_4) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage4)
		{
			Shoot(500504, 4);
			TriggerPerk(500504);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHit(evt);
		int lv;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, attackTag))
		{
			if (dicCount.TryGetValue(evt.uniqueAttackId, out var value) && value > 0)
			{
				AdventureActor.AddFromAttr(425, _actor);
				if (GetPerkLv(500508, out lv))
				{
					AdventureActor.AddFromAttr(dicEff_8.get_Item(lv), _actor);
				}
			}
			if (GetPerkLv(500515, out lv))
			{
				AdventureActor.AddFromAttr(dicEff_15.get_Item(lv), _actor);
			}
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Strong) && GetPerkLv(perkId_18, out lv))
		{
			AdventureActor.AddFromAttr(dicEff_18.get_Item(lv), _actor);
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		base.OnHitPre(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		int lv;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, attackTag))
		{
			if (GetPerkLv(500515, out lv))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(dicBuff_15.get_Item(lv), _actor);
			}
			if (GetPerkLv(500509, out lv))
			{
				monsterAdventureActor?.buffComponent.AddBuff(dicBuff_9.get_Item(lv), _actor);
			}
			if (GetPerkLv(500510, out lv) && CheckPerkCD(500510, cd_10) && dicCount.TryGetValue(evt.uniqueAttackId, out var value) && value == 3)
			{
				_actor.buffComponent.AddBuff(difBuff_10.get_Item(lv), _actor);
			}
			if (GetPerkLv(500513, out lv) && CheckPerkCD(500513, cd_13))
			{
				ModifyPerkCD(500501, dicCd_13.get_Item(lv));
				ModifyPerkCD(500502, dicCd_13.get_Item(lv));
				ModifyPerkCD(500503, dicCd_13.get_Item(lv));
				ModifyPerkCD(500504, dicCd_13.get_Item(lv));
			}
			if (GetPerkLv(500514, out lv) && monsterAdventureActor != null && (CommonUtils.CheckElementMark(CommonDefine.Light, monsterAdventureActor) || TSRandom.Range(0, 100) < dicPro_14.get_Item(lv)) && CheckPerkCD(500514, dicCd_14.get_Item(lv)))
			{
				CoroutineNode item = StartLogicCoroutine(SpecialHit(monsterAdventureActor, hitFx_14, time_14, dicDmg_14.get_Item(lv), radius_14, interval_14));
				corList.Add(item);
			}
			if (GetPerkLv(perkId_16, out lv))
			{
				CoroutineNode item2 = StartLogicCoroutine(DelayShoot(monsterAdventureActor, bullut_16, delayTime_16));
				corList.Add(item2);
			}
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Strong) && GetPerkLv(perkId_18, out lv))
		{
			monsterAdventureActor?.buffComponent.AddBuff(lightMaskBuff, _actor);
		}
	}

	private void Shoot(int hitDamageId, int perkSlotIndex, LogicEntity target = null)
	{
		if (target == null)
		{
			target = GetShootTarget();
		}
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_light_trigger_s");
			internalShoot(target, hitDamageId, perkSlotIndex);
			if (GetPerkLv(500511, out var lv) && TSRandom.Range(0, 100) <= dicProb_11.get_Item(lv) && CheckPerkCD(500511, cd_11))
			{
				CoroutineNode item = StartLogicCoroutine(DelayShoot(target, hitDamageId, perkSlotIndex));
				corList.Add(item);
			}
			if (GetPerkLv(500512, out lv) && CheckPerkCD(500512, cd_12))
			{
				CoroutineNode item2 = StartLogicCoroutine(DelayHit());
				corList.Add(item2);
			}
		}
	}

	private IEnumerator DelayHit()
	{
		yield return delayTime;
		List<LogicEntity> list = CommonUtils.SearchNearTargetsByCircle(_actor, radius_12, isConfront: true, includeSelf: false);
		for (int i = 0; i < list.Count; i++)
		{
			ILRuntimeAPI.HitActor(_actor, list.get_Item(i) as AdventureActor, hitDamageId_12, null, hitFxPath_12, attackFxPlayOnTarget: true);
		}
	}

	private IEnumerator DelayShoot(LogicEntity target, int damageId, int perkSlotIndex)
	{
		yield return delayTime;
		internalShoot(target, damageId, perkSlotIndex);
	}

	private void internalShoot(LogicEntity target, int damageId, int perkSlotIndex)
	{
		AddKey(tagCastCount);
		string hitFx = hitFxPath;
		if (GetPerkLv(500515, out var lv))
		{
			hitFx = hitFxPath_strong;
		}
		if (GetPerkLv(perkId_18, out lv) && GetKeyCount(tagCastCount) > count_18)
		{
			hitFx = hitFxPath_strong;
			ClearKey(tagCastCount);
			damageId = dicDamageId.get_Item(perkSlotIndex);
		}
		CoroutineNode item = StartLogicCoroutine(LoopLinkHit(target, damageId, hitFx));
		corList.Add(item);
	}

	private IEnumerator LoopLinkHit(LogicEntity firstTarget, int damageId, string hitFx)
	{
		int linkCount = GetMaxBounceTime();
		int curLink = 0;
		List<LogicEntity> temHitList = new List<LogicEntity>();
		LogicEntity lastTaget = null;
		while (curLink < linkCount)
		{
			if (curLink == 0)
			{
				int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
				dicCount.Add(uniqueAttackId, curLink);
				internalHit(_actor, firstTarget, damageId, hitFx, uniqueAttackId);
				dicCount.Remove(uniqueAttackId);
				curLink++;
				temHitList.Add(firstTarget);
				lastTaget = firstTarget;
			}
			else
			{
				ILRuntimeAPI.SearchByRange(lastTaget as AdventureActor, linkCheckRange, (List<LogicEntity> result) =>
				{
					if (result.Count > 0)
					{
						if (!canLinkOnSelf && result.Contains(_actor))
						{
							result.Remove(_actor);
						}
						for (int i = 0; i < temHitList.Count; i++)
						{
							if (result.Contains(temHitList.get_Item(i)))
							{
								result.Remove(temHitList.get_Item(i));
							}
						}
					}
					if (result.Count == 0)
					{
						if (GetPerkLv(perkId_17, out var _))
						{
							int num = GetMaxBounceTime() - curLink;
							for (int j = 0; j < num; j++)
							{
								int uniqueAttackId2 = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
								dicCount.Add(uniqueAttackId2, curLink);
								internalHit(lastTaget, lastTaget, damageId, null, uniqueAttackId2);
								dicCount.Remove(uniqueAttackId2);
								curLink++;
							}
						}
						else
						{
							curLink = linkCount;
						}
					}
					else
					{
						lastTaget.SearchEntitySortByDistance(result);
						LogicEntity logicEntity = result.get_Item(0);
						int uniqueAttackId3 = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
						dicCount.Add(uniqueAttackId3, curLink);
						internalHit(lastTaget, logicEntity, damageId, hitFx, uniqueAttackId3);
						dicCount.Remove(uniqueAttackId3);
						temHitList.Add(logicEntity);
						lastTaget = logicEntity;
						curLink++;
					}
				});
			}
			yield return linkHitInterval;
		}
	}

	private void internalHit(LogicEntity from, LogicEntity target, int damageId, string hitFxPath, int uniqueAtkId = 0)
	{
		AdventureActor actor = _actor;
		AdventureActor target2 = target as AdventureActor;
		GameObject gameObject = from.gameObject;
		ILRuntimeAPI.HitActor(actor, target2, damageId, null, hitFxPath, attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, default, HitBox.HurtAnimType.Small, uniqueAtkId, gameObject);
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

	private int GetMaxBounceTime()
	{
		int num = 3;
		if (GetPerkLv(500515, out var lv))
		{
			num += dicCount_15.get_Item(lv);
		}
		return num;
	}

	private IEnumerator DelayShoot(AdventureActor target, string bullut, FP time)
	{
		yield return time;
		AdventureActor actor = _actor;
		TSVector2 position = target.tsTransform.Position;
		TSVector2 position2 = target.tsTransform.Position;
		ILRuntimeAPI.Shoot(bullut, actor, default, position, default, position2, null, AimType.Default, BulletDirectionType.BulletToTarget);
	}

	private IEnumerator SpecialHit(AdventureActor to, string hitFx, FP time, int damageId, FP radius, FP interval)
	{
		FP curTime = 0;
		while (curTime < time)
		{
			List<LogicEntity> list = CommonUtils.SearchNearTargetsByCircle(to, radius, isConfront: false, includeSelf: false);
			for (int i = 0; i < list.Count; i++)
			{
				internalHit(to, list.get_Item(i), damageId, hitFx);
			}
			curTime += interval;
			yield return interval;
		}
	}
}

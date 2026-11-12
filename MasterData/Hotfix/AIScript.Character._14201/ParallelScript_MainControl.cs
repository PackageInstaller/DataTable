using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14201;

public class ParallelScript_MainControl : ParallelScript
{
	private string areaEffect_P2 = "AreaEffect_142_P2_ZhuaHen";

	private string areaEffect_P4 = "AreaEffect_142_P4_ZhuaHen";

	private int buff_base = 14293011;

	private const int perkId_1 = 514201;

	private const int buff_1 = 14201011;

	private const int once_1 = 14201011;

	private const int perkId_2 = 514202;

	private FP cd_2 = 0.5;

	private FP reduceCd_2 = 1;

	private int maxCount_2 = 5;

	private const int perkId_3 = 514203;

	private int buff_3 = 14203011;

	private int perkId_4 = 514204;

	private int buff_4 = 14204011;

	private FP cd_4 = 0.5;

	private int count_4 = 3;

	private const int perkId_5 = 514205;

	private const int buff_5 = 14205011;

	private const int perkId_6 = 514206;

	private const int buff_6 = 14206011;

	private const int perkId_7 = 514207;

	private const int buff_7 = 14207011;

	private const int perkId_8 = 514208;

	private const int buff_8 = 14208011;

	private const int perkId_9 = 514209;

	private FP radius_9 = 4;

	private int buff_9 = 14209011;

	private const int perkId_10 = 514210;

	private int maxCount_10 = 5;

	private FP cd_10 = 6;

	private int shield_10 = 14210001;

	private const int perkId_11 = 514211;

	private const int section_11 = 1;

	private int buff_11 = 14211011;

	private const int perkId_12 = 514212;

	private int buff_12 = 14212011;

	private const int perkId_13 = 514213;

	private int buff_13 = 14213011;

	private int curCount_2;

	private int curCount_10;

	private bool isSkilling;

	private int curCount_4;

	private CoroutineNode corPerk9;

	public override void OnEnable()
	{
		base.OnEnable();
		curCount_2 = 0;
		curCount_10 = 0;
		curCount_4 = 0;
		isSkilling = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		if (GetPerkLv(514209, out var lv))
		{
			StartCoroutine(ref corPerk9, CheckBuff());
		}
		if (GetPerkLv(514211, out lv))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
		if (GetPerkLv(514212, out lv))
		{
			_actor.EnableDodgeCrossObstacle();
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		StopCoroutine(ref corPerk9);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		int lv;
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerkLv(514201, out lv))
			{
				foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
				{
					(item as AdventureActor)?.buffComponent.AddBuff(14201011, _actor);
				}
			}
			if (GetPerkLv(514207, out lv))
			{
				foreach (LogicEntity item2 in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
				{
					(item2 as AdventureActor)?.buffComponent.AddBuff(14207011, _actor);
				}
			}
			isSkilling = true;
			curCount_2 = 0;
			ClearCd(514202);
		}
		else
		{
			if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
			{
				if (!GetPerkLv(514208, out lv))
				{
					return;
				}
				{
					foreach (LogicEntity item3 in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
					{
						(item3 as AdventureActor)?.buffComponent.AddBuff(14208011, _actor);
					}
					return;
				}
			}
			if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.A)
			{
				return;
			}
			if (GetPerkLv(514211, out lv))
			{
				List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.FindAll((PlayerAdventureActor x) => x.isAssist);
				if (list.Count > 0)
				{
					list.get_Item(TSRandom.Range(0, list.Count)).buffComponent.AddBuff(buff_11, _actor);
				}
			}
			if (GetPerkLv(514212, out lv))
			{
				_actor.buffComponent.AddBuff(buff_12, _actor);
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			isSkilling = false;
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		if (isSelf && GetPerkLv(514201, out var _) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MainSkill_2))
		{
			AdventureActor.AddFromAttr(14201011, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		int lv;
		PlayerAdventureActor summoner;
		if (isSelf)
		{
			bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MainSkill);
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal))
			{
				if (GetPerkLv(514210, out lv))
				{
					if (curCount_10 > maxCount_10 - 1)
					{
						if (CheckCd(514210, cd_10))
						{
							mainCtrActor.actorShield.AddShield(shield_10, _actor);
							curCount_10 = 0;
						}
					}
					else
					{
						curCount_10++;
					}
				}
				if (_actor.buffComponent.CheckBuffByBuffID(buff_3))
				{
					TriggerMask(monster);
				}
			}
			if (flag)
			{
				monster.buffComponent.AddBuff(buff_base, _actor);
				if (GetPerkLv(514205, out lv))
				{
					monster.buffComponent.AddBuff(14205011, _actor);
				}
				if (GetPerkLv(514206, out lv) && evt.isKill)
				{
					foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
					{
						(item as AdventureActor)?.buffComponent.AddBuff(14206011, _actor);
					}
				}
			}
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_AddDark))
			{
				TriggerMask(monster);
			}
		}
		else if (GetPerkLv(514202, out lv) && evt.isCrit && ((evt.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.Id != _actor.Id) || evt.from.IsPlayerMinion(out summoner)) && CheckCd(514202, cd_2))
		{
			if (curCount_2 < maxCount_2)
			{
				skillMgr.ModifyResumeTimeAbs(-reduceCd_2, ActionKey.B);
				FP rotation = TSRandom.Range(-180, 180);
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_P2, monster.tsTransform.Position, rotation);
			}
			curCount_2++;
		}
	}

	private void TriggerMask(MonsterAdventureActor monster)
	{
		monster.buffComponent.AddBuff(buff_Dark, _actor);
		if (GetPerkLv(perkId_4, out var _) && ++curCount_4 >= count_4 && CheckCd(perkId_4, cd_4))
		{
			monster.buffComponent.AddBuff(buff_4, _actor);
			FP rotation = TSRandom.Range(-180, 180);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_P4, monster.tsTransform.Position, rotation);
			curCount_4 = 0;
		}
	}

	public override void OnHurt(AdventureActorReceiveDamageEvent evt, bool isSelf)
	{
		base.OnHurt(evt, isSelf);
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		if (adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.DE && GetPerkLv(514213, out var _))
		{
			adventureElementMarkTriggerEvent.triggerActor.buffComponent.AddBuff(buff_13, _actor);
		}
	}

	private IEnumerator CheckBuff()
	{
		List<LogicEntity> list = new List<LogicEntity>();
		while (true)
		{
			CommonUtils.SearchNearTargetsByCircle(_actor, _actor.tsTransform.Position, radius_9, isConfront: true, includeSelf: false, list);
			if (list.Count > 0)
			{
				List<LogicEntity> list2 = list.FindAll((LogicEntity x) => CommonUtils.CheckElementMark(CommonDefine.Dark, x as AdventureActor));
				_actor.buffComponent.AddBuffNum(buff_9, list2.Count, _actor);
			}
			yield return _actor.WaitTime(1);
		}
	}
}

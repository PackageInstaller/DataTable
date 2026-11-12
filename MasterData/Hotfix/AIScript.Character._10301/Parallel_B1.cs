using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Character._10301;

public class Parallel_B1 : Parallel
{
	private class SkillContext
	{
		public int curCount;

		public int hitCount;
	}

	private int ammoMaxCount = 36;

	public static int skillId_S1 = 10331000;

	public static int skillId_S2 = 10331030;

	private const int perkId_1 = 510301;

	private int buffId_1 = 10350101;

	private const int perkId_2 = 510302;

	private const int perkId_3 = 510303;

	private const int buffId_3 = 10303011;

	private int once_3 = 10303011;

	private const int perkId_4 = 510304;

	private string areaEffect_4 = "AreaEffect_10301_P04_Boom";

	private FP interval_4 = 1;

	private int maxCount_4 = 5;

	private const int perkId_5 = 510305;

	private const int parameterId_5 = 10350511;

	private int buffId_5 = 10350501;

	private int paramId_5_Count = 10350512;

	private const int perkId_6 = 510306;

	private readonly FP cd_6 = 0;

	private const int once_6 = 10350601;

	private int paramId_maxCount = 10306011;

	private const int perkId_7 = 510307;

	private readonly FP cd_7 = 0;

	private const int buff_7_2 = 10350701;

	private const int perkId_8 = 510308;

	private readonly FP cd_8 = 0;

	private const int buff_8 = 10350801;

	private const int perkId_9 = 510309;

	private const int once_9 = 10350901;

	private const int perkId_10 = 510310;

	private readonly FP cd_10 = 0;

	private int paramId_10_hitCount = 10351011;

	private const int once_10 = 10351001;

	private const int perkId_11 = 510311;

	private int buffId_11 = 10351101;

	private const int parameterId_11 = 10351111;

	private const int perkId_12 = 510312;

	private readonly FP cd_12 = 0;

	private const int once_12 = 10351201;

	private const int perkId_13 = 510313;

	private const int buff_13 = 10351301;

	private int orginAmmoMaxCount;

	private CoroutineNode corMain;

	private CoroutineNode corHit;

	private CoroutineNode corRebind;

	private int _hitCount_6;

	private SkillContext curContext;

	private SkillContext lastContext;

	private FP resetSkillTime;

	private List<FP> triggerTimes = new List<FP>();

	private int curCrit;

	public override void OnEnable()
	{
		base.OnEnable();
		curCrit = 0;
		curContext = new SkillContext();
		lastContext = new SkillContext();
		orginAmmoMaxCount = _actor.ammoInfo.ammoCountMax;
		_hitCount_6 = 0;
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId_S2);
		resetSkillTime = FP.FromMyriad(skill.UseTimeHint);
		if (GetPerk(510311))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.originalTotalSectionAmount + 1, forceMaxSection: true);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corMain);
		StopCoroutine(ref corHit);
		StopCoroutine(ref corRebind);
		_actor.logicVariable.ToggleLogicTag("attck_strong", value: false);
		(_actor as PlayerAdventureActor).enableReload = true;
		_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, orginAmmoMaxCount, 1);
		triggerTimes.Clear();
		skillMgr.ResetSkillTotalSection(ActionKey.A);
	}

	public override void OnFinishReload(AdventureActorFinishReload evt)
	{
		base.OnFinishReload(evt);
		_hitCount_6 = 0;
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		if (evt.skillEventInfo.skillId == skillId_S1)
		{
			bool perkLv = GetPerkLv(510301, out var lv);
			bool perkLv2 = GetPerkLv(510302, out lv);
			if (perkLv | perkLv2)
			{
				_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, orginAmmoMaxCount, 1);
				if (perkLv)
				{
					_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, ammoMaxCount, 1);
					_actor.buffComponent.AddBuff(buffId_1, _actor);
				}
				if (perkLv2)
				{
					_actor.logicVariable.ToggleLogicTag("attck_strong", value: true);
				}
				_actor.ammoInfo.ammoCount = _actor.ammoInfo.ammoCountMax;
				(_actor as PlayerAdventureActor).enableReload = false;
				_hitCount_6 = 0;
			}
		}
		curContext.curCount++;
		curContext.hitCount = 0;
		if (GetPerkLv(510307, out var lv2) && CheckCd(510307, cd_7))
		{
			_actor.buffComponent.AddBuff(10350701, _actor);
		}
		if (GetPerkLv(510303, out lv2))
		{
			if (evt.skillEventInfo.skillId == skillId_S2)
			{
				StopCoroutine(ref corRebind);
			}
			else
			{
				_actor.buffComponent.RemoveBuffByBuffId(10303011);
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		switch (evt.skillEventInfo.skillSlotType)
		{
		case HotfixEnum.skillSlotType.B:
		{
			if (GetPerkLv(510308, out var lv) && CheckCd(510308, cd_8))
			{
				_actor.buffComponent.AddBuff(10350801, _actor);
			}
			if (GetPerkLv(510310, out lv))
			{
				lastContext.hitCount = curContext.hitCount;
				lastContext.curCount = curContext.curCount;
			}
			break;
		}
		case HotfixEnum.skillSlotType.NORMAL:
			if (_actor.ammoInfo.ammoCount == 0)
			{
				_actor.logicVariable.ToggleLogicTag("attck_strong", value: false);
				_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, orginAmmoMaxCount, 1);
				(_actor as PlayerAdventureActor).enableReload = true;
				_actor.buffComponent.RemoveBuffByBuffId(buffId_1);
			}
			break;
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		int lv;
		if (flag)
		{
			if (GetPerkLv(510306, out lv) && CheckCd(510306, cd_6))
			{
				_hitCount_6++;
				int count = Math.Min(_hitCount_6, CommonUtils.GetScriptValue(_actor, paramId_maxCount).AsInt());
				AdventureActor.AddFromAttr(10350601, _actor, count);
			}
		}
		else if (flag2 && GetPerkLv(510310, out lv) && lastContext.hitCount > 0)
		{
			AdventureActor.AddFromAttr(10351001, _actor, lastContext.hitCount);
		}
		if (GetPerkLv(510303, out var _) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill_P3))
		{
			AdventureActor.AddFromAttr(once_3, _actor);
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill_P9) && GetPerkLv(510309, out lv))
		{
			AdventureActor.AddFromAttr(10350901, _actor);
		}
		if (_actor.movementState == ActorState.Move && GetPerkLv(510312, out lv) && CheckCd(510312, cd_12))
		{
			AdventureActor.AddFromAttr(10351201, _actor);
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPre(evt, monster);
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill) || !GetPerkLv(510304, out var _))
		{
			return;
		}
		FP logicTime = _actor.LogicTime;
		FP fP = _actor.LogicTime - interval_4;
		for (int num = triggerTimes.Count - 1; num >= 0; num--)
		{
			if (triggerTimes.get_Item(num) < fP)
			{
				triggerTimes.RemoveAt(num);
			}
		}
		if (triggerTimes.Count < maxCount_4)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_4, monster.tsTransform.Position);
			triggerTimes.Add(logicTime);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, fireHit);
		if (flag)
		{
			if (CommonUtils.CheckElementMark(CommonDefine.FireMark1, monster))
			{
				if (GetPerkLv(510303, out var lv))
				{
					_actor.buffComponent.AddBuff(10303011, _actor);
				}
				if (evt.isKill && GetPerkLv(510310, out lv))
				{
					curContext.hitCount = Math.Min(CommonUtils.GetScriptValue(_actor, paramId_10_hitCount).AsInt(), ++curContext.hitCount);
				}
				if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Trigger))
				{
					TriggerFireMark(monster, HotfixEnum.skillSlotType.B);
				}
			}
		}
		else if (flag2 && CommonUtils.CheckElementMark(CommonDefine.FireMark1, monster) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Trigger))
		{
			TriggerFireMark(monster, HotfixEnum.skillSlotType.D);
		}
		if (GetPerkLv(510311, out var _) && (monster.IsBossMonster() || monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE) && CheckCd(510311, CommonUtils.GetScriptValue(_actor, 10351111)))
		{
			_actor.buffComponent.AddBuff(buffId_11, _actor);
		}
	}

	public override void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
		base.OnCrit(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.FireMark1, monsterAdventureActor) && GetPerkLv(510313, out var _))
		{
			_actor.buffComponent.AddBuff(10351301, _actor);
		}
		if (!GetPerk(510305))
		{
			return;
		}
		curCrit++;
		int num = CommonUtils.GetScriptValue(_actor, paramId_5_Count).AsInt();
		if (curCrit > num && CheckCd(510305, CommonUtils.GetScriptValue(_actor, 10350511)))
		{
			_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, orginAmmoMaxCount, 1);
			if (GetPerkLv(510301, out var _))
			{
				_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Main, ammoMaxCount, 1);
			}
			_actor.ammoInfo.ammoCount = _actor.ammoInfo.ammoCountMax;
			(_actor as PlayerAdventureActor).enableReload = false;
			_actor.buffComponent.AddBuff(buffId_5, _actor);
			curCrit = 0;
		}
	}

	public override void OnRebindSkill(AdventurRebindSkill evt)
	{
		base.OnRebindSkill(evt);
		skillMgr.BindSkillIdToButton(evt.slotKey, evt.skillId, evt.skillId == skillId_S1);
		if (evt.skillId == skillId_S2)
		{
			StartCoroutine(ref corRebind, ResetSkill());
		}
	}

	private IEnumerator ResetSkill()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(resetSkillTime));
		skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1);
	}
}

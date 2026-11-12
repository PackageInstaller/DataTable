using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Character._11301;

public class ParallelScript_MainControl : ParallelScript
{
	private const int perkId_1 = 511301;

	private int buffId_1 = 11301011;

	private const int perkId_2 = 511302;

	private int once_2 = 11302011;

	private const int perkId_3 = 511303;

	private int buffId_3 = 11303011;

	private int once_3 = 11303011;

	private const int perkId_4 = 511304;

	private const int perkId_5 = 511305;

	private int buffId_5_1 = 11305011;

	private int buffId_5_2 = 11305012;

	private const int perkId_6 = 511306;

	private const int paramId_6_cd = 11306001;

	private int once_6 = 11306002;

	private const int perkId_7 = 511307;

	private Dictionary<int, int> dicOnce_7 = new Dictionary<int, int>
	{
		[0] = 11307001,
		[1] = 11307002,
		[2] = 11307003,
		[3] = 11307004,
		[4] = 11307005,
		[5] = 11307006,
		[6] = 11307007,
		[7] = 11307008,
		[8] = 11307009,
		[9] = 11307009
	};

	private FP hpPercent_7 = 10;

	private const int perkId_8 = 511308;

	private int buffId_8 = 11308001;

	private int paramId_8_maxCount = 11308001;

	private const int perkId_9 = 511309;

	private string areaEffect_9 = "AreaEffect_11301_Skill_Main_P09_Wave";

	private FP cd_9 = 5;

	private int prob_9 = 15;

	private const int perkId_10 = 511310;

	private FP time_10 = 3;

	private FP interval_10 = 0.3f;

	private FP cd_10 = 10;

	private string areaEffect_10 = "AreaEffect_11301_Skill_Main_P10_Puddle";

	private const int perkId_11 = 511311;

	private int once_11 = 11311001;

	private int buff_11 = 11311011;

	private const int perkId_12 = 511312;

	private int buffId_12 = 11312011;

	private const int perkId_13 = 511313;

	private int once_13_1 = 11313001;

	private int once_13_2 = 11313002;

	private CoroutineNode corRebind;

	private CoroutineNode corCastArea;

	private FP resetSkillTime;

	private bool isInSkill;

	private HashSet<long> monsterSet_3 = new HashSet<long>();

	private bool nextSkill;

	private bool resetS2;

	private bool triggerS2;

	private int count_8;

	public override void OnEnable()
	{
		base.OnEnable();
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId_S2);
		resetSkillTime = FP.FromMyriad(skill.UseTimeHint);
		Singleton<HotfixDataController>.Instance.GetSkill(skillId_S2);
		isInSkill = false;
		nextSkill = false;
		resetS2 = false;
		triggerS2 = false;
		monsterSet_3.Clear();
		count_8 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corRebind);
		StopCoroutine(ref corCastArea);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		int lv;
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			if (GetPerkLv(511312, out lv))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buffId_12);
			}
			StopCoroutine(ref corRebind);
			skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1);
		}
		else if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (evt.skillEventInfo.skillId == skillId_S1)
			{
				isInSkill = true;
				monsterSet_3.Clear();
				if (GetPerkLv(511305, out lv))
				{
					_actor.buffComponent.AddBuff(buffId_5_1, _actor);
				}
			}
			else if (evt.skillEventInfo.skillId == skillId_S2)
			{
				if (GetPerkLv(511301, out lv))
				{
					_actor.buffComponent.RemoveBuffByBuffId(buffId_1);
				}
				StopCoroutine(ref corRebind);
				if (triggerS2)
				{
					count_8++;
					triggerS2 = false;
				}
			}
			if (GetPerkLv(511303, out lv))
			{
				monsterSet_3.Clear();
			}
			if (GetPerkLv(511312, out lv))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buffId_12);
			}
		}
		if (GetPerkLv(511310, out lv) && (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B || evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A) && CheckCd(511310, cd_10))
		{
			StartCoroutine(ref corCastArea, CastArea());
		}
		base.OnCastSkill(evt);
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			int lv;
			if (evt.skillEventInfo.skillId == skillId_S1)
			{
				nextSkill = false;
				isInSkill = false;
				if (GetPerkLv(511305, out lv))
				{
					_actor.buffComponent.RemoveBuffByBuffId(buffId_5_1);
				}
			}
			else if (evt.skillEventInfo.skillId == skillId_S2)
			{
				if (!resetS2)
				{
					StopCoroutine(ref corRebind);
					skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1, resetSection: true);
				}
				else
				{
					resetS2 = false;
				}
				if (GetPerkLv(511311, out lv))
				{
					_actor.buffComponent.AddBuff(buff_11, _actor);
				}
			}
		}
		base.OnCastEndSkill(evt);
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NA);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SM);
		bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SM1);
		bool flag4 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SM2);
		if (GetPerkLv(511302, out var lv) && flag2 && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(once_2, _actor);
		}
		if (GetPerkLv(511303, out lv) && flag4)
		{
			AdventureActor.AddFromAttr(once_3, _actor);
		}
		if (GetPerkLv(511306, out lv) && flag3 && nextSkill)
		{
			AdventureActor.AddFromAttr(once_6, _actor);
		}
		if (GetPerkLv(511307, out lv) && flag4 && (monster.buffComponent.CheckBuffByBuffTag(buffTag_Cold) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Frozen)))
		{
			int key = TSMath.FloorToInt((1 - (FP)monster.actorHealthInfo.hpPercentage) * 100 / hpPercent_7);
			if (dicOnce_7.get_Item(key) > 0)
			{
				AdventureActor.AddFromAttr(dicOnce_7.get_Item(key), _actor);
			}
		}
		if (GetPerkLv(511311, out lv) && flag && _actor.buffComponent.CheckBuffByBuffID(buff_11))
		{
			AdventureActor.AddFromAttr(once_11, _actor);
		}
		if (GetPerkLv(511313, out lv) && flag2)
		{
			if (monster.buffComponent.CheckBuffByBuffTag(buffTag_Cold))
			{
				AdventureActor.AddFromAttr(once_13_1, _actor);
			}
			if (monster.monsterToughnessInfo.isToughnessBroken)
			{
				AdventureActor.AddFromAttr(once_13_2, _actor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SM);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SM1);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SM2);
		bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NA);
		if (GetPerkLv(511301, out var lv) && flag && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()))
		{
			_actor.buffComponent.AddBuff(buffId_1, _actor);
		}
		if (GetPerkLv(511303, out lv) && flag && !monsterSet_3.Contains(monster.Id))
		{
			_actor.buffComponent.AddBuff(buffId_3, _actor);
			monsterSet_3.Add(monster.Id);
		}
		if (GetPerkLv(511308, out lv) && flag2 && evt.isKill && monster.buffComponent.CheckBuffByBuffTag(buffTag_Frozen))
		{
			_actor.buffComponent.AddBuff(buffId_8, _actor);
			int num = CommonUtils.GetScriptValue(_actor, paramId_8_maxCount).AsInt();
			if (count_8 < num)
			{
				skillMgr.ResetSkillCD(ActionKey.B);
				skillMgr.ResetUseTimeHint(ActionKey.B);
				StartCoroutine(ref corRebind, ResetSkill());
				resetS2 = true;
				triggerS2 = true;
			}
		}
		if (GetPerkLv(511309, out lv) && TSRandom.Range(0, 100) < prob_9 && CheckCd(511309, cd_9))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_9, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		}
		if (GetPerkLv(511312, out lv) && flag3 && (monster.buffComponent.CheckBuffByBuffTag(buffTag_Cold) || monster.buffComponent.CheckBuffByBuffTag(buffTag_Frozen)))
		{
			_actor.buffComponent.AddBuff(buffId_12, _actor);
		}
	}

	public override void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHurt(evt);
		if (GetPerkLv(511305, out var _) && isInSkill)
		{
			_actor.buffComponent.AddBuff(buffId_5_2, _actor);
		}
	}

	public override void OnRebindSkill(AdventurRebindSkill evt)
	{
		base.OnRebindSkill(evt);
		skillMgr.BindSkillIdToButton(evt.slotKey, evt.skillId);
		if (evt.skillId == skillId_S2)
		{
			StartCoroutine(ref corRebind, ResetSkill());
		}
	}

	private IEnumerator ResetSkill()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(resetSkillTime));
		skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1, resetSection: true);
		if (GetPerkLv(511306, out var _))
		{
			skillMgr.ModifyResumeTimeAbs(-CommonUtils.GetScriptValue(_actor, 11306001), ActionKey.B);
			nextSkill = true;
		}
		if (GetPerkLv(511308, out var _))
		{
			triggerS2 = false;
			count_8 = 0;
		}
	}

	private IEnumerator CastArea()
	{
		FP timer = 0;
		FP playerTimer = 0;
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_10, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		while (timer < time_10)
		{
			if (playerTimer >= interval_10)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_10, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
				playerTimer = 0;
			}
			yield return null;
			timer += _actor.LogicDeltaTime;
			playerTimer += _actor.LogicDeltaTime;
		}
	}
}

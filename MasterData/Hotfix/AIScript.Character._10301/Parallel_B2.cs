using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10301;

public class Parallel_B2 : Parallel
{
	private int skillEndHit = CommonHelper.StringToHash("skillEndHit");

	private const int perkId_1 = 510321;

	private FP cd_1 = 1;

	private FP cd_1_Skill = 14;

	private const int perkId_5 = 510322;

	private const string areaEffect_5 = "AreaEffect_10301_Support_P25_Shadow";

	private FP range_5 = 10;

	private FP interval_5 = 2;

	private FP firstDelay_5 = 1;

	private int maxCount_5 = 2;

	private FP startAngle_5 = -45;

	private const int perkId_25 = 510325;

	private int once_25 = 10325001;

	private const int perkId_6 = 510326;

	private int maxCount_6 = 4;

	private FP Interval_6 = 4;

	private const int once_6 = 10352601;

	private const int perkId_7 = 510327;

	private int buffId_7 = 10352711;

	private const int parameterId_7 = 10352711;

	private const int perkId_8 = 510328;

	private int countPerSec_8 = 1;

	private int initCount_8 = 10;

	private const int buff_8 = 10352801;

	private const int perkId_9 = 510329;

	private const int buff_9 = 10352901;

	private const int perkId_10 = 510330;

	private int cd_10 = 2;

	private const int buff_10 = 10353001;

	private const int perkId_13 = 510333;

	private const int buff_13 = 10353311;

	private Dictionary<LogicEntity, FP> hitMonsterDic = new Dictionary<LogicEntity, FP>();

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private int curCount;

	private FP curTime;

	private CoroutineNode corCastArea;

	private List<LogicEntity> entities = new List<LogicEntity>();

	public override void OnEnable()
	{
		base.OnEnable();
		curTime = _actor.LogicTime;
		corList?.Clear();
		if (GetPerkLv(510321, out var lv))
		{
			CoroutineNode item = StartCoroutine(DoSetCD());
			corList.Add(item);
		}
		if (GetPerkLv(510328, out lv))
		{
			CoroutineNode item2 = StartCoroutine(DoBuffDelLogic(lv));
			corList.Add(item2);
		}
		if (!GetPerkLv(510333, out lv))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.AddBuff(10353311, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		hitMonsterDic.Clear();
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		StopCoroutine(ref corCastArea);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		HotfixEnum.skillSlotType skillSlotType = evt.skillEventInfo.skillSlotType;
		if (skillSlotType != HotfixEnum.skillSlotType.B)
		{
			_ = 4;
			return;
		}
		if (GetPerkLv(510327, out var _) && CheckCd(510327, CommonUtils.GetScriptValue(_actor, 10352711)))
		{
			_actor.buffComponent.AddBuff(buffId_7, _actor);
		}
		curCount = 0;
		if (GetPerkLv(510322, out var _))
		{
			StartCoroutine(ref corCastArea, DoCastAreaEffect());
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		int lv2;
		switch (evt.skillEventInfo.skillSlotType)
		{
		case HotfixEnum.skillSlotType.D:
			if (GetPerkLv(510330, out lv2))
			{
				_actor.buffComponent.RemoveBuffByBuffId(10353001);
			}
			break;
		case HotfixEnum.skillSlotType.B:
		{
			if (GetPerkLv(510322, out var _))
			{
				StopCoroutine(ref corCastArea);
			}
			if (GetPerkLv(510328, out lv2))
			{
				for (int i = 0; i < initCount_8; i++)
				{
					_actor.buffComponent.AddBuff(10352801, _actor);
				}
			}
			if (GetPerkLv(510329, out lv2))
			{
				_actor.buffComponent.AddBuff(10352901, _actor);
			}
			curTime = _actor.LogicTime;
			break;
		}
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill) && GetPerkLv(510326, out var _))
		{
			int val = TSMath.FloorToInt((_actor.LogicTime - curTime) / Interval_6);
			val = Math.Min(val, maxCount_6);
			AdventureActor.AddFromAttr(10352601, _actor, val);
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill_P25) && GetPerkLv(510325, out var _))
		{
			AdventureActor.AddFromAttr(once_25, _actor);
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPre(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (flag && CommonUtils.CheckElementMark(CommonDefine.FireMark1, monster) && GetPerkLv(510330, out var _) && CheckCd(510330, cd_10))
		{
			_actor.buffComponent.AddBuff(10353001, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (flag)
		{
			if (!CommonUtils.CheckElementMark(CommonDefine.FireMark1, monster))
			{
				return;
			}
			bool flag3 = true;
			if (GetPerkLv(510321, out var _))
			{
				if (hitMonsterDic.TryGetValue(monster, out var value))
				{
					flag3 = _actor.LogicTime - value > cd_1;
					if (flag3)
					{
						hitMonsterDic.set_Item((LogicEntity)monster, _actor.LogicTime);
					}
				}
				else
				{
					hitMonsterDic.Add(monster, _actor.LogicTime);
					flag3 = true;
				}
			}
			if (flag3 && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Trigger))
			{
				TriggerFireMark(monster, HotfixEnum.skillSlotType.B);
			}
		}
		else if (flag2 && CommonUtils.CheckElementMark(CommonDefine.FireMark1, monster) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Trigger))
		{
			TriggerFireMark(monster, HotfixEnum.skillSlotType.D);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		_ = evt.eventHashCode;
		_ = skillEndHit;
	}

	private IEnumerator DoBuffDelLogic(int lv)
	{
		while (true)
		{
			if (_actor.buffComponent.CheckBuffByBuffID(10352801))
			{
				for (int i = 0; i < countPerSec_8; i++)
				{
					_actor.buffComponent.RemoveBuffByBuffId(10352801, 1);
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(1));
		}
	}

	private IEnumerator DoSetCD()
	{
		yield return null;
		skillMgr.ModifyOriginalSectionResumeTime(ActionKey.B, cd_1_Skill);
	}

	private IEnumerator DoCastAreaEffect()
	{
		yield return _actor.WaitTime(firstDelay_5);
		List<int> dirList = new List<int>();
		while (true)
		{
			dirList.Clear();
			for (int i = 0; i < maxCount_5; i++)
			{
				dirList.Add(i);
			}
			float num = 360f / (float)dirList.Count;
			CommonUtils.SearchNearTargetsByCircle(_actor, range_5, isConfront: true, includeSelf: false, entities);
			for (int j = 0; j < maxCount_5; j++)
			{
				if (entities.Count > 0)
				{
					int index = TSRandom.Range(0, Math.Min(1, entities.Count));
					LogicEntity monster = entities.get_Item(index);
					entities.RemoveAt(index);
					ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_10301_Support_P25_Shadow", _actor.tsTransform.Position, default, (AreaEffectEntity entity) =>
					{
						AreaEffect_FollowComponent logicComponent = entity.GetLogicComponent<AreaEffect_FollowComponent>();
						if (logicComponent != null)
						{
							logicComponent.enabled = true;
							logicComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
							logicComponent.FollowTarget = monster;
						}
						AreaEffect_MoveComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_MoveComponent>();
						if (logicComponent2 != null)
						{
							logicComponent2.enabled = false;
						}
					});
					continue;
				}
				int index2 = TSRandom.Range(0, dirList.Count);
				FP degrees = (float)dirList.get_Item(index2) * num + startAngle_5;
				dirList.RemoveAt(index2);
				TSVector2 tSVector = TSVector2.Rotate(TSVector2.up, degrees);
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_10301_Support_P25_Shadow", _actor.tsTransform.Position, tSVector.GetAngle(), (AreaEffectEntity entity) =>
				{
					AreaEffect_FollowComponent logicComponent = entity.GetLogicComponent<AreaEffect_FollowComponent>();
					if (logicComponent != null)
					{
						logicComponent.enabled = false;
					}
					AreaEffect_MoveComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_MoveComponent>();
					if (logicComponent2 != null)
					{
						logicComponent2.enabled = true;
					}
				});
			}
			yield return _actor.WaitTime(interval_5);
		}
	}
}

using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70031Huochui;

public class Action_FuYouJian : MonsterActionBase
{
	private static readonly int Skill_01 = 7003181;

	private static readonly int Skill_02 = 7003182;

	private static readonly int Skill_03 = 7003183;

	private static readonly int SitDown = 7003186;

	private static readonly int Dead = 7003185;

	private static readonly FP PlayerDistance = 3;

	private bool SkillTips;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 0;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = InitialCast;
		list2.Add(new PoolBranchInfo(actor, 1000, 999, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		list2.Add(new PoolBranchInfo(_actor, 1001, 98, 5, 0, active: true, 2, 360, 10, null, null, Attack01));
		AdventureActor actor2 = _actor;
		FP cd2 = 40;
		FP initCd2 = 40;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 1002, 99, cd2, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 20;
		FP initCd3 = 20;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor3, 1003, 99, cd3, initCd3, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 0;
		FP initCd4 = 0;
		Func<bool> operationConditionFunc = SitDownCondition;
		operateIEnumerator = ASitDown;
		list2.Add(new PoolBranchInfo(actor4, 1004, 999, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0;
		FP initCd5 = 0;
		operationConditionFunc = DeadCondition;
		operateIEnumerator = ADead;
		list2.Add(new PoolBranchInfo(actor5, 1005, 9999, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void GotoCastSkill(int id)
	{
		CastSkill(id);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, SitDownSkill);
	}

	private void SitDownSkill(IEvent evt)
	{
		if (_actor.actorHealthInfo.hp <= 10)
		{
			SetBattleOutEnable();
			_actor.InterruptAttack(force: true);
		}
	}

	private bool SitDownCondition()
	{
		if (_actor.actorHealthInfo.hp <= 10)
		{
			return true;
		}
		return false;
	}

	private bool DeadCondition()
	{
		if (GetBuffNum(_actor, 700310040) > 0)
		{
			return true;
		}
		return false;
	}

	private IEnumerator InitialCast()
	{
		SetLockHpAbsEnable(isAbs: true, 5);
		SetPoolBranchActive(1000, active: false);
		yield break;
	}

	private IEnumerator ASitDown()
	{
		_actor.InterruptAttack(force: true);
		GotoCastSkill(SitDown);
		yield return WaitSkillFinish();
	}

	private IEnumerator ADead()
	{
		_actor.InterruptAttack(force: true);
		GotoCastSkill(Dead);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack01()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 4)
		{
			CastSkill(Skill_01);
			yield return WaitSkillFinish();
		}
		else
		{
			CastSkill(Skill_02);
			yield return WaitSkillFinish();
			SkillTips = true;
		}
	}

	private IEnumerator Attack02()
	{
		if (SkillTips)
		{
			CastSkill(Skill_01);
			yield return WaitSkillFinish();
			SkillTips = false;
		}
		else
		{
			CastSkill(Skill_02);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Attack03()
	{
		GotoCastSkill(Skill_03);
		yield return WaitSkillFinish();
	}
}

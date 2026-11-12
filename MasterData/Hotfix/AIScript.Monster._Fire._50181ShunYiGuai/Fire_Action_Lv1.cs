using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Action_Lv1 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 5018112;

	private static readonly int Skill_Attack02 = 5018113;

	private static readonly int Skill_Attack03 = 5018115;

	private static readonly int Skill_Attack04 = 5018118;

	private static readonly int Skill_Attack05 = 5018119;

	private static readonly int Skill_Attack06 = 5018119;

	private static readonly int Skill_Teleport = 5018122;

	private int SkillTimes01;

	private int SkillTimes02;

	private int SkillTimes03;

	private int Listnum;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 8;
		FP initCd = 0;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor, 1001, 50, cd, initCd, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 8;
		FP initCd2 = 2;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 1002, 150, cd2, initCd2, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 13;
		FP initCd3 = 6;
		FP releaseDistance3 = 15;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor3, 1003, 50, cd3, initCd3, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 18;
		FP initCd4 = 6;
		FP releaseDistance4 = 100;
		FP releaseAngle4 = 360;
		operateIEnumerator = Attack04;
		list2.Add(new PoolBranchInfo(actor4, 1004, 200, cd4, initCd4, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 45;
		FP initCd5 = 40;
		FP releaseDistance5 = 100;
		FP releaseAngle5 = 360;
		operateIEnumerator = Attack05;
		list2.Add(new PoolBranchInfo(actor5, 1005, 999, cd5, initCd5, active: true, releaseDistance5, releaseAngle5, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 10;
		FP initCd6 = 8;
		Func<bool> operationConditionFunc = Condition02;
		operateIEnumerator = Teleport;
		list2.Add(new PoolBranchInfo(actor6, 1006, 300, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 200;
		FP initCd7 = 0;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack06;
		list2.Add(new PoolBranchInfo(actor7, 1007, 998, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SetLogicTagFpValue(_actor, "Trick", 0);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
		SkillTimes03 = 0;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, HpChange);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void HpChange(IEvent custom)
	{
		if (_actor.actorHealthInfo.hpPercentage <= FDP.FromDouble(0.5) && GetLogicTagFpValue(_actor, "Trick") == 0)
		{
			SetLogicTagFpValue(_actor, "Trick", 1);
			SkillTimes02 = 1;
		}
	}

	private void InterruptStrong(IEvent evt)
	{
		SkillTimes01 = 0;
	}

	private bool Condition01()
	{
		if (SkillTimes01 >= 7 && SkillTimes02 == 1)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) > 6)
		{
			return true;
		}
		return false;
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator Attack01()
	{
		GotoCastskill(Skill_Attack01);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
		SkillTimes01 = 0;
		SkillTimes02 = 0;
	}

	private IEnumerator Teleport()
	{
		GotoCastskill(Skill_Teleport);
		yield return WaitSkillFinish();
		if (SkillTimes03 == 0)
		{
			SkillTimes03 = 1;
			GotoCastskill(Skill_Attack03);
			yield return WaitSkillFinish();
		}
		else
		{
			SkillTimes03 = 0;
			GotoCastskill(Skill_Attack01);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Attack06()
	{
		GotoCastskill(Skill_Attack06);
		yield return WaitSkillFinish();
	}
}

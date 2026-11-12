using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Light._50251ShanDianLieQuan;

public class MiniBoss_Action_Lv1 : MonsterActionBase
{
	private readonly int Skill_Attack01_1 = 5025110;

	private readonly int Skill_Attack01_2 = 5025111;

	private readonly int Skill_Attack01_3 = 5025112;

	private readonly int Skill_Attack02 = 5025113;

	private readonly int Skill_Attack03_1 = 5025114;

	private readonly int Skill_Attack03_2 = 5025115;

	private readonly int Skill_Attack04 = 5025116;

	private readonly int Skill_Attack05 = 5025117;

	private readonly int Skill_Linger = 5025198;

	private int SkillTimes01;

	private int SkillTimes02;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
	}

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
		FP cd = 40;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition03;
		OperateDelegate operateIEnumerator = Attack05;
		list2.Add(new PoolBranchInfo(actor, 1001, 90, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 10;
		FP initCd2 = 0;
		FP releaseDistance = 4;
		FP releaseAngle = 360;
		operateIEnumerator = Attack01_1;
		list2.Add(new PoolBranchInfo(actor2, 1002, 80, cd2, initCd2, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 10;
		FP initCd3 = 0;
		FP releaseDistance2 = 15;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack03_1;
		list2.Add(new PoolBranchInfo(actor3, 1003, 70, cd3, initCd3, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 5;
		FP initCd4 = 0;
		FP releaseDistance3 = 100;
		FP releaseAngle3 = 360;
		operateIEnumerator = Linger;
		list2.Add(new PoolBranchInfo(actor4, 1005, 50, cd4, initCd4, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		PoolBranchesInfo poolBranchesInfo2 = new PoolBranchesInfo
		{
			index = 2
		};
		List<PoolBranchInfo> list3 = new List<PoolBranchInfo>();
		AdventureActor actor5 = _actor;
		FP cd5 = 80;
		FP initCd5 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Attack04;
		list3.Add(new PoolBranchInfo(actor5, 2001, 999, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 2;
		FP initCd6 = 0;
		operationConditionFunc = Condition04;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor6, 2002, 200, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 15;
		FP initCd7 = 0;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack01_3;
		list3.Add(new PoolBranchInfo(actor7, 2003, 100, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 18;
		FP initCd8 = 0;
		FP releaseDistance4 = 100;
		FP releaseAngle4 = 360;
		operateIEnumerator = Attack02;
		list3.Add(new PoolBranchInfo(actor8, 2004, 90, cd8, initCd8, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		FP cd9 = 20;
		FP initCd9 = 0;
		FP releaseDistance5 = 100;
		FP releaseAngle5 = 360;
		operateIEnumerator = Attack03_2;
		list3.Add(new PoolBranchInfo(actor9, 2005, 80, cd9, initCd9, active: true, releaseDistance5, releaseAngle5, default, null, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		FP cd10 = 10;
		FP initCd10 = 0;
		FP releaseDistance6 = 4;
		FP releaseAngle6 = 360;
		operateIEnumerator = Attack01_2;
		list3.Add(new PoolBranchInfo(actor10, 2006, 70, cd10, initCd10, active: true, releaseDistance6, releaseAngle6, default, null, null, operateIEnumerator));
		AdventureActor actor11 = _actor;
		FP cd11 = 10;
		FP initCd11 = 5;
		FP releaseDistance7 = 100;
		FP releaseAngle7 = 360;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor11, 2007, 10, cd11, initCd11, active: true, releaseDistance7, releaseAngle7, default, null, null, operateIEnumerator));
		poolBranchesInfo2.braches = list3;
		list.Add(poolBranchesInfo2);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(2, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void InterruptStrong(IEvent evt)
	{
		RemoveBuffFromTarget(_actor, 502510001);
		SwitchPool(1);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
	}

	private bool Condition01()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (Distance(GetPosition(), GetEntityPositionObsoleted(currentPlayer)) > 8 && Distance(GetPosition(), GetEntityPositionObsoleted(currentPlayer)) <= 30)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes01 >= 5)
		{
			return true;
		}
		return false;
	}

	private bool Condition03()
	{
		if (SkillTimes01 >= 4)
		{
			return true;
		}
		return false;
	}

	private bool Condition04()
	{
		if (SkillTimes02 >= 2)
		{
			return true;
		}
		return false;
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator Attack01_1()
	{
		GotoCastskill(Skill_Attack01_1);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator Attack01_2()
	{
		GotoCastskill(Skill_Attack01_2);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator Attack01_3()
	{
		GotoCastskill(Skill_Attack01_3);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator Attack03_1()
	{
		GotoCastskill(Skill_Attack03_1);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator Attack03_2()
	{
		GotoCastskill(Skill_Attack03_2);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		yield return WaitSkillFinish();
		SwitchPool(1);
		SkillTimes01 = 0;
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
		SwitchPool(2);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
	}

	private IEnumerator Linger()
	{
		GotoCastskill(Skill_Linger);
		yield return WaitSkillFinish();
		SkillTimes02 = 0;
	}
}

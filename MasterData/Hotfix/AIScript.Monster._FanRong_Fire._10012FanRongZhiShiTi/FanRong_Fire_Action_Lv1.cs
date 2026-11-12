using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_Action_Lv1 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 1001210;

	private static readonly int Skill_Attack02 = 1001212;

	private static readonly int Skill_Attack03 = 1001215;

	private static readonly int Skill_Attack04 = 1001217;

	private static readonly int StageChange = 1001220;

	private readonly int Skill_Linger = 1001205;

	private static readonly int Skill_Attack01_EX = 1001211;

	private static readonly int Skill_Attack02_Ex_Lv1 = 1001213;

	private static readonly int Skill_Attack03_Ex = 1001216;

	private static readonly int Skill_Attack05_Lv1 = 1001218;

	private static readonly int Skill_Attack06_Lv1 = 1001222;

	private int BossStage;

	private int SkillTimes01;

	private int SkillTimes02;

	private int[] CdList1 = new int[2] { 0, 3 };

	private int[] CdList2 = new int[2] { 0, 13 };

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		BossStage = 1;
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
		FP cd = 2;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition02;
		OperateDelegate operateIEnumerator = Linger;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 25;
		FP initCd2 = randomWeight(CdList1);
		FP releaseDistance = 20;
		FP releaseAngle = 35;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 1002, 90, cd2, initCd2, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 22;
		FP initCd3 = 0;
		FP releaseDistance2 = 10;
		FP releaseAngle2 = 60;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor3, 1003, 40, cd3, initCd3, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 20;
		FP initCd4 = 0;
		FP releaseDistance3 = 4;
		FP releaseAngle3 = 60;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor4, 1004, 30, cd4, initCd4, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 5;
		FP initCd5 = 0;
		FP releaseDistance4 = 5;
		FP releaseAngle4 = 45;
		operateIEnumerator = Attack04;
		list2.Add(new PoolBranchInfo(actor5, 1005, 20, cd5, initCd5, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		PoolBranchesInfo poolBranchesInfo2 = new PoolBranchesInfo
		{
			index = 2
		};
		List<PoolBranchInfo> list3 = new List<PoolBranchInfo>();
		AdventureActor actor6 = _actor;
		FP cd6 = 10;
		FP initCd6 = 0;
		operationConditionFunc = Condition03;
		operateIEnumerator = ChangeStage;
		list3.Add(new PoolBranchInfo(actor6, 2001, 999, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 10;
		FP initCd7 = 0;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack05_Lv1;
		list3.Add(new PoolBranchInfo(actor7, 2002, 888, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 2;
		FP initCd8 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor8, 2003, 777, cd8, initCd8, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		FP cd9 = 33;
		FP initCd9 = randomWeight(CdList2);
		FP releaseDistance5 = 30;
		FP releaseAngle5 = 90;
		operateIEnumerator = Attack06_Lv1;
		list3.Add(new PoolBranchInfo(actor9, 2004, 100, cd9, initCd9, active: true, releaseDistance5, releaseAngle5, default, null, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		FP cd10 = 28;
		FP initCd10 = 0;
		FP releaseDistance6 = 30;
		FP releaseAngle6 = 35;
		operateIEnumerator = Attack02_Ex_Lv1;
		list3.Add(new PoolBranchInfo(actor10, 2005, 90, cd10, initCd10, active: true, releaseDistance6, releaseAngle6, default, null, null, operateIEnumerator));
		AdventureActor actor11 = _actor;
		FP cd11 = 20;
		FP initCd11 = 0;
		FP releaseDistance7 = 30;
		FP releaseAngle7 = 60;
		operateIEnumerator = Attack03_Ex;
		list3.Add(new PoolBranchInfo(actor11, 2006, 80, cd11, initCd11, active: true, releaseDistance7, releaseAngle7, default, null, null, operateIEnumerator));
		AdventureActor actor12 = _actor;
		FP cd12 = 18;
		FP initCd12 = 0;
		FP releaseDistance8 = 7;
		FP releaseAngle8 = 60;
		operateIEnumerator = Attack01_EX;
		list3.Add(new PoolBranchInfo(actor12, 2007, 70, cd12, initCd12, active: true, releaseDistance8, releaseAngle8, default, null, null, operateIEnumerator));
		AdventureActor actor13 = _actor;
		FP cd13 = 6;
		FP initCd13 = 0;
		FP releaseDistance9 = 5;
		FP releaseAngle9 = 45;
		operateIEnumerator = Attack04;
		list3.Add(new PoolBranchInfo(actor13, 2008, 60, cd13, initCd13, active: true, releaseDistance9, releaseAngle9, default, null, null, operateIEnumerator));
		poolBranchesInfo2.braches = list3;
		list.Add(poolBranchesInfo2);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, HpChange);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void HpChange(IEvent custom)
	{
		if (_actor.actorHealthInfo.hpPercentage <= FDP.FromDouble(0.7) && GetLogicTagFpValue(_actor, "BattleStage") != 2)
		{
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			SwitchPool(2);
			BossStage = 1;
		}
	}

	private void InterruptStrong(IEvent evt)
	{
		SkillTimes02 = 0;
	}

	private bool Condition01()
	{
		if (SkillTimes01 >= 6)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes02 >= 2)
		{
			return true;
		}
		return false;
	}

	private bool Condition03()
	{
		if (BossStage == 1)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Linger()
	{
		GotoCastskill(Skill_Linger);
		SkillTimes02 = 0;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack01()
	{
		GotoCastskill(Skill_Attack01);
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator ChangeStage()
	{
		GotoCastskill(StageChange);
		BossStage = 2;
		SkillTimes01 = 8;
		SkillTimes02 = 0;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack01_EX()
	{
		GotoCastskill(Skill_Attack01_EX);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02_Ex_Lv1()
	{
		GotoCastskill(Skill_Attack02_Ex_Lv1);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03_Ex()
	{
		GotoCastskill(Skill_Attack03_Ex);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05_Lv1()
	{
		GotoCastskill(Skill_Attack05_Lv1);
		SkillTimes01 = 0;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack06_Lv1()
	{
		GotoCastskill(Skill_Attack06_Lv1);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}
}

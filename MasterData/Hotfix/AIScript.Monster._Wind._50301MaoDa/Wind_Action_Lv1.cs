using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Action_Lv1 : MonsterActionBase
{
	private readonly int Skill_Attack01 = 5030102;

	private readonly int Skill_Attack02 = 5030103;

	private readonly int Skill_Attack03 = 5030108;

	private readonly int Skill_Attack04 = 5030109;

	private readonly int Skill_Attack05 = 5030111;

	private readonly int Skill_Linger = 5030199;

	private int SkillTimes01;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SkillTimes01 = 0;
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
		FP cd = 35;
		FP initCd = 30;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = StageChange;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, initCd, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 2;
		FP initCd2 = 0;
		Func<bool> operationConditionFunc = Condition02;
		operateIEnumerator = Linger;
		list2.Add(new PoolBranchInfo(actor2, 1002, 100, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 15;
		FP initCd3 = 0;
		FP releaseDistance2 = 3;
		FP releaseAngle2 = 360;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack04_01;
		list2.Add(new PoolBranchInfo(actor3, 1003, 90, cd3, initCd3, active: true, releaseDistance2, releaseAngle2, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 10;
		FP initCd4 = 1.5;
		FP releaseDistance3 = 100;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor4, 1004, 80, cd4, initCd4, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 8;
		FP initCd5 = 4;
		FP releaseDistance4 = 100;
		FP releaseAngle4 = 360;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor5, 1005, 70, cd5, initCd5, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 20;
		FP initCd6 = 10;
		FP releaseDistance5 = 3;
		FP releaseAngle5 = 360;
		operateIEnumerator = Attack04_02;
		list2.Add(new PoolBranchInfo(actor6, 1006, 90, cd6, initCd6, active: true, releaseDistance5, releaseAngle5, default, null, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 5;
		FP initCd7 = 0;
		FP releaseDistance6 = 20;
		FP releaseAngle6 = 360;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor7, 1007, 50, cd7, initCd7, active: true, releaseDistance6, releaseAngle6, default, null, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 2;
		FP initCd8 = 0;
		FP releaseDistance7 = 100;
		FP releaseAngle7 = 360;
		operateIEnumerator = Linger;
		list2.Add(new PoolBranchInfo(actor8, 1008, 10, cd8, initCd8, active: true, releaseDistance7, releaseAngle7, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		PoolBranchesInfo poolBranchesInfo2 = new PoolBranchesInfo
		{
			index = 2
		};
		List<PoolBranchInfo> list3 = new List<PoolBranchInfo>();
		AdventureActor actor9 = _actor;
		FP cd9 = 35;
		FP initCd9 = 30;
		FP releaseDistance8 = 100;
		FP releaseAngle8 = 360;
		operateIEnumerator = Attack05;
		list3.Add(new PoolBranchInfo(actor9, 2001, 999, cd9, initCd9, active: true, releaseDistance8, releaseAngle8, default, null, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		FP cd10 = 2;
		FP initCd10 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor10, 2002, 100, cd10, initCd10, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor11 = _actor;
		FP cd11 = 18;
		FP initCd11 = 0;
		FP releaseDistance9 = 3;
		FP releaseAngle9 = 360;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack04_01;
		list3.Add(new PoolBranchInfo(actor11, 2003, 90, cd11, initCd11, active: true, releaseDistance9, releaseAngle9, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor12 = _actor;
		FP cd12 = 15;
		FP initCd12 = 3;
		FP releaseDistance10 = 100;
		FP releaseAngle10 = 360;
		operateIEnumerator = Attack02;
		list3.Add(new PoolBranchInfo(actor12, 2004, 80, cd12, initCd12, active: true, releaseDistance10, releaseAngle10, default, null, null, operateIEnumerator));
		AdventureActor actor13 = _actor;
		FP cd13 = 8;
		FP initCd13 = 4;
		FP releaseDistance11 = 100;
		FP releaseAngle11 = 360;
		operateIEnumerator = Attack03;
		list3.Add(new PoolBranchInfo(actor13, 2005, 70, cd13, initCd13, active: true, releaseDistance11, releaseAngle11, default, null, null, operateIEnumerator));
		AdventureActor actor14 = _actor;
		FP cd14 = 15;
		FP initCd14 = 10;
		FP releaseDistance12 = 3;
		FP releaseAngle12 = 360;
		operateIEnumerator = Attack04_02;
		list3.Add(new PoolBranchInfo(actor14, 2006, 90, cd14, initCd14, active: true, releaseDistance12, releaseAngle12, default, null, null, operateIEnumerator));
		AdventureActor actor15 = _actor;
		FP cd15 = 8;
		FP initCd15 = 0;
		FP releaseDistance13 = 20;
		FP releaseAngle13 = 360;
		operateIEnumerator = Attack01;
		list3.Add(new PoolBranchInfo(actor15, 2007, 50, cd15, initCd15, active: true, releaseDistance13, releaseAngle13, default, null, null, operateIEnumerator));
		AdventureActor actor16 = _actor;
		FP cd16 = 2;
		FP initCd16 = 0;
		FP releaseDistance14 = 100;
		FP releaseAngle14 = 360;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor16, 2008, 10, cd16, initCd16, active: true, releaseDistance14, releaseAngle14, default, null, null, operateIEnumerator));
		poolBranchesInfo2.braches = list3;
		list.Add(poolBranchesInfo2);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptSpawnerAttack);
	}

	private void InterruptSpawnerAttack(IEvent evt)
	{
		SkillTimes01 = 0;
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		for (int i = 0; i < targetByTeammateIndex.Count; i++)
		{
			LogicEntity logicEntity = targetByTeammateIndex.get_Item(i);
			AddBuffToTarget(logicEntity, 503010006);
		}
	}

	private bool Condition01()
	{
		if (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) <= 5)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes01 >= 2)
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
		SkillTimes01++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		SkillTimes01++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04_01()
	{
		GotoCastskill(Skill_Attack04);
		SetPoolBranchCD(1006, 20);
		SetPoolBranchCD(2006, 15);
		SkillTimes01++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04_02()
	{
		GotoCastskill(Skill_Attack04);
		SetPoolBranchCD(1003, 15);
		SetPoolBranchCD(2003, 18);
		SkillTimes01++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		SkillTimes01 = 2;
		SetPoolBranchCD(2004, 3);
		yield return WaitSkillFinish();
	}

	private IEnumerator StageChange()
	{
		AddBuffToTarget(_actor, 503010003);
		SwitchPool(2);
		SkillTimes01 = 2;
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
	}

	private IEnumerator Linger()
	{
		GotoCastskill(Skill_Linger);
		SkillTimes01 = 0;
		yield return WaitSkillFinish();
	}
}

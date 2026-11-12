using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Action_Lv2_DaWuGui_Earth : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 5018112;

	private static readonly int Skill_Attack02 = 5018113;

	private static readonly int Skill_Attack03 = 5018115;

	private static readonly int Skill_Attack04 = 5018118;

	private static readonly int Skill_Attack05 = 5018119;

	private static readonly int Skill_Teleport = 5018122;

	private static readonly int Skill_Walk = 5018199;

	private FP SkillTimes01;

	private FP SkillTimes02;

	private int SkillTimes03;

	private int SkillTimes04;

	private static readonly int Skill_Test = 0;

	private bool Condition01Recieved;

	private bool Condition02Recieved;

	private bool Condition03Recieved;

	private bool Condition04Recieved;

	private bool Condition05Recieved;

	private bool Condition06Recieved;

	private bool Condition08Recieved;

	private bool Condition09Recieved;

	private bool Condition10Recieved;

	private bool Condition11Recieved;

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
		FP cd = 0.1;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Attack01;
		Action operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor2 = _actor;
		FP cd2 = 0.1;
		FP initCd2 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Attack02;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor2, 1002, 99, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor3 = _actor;
		FP cd3 = 0.1;
		FP initCd3 = 0;
		operationConditionFunc = Condition03;
		operateIEnumerator = Attack03;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor3, 1003, 99, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor4 = _actor;
		FP cd4 = 0.1;
		FP initCd4 = 0;
		operationConditionFunc = Condition04;
		operateIEnumerator = Attack04;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor4, 1004, 99, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor5 = _actor;
		FP cd5 = 0.1;
		FP initCd5 = 0;
		operationConditionFunc = Condition05;
		operateIEnumerator = Attack05;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor5, 1005, 99, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor6 = _actor;
		FP cd6 = 0.1;
		FP initCd6 = 0;
		operationConditionFunc = Condition06;
		operateIEnumerator = Teleport;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor6, 1006, 99, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor7 = _actor;
		FP cd7 = 0.1;
		FP initCd7 = 0;
		operateIEnumerator = Walk;
		list2.Add(new PoolBranchInfo(actor7, 1007, 1, cd7, initCd7, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 0.1;
		FP initCd8 = 0;
		operationConditionFunc = Condition08;
		operateIEnumerator = TeleportAttack01;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor8, 1008, 99, cd8, initCd8, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor9 = _actor;
		FP cd9 = 0.1;
		FP initCd9 = 0;
		operationConditionFunc = Condition09;
		operateIEnumerator = TeleportAttack02;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor9, 1009, 99, cd9, initCd9, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor10 = _actor;
		FP cd10 = 0.1;
		FP initCd10 = 0;
		operationConditionFunc = Condition10;
		operateIEnumerator = TeleportAttack03;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor10, 1010, 99, cd10, initCd10, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor11 = _actor;
		FP cd11 = 0.1;
		FP initCd11 = 0;
		operationConditionFunc = Condition11;
		operateIEnumerator = TeleportAttack04;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor11, 1011, 99, cd11, initCd11, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		Condition01Recieved = false;
		Condition02Recieved = false;
		Condition03Recieved = false;
		Condition04Recieved = false;
		Condition05Recieved = false;
		Condition06Recieved = false;
		Condition08Recieved = false;
		Condition09Recieved = false;
		Condition10Recieved = false;
		Condition11Recieved = false;
		SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
		SkillTimes02 = GetRandomValue(0, 1.5, isInt: true);
		SkillTimes03 = 0;
		SkillTimes04 = 0;
		SendMessageToGroupController(_actor.Id, "Free");
	}

	protected override void OnActionDisable()
	{
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.GroupController, active: true, GroupMessageOperate);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void InterruptStrong(IEvent evt)
	{
		SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
		SkillTimes02 = GetRandomValue(0, 1.5, isInt: true);
		SkillTimes03 = 0;
		SkillTimes04 = 0;
		Condition01Recieved = false;
		Condition02Recieved = false;
		Condition03Recieved = false;
		Condition04Recieved = false;
		Condition05Recieved = false;
		Condition06Recieved = false;
		Condition08Recieved = false;
		Condition09Recieved = false;
		Condition10Recieved = false;
		Condition11Recieved = false;
	}

	private void GroupMessageOperate(IEvent evt)
	{
		SendMessageToGroupController(_actor.Id, "Free");
		switch ((evt as AdventureGroupControllerToMonsterMessage).operationType)
		{
		case "Skill_Attack01And02":
			if (SkillTimes01 == 0)
			{
				if (Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) > 6)
				{
					Condition08Recieved = true;
					SkillTimes01 = 1;
				}
				else
				{
					Condition01Recieved = true;
					SkillTimes01 = 1;
				}
			}
			else if (Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) > 6)
			{
				Condition09Recieved = true;
				SkillTimes01 = 0;
			}
			else
			{
				Condition02Recieved = true;
				SkillTimes01 = 0;
			}
			break;
		case "Skill_Attack03And04":
			if (SkillTimes02 == 0)
			{
				if (Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) > 6)
				{
					Condition10Recieved = true;
					SkillTimes02 = 1;
				}
				else
				{
					Condition03Recieved = true;
					SkillTimes02 = 1;
				}
			}
			else if (Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) > 6)
			{
				Condition11Recieved = true;
				SkillTimes02 = 0;
			}
			else
			{
				Condition04Recieved = true;
				SkillTimes02 = 0;
			}
			break;
		case "Skill_Attack05":
			Condition05Recieved = true;
			break;
		case "TeleportAttack02":
			Condition09Recieved = true;
			break;
		case "Teleport":
			Condition06Recieved = true;
			break;
		}
	}

	private bool Condition01()
	{
		return Condition01Recieved;
	}

	private bool Condition02()
	{
		return Condition02Recieved;
	}

	private bool Condition03()
	{
		return Condition03Recieved;
	}

	private bool Condition04()
	{
		return Condition04Recieved;
	}

	private bool Condition05()
	{
		return Condition05Recieved;
	}

	private bool Condition06()
	{
		return Condition06Recieved;
	}

	private bool Condition08()
	{
		return Condition08Recieved;
	}

	private bool Condition09()
	{
		return Condition09Recieved;
	}

	private bool Condition10()
	{
		return Condition10Recieved;
	}

	private bool Condition11()
	{
		return Condition11Recieved;
	}

	private IEnumerator Attack01()
	{
		GotoCastSkill(Skill_Attack01);
		Condition01Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastSkill(Skill_Attack02);
		Condition02Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastSkill(Skill_Attack03);
		Condition03Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		GotoCastSkill(Skill_Attack04);
		Condition04Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		GotoCastSkill(Skill_Attack05);
		Condition05Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Teleport()
	{
		GotoCastSkill(Skill_Teleport);
		Condition06Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Walk()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(Skill_Walk);
		yield return WaitSkillFinish();
	}

	private IEnumerator TeleportAttack01()
	{
		GotoCastSkill(Skill_Teleport);
		yield return WaitSkillFinish();
		Condition08Recieved = false;
		Condition01Recieved = true;
		GotoCastSkill(Skill_Attack01);
		Condition01Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator TeleportAttack02()
	{
		GotoCastSkill(Skill_Teleport);
		yield return WaitSkillFinish();
		Condition09Recieved = false;
		Condition02Recieved = true;
		GotoCastSkill(Skill_Attack02);
		Condition02Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator TeleportAttack03()
	{
		GotoCastSkill(Skill_Teleport);
		yield return WaitSkillFinish();
		Condition10Recieved = false;
		Condition03Recieved = true;
		GotoCastSkill(Skill_Attack03);
		Condition03Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator TeleportAttack04()
	{
		GotoCastSkill(Skill_Teleport);
		yield return WaitSkillFinish();
		Condition11Recieved = false;
		Condition04Recieved = true;
		GotoCastSkill(Skill_Attack04);
		Condition04Recieved = false;
		yield return WaitSkillFinish();
	}

	private void GotoCastSkill(int ID)
	{
		int num = ID;
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
		if (num != Skill_Walk)
		{
			SendMessageToGroupController(_actor.Id, "Busy");
		}
	}

	private void SkillComplete()
	{
		SendMessageToGroupController(_actor.Id, "Free");
	}
}

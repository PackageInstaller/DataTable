using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Action_Lv2_ShunYiGuai_Fire : MonsterActionBase
{
	private readonly int Skill_Attack01 = 5031102;

	private readonly int Skill_Attack02 = 5031103;

	private readonly int Skill_Attack03 = 5031104;

	private readonly int Skill_Attack04 = 5031105;

	private readonly int Skill_Attack05 = 5031106;

	private readonly int Skill_Attack06 = 5031107;

	private readonly int Skill_Attack07 = 5031108;

	private readonly int Skill_Linger = 5031198;

	private static readonly int Skill_Test;

	private bool Condition01Recieved;

	private bool Condition02Recieved;

	private bool Condition03Recieved;

	private bool Condition04Recieved;

	private bool Condition05Recieved;

	private bool Condition06Recieved;

	private bool Condition07Recieved;

	private FP SkillTimes01;

	private FP SkillTimes02;

	private int SkillTimes03;

	private int SkillTimes04;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
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
		operateIEnumerator = Attack06;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor6, 1006, 99, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor7 = _actor;
		FP cd7 = 0.1;
		FP initCd7 = 0;
		operationConditionFunc = Condition07;
		operateIEnumerator = Attack07;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor7, 1007, 99, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor8 = _actor;
		FP cd8 = 0.1;
		FP initCd8 = 0;
		operateIEnumerator = Walk;
		list2.Add(new PoolBranchInfo(actor8, 1008, 1, cd8, initCd8, active: true, default, default, default, null, null, operateIEnumerator));
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
		Condition07Recieved = false;
		SendMessageToGroupController(_actor.Id, "Free");
		SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
		SkillTimes02 = 0;
		SkillTimes03 = 0;
		SkillTimes04 = 0;
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
		Condition01Recieved = false;
		Condition02Recieved = false;
		Condition03Recieved = false;
		Condition04Recieved = false;
		Condition05Recieved = false;
		Condition06Recieved = false;
		Condition07Recieved = false;
		SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		switch ((evt as AdventureGroupControllerToMonsterMessage).operationType)
		{
		case "Skill_Attack04":
			Condition04Recieved = true;
			break;
		case "Skill_Attack04And03":
			if (SkillTimes02 == 0)
			{
				Condition03Recieved = true;
				SkillTimes02 = 1;
			}
			else
			{
				Condition04Recieved = true;
				SkillTimes02 = 0;
			}
			break;
		case "Skill_Attack07":
			Condition07Recieved = true;
			break;
		case "Skill_Attack06":
			Condition06Recieved = true;
			break;
		case "Skill_Attack09":
			if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) <= 5)
			{
				if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 90)
				{
					Condition05Recieved = true;
				}
				else if ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180) || (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -90))
				{
					Condition01Recieved = true;
				}
			}
			else
			{
				SendMessageToGroupController(_actor.Id, "Free");
			}
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

	private bool Condition07()
	{
		return Condition07Recieved;
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
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 90)
		{
			GotoCastSkill(Skill_Attack02);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Attack04()
	{
		GotoCastSkill(Skill_Attack04);
		Condition04Recieved = false;
		yield return WaitSkillFinish();
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) <= 5)
		{
			if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 90)
			{
				GotoCastSkill(Skill_Attack05);
				yield return WaitSkillFinish();
			}
			else if ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180) || (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -90))
			{
				GotoCastSkill(Skill_Attack01);
				yield return WaitSkillFinish();
			}
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 90 && SkillTimes01 == 0)
		{
			GotoCastSkill(Skill_Attack02);
			SkillTimes01 = 1;
			yield return WaitSkillFinish();
		}
		else
		{
			SkillTimes01 = 0;
			GotoCastSkill(Skill_Attack06);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Attack05()
	{
		GotoCastSkill(Skill_Attack05);
		Condition05Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack06()
	{
		GotoCastSkill(Skill_Attack06);
		Condition06Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack07()
	{
		GotoCastSkill(Skill_Attack07);
		Condition07Recieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Walk()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(Skill_Linger);
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
		if (num != Skill_Linger)
		{
			SendMessageToGroupController(_actor.Id, "Busy");
		}
	}

	private void SkillComplete()
	{
		SendMessageToGroupController(_actor.Id, "Free");
	}
}

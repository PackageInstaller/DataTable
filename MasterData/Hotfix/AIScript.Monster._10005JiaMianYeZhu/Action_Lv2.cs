using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Action_Lv2 : MonsterActionBase
{
	private static readonly int Skill_Turn = 1000508;

	private static readonly int Skill_Impact = 1000501;

	private static readonly int Skill_StrikeFly = 1000503;

	private static readonly int Skill_Dash = 1000502;

	private static readonly int Skill_Crush = 1000504;

	private static readonly int Skill_ThousandDash = 1000505;

	private static readonly int Skill_WanderAct = 1000515;

	private static readonly int Skill_LighteningDash = 1000507;

	private static readonly int Skill_Angry = 1000506;

	private static readonly FP HpPercentage_Stage1To2 = 0.75;

	private static readonly FP AngryBuffMaxTime = 15;

	private static readonly int Skill_Test = 0;

	private bool IsPhase2;

	private FP Angle;

	private FP AngryContinuousTime;

	private FP AngryTimes;

	private FP SkillCount;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SetLogicTagFpValue(_actor, "AngryTimes", 0);
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 1;
		FP initCd = 0;
		Func<bool> operationConditionFunc = WanderActCondition;
		OperateDelegate operateIEnumerator = WanderActCast;
		list2.Add(new PoolBranchInfo(actor, 1099, 99, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		list2.Add(new PoolBranchInfo(_actor, 1001, 60, 45, 0, active: true, 999, 360, 99, ThousandDashCondition, null, ThousandDashCast));
		list2.Add(new PoolBranchInfo(_actor, 1002, 50, 20, 0, active: true, 99, 360, 99, LighteningDashCondition, null, LighteningDashCast));
		list2.Add(new PoolBranchInfo(_actor, 1003, 40, 6, 0, active: true, 3, 360, 1, CrushCondition, null, CrushCast));
		list2.Add(new PoolBranchInfo(_actor, 1004, 30, 3, 0, active: true, 3, 360, 1, AttackCondition, null, AttackCast));
		list2.Add(new PoolBranchInfo(_actor, 1006, 10, 1, 0, active: true, 13, 360, 5, null, null, DashCast));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		IsPhase2 = false;
		SkillCount = 0;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptAngry);
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
	}

	private IEnumerator ThousandDashCast()
	{
		GotoCastSkill(Skill_ThousandDash);
		yield return WaitSkillFinish();
		GotoCastSkill(Skill_Angry);
		yield return WaitSkillFinish();
		CheckAngry();
	}

	private IEnumerator LighteningDashCast()
	{
		GotoCastSkill(Skill_Turn);
		yield return WaitSkillFinish();
		GotoCastSkill(Skill_LighteningDash);
		yield return WaitSkillFinish();
		CheckAngry();
	}

	private IEnumerator CrushCast()
	{
		GotoCastSkill(Skill_Crush);
		yield return WaitSkillFinish();
		CheckAngry();
	}

	private IEnumerator AttackCast()
	{
		Angle = CalcAngleBetweenSelfAndAttackTarget();
		GotoCastSkill(Skill_Turn);
		yield return WaitSkillFinish();
		if (Angle < 90)
		{
			GotoCastSkill(Skill_Impact);
		}
		else
		{
			GotoCastSkill(Skill_StrikeFly);
		}
		yield return WaitSkillFinish();
		CheckAngry();
	}

	private IEnumerator DashCast()
	{
		GotoCastSkill(Skill_Turn);
		yield return WaitSkillFinish();
		GotoCastSkill(Skill_Dash);
		yield return WaitSkillFinish();
		CheckAngry();
	}

	private IEnumerator WanderActCast()
	{
		GotoCastSkill(Skill_WanderAct);
		SkillCount = 0;
		yield return WaitSkillFinish();
	}

	private bool ThousandDashCondition()
	{
		if (GetLogicTagFpValue(_actor, "BattleStage") == 2)
		{
			return true;
		}
		return false;
	}

	private bool LighteningDashCondition()
	{
		if (GetBuffNum(_actor, 100050110) > 0 && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 5 && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 9)
		{
			return true;
		}
		return false;
	}

	private bool CrushCondition()
	{
		TSVector2 position = GetPosition();
		FP width = 8;
		FP length = 2;
		FP rotation = GetRotation();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		if (GetLogicTagFpValue(_actor, "BattleStage") == 2 && AreaCheckMonsterTarget(shapeData))
		{
			return true;
		}
		return false;
	}

	private bool AttackCondition()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 7)
		{
			return true;
		}
		return false;
	}

	private bool WanderActCondition()
	{
		if (SkillCount >= 5)
		{
			return true;
		}
		return false;
	}

	private void InterruptAngry(IEvent evt)
	{
		RemoveBuffFromTarget(_actor, 100050110);
		SetPoolBranchCD(1001, 25);
		SkillCount = 0;
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentage_Stage1To2 && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			IsPhase2 = true;
		}
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
		if (ID == Skill_Impact || ID == Skill_StrikeFly)
		{
			SkillCount += (FP)1;
		}
		else if (ID == Skill_Dash || ID == Skill_Crush)
		{
			SkillCount += (FP)1.5;
		}
	}

	private void CheckAngry()
	{
		AngryContinuousTime = _actor.LogicTime - GetLogicTagFpValue(_actor, "AngryBuffStartTime");
		AngryTimes = GetLogicTagFpValue(_actor, "AngryTimes");
		if (GetBuffNum(_actor, 100050110) > 0 && AngryContinuousTime > AngryBuffMaxTime && AngryTimes < 3)
		{
			RemoveBuffFromTarget(_actor, 100050110);
			SkillCount = 99;
		}
	}
}

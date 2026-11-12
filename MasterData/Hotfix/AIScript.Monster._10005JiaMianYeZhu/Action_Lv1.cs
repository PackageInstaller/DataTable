using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Action_Lv1 : MonsterActionBase
{
	private static readonly int Skill_Turn = 1000508;

	private static readonly int Skill_Impact = 1000501;

	private static readonly int Skill_StrikeFly = 1000503;

	private static readonly int Skill_Dash = 1000509;

	private static readonly int Skill_Crush = 1000504;

	private static readonly int Skill_ThousandDash = 1000510;

	private static readonly int Skill_WanderAct = 1000515;

	private static readonly FP HpPercentage_Stage1To2 = 0.75;

	private static readonly int Skill_Test = 0;

	private bool IsPhase2;

	private FP Angle;

	private FP SkillCount;

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
		FP cd = 1;
		FP initCd = 0;
		Func<bool> operationConditionFunc = WanderActCondition;
		OperateDelegate operateIEnumerator = WanderActCast;
		list2.Add(new PoolBranchInfo(actor, 1099, 99, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		list2.Add(new PoolBranchInfo(_actor, 1001, 60, 45, 0, active: true, 999, 360, 99, ThousandDashCondition, null, ThousandDashCast));
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
	}

	private IEnumerator CrushCast()
	{
		GotoCastSkill(Skill_Crush);
		yield return WaitSkillFinish();
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
	}

	private IEnumerator DashCast()
	{
		GotoCastSkill(Skill_Turn);
		yield return WaitSkillFinish();
		GotoCastSkill(Skill_Dash);
		yield return WaitSkillFinish();
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
		if (SkillCount >= 3)
		{
			return true;
		}
		return false;
	}

	private void InterruptAngry(IEvent evt)
	{
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
}

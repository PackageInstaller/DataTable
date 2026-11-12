using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Action_Lv1 : MonsterActionBase
{
	private static readonly int Skill_Expansion = 5057201;

	private static readonly int Skill_Wander = 5057202;

	private static readonly FP LiftTime = 4;

	private FP VolumeLevel;

	private CoroutineNode CheckCor;

	private CoroutineNode CountDownCor;

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
		FP liftTime = LiftTime;
		FP liftTime2 = LiftTime;
		Func<bool> operationConditionFunc = ExpansionCondition;
		OperateDelegate operateIEnumerator = ExpansionCast;
		list2.Add(new PoolBranchInfo(actor, 1002, 80, liftTime, liftTime2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd = 6;
		FP initCd = 0;
		operateIEnumerator = WanderCast;
		list2.Add(new PoolBranchInfo(actor2, 1003, 60, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		VolumeLevel = 0;
		SetLogicTagToggleValue(_actor, "LifeEnd", value: false);
		SetLogicTagTSVector2Value(_actor, "SpawnPosition", GetPosition());
		StartCoroutine(ref CheckCor, Check());
	}

	protected override void OnActionDisable()
	{
		StopCoroutine(CheckCor);
		StopCoroutine(CountDownCor);
	}

	private void GotoCastSkill(int ID)
	{
		CastSkill(ID);
	}

	private IEnumerator ExpansionCast()
	{
		VolumeLevel = GetLogicTagFpValue(_actor, "VolumeLevel");
		VolumeLevel += (FP)1;
		GotoCastSkill(Skill_Expansion);
		yield return WaitSkillFinish();
	}

	private IEnumerator WanderCast()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(Skill_Wander);
		yield return WaitSkillFinish();
	}

	private bool ExpansionCondition()
	{
		if (VolumeLevel == 3)
		{
			return false;
		}
		return true;
	}

	private IEnumerator Check()
	{
		while (GetBuffNum(_actor, 505719901) <= 0)
		{
			yield return null;
		}
		SetLogicTagFpValue(_actor, "SkillMode", 1);
		yield return null;
		_actor.InterruptForceControl();
		_actor.DestroySelf();
	}
}

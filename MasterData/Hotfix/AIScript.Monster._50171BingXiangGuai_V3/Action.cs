using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Action : MonsterActionBase
{
	private static readonly int Skillid_ThrowIceCube = 5017111;

	private static readonly int Skillid_NormalAttack_Fan = 5017112;

	private static readonly int Skillid_NormalAttack_Circle = 5017126;

	private static readonly int Skillid_Dash = 5017113;

	private static readonly int Skillid_DashSide = 5017114;

	private static readonly int Skillid_DashBack = 5017115;

	private static readonly int Skillid_FrozenInjection = 5017116;

	private static readonly int testSkillId = 0;

	private static readonly FP HP_P2 = 0.5;

	private int SkillTimes01;

	private int SkillTimes02;

	private int DashNum;

	private List<LogicEntity> IceCube = new List<LogicEntity>();

	protected override void OnActionEnable()
	{
		SkillTimes01 = 4;
		SkillTimes02 = 0;
		IceCube.Clear();
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			DashNum = 6;
		}
		else
		{
			DashNum = 4;
		}
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
		FP cd = 10;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = ThrowIceCube;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 15;
		FP initCd2 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Dash;
		list2.Add(new PoolBranchInfo(actor2, 1002, 90, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 10;
		FP initCd3 = 0;
		operateIEnumerator = NormalAttack_Fan;
		list2.Add(new PoolBranchInfo(actor3, 1003, 80, cd3, initCd3, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 10;
		FP initCd4 = 0;
		operateIEnumerator = MoveAttack;
		list2.Add(new PoolBranchInfo(actor4, 1004, 70, cd4, initCd4, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 10;
		FP initCd5 = 0;
		operateIEnumerator = NormalAttack_Circle;
		list2.Add(new PoolBranchInfo(actor5, 1005, 70, cd5, initCd5, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, CleanCount);
	}

	private void CleanCount(IEvent evt)
	{
		SkillTimes01 = 4;
	}

	private bool Condition01()
	{
		if (SkillTimes01 >= 4)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		IceCube.Clear();
		IceCube.AddRange(GetTargetByTeammateIndex(0));
		if (IceCube.Count <= DashNum)
		{
			return true;
		}
		return false;
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator ThrowIceCube()
	{
		if (_actor.actorHealthInfo.hpPercentage <= HP_P2 && SkillTimes02 == 0)
		{
			GotoCastSkill(Skillid_FrozenInjection);
			SkillTimes02 = 1;
		}
		else
		{
			GotoCastSkill(Skillid_ThrowIceCube);
			SkillTimes02 = 0;
		}
		yield return WaitSkillFinish();
		SkillTimes01 = 0;
	}

	private IEnumerator NormalAttack_Fan()
	{
		GotoCastSkill(Skillid_NormalAttack_Fan);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator NormalAttack_Circle()
	{
		GotoCastSkill(Skillid_NormalAttack_Circle);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator Dash()
	{
		GotoCastSkill(Skillid_Dash);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator MoveAttack()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -135 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 135)
		{
			GotoCastSkill(Skillid_DashSide);
		}
		else
		{
			GotoCastSkill(Skillid_DashBack);
		}
		yield return WaitSkillFinish();
		SkillTimes01++;
	}
}

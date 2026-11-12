using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._18011LiMingFaShi;

public class Action_9_3 : MonsterActionBase
{
	private readonly int SkillId_FallingStar = 1801108;

	private readonly int SkillId_Teleport = 1801109;

	private FP SkillTimes01;

	private FP SkillTimes02;

	private readonly int testSkillId;

	private bool _finalStarted;

	private int _deathCount;

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
		FP cd = 7;
		FP initCd = 1;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Skill2_FallingStar;
		list2.Add(new PoolBranchInfo(actor, 4, 80, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 10;
		FP initCd2 = 2;
		operationConditionFunc = Condition02;
		operateIEnumerator = Skill3_Teleport;
		list2.Add(new PoolBranchInfo(actor2, 5, 999, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SkillTimes01 = 0;
		SkillTimes02 = 0;
		InitListenEvent(MonsterEventType.MonsterDie, true, InterruptStrong, 1952805747, 1918065779, 1867013987, 2020173428, 1701336156);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	private void InterruptStrong(IEvent evt)
	{
		_deathCount++;
		if (!_finalStarted && _deathCount == 9)
		{
			_finalStarted = true;
			StartCor(WaitTime());
		}
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private bool Condition01()
	{
		if (SkillTimes01 == 0)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes02 == 1)
		{
			return true;
		}
		return false;
	}

	private IEnumerator WaitTime()
	{
		SkillTimes01 = 1;
		InterruptSkill();
		yield return WaitTime(8);
		SkillTimes02 = 1;
	}

	private IEnumerator Skill2_FallingStar()
	{
		GotoCastSkill(SkillId_FallingStar);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill3_Teleport()
	{
		GotoCastSkill(SkillId_Teleport);
		yield return WaitSkillFinish();
	}
}

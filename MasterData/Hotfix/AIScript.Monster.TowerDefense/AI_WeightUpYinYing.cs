using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_WeightUpYinYing : TowerMonsterBaseAI
{
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
		OperateDelegate operateIEnumerator = WeightUpSkillCast;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagToggleValue(_actor, "IsHurtInterrupted", value: false);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, StopWeightUpSkill);
	}

	private IEnumerator WeightUpSkillCast()
	{
		PauseMove();
		CastSkill(8070201);
		yield return WaitTime(2);
		ResumeMove();
		yield return WaitSkillFinish();
		SetPoolBranchCD(1001, 10);
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}

	private void StopWeightUpSkill(IEvent evt)
	{
		SetPoolBranchCD(1001, 10);
	}
}

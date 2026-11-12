using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_WeightUpChuanSongGuai : TowerMonsterBaseAI
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
		FP cd = 5;
		FP initCd = 1;
		OperateDelegate operateIEnumerator = WeightUpSkillCast;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator WeightUpSkillCast()
	{
		PauseMove();
		CastSkill(8080201);
		yield return WaitTime(1);
		ResumeMove();
		yield return WaitSkillFinish();
		SetPoolBranchActive(1001, active: false);
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}
}

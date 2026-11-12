using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster.TowerDefense;

public class AI_JustRun : TowerMonsterBaseAI
{
	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
		{
			new PoolBranchesInfo
			{
				index = 1,
				braches = new List<PoolBranchInfo>()
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}
}

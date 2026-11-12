using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_BianSuCiKe : TowerMonsterBaseAI
{
	private const int skillId_Main = 8080501;

	private const int cd_Main = 30;

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
		FP cd = 30;
		FP initCd = 10;
		OperateDelegate operateIEnumerator = BianSuCiKeSkillCast;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator BianSuCiKeSkillCast()
	{
		PauseMove();
		CastSkill(8080501);
		yield return WaitSkillFinish();
		ResumeMove();
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}
}

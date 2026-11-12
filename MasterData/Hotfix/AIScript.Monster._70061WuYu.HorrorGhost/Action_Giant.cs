using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Action_Giant : MonsterActionBase
{
	private const int Skill_Slam = 7006145;

	private static readonly FP SlamRange = 100;

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
		FP cd = 0;
		FP initCd = 0;
		FP slamRange = SlamRange;
		OperateDelegate operateIEnumerator = DoCast_Slam;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, slamRange, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator DoCast_Slam()
	{
		CastSkill(7006145);
		yield return WaitSkillFinish();
	}
}

using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_LaserOrb : MonsterActionBase
{
	private const int skill_LaserOrbSweep = 7201306;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
		{
			new PoolBranchesInfo
			{
				index = 1,
				braches = new List<PoolBranchInfo>
				{
					new PoolBranchInfo(_actor, 1001, 1, 0, 0, active: true, operateIEnumerator: DoCast_LaserSweep, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => true)
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator DoCast_LaserSweep()
	{
		CastSkill(7201306);
		yield return WaitSkillFinish();
		_actor.DestroySelf(forceDestory: true);
	}
}

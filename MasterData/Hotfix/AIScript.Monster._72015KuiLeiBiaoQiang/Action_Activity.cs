using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Action_Activity : MonsterActionBase
{
	private static readonly FP SaoJiRange = 4.5f;

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
					new PoolBranchInfo(_actor, 1001, 2, 8, 3, active: true, 2.5, operateIEnumerator: DoXiShuaSaoJi, releaseAngle: default, traceDuration: default, operationConditionFunc: () => GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= SaoJiRange),
					new PoolBranchInfo(_actor, 1002, 3, 20, 12, active: true, 8, operateIEnumerator: DoFengKuangTouZhi, releaseAngle: default, traceDuration: default, operationConditionFunc: () => GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > SaoJiRange),
					new PoolBranchInfo(_actor, 1003, 1, 2, 0, active: true, 2, operateIEnumerator: DoPuGongDanDuan, releaseAngle: default, traceDuration: default, operationConditionFunc: () => true)
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator DoPuGongDanDuan()
	{
		CastSkill(7201501);
		yield return WaitSkillFinish();
		yield return WaitTime(0.5);
	}

	private IEnumerator DoFengKuangTouZhi()
	{
		CastSkill(7201502);
		yield return WaitSkillFinish();
		yield return WaitTime(1);
	}

	private IEnumerator DoXiShuaSaoJi()
	{
		CastSkill(7201503);
		yield return WaitSkillFinish();
		yield return WaitTime(0.5);
	}
}

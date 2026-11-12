using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Action_Summon_ActionStop_Phase_2 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 7000131;

	private CoroutineNode corKill;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		StopCoroutine(ref corKill);
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
		FP cd = 2;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator Attack01()
	{
		CastSkill(Skill_Attack01);
		yield return WaitSkillFinish();
	}
}

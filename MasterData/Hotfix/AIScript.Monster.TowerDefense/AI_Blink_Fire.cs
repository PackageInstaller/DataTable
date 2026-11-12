using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_Blink_Fire : TowerMonsterBaseAI
{
	private bool hasDeployGrid;

	private FP searchRange = 999;

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
		FP initCd = 0;
		OperateDelegate operateIEnumerator = FlameWaveSkillCast;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 10;
		FP initCd2 = 5;
		operateIEnumerator = FireGridSkillCast;
		list2.Add(new PoolBranchInfo(actor2, 1002, 50, cd2, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		hasDeployGrid = false;
	}

	private IEnumerator FlameWaveSkillCast()
	{
		PauseMove();
		CastSkill(8080401);
		yield return WaitSkillFinish();
		ResumeMove();
	}

	private IEnumerator FireGridSkillCast()
	{
		PauseMove();
		CastSkill(8080402);
		yield return WaitSkillFinish();
		ResumeMove();
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}
}

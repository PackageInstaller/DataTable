using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_ShuZhuangShu_GrowGrass : TowerMonsterBaseAI
{
	private int SkillStage;

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
		FP cd = 20;
		FP initCd = 5;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Attack;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SkillStage = 0;
	}

	protected override void SetListenEvents()
	{
	}

	private bool Condition01()
	{
		Dispatch_GetNextGridInfo((MonsterRecGridInfo gridInfo) =>
		{
			if (gridInfo.ccDeployType != GridDeployType.TrapSpawnPoint && gridInfo.ccWalkableType == GridWalkableType.Walkable)
			{
				SkillStage = 1;
			}
		});
		if (SkillStage == 1)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Attack()
	{
		PauseMove();
		yield return WaitTime(0.1);
		PauseMove();
		CastSkill(8080301);
		SkillStage = 0;
		yield return WaitSkillFinish();
		ResumeMove();
		SetPoolBranchCD(1001, 20);
	}
}

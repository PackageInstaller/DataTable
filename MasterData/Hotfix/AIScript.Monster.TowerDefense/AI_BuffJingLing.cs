using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_BuffJingLing : TowerMonsterBaseAI
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
		FP cd = 8;
		FP initCd = 0;
		Func<bool> operationConditionFunc = SpeedUpSkillCondition;
		OperateDelegate operateIEnumerator = SpeedUpSkillCast;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private bool SpeedUpSkillCondition()
	{
		TSVector2 position = GetPosition();
		FP radius = 7.5;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
		List<LogicEntity> targetsByFactionByTD = CommonUtils.GetTargetsByFactionByTD(_actor, isFriend: true);
		List<LogicEntity> targetsFromShape = GetTargetsFromShape(shapeData, targetsByFactionByTD);
		if (targetsFromShape.Count > 0)
		{
			int num = 0;
			foreach (LogicEntity item in targetsFromShape)
			{
				if ((item as AdventureActor).dataID != _actor.dataID)
				{
					num++;
				}
			}
			return num > 0;
		}
		return false;
	}

	private IEnumerator SpeedUpSkillCast()
	{
		PauseMove();
		CastSkill(8080101);
		yield return WaitSkillFinish();
		ResumeMove();
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}
}

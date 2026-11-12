using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_FengLing_Fire : TowerMonsterBaseAI
{
	private bool hasDeployGrid;

	private FP searchRange = 10;

	private int fireHeatDelta = 20;

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
		FP cd = 15;
		FP initCd = 5;
		Func<bool> operationConditionFunc = FireBallCondition;
		OperateDelegate operateIEnumerator = FireBallSkillCast;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		hasDeployGrid = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent) || adventureBulletFinishEvent.owner != _actor || string.IsNullOrEmpty(adventureBulletFinishEvent.tag) || !adventureBulletFinishEvent.tag.Equals("FengLingFire_Heat:"))
		{
			return;
		}
		Dispatch_GetGridInfoByPosition(adventureBulletFinishEvent.bulletPosition, (GridInfoData gridInfo) =>
		{
			if (gridInfo != null)
			{
				Dispatch_CreateFire(gridInfo.gridIndex);
				if (CommonUtils.GetTargetsByFactionByTD(_actor, isFriend: false).FindAll((LogicEntity x) => x is TowerDefenseCharacterActor).FindLast((LogicEntity x) => (x as TowerDefenseCharacterActor).dataID == gridInfo.playerID) is TowerDefenseCharacterActor { IsActive: not false } towerDefenseCharacterActor)
				{
					towerDefenseCharacterActor.UpdateFire(fireHeatDelta);
				}
			}
		});
	}

	private bool FireBallCondition()
	{
		hasDeployGrid = false;
		Dispatch_GetGridsInfoInCircle(_actor.tsTransform.Position, searchRange, preferNonFlame: true, (List<GridInfoData> grids) =>
		{
			if (grids != null && grids.Count > 0)
			{
				hasDeployGrid = true;
			}
		});
		return hasDeployGrid;
	}

	private IEnumerator FireBallSkillCast()
	{
		PauseMove();
		CastSkill(8070402);
		yield return WaitSkillFinish();
		ResumeMove();
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}
}

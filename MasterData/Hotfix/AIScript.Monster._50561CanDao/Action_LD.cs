using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50561CanDao;

public class Action_LD : MonsterActionBase
{
	private readonly int shootSkill = 5056102;

	private readonly int reloadSkill = 5056101;

	private readonly int catchSkill = 5056103;

	private readonly int wanderSkill = 5056104;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_actor.logicVariable.ToggleLogicTag("isCatchBullet", value: false);
		_actor.logicVariable.ToggleLogicTag("haveBullet", value: true);
		_actor.logicVariable.ToggleLogicTag("needReload", value: false);
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		_thinkInterval = 0.05;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 0.5;
		FP initCd = 2;
		OperateDelegate operateIEnumerator = shootCondition;
		list2.Add(new PoolBranchInfo(actor, 1000, 3, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		operateIEnumerator = reloadCondition;
		list2.Add(new PoolBranchInfo(actor2, 1001, 4, cd2, initCd2, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0.1;
		FP initCd3 = 2;
		operateIEnumerator = catchCondition;
		list2.Add(new PoolBranchInfo(actor3, 1002, 2, cd3, initCd3, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 3;
		FP initCd4 = 0;
		operateIEnumerator = wanderCondition;
		list2.Add(new PoolBranchInfo(actor4, 1003, 1, cd4, initCd4, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator shootCondition()
	{
		if (GetLogicTagToggleValue(_actor, "haveBullet"))
		{
			CastSkill(shootSkill);
			yield return WaitSkillFinish();
			_actor.logicVariable.ToggleLogicTag("haveBullet", value: false);
		}
		else
		{
			SetPoolBranchActive(1001, active: true);
		}
	}

	private IEnumerator reloadCondition()
	{
		_actor.logicVariable.ToggleLogicTag("haveBullet", value: true);
		_actor.logicVariable.ToggleLogicTag("needReload", value: false);
		CastSkill(reloadSkill);
		SetPoolBranchActive(1001, active: false);
		yield return WaitSkillFinish();
		SetPoolBranchCD(1000, 0);
	}

	private IEnumerator catchCondition()
	{
		if (GetLogicTagToggleValue(_actor, "isCatchBullet"))
		{
			CastSkill(catchSkill);
			_actor.logicVariable.ToggleLogicTag("haveBullet", value: true);
		}
		_actor.logicVariable.ToggleLogicTag("isCatchBullet", value: false);
		yield break;
	}

	private IEnumerator wanderCondition()
	{
		CastSkill(wanderSkill);
		yield break;
	}
}

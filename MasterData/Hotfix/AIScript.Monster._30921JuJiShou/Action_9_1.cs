using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30921JuJiShou;

public class Action_9_1 : MonsterActionBase
{
	private readonly int SkillId_Snipe = 3092103;

	private readonly int SkillId_Wait = 9999999;

	private readonly int testSkillId;

	private FP FarDistance;

	private FP CloseDistance;

	private bool CanSnipe;

	private bool IsSneak;

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
		Func<bool> operationConditionFunc = ShootCondition;
		OperateDelegate operateIEnumerator = Skill_Snipe;
		list2.Add(new PoolBranchInfo(actor, 1, 80, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		operateIEnumerator = Wait;
		list2.Add(new PoolBranchInfo(actor2, 2, 70, cd2, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		StartCor(CheckSneakDistance());
		StartCor(CheckSneakBuff());
		FarDistance = CommonUtils.ParseStringParamToFP(GetMonsterTagValue(_actor, 2));
		CloseDistance = CommonUtils.ParseStringParamToFP(GetMonsterTagValue(_actor, 3));
		CanSnipe = true;
		IsSneak = false;
		new PlayFX().Play(_actor, null, "fx_m30921_loop_FlashBomb_Hide", default, _actor.tsTransform.Position, default);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private bool ShootCondition()
	{
		if (CanSnipe)
		{
			return !IsSneak;
		}
		return false;
	}

	private IEnumerator Skill_Snipe()
	{
		GotoCastSkill(SkillId_Snipe);
		yield return WaitSkillFinish();
	}

	private IEnumerator Wait()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(SkillId_Wait);
		yield return WaitSkillFinish();
	}

	private IEnumerator CheckSneakDistance()
	{
		while (true)
		{
			FP distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
			if (distanceWithTarget > FarDistance || distanceWithTarget < CloseDistance)
			{
				CanSnipe = false;
				SetHideModelEnable();
			}
			else if (distanceWithTarget <= FarDistance && distanceWithTarget >= CloseDistance + 3)
			{
				CanSnipe = true;
				InterruptHideModel();
			}
			yield return null;
		}
	}

	private IEnumerator CheckSneakBuff()
	{
		LogicEntity player = GetCurrentPlayer();
		while (true)
		{
			if (GetBuffNum(player, 911090120) != 0 && !IsSneak)
			{
				InterruptSkill();
				IsSneak = true;
			}
			else if (GetBuffNum(player, 911090120) == 0 && IsSneak)
			{
				IsSneak = false;
			}
			yield return null;
		}
	}
}

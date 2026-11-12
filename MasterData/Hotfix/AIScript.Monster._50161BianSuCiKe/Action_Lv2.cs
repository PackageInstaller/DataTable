using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Action_Lv2 : MonsterActionBase
{
	private static readonly int Skill_Dash = 5016101;

	private static readonly int Skill_Shoot = 5016102;

	private static readonly int Skill_TopDown = 5016103;

	private static readonly int Skill_Hide = 5016104;

	private static readonly int Skill_Summon = 5016105;

	private static readonly int Skill_Test = 0;

	private bool DashSkillMessageRecieved;

	private bool ShootSkillMessageRecieved;

	private bool TopDownSkillMessageRecieved;

	private bool SummonSkillMessageRecieved;

	private bool IsFirstSkill;

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
		FP cd = 1;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = FirstHideCast;
		System.Action operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor, 1099, 1, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor2 = _actor;
		FP cd2 = 0.1;
		FP initCd2 = 0;
		Func<bool> operationConditionFunc = DashSkillMessage;
		operateIEnumerator = DashSkillCast;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor2, 1001, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor3 = _actor;
		FP cd3 = 0.1;
		FP initCd3 = 0;
		operationConditionFunc = ShootSkillMessage;
		operateIEnumerator = ShootSkillCast;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor3, 1002, 1, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor4 = _actor;
		FP cd4 = 0.1;
		FP initCd4 = 0;
		operationConditionFunc = TopDownSkillMessage;
		operateIEnumerator = TopDownSkillCast;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor4, 1003, 1, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, operateCompleteCallback));
		AdventureActor actor5 = _actor;
		FP cd5 = 0.1;
		FP initCd5 = 0;
		operateIEnumerator = HideSkillCast;
		operateCompleteCallback = SkillComplete;
		list2.Add(new PoolBranchInfo(actor5, 1090, 99, cd5, initCd5, active: false, default, default, default, null, null, operateIEnumerator, operateCompleteCallback));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		DashSkillMessageRecieved = false;
		ShootSkillMessageRecieved = false;
		TopDownSkillMessageRecieved = false;
		SummonSkillMessageRecieved = false;
		IsFirstSkill = true;
		SetLogicTagToggleValue(_actor, "IsSummonSkill", value: false);
	}

	protected override void OnActionDisable()
	{
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.GroupController, active: true, GroupMessageOperate);
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, OpenHideSkill);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		switch ((evt as AdventureGroupControllerToMonsterMessage).operationType)
		{
		case "WakeUp":
			SetLogicTagToggleValue(_actor, "WakeUp", value: true);
			break;
		case "Skill_Dash":
			DashSkillMessageRecieved = true;
			break;
		case "Skill_Shoot":
			ShootSkillMessageRecieved = true;
			break;
		case "Skill_TopDown":
			TopDownSkillMessageRecieved = true;
			break;
		case "Skill_Summon":
			SummonSkillMessageRecieved = true;
			_actor.InterruptForceControl();
			_actor.InterruptChaos();
			InterruptSkill();
			SetImmuneControlEnable();
			break;
		case "Volley":
			SetLogicTagToggleValue(_actor, "isVolley", value: true);
			break;
		}
	}

	private bool DashSkillMessage()
	{
		return DashSkillMessageRecieved;
	}

	private bool ShootSkillMessage()
	{
		return ShootSkillMessageRecieved;
	}

	private bool TopDownSkillMessage()
	{
		return TopDownSkillMessageRecieved;
	}

	private IEnumerator FirstHideCast()
	{
		GotoCastSkill(Skill_Hide);
		SetPoolBranchActive(1099, active: false);
		yield return WaitSkillFinish();
	}

	private IEnumerator DashSkillCast()
	{
		GotoCastSkill(Skill_Dash);
		DashSkillMessageRecieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator ShootSkillCast()
	{
		GotoCastSkill(Skill_Shoot);
		ShootSkillMessageRecieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator TopDownSkillCast()
	{
		GotoCastSkill(Skill_TopDown);
		TopDownSkillMessageRecieved = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator HideSkillCast()
	{
		GotoCastSkill(Skill_Hide);
		yield return WaitSkillFinish();
		SetPoolBranchActive(1090, active: false);
	}

	private void OpenHideSkill(IEvent evt)
	{
		SendMessageToGroupController(_actor.Id, "Busy");
		SetPoolBranchActive(1090, active: true);
		SetPoolBranchCD(1090, 0.75);
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
		SendMessageToGroupController(_actor.Id, "Busy");
	}

	private void SkillComplete()
	{
		SendMessageToGroupController(_actor.Id, "Free");
		if (IsFirstSkill)
		{
			SendMessageToGroupController(_actor.Id, "ImWakeUp");
			IsFirstSkill = false;
		}
	}
}

using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Action : MonsterActionBase
{
	private readonly FP HP_Percent = 0.5;

	private bool check_Born;

	private bool check_MeleeCombo;

	private bool check_SilkPierce;

	private bool check_PuppetControl;

	private bool check_ZhuNengGuangXian;

	private bool check_NengLiangQiu;

	private bool check_RangedCombo;

	private bool check_StageChange;

	private bool _isPhase2;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetSummonLevel();
		BossEnergyValueChage(0, _actor);
		_actor.LockHpPercent(49);
		int level = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.damageReductionBuffIds);
		int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.vulnerableBuffIds);
		Common_73001.SyncBossBuffChange(_actor, monsterIdByLevel, monsterIdByLevel2);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ResetAllChecks();
		_actor.UnlockHp();
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.GroupController, active: true, GroupMessageOperate);
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
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
		FP cd = 1000;
		FP initCd = 0;
		FP releaseDistance = 100;
		Func<bool> operationConditionFunc = Check_Born;
		OperateDelegate operateIEnumerator = DoCast_Born;
		list2.Add(new PoolBranchInfo(actor, 1000, 1, cd, initCd, active: true, releaseDistance, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 10;
		FP initCd2 = 0;
		FP releaseDistance2 = 100;
		FP releaseAngle = 30;
		operationConditionFunc = Check_MeleeCombo;
		operateIEnumerator = DoCast_MeleeCombo;
		list2.Add(new PoolBranchInfo(actor2, 1001, 2, cd2, initCd2, active: true, releaseDistance2, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 10;
		FP initCd3 = 0;
		FP releaseDistance3 = 100;
		FP releaseAngle2 = 30;
		operationConditionFunc = Check_SilkPierce;
		operateIEnumerator = DoCast_SilkPierce;
		list2.Add(new PoolBranchInfo(actor3, 1002, 2, cd3, initCd3, active: true, releaseDistance3, releaseAngle2, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 10;
		FP initCd4 = 0;
		FP releaseDistance4 = 100;
		FP releaseAngle3 = 30;
		operationConditionFunc = Check_PuppetControl;
		operateIEnumerator = DoCast_PuppetControl;
		list2.Add(new PoolBranchInfo(actor4, 1003, 2, cd4, initCd4, active: true, releaseDistance4, releaseAngle3, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 10;
		FP initCd5 = 0;
		FP releaseDistance5 = 100;
		FP releaseAngle4 = 30;
		operationConditionFunc = Check_ZhuNengGuangXian;
		operateIEnumerator = DoCast_ZhuNengGuangXian;
		list2.Add(new PoolBranchInfo(actor5, 1004, 2, cd5, initCd5, active: true, releaseDistance5, releaseAngle4, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 10;
		FP initCd6 = 0;
		FP releaseDistance6 = 100;
		FP releaseAngle5 = 30;
		operationConditionFunc = Check_NengLiangQiu;
		operateIEnumerator = DoCast_NengLiangQiu;
		list2.Add(new PoolBranchInfo(actor6, 1005, 2, cd6, initCd6, active: true, releaseDistance6, releaseAngle5, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 10;
		FP initCd7 = 0;
		FP releaseDistance7 = 100;
		FP releaseAngle6 = 30;
		operationConditionFunc = Check_RangedCombo;
		operateIEnumerator = DoCast_RangedCombo;
		list2.Add(new PoolBranchInfo(actor7, 1006, 2, cd7, initCd7, active: true, releaseDistance7, releaseAngle6, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 0;
		FP initCd8 = 0;
		FP releaseDistance8 = 100;
		operationConditionFunc = Check_StageChange;
		operateIEnumerator = DoCast_StageChange;
		list2.Add(new PoolBranchInfo(actor8, 1007, 1, cd8, initCd8, active: true, releaseDistance8, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected void SetSummonLevel()
	{
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		Common_73001.SetSummonLevelByTag(_actor, monsterTagValue);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		switch ((evt as AdventureGroupControllerToMonsterMessage).operationType)
		{
		case "Skill_Born":
			check_Born = true;
			break;
		case "Skill_MeleeCombo":
			check_MeleeCombo = true;
			break;
		case "Skill_SilkPierce":
			check_SilkPierce = true;
			break;
		case "Skill_PuppetControl":
			check_PuppetControl = true;
			break;
		case "Skill_ZhuNengGuangXian":
			check_ZhuNengGuangXian = true;
			break;
		case "Skill_NengLiangQiu":
			check_NengLiangQiu = true;
			break;
		case "Skill_RangedCombo":
			check_RangedCombo = true;
			break;
		}
	}

	private void ResetAllChecks()
	{
		check_Born = false;
		check_MeleeCombo = false;
		check_SilkPierce = false;
		check_PuppetControl = false;
		check_ZhuNengGuangXian = false;
		check_NengLiangQiu = false;
		check_RangedCombo = false;
		check_StageChange = false;
		_isPhase2 = false;
	}

	private bool Check_Born()
	{
		return check_Born;
	}

	private bool Check_MeleeCombo()
	{
		return check_MeleeCombo;
	}

	private bool Check_SilkPierce()
	{
		return check_SilkPierce;
	}

	private bool Check_PuppetControl()
	{
		return check_PuppetControl;
	}

	private bool Check_ZhuNengGuangXian()
	{
		return check_ZhuNengGuangXian;
	}

	private bool Check_NengLiangQiu()
	{
		return check_NengLiangQiu;
	}

	private bool Check_RangedCombo()
	{
		return check_RangedCombo;
	}

	private bool Check_StageChange()
	{
		return check_StageChange;
	}

	private IEnumerator DoCast_Born()
	{
		check_Born = false;
		CastSkill(9999989);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoCast_MeleeCombo()
	{
		check_MeleeCombo = false;
		CastSkill(7201103);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_XiaoMoXiang.Skill_MeleeCombo_Finish, value: true);
	}

	private IEnumerator DoCast_SilkPierce()
	{
		check_SilkPierce = false;
		CastSkill(7201101);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Common_73001.Skill_SilkPierce_Finish, value: true);
	}

	private IEnumerator DoCast_PuppetControl()
	{
		check_PuppetControl = false;
		CastSkill(7201102);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Common_73001.Skill_PuppetControl_Finish, value: true);
	}

	private IEnumerator DoCast_ZhuNengGuangXian()
	{
		check_ZhuNengGuangXian = false;
		CastSkill(7201105);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_XiaoMoXiang.Skill_ZhuNengGuangXian_Finish, value: true);
	}

	private IEnumerator DoCast_NengLiangQiu()
	{
		check_NengLiangQiu = false;
		CastSkill(7201106);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_XiaoMoXiang.Skill_NengLiangQiu_Finish, value: true);
	}

	private IEnumerator DoCast_RangedCombo()
	{
		check_RangedCombo = false;
		CastSkill(7201104);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_XiaoMoXiang.Skill_RangedCombo_Finish, value: true);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HP_Percent)
		{
			_ = _isPhase2;
		}
	}

	private IEnumerator DoCast_StageChange()
	{
		check_StageChange = false;
		CastSkill(9999990);
		yield return WaitSkillFinish();
	}
}

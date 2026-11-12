using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Action_BossRush_1 : MonsterActionBase
{
	private static readonly int Skill_Idle = 3130104;

	private static readonly int Skill_Show = 3130103;

	private static readonly int Skill_Sweep = 3130105;

	private static readonly int Skill_Smash = 3130106;

	private static readonly int Skill_SprayWater = 3130109;

	private static readonly int Skill_IceStab = 3130147;

	private static readonly int Skill_BurrowingAttack = 3130108;

	private static readonly int Skill_SummonTraceTornado = 3130144;

	private static readonly int Skill_SummonDashTornado = 3130145;

	private static readonly int Skill_SummonSplitTornado = 3130146;

	private static readonly int Skill_SummonIceMaker = 3130112;

	private static readonly int Skill_ActiveBattery = 3130111;

	private static readonly int Skill_Ultra = 3130152;

	private static readonly int Skill_BurrowSprayWater = 3130150;

	private int phase;

	private int lv;

	private bool check_Idle;

	private bool check_BurrowSprayWater;

	private bool check_Show;

	private bool check_Sweep;

	private bool check_Smash;

	private bool check_SprayWater;

	private bool check_IceStab;

	private bool check_BurrowAttack;

	private bool check_TraceTornado;

	private bool check_DashTornado;

	private bool check_SplitTornado;

	private bool check_IceMaker;

	private bool check_ActiveBattery;

	private bool check_Ultra;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		ResetAllChecks();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ResetAllChecks();
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.GroupController, active: true, GroupMessageOperate);
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
		FP cd = 0.1;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Check_Idle;
		OperateDelegate operateIEnumerator = DoCast_Idle;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0.1;
		FP initCd2 = 0;
		operationConditionFunc = Check_Sweep;
		operateIEnumerator = DoCast_Sweep;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0.1;
		FP initCd3 = 0;
		operationConditionFunc = Check_Smash;
		operateIEnumerator = DoCast_Smash;
		list2.Add(new PoolBranchInfo(actor3, 1003, 1, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 0.1;
		FP initCd4 = 0;
		operationConditionFunc = Check_SprayWater;
		operateIEnumerator = DoCast_SprayWater;
		list2.Add(new PoolBranchInfo(actor4, 1004, 1, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0.1;
		FP initCd5 = 0;
		operationConditionFunc = Check_IceStab;
		operateIEnumerator = DoCast_IceStab;
		list2.Add(new PoolBranchInfo(actor5, 1005, 1, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 0.1;
		FP initCd6 = 0;
		operationConditionFunc = Check_BurrowAttack;
		operateIEnumerator = DoCast_BurrowAttack;
		list2.Add(new PoolBranchInfo(actor6, 1006, 1, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 0.1;
		FP initCd7 = 0;
		operationConditionFunc = Check_TraceTornado;
		operateIEnumerator = DoCast_TraceTornado;
		list2.Add(new PoolBranchInfo(actor7, 1007, 1, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 0.1;
		FP initCd8 = 0;
		operationConditionFunc = Check_DashTornado;
		operateIEnumerator = DoCast_DashTornado;
		list2.Add(new PoolBranchInfo(actor8, 1008, 1, cd8, initCd8, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		FP cd9 = 0.1;
		FP initCd9 = 0;
		operationConditionFunc = Check_SplitTornado;
		operateIEnumerator = DoCast_SplitTornado;
		list2.Add(new PoolBranchInfo(actor9, 1009, 1, cd9, initCd9, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		FP cd10 = 0.1;
		FP initCd10 = 0;
		operationConditionFunc = Check_IceMaker;
		operateIEnumerator = DoCast_IceMaker;
		list2.Add(new PoolBranchInfo(actor10, 1010, 1, cd10, initCd10, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor11 = _actor;
		FP cd11 = 0.1;
		FP initCd11 = 0;
		operationConditionFunc = Check_ActiveBattery;
		operateIEnumerator = DoCast_ActiveBattery;
		list2.Add(new PoolBranchInfo(actor11, 1011, 1, cd11, initCd11, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor12 = _actor;
		FP cd12 = 0.1;
		FP initCd12 = 0;
		operationConditionFunc = Check_Ultra;
		operateIEnumerator = DoCast_Ultra;
		list2.Add(new PoolBranchInfo(actor12, 1012, 1, cd12, initCd12, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor13 = _actor;
		FP cd13 = 0.1;
		FP initCd13 = 0;
		operationConditionFunc = Check_Show;
		operateIEnumerator = DoCast_Show;
		list2.Add(new PoolBranchInfo(actor13, 1013, 1, cd13, initCd13, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor14 = _actor;
		FP cd14 = 0.1;
		FP initCd14 = 0;
		operationConditionFunc = Check_BurrowSprayWater;
		operateIEnumerator = DoCast_BurrowSprayWater;
		list2.Add(new PoolBranchInfo(actor14, 1014, 1, cd14, initCd14, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		switch ((evt as AdventureGroupControllerToMonsterMessage).operationType)
		{
		case "WakeUp":
			phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
			lv = GetLogicTagFpValue(_actor, "Level").AsInt();
			break;
		case "Skill_Idle":
			check_Idle = true;
			break;
		case "Skill_Sweep":
			check_Sweep = true;
			break;
		case "Skill_Smash":
			check_Smash = true;
			break;
		case "Skill_SprayWater":
			check_SprayWater = true;
			break;
		case "Skill_IceStab":
			check_IceStab = true;
			break;
		case "Skill_BurrowAttack":
			check_BurrowAttack = true;
			break;
		case "Skill_TraceTornado":
			check_TraceTornado = true;
			break;
		case "Skill_DashTornado":
			check_DashTornado = true;
			break;
		case "Skill_SplitTornado":
			check_SplitTornado = true;
			break;
		case "Skill_IceMaker":
			check_IceMaker = true;
			break;
		case "Skill_ActiveBattery":
			check_ActiveBattery = true;
			break;
		case "Skill_Ultra":
			check_Ultra = true;
			break;
		case "Skill_Show":
			check_Show = true;
			break;
		case "Skill_BurrowingSprayWater":
			check_BurrowSprayWater = true;
			break;
		case "InterruptAllSkill":
			InterruptSkill();
			break;
		}
	}

	private void ResetAllChecks()
	{
		check_BurrowSprayWater = false;
		check_Idle = false;
		check_Show = false;
		check_Sweep = false;
		check_Smash = false;
		check_SprayWater = false;
		check_IceStab = false;
		check_BurrowAttack = false;
		check_TraceTornado = false;
		check_DashTornado = false;
		check_SplitTornado = false;
		check_IceMaker = false;
		check_ActiveBattery = false;
		check_Ultra = false;
	}

	private bool Check_Idle()
	{
		return check_Idle;
	}

	private bool Check_BurrowSprayWater()
	{
		return check_BurrowSprayWater;
	}

	private bool Check_Sweep()
	{
		return check_Sweep;
	}

	private bool Check_Smash()
	{
		return check_Smash;
	}

	private bool Check_SprayWater()
	{
		return check_SprayWater;
	}

	private bool Check_IceStab()
	{
		return check_IceStab;
	}

	private bool Check_BurrowAttack()
	{
		return check_BurrowAttack;
	}

	private bool Check_TraceTornado()
	{
		return check_TraceTornado;
	}

	private bool Check_DashTornado()
	{
		return check_DashTornado;
	}

	private bool Check_SplitTornado()
	{
		return check_SplitTornado;
	}

	private bool Check_IceMaker()
	{
		return check_IceMaker;
	}

	private bool Check_ActiveBattery()
	{
		return check_ActiveBattery;
	}

	private bool Check_Ultra()
	{
		return check_Ultra;
	}

	private bool Check_Show()
	{
		return check_Show;
	}

	private IEnumerator DoCast_Idle()
	{
		check_Idle = false;
		GotoCastSkill(Skill_Idle);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_Idle_Finish, value: true);
	}

	private IEnumerator DoCast_Sweep()
	{
		check_Sweep = false;
		GotoCastSkill(Skill_Sweep);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_Sweep_Finish, value: true);
	}

	private IEnumerator DoCast_Smash()
	{
		check_Smash = false;
		GotoCastSkill(Skill_Smash);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_Smash_Finish, value: true);
	}

	private IEnumerator DoCast_SprayWater()
	{
		check_SprayWater = false;
		GotoCastSkill(Skill_SprayWater);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_SprayWater_Finish, value: true);
	}

	private IEnumerator DoCast_IceStab()
	{
		check_IceStab = false;
		GotoCastSkill(Skill_IceStab);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_IceStab_Finish, value: true);
	}

	private IEnumerator DoCast_BurrowAttack()
	{
		check_BurrowAttack = false;
		GotoCastSkill(Skill_BurrowingAttack);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_BurrowAttack_Finish, value: true);
	}

	private IEnumerator DoCast_TraceTornado()
	{
		check_TraceTornado = false;
		GotoCastSkill(Skill_SummonTraceTornado);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_TraceTornado_Finish, value: true);
	}

	private IEnumerator DoCast_DashTornado()
	{
		check_DashTornado = false;
		GotoCastSkill(Skill_SummonDashTornado);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_DashTornado_Finish, value: true);
	}

	private IEnumerator DoCast_SplitTornado()
	{
		check_SplitTornado = false;
		GotoCastSkill(Skill_SummonSplitTornado);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_SplitTornado_Finish, value: true);
	}

	private IEnumerator DoCast_IceMaker()
	{
		check_IceMaker = false;
		GotoCastSkill(Skill_SummonIceMaker);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_IceMaker_Finish, value: true);
	}

	private IEnumerator DoCast_ActiveBattery()
	{
		check_ActiveBattery = false;
		GotoCastSkill(Skill_ActiveBattery);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_ActiveBattery_Finish, value: true);
	}

	private IEnumerator DoCast_Ultra()
	{
		check_Ultra = false;
		GotoCastSkill(Skill_Ultra);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_Ultra_Finish, value: true);
	}

	private IEnumerator DoCast_Show()
	{
		check_Show = false;
		GotoCastSkill(Skill_Show);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_Show_Finish, value: true);
	}

	private IEnumerator DoCast_BurrowSprayWater()
	{
		check_BurrowSprayWater = false;
		GotoCastSkill(Skill_BurrowSprayWater);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config.Skill_BurrowSprayWater_Finish, value: true);
	}

	private void GotoCastSkill(int id)
	{
		CastSkill(id);
	}
}

using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Action_OctopusBattery : MonsterActionBase
{
	private const int Skill_Awake = 3130133;

	private const int Skill_Sleep = 3130134;

	private const int Skill_Attack = 3130132;

	private const int Buff_AntiSleep = 313020010;

	private FP activeLoopTime = 35;

	private bool _isActivated;

	private FP sleepImmuneTime = 0.5;

	private CoroutineNode corTime;

	private CoroutineNode corImmune;

	private bool _sleepImmune;

	private bool check_Awake;

	private bool check_Sleep;

	private bool check_Attack;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_actor.GetLogicComponent<MonsterSummonInfo>();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessBroken);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessBroken);
		check_Awake = false;
		check_Sleep = false;
		check_Attack = false;
		_isActivated = false;
		_sleepImmune = false;
		StopCor(ref corTime);
		StopCor(ref corImmune);
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
		Func<bool> operationConditionFunc = Check_Awake;
		OperateDelegate operateIEnumerator = DoCast_Awake;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 2;
		FP initCd2 = 0;
		operationConditionFunc = Check_Sleep;
		operateIEnumerator = DoCast_Sleep;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 7;
		FP initCd3 = 0;
		operationConditionFunc = Check_Attack;
		operateIEnumerator = DoCast_Attack;
		list2.Add(new PoolBranchInfo(actor3, 1003, 1, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			if (adventureActorCustomEvent.eventHashCode == Config.evt_ActiveBattery)
			{
				EnterActive();
			}
			else if (adventureActorCustomEvent.eventHashCode == Config.evt_DeactivateBattery)
			{
				EnterSleep();
			}
			else if (adventureActorCustomEvent.eventHashCode == Config.evt_SetShase)
			{
				SetLogicTagFpValue(_actor, "Phase", adventureActorCustomEvent.intParam);
			}
		}
	}

	private void OnToughnessBroken(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent { actor: MonsterAdventureActor actor })
		{
			string logicTagStringValue = GetLogicTagStringValue(actor, "MonsterTag");
			if (!string.IsNullOrEmpty(logicTagStringValue) && logicTagStringValue.Equals(Config.bossTag))
			{
				EnterSleep();
			}
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && !(adventureActorGetBuff.sender as LogicEntity != _actor) && adventureActorGetBuff.eventInfo.buffId == 313010010)
		{
			if (_sleepImmune)
			{
				RemoveBuffFromTarget(_actor, 313010010);
			}
			else if (GetBuffNum(_actor, 313020010) >= 1)
			{
				RemoveBuffFromTarget(_actor, 313020010);
				RemoveBuffFromTarget(_actor, 313010010);
				StartCor(ref corImmune, DoSleepImmune());
			}
			else
			{
				EnterSleep();
			}
		}
	}

	private IEnumerator DoSleepImmune()
	{
		_sleepImmune = true;
		yield return WaitTime(sleepImmuneTime);
		_sleepImmune = false;
	}

	private IEnumerator DoCheckSleep()
	{
		yield return WaitTime(activeLoopTime);
		EnterSleep();
	}

	private void EnterActive()
	{
		if (!_isActivated && !check_Awake)
		{
			check_Awake = true;
			check_Sleep = false;
			check_Attack = false;
			ShowBlood(isShow: true);
			SetSearchedImmunityDisable();
			SetCloseBlockDisable();
		}
	}

	private void EnterSleep()
	{
		if ((_isActivated || check_Awake) && !check_Sleep)
		{
			_isActivated = false;
			check_Awake = false;
			check_Sleep = true;
			check_Attack = false;
			StopCor(ref corTime);
			ShowBlood(isShow: false);
			SetSearchedImmunityEnable();
			SetCloseBlockEnable();
			InterruptSkill();
		}
	}

	private bool Check_Awake()
	{
		return check_Awake;
	}

	private IEnumerator DoCast_Awake()
	{
		CastSkill(3130133);
		yield return WaitSkillFinish();
		if (check_Awake)
		{
			check_Awake = false;
			check_Attack = true;
			_isActivated = true;
			StartCor(ref corTime, DoCheckSleep());
		}
	}

	private bool Check_Sleep()
	{
		return check_Sleep;
	}

	private IEnumerator DoCast_Sleep()
	{
		RemoveBuffFromTarget(_actor, 313020010);
		CastSkill(3130134);
		yield return WaitSkillFinish();
		check_Sleep = false;
	}

	private bool Check_Attack()
	{
		return check_Attack;
	}

	private IEnumerator DoCast_Attack()
	{
		CastSkill(3130132);
		yield return WaitSkillFinish();
	}
}

using System;
using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._31301JiJuXie;

public class Action_OctopusBattery_BossRush : MonsterActionBase
{
	private const int Skill_Awake = 3130133;

	private const int Skill_Sleep = 3130134;

	private const int Skill_Attack = 3130138;

	private const int Skill_Attack1 = 3130139;

	private const int Skill_Attack2 = 3130149;

	private const int Skill_Attack3 = 3130151;

	private const int Buff_AntiSleep = 313020010;

	private FP activeLoopTime = 180;

	private bool _isActivated;

	private bool _pendingUltra;

	private bool _pendingAttack3;

	private FP sleepImmuneTime = 0.5;

	private readonly HotfixEnum.scoreBossBehavior entryEnum_SleepScore = HotfixEnum.scoreBossBehavior.TriggerCommon3;

	private CoroutineNode corTime;

	private CoroutineNode corImmune;

	private bool _sleepImmune;

	private MonsterAdventureActor _scoreBoss;

	private int _attack3Version;

	private bool check_Awake;

	private bool check_Sleep;

	private bool check_Attack;

	private bool check_Attack1;

	private bool check_Attack2;

	private bool check_Attack3;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagToggleValue(_actor, "isActive", value: false);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBossBattleLevelChanged);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		SetLogicTagToggleValue(_actor, "isActive", value: false);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBossBattleLevelChanged);
		check_Awake = false;
		_pendingUltra = false;
		check_Sleep = false;
		check_Attack = false;
		check_Attack1 = false;
		check_Attack2 = false;
		_isActivated = false;
		_sleepImmune = false;
		check_Attack3 = false;
		_attack3Version = 0;
		_scoreBoss = null;
		_pendingAttack3 = false;
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
		FP cd3 = 0;
		FP initCd3 = 0;
		operationConditionFunc = Check_Attack;
		operateIEnumerator = DoCast_Attack;
		list2.Add(new PoolBranchInfo(actor3, 1003, 1, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 0;
		FP initCd4 = 0;
		operationConditionFunc = Check_Attack3;
		operateIEnumerator = DoCast_Attack3;
		list2.Add(new PoolBranchInfo(actor4, 1006, 1, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0;
		FP initCd5 = 0;
		operationConditionFunc = Check_Attack1;
		operateIEnumerator = DoCast_Attack1;
		list2.Add(new PoolBranchInfo(actor5, 1004, 1, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 0;
		FP initCd6 = 0;
		operationConditionFunc = Check_Attack2;
		operateIEnumerator = DoCast_Attack2;
		list2.Add(new PoolBranchInfo(actor6, 1005, 1, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
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
			else if (adventureActorCustomEvent.eventHashCode == Config.evt_SprayWaterBattery)
			{
				TriggerSprayWater();
			}
			else if (adventureActorCustomEvent.eventHashCode == Config.evt_SprayWaterBatteryUltra)
			{
				EnterActiveUltra();
			}
			else if (adventureActorCustomEvent.eventHashCode == Config.evt_SetShase)
			{
				SetLogicTagFpValue(_actor, "Phase", adventureActorCustomEvent.intParam);
			}
		}
	}

	private void OnToughnessStateChange(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent { actor: MonsterAdventureActor actor } monsterToughnessStateChangeEvent)
		{
			string logicTagStringValue = GetLogicTagStringValue(actor, "MonsterTag");
			if (!string.IsNullOrEmpty(logicTagStringValue) && logicTagStringValue.Equals(Config.bossTag) && monsterToughnessStateChangeEvent.isToughnessBroken)
			{
				TriggerBulletAttack();
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
				bool willSleep = (_isActivated || check_Awake) && !check_Sleep;
				EnterSleep();
				TryAddSleepScore(willSleep);
			}
		}
	}

	private IEnumerator DoSleepImmune()
	{
		_sleepImmune = true;
		yield return WaitTime(sleepImmuneTime);
		_sleepImmune = false;
	}

	private void TriggerBulletAttack()
	{
		if ((!_isActivated && !check_Awake) || check_Sleep)
		{
			return;
		}
		if (check_Awake)
		{
			_pendingUltra = false;
			_pendingAttack3 = true;
			return;
		}
		if (check_Attack3)
		{
			_attack3Version++;
		}
		check_Attack = false;
		check_Attack1 = false;
		check_Attack2 = false;
		_pendingUltra = false;
		check_Attack3 = true;
		InterruptSkill();
	}

	private void EnterActiveUltra()
	{
		if (_isActivated)
		{
			TriggerSprayWaterUltra();
			return;
		}
		if (check_Awake)
		{
			_pendingUltra = true;
			_pendingAttack3 = false;
			return;
		}
		_pendingUltra = true;
		check_Awake = true;
		check_Sleep = false;
		check_Attack = false;
		check_Attack1 = false;
		check_Attack2 = false;
		check_Attack3 = false;
		_pendingAttack3 = false;
		SetCloseBlockDisable();
	}

	private void TriggerSprayWater()
	{
		if (_isActivated && !check_Sleep && !check_Attack1)
		{
			check_Attack = false;
			check_Attack3 = false;
			check_Attack1 = true;
			check_Attack2 = false;
			InterruptSkill();
		}
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
			check_Attack1 = false;
			check_Attack2 = false;
			check_Attack3 = false;
			_pendingUltra = false;
			_pendingAttack3 = false;
			SetCloseBlockDisable();
		}
	}

	private void EnterSleep()
	{
		if ((_isActivated || check_Awake) && !check_Sleep)
		{
			_isActivated = false;
			SetLogicTagToggleValue(_actor, "isActive", value: false);
			check_Awake = false;
			check_Sleep = true;
			check_Attack = false;
			_pendingUltra = false;
			check_Attack1 = false;
			check_Attack2 = false;
			check_Attack3 = false;
			_pendingAttack3 = false;
			StopCor(ref corTime);
			SetCloseBlockEnable();
			InterruptSkill();
		}
	}

	private void TryAddSleepScore(bool willSleep)
	{
		if (willSleep)
		{
			if (_scoreBoss == null)
			{
				_scoreBoss = FindBoss();
			}
			if (!(_scoreBoss == null) && _scoreBoss.CheckScoreBossBehaviour((int)entryEnum_SleepScore))
			{
				_scoreBoss.TriggerScoreBossBehaviour((int)entryEnum_SleepScore);
			}
		}
	}

	private MonsterAdventureActor FindBoss()
	{
		List<LogicEntity> entities = ModuleController<AdventureModuleController>.Instance.entities;
		for (int num = entities.Count - 1; num >= 0; num--)
		{
			if (entities.get_Item(num) is MonsterAdventureActor monsterAdventureActor)
			{
				string logicTagStringValue = GetLogicTagStringValue(monsterAdventureActor, "MonsterTag");
				if (!string.IsNullOrEmpty(logicTagStringValue) && logicTagStringValue.Equals(Config.bossTag))
				{
					return monsterAdventureActor;
				}
			}
		}
		return null;
	}

	private void OnBossBattleLevelChanged(IEvent evt)
	{
		if (evt is AdventureMonsterBattleLevelChangedEvent { sender: MonsterAdventureActor sender })
		{
			_scoreBoss = sender;
			ChangeTempValueByBossRushLv();
		}
	}

	private void ChangeTempValueByBossRushLv()
	{
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(_actor.attrTempleteID);
		if (monsterValueTempleteAdjust == null)
		{
			Debug.LogError($"找不到怪物模板校正数据，ID：{_actor.attrTempleteID}");
			return;
		}
		MonsterAdventureActor scoreBoss = _scoreBoss;
		if ((object)scoreBoss != null)
		{
			long num = (long)monsterValueTempleteAdjust.TemplateId * 1000L + 10 + scoreBoss.BattleLevel;
			MonsterValueTemplete monsterValueTemplete = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(num);
			if (monsterValueTemplete == null)
			{
				Debug.LogError($"templeteInfo config not exist, attrId:{num}, BattleLevel:{scoreBoss.BattleLevel}");
				return;
			}
			_actor.attributeList.SetOriginLongValue(HotfixEnum.effectAttributeType.MAXHP, monsterValueTemplete.Hp, FDP.One);
			_actor.attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.ATK, monsterValueTemplete.Atk, FDP.One);
			_actor.attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.DEF, monsterValueTemplete.Def, FDP.One);
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
			check_Attack1 = false;
			check_Attack3 = false;
			_isActivated = true;
			SetLogicTagToggleValue(_actor, "isActive", value: true);
			ChangeTempValueByBossRushLv();
			StartCor(ref corTime, DoCheckSleep());
			if (_pendingUltra)
			{
				_pendingUltra = false;
				_pendingAttack3 = false;
				check_Attack = false;
				check_Attack2 = true;
			}
			else if (_pendingAttack3)
			{
				_pendingAttack3 = false;
				check_Attack = false;
				check_Attack3 = true;
			}
			else
			{
				check_Attack = true;
			}
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
		CastSkill(3130138);
		yield return WaitSkillFinish();
	}

	private bool Check_Attack1()
	{
		return check_Attack1;
	}

	private IEnumerator DoCast_Attack1()
	{
		CastSkill(3130139);
		yield return WaitSkillFinish();
		if (_isActivated && !check_Attack2 && !check_Attack3)
		{
			check_Attack1 = false;
			check_Attack = true;
		}
	}

	private void TriggerSprayWaterUltra()
	{
		if (_isActivated && !check_Sleep && !check_Attack2)
		{
			check_Attack = false;
			check_Attack1 = false;
			check_Attack3 = false;
			check_Attack2 = true;
			InterruptSkill();
		}
	}

	private bool Check_Attack2()
	{
		return check_Attack2;
	}

	private IEnumerator DoCast_Attack2()
	{
		CastSkill(3130149);
		yield return WaitSkillFinish();
		if (_isActivated && !check_Attack1 && !check_Attack3)
		{
			check_Attack2 = false;
			check_Attack = true;
		}
	}

	private bool Check_Attack3()
	{
		return check_Attack3;
	}

	private IEnumerator DoCast_Attack3()
	{
		int myVersion = ++_attack3Version;
		CastSkill(3130151);
		yield return WaitSkillFinish();
		if (_isActivated && myVersion == _attack3Version && !check_Attack1 && !check_Attack2)
		{
			check_Attack3 = false;
			check_Attack = true;
		}
	}
}

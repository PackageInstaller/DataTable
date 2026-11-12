using System.Collections;
using System.Collections.Generic;
using AIScript.Monster._31301JiJuXie;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class JiJuXieGroupController_Lv3 : GroupControllerBase
{
	private int _BossID = 6310260;

	private int _AI_Difficulty = 1;

	private int _Phase = 1;

	protected const int SEQ_P1 = 1;

	protected const int SEQ_P2 = 2;

	protected const int SEQ_P3 = 3;

	protected const int SEQ_ULTRA = 4;

	protected const int SEQ_ULTRA_BROKEN_BRIDGE = 5;

	private const int Stage2RequireLevel = 15;

	private const int Stage3RequireLevel = 25;

	private MonsterAdventureActor leader;

	private bool LevelStart;

	private int _step2_meleeLast;

	private int _step2_rangedLast;

	private int _step5LastChoice;

	private int _p3_summonLast;

	private int _step2_meleeStreak;

	private int _step2_rangedStreak;

	private bool _step2_leftoverLastSmash;

	private bool _step2_leftoverLastSweep;

	private int _curSeqIndex;

	private int _nextBranchIndex;

	private bool _isSeqEnd;

	private int _burrowSprayLast;

	private bool _ultraInterrupted;

	protected virtual int BossID => _BossID;

	protected virtual int AI_Difficulty => _AI_Difficulty;

	protected virtual int Phase
	{
		get
		{
			return _Phase;
		}
		set
		{
			_Phase = value;
		}
	}

	protected override void OnStart()
	{
		base.OnStart();
		_step2_meleeStreak = 0;
		_step2_rangedStreak = 0;
		LevelStart = false;
		_step2_meleeLast = 0;
		_step2_rangedLast = 0;
		_step5LastChoice = 0;
		_p3_summonLast = 0;
		_burrowSprayLast = 0;
		_curSeqIndex = 1;
		_step2_leftoverLastSmash = false;
		_step2_leftoverLastSweep = false;
		_ultraInterrupted = false;
		_isSeqEnd = false;
		int p3_summonLast = TSRandom.Range(1, 3);
		_p3_summonLast = p3_summonLast;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		StartCor(LevelMonsterInitial());
	}

	protected override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	private IEnumerator LevelMonsterInitial()
	{
		while (GetTargetsByDataId(BossID).Count < 1)
		{
			yield return null;
		}
		leader = GetTargetsByDataId(BossID).get_Item(0) as MonsterAdventureActor;
		SetLogicTagFpValue(leader, "Phase", Phase);
		SetLogicTagFpValue(leader, "Level", AI_Difficulty);
		SetLogicTagStringValue(leader, "MonsterTag", Config.bossTag);
		LevelStart = true;
		yield return WaitUntil(() => leader.state == ActorState.Action);
		ShowCenterHpBar(leader);
	}

	protected override void SetConfig()
	{
		GroupAIType = GroupAIType.SEQUENCE;
		List<BaseGroupBranchInfo> sequenceBranches = new List<BaseGroupBranchInfo>
		{
			new BaseGroupBranchInfo(0, DoCast_Awake),
			new BaseGroupBranchInfo(1001, DoCast_Idle),
			new BaseGroupBranchInfo(1002, DoCast_Sweep),
			new BaseGroupBranchInfo(1003, DoCast_Smash),
			new BaseGroupBranchInfo(1004, DoCast_SprayWater),
			new BaseGroupBranchInfo(1005, DoCast_IceStab),
			new BaseGroupBranchInfo(1006, DoCast_BurrowAttack),
			new BaseGroupBranchInfo(1007, DoCast_TraceTornado),
			new BaseGroupBranchInfo(1008, DoCast_DashTornado),
			new BaseGroupBranchInfo(1009, DoCast_SplitTornado),
			new BaseGroupBranchInfo(1010, DoCast_IceMaker),
			new BaseGroupBranchInfo(1011, DoCast_ActiveBattery),
			new BaseGroupBranchInfo(1012, DoCast_Ultra),
			new BaseGroupBranchInfo(1013, DoCast_Show),
			new BaseGroupBranchInfo(1014, DoCast_BurrowSprayWater),
			new BaseGroupBranchInfo(2001, DoCast_Step2_Leftover),
			new BaseGroupBranchInfo(2002, DoCast_Step5_Leftover),
			new BaseGroupBranchInfo(2003, DoCast_DoCast_Idle_Leftover)
		};
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 0, 1013, 2001, 1011, 1005, 1001, 2001, 1014, 1013, 2001 },
			[2] = new List<int> { 1013, 1010, 2001, 1005, 1013, 2002, 2001, 1005, 1013 },
			[3] = new List<int>
			{
				1013, 2001, 1014, 2001, 1010, 2002, 2003, 2001, 1005, 1013,
				2002, 2003, 2001, 1012
			},
			[4] = new List<int> { 1012 },
			[5] = new List<int> { 1011 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ToughnessBroken, active: true, OnToughnessBroken);
		InitListenEvent(GroupEventType.ExitToughnessBroken, active: true, OnExitToughnessBroken);
	}

	private void OnToughnessBroken(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && monsterToughnessStateChangeEvent.actor == leader && monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			int monsterTeammateId = CommonHelper.GetMonsterTeammateId(leader.monsterInfo.teamId, 1);
			List<LogicEntity> entities = ModuleController<AdventureModuleController>.Instance.entities;
			int num = entities.Count - 1;
			while (num >= 0 && (!(entities.get_Item(num) is MonsterAdventureActor monsterAdventureActor) || monsterAdventureActor.dataID != monsterTeammateId || !GetLogicTagToggleValue(monsterAdventureActor, "isActive")))
			{
				num--;
			}
			if (!GetLogicTagToggleValue(leader, "CallActive"))
			{
				_ultraInterrupted = true;
			}
		}
	}

	private void OnExitToughnessBroken(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && monsterToughnessStateChangeEvent.actor == leader && !monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			OnSequenceBranchOperateComplete(_curSeqIndex, _nextBranchIndex, _isSeqEnd);
			ExitPause();
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && leader != null && adventureActorDiedEvent.actor == leader)
		{
			DeactivateAllBatteries();
			CleanSummons();
		}
	}

	private void DeactivateAllBatteries()
	{
		if (!(leader == null))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = leader;
			adventureActorCustomEvent.actor = leader;
			adventureActorCustomEvent.eventHashCode = Config.evt_DeactivateBattery;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void SprayWaterBatteries()
	{
		if (!(leader == null))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = leader;
			adventureActorCustomEvent.actor = leader;
			adventureActorCustomEvent.eventHashCode = Config.evt_SprayWaterBattery;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void ClearInactiveIceMakers()
	{
		if (!(leader == null))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = leader;
			adventureActorCustomEvent.actor = leader;
			adventureActorCustomEvent.eventHashCode = Config.evt_ClearInactiveIceMaker;
			leader.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void CleanSummons()
	{
		if (leader == null)
		{
			return;
		}
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int num = monsterSummonInfos.Count - 1; num >= 0; num--)
		{
			if (monsterSummonInfos.get_Item(num).SummonActorID == leader.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(num).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.DestroySelf(forceDestory: true);
				}
			}
		}
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int nextBranchIndex, bool isSeqEnd)
	{
		if (leader == null || leader.IsDead())
		{
			return;
		}
		_curSeqIndex = curSeqIndex;
		_nextBranchIndex = nextBranchIndex;
		_isSeqEnd = isSeqEnd;
		if (leader.monsterToughnessInfo.isToughnessBroken)
		{
			EenterPause();
			return;
		}
		if ((curSeqIndex == 4) & isSeqEnd)
		{
			if (_ultraInterrupted && Phase == 3)
			{
				_ultraInterrupted = false;
				SwitchSequence(5);
			}
			else
			{
				_ultraInterrupted = false;
				SwitchSequence(GetSeqIndexByPhase(Phase));
			}
			return;
		}
		if ((curSeqIndex == 5) & isSeqEnd)
		{
			SwitchSequence(GetSeqIndexByPhase(Phase));
			return;
		}
		switch (curSeqIndex)
		{
		case 1:
			if (leader.BattleLevel >= 25)
			{
				ClearStep2MeleeLeftoverMemory();
				EnterPhase(3);
			}
			else if ((leader.BattleLevel >= 15) | isSeqEnd)
			{
				CleanSummons();
				SetPhaseForAll(2);
				ClearStep2MeleeLeftoverMemory();
				SwitchSequence(2);
			}
			break;
		case 2:
			if ((leader.BattleLevel >= 25) | isSeqEnd)
			{
				EnterPhase(3);
			}
			break;
		case 3:
			if (isSeqEnd)
			{
				if (_ultraInterrupted)
				{
					_ultraInterrupted = false;
					SwitchSequence(5);
				}
				else
				{
					SwitchSequence(curSeqIndex);
				}
			}
			break;
		}
	}

	private void EnterPhase(int newPhase)
	{
		CleanSummons();
		SetPhaseForAll(newPhase);
		SwitchSequence(4);
	}

	private int GetSeqIndexByPhase(int phase)
	{
		if (phase >= 3)
		{
			return 3;
		}
		if (phase >= 2)
		{
			return 2;
		}
		return 1;
	}

	private void SetPhaseForAll(int newPhase)
	{
		Phase = newPhase;
		SetLogicTagFpValue(leader, "Phase", newPhase);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = leader;
		adventureActorCustomEvent.eventHashCode = Config.evt_SetShase;
		adventureActorCustomEvent.intParam = newPhase;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	private IEnumerator DoCast_Awake()
	{
		while (!LevelStart)
		{
			yield return null;
		}
		SetLogicTagFpValue(leader, "Phase", Phase);
		SetLogicTagFpValue(leader, "Level", AI_Difficulty);
		SendMessageToMonster(leader.Id, "WakeUp");
		yield return WaitTime(0.1);
	}

	private IEnumerator DoCast_Idle()
	{
		ClearStep2MeleeLeftoverMemory();
		SetLogicTagToggleValue(leader, Config.Skill_Idle_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Idle");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Idle_Finish));
	}

	private IEnumerator DoCast_Show()
	{
		SetLogicTagToggleValue(leader, Config.Skill_Show_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Show");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Show_Finish));
	}

	private IEnumerator DoCast_BurrowSprayWater()
	{
		ClearStep2MeleeLeftoverMemory();
		_step2_rangedLast = 1;
		SetLogicTagToggleValue(leader, Config.Skill_BurrowSprayWater_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_BurrowingSprayWater");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_BurrowSprayWater_Finish));
	}

	private IEnumerator DoCast_Sweep()
	{
		SetLogicTagToggleValue(leader, Config.Skill_Sweep_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Sweep");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Sweep_Finish));
	}

	private IEnumerator DoCast_Smash()
	{
		SetLogicTagToggleValue(leader, Config.Skill_Smash_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Smash");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Smash_Finish));
	}

	private IEnumerator DoCast_SprayWater()
	{
		ClearStep2MeleeLeftoverMemory();
		SetLogicTagToggleValue(leader, Config.Skill_SprayWater_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_SprayWater");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_SprayWater_Finish));
	}

	private IEnumerator DoCast_IceStab()
	{
		ClearStep2MeleeLeftoverMemory();
		SetLogicTagToggleValue(leader, Config.Skill_IceStab_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_IceStab");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_IceStab_Finish));
	}

	private IEnumerator DoCast_BurrowAttack()
	{
		ClearStep2MeleeLeftoverMemory();
		_step2_rangedLast = 2;
		SetLogicTagToggleValue(leader, Config.Skill_BurrowAttack_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_BurrowAttack");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_BurrowAttack_Finish));
	}

	private IEnumerator DoCast_TraceTornado()
	{
		SetLogicTagToggleValue(leader, Config.Skill_TraceTornado_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_TraceTornado");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_TraceTornado_Finish));
	}

	private IEnumerator DoCast_DashTornado()
	{
		SetLogicTagToggleValue(leader, Config.Skill_DashTornado_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_DashTornado");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_DashTornado_Finish));
	}

	private IEnumerator DoCast_SplitTornado()
	{
		SetLogicTagToggleValue(leader, Config.Skill_SplitTornado_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_SplitTornado");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_SplitTornado_Finish));
	}

	private IEnumerator DoCast_IceMaker()
	{
		ClearInactiveIceMakers();
		DeactivateAllBatteries();
		ClearStep2MeleeLeftoverMemory();
		SetLogicTagToggleValue(leader, Config.Skill_IceMaker_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_IceMaker");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_IceMaker_Finish));
	}

	private IEnumerator DoCast_ActiveBattery()
	{
		ClearInactiveIceMakers();
		ClearStep2MeleeLeftoverMemory();
		SetLogicTagToggleValue(leader, Config.Skill_ActiveBattery_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_ActiveBattery");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_ActiveBattery_Finish));
	}

	private IEnumerator DoCast_Ultra()
	{
		ClearInactiveIceMakers();
		DeactivateAllBatteries();
		ClearStep2MeleeLeftoverMemory();
		_ultraInterrupted = false;
		SetLogicTagToggleValue(leader, Config.Skill_Ultra_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Ultra");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Ultra_Finish));
	}

	private IEnumerator DoCast_Step2_Leftover()
	{
		bool flag = _step2_rangedStreak >= 2;
		string operationType;
		string finishTag;
		if (flag || !IsPlayerNear())
		{
			_step2_rangedLast = 2;
			operationType = "Skill_BurrowAttack";
			finishTag = Config.Skill_BurrowAttack_Finish;
			if (flag)
			{
				_step2_rangedStreak = 0;
			}
			else
			{
				_step2_rangedStreak++;
			}
			_step2_meleeStreak = 0;
			_step2_leftoverLastSmash = false;
			_step2_leftoverLastSweep = false;
		}
		else
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			FP fP = ((currentPlayer != null) ? (leader.tsTransform.Position - currentPlayer.tsTransform.Position).magnitude : FP.Zero);
			bool flag2 = IsPlayerBehindBoss(11);
			if (flag2 && fP > 7)
			{
				operationType = "Skill_BurrowAttack";
				finishTag = Config.Skill_BurrowAttack_Finish;
				_step2_rangedLast = 2;
				_step2_leftoverLastSmash = false;
				_step2_leftoverLastSweep = false;
			}
			else if (flag2)
			{
				if (_step2_leftoverLastSmash)
				{
					operationType = "Skill_BurrowAttack";
					finishTag = Config.Skill_BurrowAttack_Finish;
					_step2_rangedLast = 2;
					_step2_leftoverLastSmash = false;
					_step2_leftoverLastSweep = false;
				}
				else
				{
					operationType = "Skill_Smash";
					finishTag = Config.Skill_Smash_Finish;
					_step2_meleeLast = 2;
					_step2_meleeStreak++;
					_step2_rangedStreak = 0;
					_step2_leftoverLastSmash = true;
					_step2_leftoverLastSweep = false;
				}
			}
			else if (_step2_leftoverLastSweep)
			{
				operationType = "Skill_BurrowAttack";
				finishTag = Config.Skill_BurrowAttack_Finish;
				_step2_rangedLast = 2;
				_step2_leftoverLastSmash = false;
				_step2_leftoverLastSweep = false;
			}
			else
			{
				operationType = "Skill_Sweep";
				finishTag = Config.Skill_Sweep_Finish;
				_step2_meleeLast = 1;
				_step2_meleeStreak++;
				_step2_rangedStreak = 0;
				_step2_leftoverLastSmash = false;
				_step2_leftoverLastSweep = true;
			}
		}
		SetLogicTagToggleValue(leader, finishTag, value: false);
		SendMessageToMonster(leader.Id, operationType);
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, finishTag));
	}

	private bool IsPlayerNear()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			return false;
		}
		return (leader.tsTransform.Position - currentPlayer.tsTransform.Position).magnitude <= 11;
	}

	private IEnumerator DoCast_Step5_Leftover()
	{
		string operationType;
		string finishTag;
		if ((_step5LastChoice = ((_step5LastChoice != 0) ? ((_step5LastChoice != 1) ? 1 : 2) : TSRandom.Range(1, 3))) == 1)
		{
			operationType = "Skill_TraceTornado";
			finishTag = Config.Skill_TraceTornado_Finish;
		}
		else
		{
			operationType = "Skill_DashTornado";
			finishTag = Config.Skill_DashTornado_Finish;
		}
		SetLogicTagToggleValue(leader, finishTag, value: false);
		SendMessageToMonster(leader.Id, operationType);
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, finishTag));
	}

	private IEnumerator DoCast_DoCast_Idle_Leftover()
	{
		if (_step5LastChoice == 1)
		{
			ClearStep2MeleeLeftoverMemory();
			SetLogicTagToggleValue(leader, Config.Skill_Idle_Finish, value: false);
			SendMessageToMonster(leader.Id, "Skill_Idle");
			yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Idle_Finish));
		}
	}

	private bool IsPlayerBehindBoss(FP distance)
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			return false;
		}
		if (leader == null)
		{
			return false;
		}
		TSVector2 tSVector = currentPlayer.tsTransform.Position - leader.tsTransform.Position;
		if (tSVector.magnitude > distance)
		{
			return false;
		}
		TSVector2 forward = leader.tsTransform.Forward;
		return TSVector2.Dot(tSVector.normalized, forward) < 0;
	}

	private void ClearStep2MeleeLeftoverMemory()
	{
		_step2_leftoverLastSmash = false;
		_step2_leftoverLastSweep = false;
	}
}

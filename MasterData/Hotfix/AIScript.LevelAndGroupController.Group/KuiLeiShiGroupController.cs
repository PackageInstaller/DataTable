using System.Collections;
using System.Collections.Generic;
using AIScript.Monster._73001KuiLeiShi;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class KuiLeiShiGroupController : GroupControllerBase
{
	protected const int SEQ_P1 = 1;

	protected const int SEQ_HEXINBAOFA = 2;

	protected const int SEQ_CHARGE = 3;

	private MonsterAdventureActor leader;

	private MonsterAdventureActor juXing;

	private bool _inHeXinBaoFa;

	private bool _inCharge;

	private int _lastP1BranchIndex;

	private int _lastChargeIndex;

	private PlayFX _shieldDownFx;

	private PlayFX _breakLineFx;

	protected virtual int BossID_XiaoMoXiang => 7201101;

	protected virtual int BossID_JuXingMoXiang => 7201201;

	protected override void OnStart()
	{
		base.OnStart();
		EenterPause();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		StartCor(LevelMonsterInitial());
	}

	protected override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		_inHeXinBaoFa = false;
		_inCharge = false;
		_lastP1BranchIndex = 0;
		_lastChargeIndex = 0;
		ILRuntimeAPI.ClearPlayFX(_shieldDownFx);
		ILRuntimeAPI.ClearPlayFX(_breakLineFx);
	}

	private IEnumerator LevelMonsterInitial()
	{
		while (GetTargetsByDataId(BossID_XiaoMoXiang).Count < 1)
		{
			yield return null;
		}
		leader = GetTargetsByDataId(BossID_XiaoMoXiang).get_Item(0) as MonsterAdventureActor;
		while (GetTargetsByDataId(BossID_JuXingMoXiang).Count < 1)
		{
			yield return null;
		}
		juXing = GetTargetsByDataId(BossID_JuXingMoXiang).get_Item(0) as MonsterAdventureActor;
		SetLogicTagFpValue(juXing, Config_JuXingMoXiang.PartnerDataIdTag, BossID_XiaoMoXiang);
		SetLogicTagFpValue(leader, Config_JuXingMoXiang.SelfDataIdTag, BossID_JuXingMoXiang);
		yield return WaitUntil(() => leader != null && leader.state == ActorState.Action);
		FP logicTagFpValue = CommonUtils_MonsterAPI.GetLogicTagFpValue(leader, Common_73001.SummonLevel_Tag);
		CommonUtils_MonsterAPI.SetLogicTagFpValue(juXing, Common_73001.SummonLevel_Tag, logicTagFpValue);
		ExitPause();
	}

	protected override void SetConfig()
	{
		GroupAIType = GroupAIType.SEQUENCE;
		List<BaseGroupBranchInfo> sequenceBranches = new List<BaseGroupBranchInfo>
		{
			new BaseGroupBranchInfo(1001, DoCast_MeleeCombo),
			new BaseGroupBranchInfo(1002, DoCast_RangedCombo),
			new BaseGroupBranchInfo(1003, DoCast_PuppetControl),
			new BaseGroupBranchInfo(1004, DoCast_SilkPierce),
			new BaseGroupBranchInfo(1021, DoCast_Bombard),
			new BaseGroupBranchInfo(1022, DoCast_LaserSweep),
			new BaseGroupBranchInfo(1051, DoCast_ZhuNengGuangXian),
			new BaseGroupBranchInfo(1052, DoCast_NengLiangQiu),
			new BaseGroupBranchInfo(1053, DoCast_ChargeSwitch),
			new BaseGroupBranchInfo(1011, DoCast_MeleeCombo_Bombard),
			new BaseGroupBranchInfo(1012, DoCast_MeleeCombo_LaserSweep),
			new BaseGroupBranchInfo(1013, DoCast_RangedCombo_Bombard),
			new BaseGroupBranchInfo(1014, DoCast_RangedCombo_LaserSweep),
			new BaseGroupBranchInfo(1015, DoCast_PuppetControl_Bombard),
			new BaseGroupBranchInfo(1016, DoCast_PuppetControl_LaserSweep),
			new BaseGroupBranchInfo(1017, DoCast_SilkPierce_Bombard),
			new BaseGroupBranchInfo(1018, DoCast_SilkPierce_LaserSweep),
			new BaseGroupBranchInfo(1101, DoCast_HeXinBaoFa_Combo)
		};
		InitSequenceBranches(1, sequenceBranches, GetSequenceDict());
	}

	protected virtual Dictionary<int, List<int>> GetSequenceDict()
	{
		return new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1001, 1004, 1016, 1002, 1004, 1001, 1015, 1002, 1004, 1012,
				1003
			},
			[2] = new List<int> { 1101 },
			[3] = new List<int> { 1051, 1052, 1053 }
		};
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ToughnessBroken, active: true, OnToughnessBroken);
		InitListenEvent(GroupEventType.ExitToughnessBroken, active: true, OnExitToughnessBroken);
	}

	private void OnToughnessBroken(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && !(monsterToughnessStateChangeEvent.actor != leader))
		{
			if (_inCharge)
			{
				_lastChargeIndex = CurrentIndex;
			}
			_inCharge = false;
			_inHeXinBaoFa = false;
			if (CurrentSeqIndex == 1)
			{
				_lastP1BranchIndex = CurrentIndex;
			}
			SwitchSequence(1, initialIndex: false);
			SetCurrentSequenceIndex(_lastP1BranchIndex);
			InterruptCurrentBranch();
			if (juXing != null)
			{
				SendMessageToMonster(juXing.Id, "InterruptAllSkill");
			}
			EenterPause();
		}
	}

	private void OnExitToughnessBroken(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && !(monsterToughnessStateChangeEvent.actor != leader))
		{
			_inCharge = false;
			_inHeXinBaoFa = false;
			SwitchSequence(1, initialIndex: false);
			SetCurrentSequenceIndex(_lastP1BranchIndex);
			ExitPause();
		}
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int nextBranchIndex, bool isSeqEnd)
	{
		if ((curSeqIndex == 2) & isSeqEnd)
		{
			_inHeXinBaoFa = false;
			SwitchSequence(1, initialIndex: false);
			SetCurrentSequenceIndex(_lastP1BranchIndex);
			return;
		}
		switch (curSeqIndex)
		{
		case 3:
			_inCharge = false;
			_lastChargeIndex = nextBranchIndex;
			if (juXing != null && GetLogicTagFpValue(juXing, Config_JuXingMoXiang.EnergyTag) >= 100)
			{
				_inHeXinBaoFa = true;
				SwitchSequence(2);
			}
			else
			{
				SwitchSequence(1, initialIndex: false);
				SetCurrentSequenceIndex(_lastP1BranchIndex);
			}
			return;
		case 1:
			if (!_inHeXinBaoFa && !_inCharge && juXing != null)
			{
				_lastP1BranchIndex = nextBranchIndex;
				if (juXing != null && GetLogicTagFpValue(juXing, Config_JuXingMoXiang.EnergyTag) >= 100)
				{
					_inHeXinBaoFa = true;
					SwitchSequence(2);
					return;
				}
				if (leader != null && leader.monsterInfo.currentEnergy >= leader.monsterInfo.maxEnergy)
				{
					_inCharge = true;
					leader.monsterInfo.currentEnergy = 0;
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", leader.Id, 0, a2: false);
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("CastUltra", leader.Id);
					SwitchSequence(3, initialIndex: false);
					SetCurrentSequenceIndex(_lastChargeIndex);
					return;
				}
			}
			break;
		}
		if (isSeqEnd)
		{
			SwitchSequence(curSeqIndex);
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent)
		{
			if (leader != null && adventureActorDiedEvent.actor == leader)
			{
				CleanSummons(leader);
			}
			else
			{
				OnConduitDied(adventureActorDiedEvent);
			}
		}
	}

	private void OnConduitDied(AdventureActorDiedEvent diedEvent)
	{
		MonsterAdventureActor monsterAdventureActor = diedEvent.actor as MonsterAdventureActor;
		if (monsterAdventureActor == null)
		{
			return;
		}
		MonsterSummonInfo logicComponent = monsterAdventureActor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent == null || !(diedEvent.killer is PlayerAdventureActor) || !(leader != null) || logicComponent.SummonActorId != leader.Id)
		{
			return;
		}
		int level = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(leader, Common_73001.SummonLevel_Tag);
		int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.zhuNengKuiLeiMonsterIds);
		if (monsterAdventureActor.dataID != monsterIdByLevel)
		{
			return;
		}
		int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.damageBuffIds);
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		foreach (PlayerAdventureActor item in list)
		{
			item?.buffComponent?.AddBuffNum(monsterIdByLevel2, 2, leader);
		}
	}

	private void CleanSummons(MonsterAdventureActor summoner)
	{
		if (summoner == null)
		{
			return;
		}
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int num = monsterSummonInfos.Count - 1; num >= 0; num--)
		{
			if (monsterSummonInfos.get_Item(num).SummonActorID == summoner.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(num).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.DestroySelf(forceDestory: true);
				}
			}
		}
	}

	private IEnumerator DoCast_MeleeCombo()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_MeleeCombo");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish));
	}

	private IEnumerator DoCast_RangedCombo()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_RangedCombo");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish));
	}

	private IEnumerator DoCast_PuppetControl()
	{
		SetLogicTagToggleValue(leader, Common_73001.Skill_PuppetControl_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_PuppetControl");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Common_73001.Skill_PuppetControl_Finish));
	}

	private IEnumerator DoCast_SilkPierce()
	{
		SetLogicTagToggleValue(leader, Common_73001.Skill_SilkPierce_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_SilkPierce");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Common_73001.Skill_SilkPierce_Finish));
	}

	private IEnumerator DoCast_Bombard()
	{
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish, value: false);
		SendMessageToMonster(juXing.Id, "Bombard");
		yield return WaitUntil(() => GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish));
	}

	private IEnumerator DoCast_LaserSweep()
	{
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish, value: false);
		SendMessageToMonster(juXing.Id, "LaserSweep");
		yield return WaitUntil(() => GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish));
		yield return WaitTime(5);
	}

	private IEnumerator DoCast_ZhuNengGuangXian()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_ZhuNengGuangXian_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_ZhuNengGuangXian");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_ZhuNengGuangXian_Finish));
	}

	private IEnumerator DoCast_NengLiangQiu()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_NengLiangQiu_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_NengLiangQiu");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_NengLiangQiu_Finish));
	}

	private IEnumerator DoCast_ChargeSwitch()
	{
		if (TSRandom.Range(0, 2) == 0)
		{
			SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_ZhuNengGuangXian_Finish, value: false);
			SendMessageToMonster(leader.Id, "Skill_ZhuNengGuangXian");
			yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_ZhuNengGuangXian_Finish));
		}
		else
		{
			SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_NengLiangQiu_Finish, value: false);
			SendMessageToMonster(leader.Id, "Skill_NengLiangQiu");
			yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_NengLiangQiu_Finish));
		}
	}

	private IEnumerator DoCast_MeleeCombo_Bombard()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish, value: false);
		SendMessageToMonster(juXing.Id, "Bombard");
		yield return WaitTime(1.5);
		SendMessageToMonster(leader.Id, "Skill_MeleeCombo");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish));
	}

	private IEnumerator DoCast_MeleeCombo_LaserSweep()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_MeleeCombo");
		SendMessageToMonster(juXing.Id, "LaserSweep");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish));
	}

	private IEnumerator DoCast_RangedCombo_Bombard()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_RangedCombo");
		SendMessageToMonster(juXing.Id, "Bombard");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish));
	}

	private IEnumerator DoCast_RangedCombo_LaserSweep()
	{
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_RangedCombo");
		SendMessageToMonster(juXing.Id, "LaserSweep");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish));
	}

	private IEnumerator DoCast_PuppetControl_Bombard()
	{
		SetLogicTagToggleValue(leader, Common_73001.Skill_PuppetControl_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_PuppetControl");
		SendMessageToMonster(juXing.Id, "Bombard");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Common_73001.Skill_PuppetControl_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish));
	}

	private IEnumerator DoCast_PuppetControl_LaserSweep()
	{
		SetLogicTagToggleValue(leader, Common_73001.Skill_PuppetControl_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_PuppetControl");
		SendMessageToMonster(juXing.Id, "LaserSweep");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Common_73001.Skill_PuppetControl_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish));
	}

	private IEnumerator DoCast_SilkPierce_Bombard()
	{
		SetLogicTagToggleValue(leader, Common_73001.Skill_SilkPierce_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_SilkPierce");
		SendMessageToMonster(juXing.Id, "Bombard");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Common_73001.Skill_SilkPierce_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemBombard_Finish));
	}

	private IEnumerator DoCast_SilkPierce_LaserSweep()
	{
		SetLogicTagToggleValue(leader, Common_73001.Skill_SilkPierce_Finish, value: false);
		SetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_SilkPierce");
		SendMessageToMonster(juXing.Id, "LaserSweep");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Common_73001.Skill_SilkPierce_Finish) && GetLogicTagToggleValue(juXing, Common_73001.Skill_GiantGolemLaserSweep_Finish));
	}

	private IEnumerator DoCast_HeXinBaoFa_Combo()
	{
		SetLogicTagToggleValue(juXing, Config_JuXingMoXiang.Skill_HeXinBaoFa_Finish, value: false);
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish, value: false);
		SendMessageToMonster(juXing.Id, "Skill_HeXinBaoFa");
		SendMessageToMonster(leader.Id, "Skill_MeleeCombo");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_MeleeCombo_Finish));
		SetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_RangedCombo");
		yield return WaitUntil(() => GetLogicTagToggleValue(juXing, Config_JuXingMoXiang.Skill_HeXinBaoFa_Finish) && GetLogicTagToggleValue(leader, Config_XiaoMoXiang.Skill_RangedCombo_Finish));
	}
}

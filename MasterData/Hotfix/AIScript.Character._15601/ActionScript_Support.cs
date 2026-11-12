using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class ActionScript_Support : ActionScript
{
	private int _nextRaffleTimes;

	private CoroutineNode _raffleIntervalCor;

	private bool _teleportForBattleReady;

	private List<Config_Support.RaffleCombinationType> _raffleResultList;

	private int NextRaffleTimes
	{
		get
		{
			return _nextRaffleTimes;
		}
		set
		{
			if (value != _nextRaffleTimes)
			{
				_nextRaffleTimes = value;
				((PlayerAdventureActor)_actor).SetLocalData("NextRaffleTimes", _nextRaffleTimes.ToString());
			}
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	public override void OnStart()
	{
		base.OnStart();
		int num = _actor.logicVariable.GetLogicTagValue("InitNextRaffleTimes").AsInt();
		if (num > 0)
		{
			_actor.logicVariable.SetLogicTagValue("InitNextRaffleTimes", 0);
			NextRaffleTimes = num;
			BeginRaffle(strollFirst: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515631, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.SE)
				{
					actorL.buffComponent.AddBuff(15631011, _actor);
				}
			}
		}
		_teleportForBattleReady = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	protected override void OnCastSkill()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish))
		{
			ForceStopRaffleLogic();
			NextRaffleTimes = 1;
		}
	}

	protected override void OnCastUltimate()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish))
		{
			_actor.StandBy();
			if (_raffleIntervalCor != null)
			{
				_actor.StopLogicCoroutine(_raffleIntervalCor);
			}
			_raffleIntervalCor = null;
			_actor.buffComponent.RemoveBuffByBuffId(15691014);
		}
	}

	private void OnSkillFinish(bool success)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		if (success)
		{
			BeginRaffle();
		}
	}

	private void OnUltraSkillFinish(bool success)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		if (NextRaffleTimes > 0)
		{
			BeginRaffle(strollFirst: true);
		}
	}

	private void BeginRaffle(bool strollFirst = false)
	{
		((PlayerAdventureActor)_actor).isResidentAssist = true;
		_actor.buffComponent.AddBuff(15691014, _actor);
		if (strollFirst)
		{
			_raffleIntervalCor = _actor.StartLogicCoroutine(RaffleInterval());
		}
		else
		{
			Raffle(NextRaffleTimes == 5);
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}

	private void Raffle(bool isLastRaffle)
	{
		if (!((PlayerAdventureActor)_actor).isAssistAIFinish)
		{
			return;
		}
		int perkLevel = NextRaffleTimes++;
		List<FP> list = Config_Support.raffleRateList;
		Config_Support.RaffleCombinationType raffleCombinationType = (Config_Support.RaffleCombinationType)258;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515622, out perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515623, out perkLevel))
			{
				list = Config_Support.raffleRateList_P22_P23;
				raffleCombinationType = (Config_Support.RaffleCombinationType)258;
			}
			else
			{
				list = Config_Support.raffleRateList_P22;
				raffleCombinationType = Config_Support.RaffleCombinationType.AAA;
			}
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 515623, out perkLevel))
		{
			list = Config_Support.raffleRateList_P23;
			raffleCombinationType = Config_Support.RaffleCombinationType.BBB;
		}
		FP maxValue = 0;
		foreach (FP item2 in list)
		{
			maxValue += item2;
		}
		FP fP = TSRandom.Range(0, maxValue);
		int num = 0;
		FP fP2 = 0;
		for (int i = 0; i < list.Count; i++)
		{
			fP2 += list.get_Item(i);
			if (fP <= fP2)
			{
				num = i;
				break;
			}
		}
		int index = TSMath.Clamp(num, 0, Config_Support.raffleResultGroupList.Count - 1).AsInt();
		List<Config_Support.RaffleCombinationType> list2 = Config_Support.raffleResultGroupList.get_Item(index);
		Config_Support.RaffleCombinationType item = list2.get_Item(TSRandom.Range(0, list2.Count));
		if (_raffleResultList == null)
		{
			_raffleResultList = new List<Config_Support.RaffleCombinationType>();
		}
		Config_Support.RaffleCombinationType raffleCombinationType2 = Config_Support.RaffleCombinationType.None;
		if (_raffleResultList.Count > 0)
		{
			raffleCombinationType2 = _raffleResultList.Last();
		}
		if (isLastRaffle)
		{
			bool flag = true;
			for (int j = 0; j < _raffleResultList.Count; j++)
			{
				if ((_raffleResultList.get_Item(j) & raffleCombinationType) != 0)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				if (raffleCombinationType == (Config_Support.RaffleCombinationType)258)
				{
					raffleCombinationType = ((TSRandom.Range(FP.Zero, 100) > 50) ? Config_Support.RaffleCombinationType.AAA : Config_Support.RaffleCombinationType.BBB);
				}
				_raffleResultList.Add(raffleCombinationType);
			}
			else
			{
				_raffleResultList.Add(item);
			}
		}
		else
		{
			_raffleResultList.Add(item);
		}
		Config_Support.RaffleCombinationType raffleCombinationType3 = _raffleResultList.Last();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515632, out perkLevel))
		{
			_actor.buffComponent.AddBuff(15632011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515633, out perkLevel) && (raffleCombinationType2 == Config_Support.RaffleCombinationType.AAA || raffleCombinationType2 == Config_Support.RaffleCombinationType.BBB) && (raffleCombinationType3 == Config_Support.RaffleCombinationType.AAA || raffleCombinationType3 == Config_Support.RaffleCombinationType.BBB))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(15633011, _actor);
			}
		}
		_actor.logicVariable.SetLogicTagValue("RaffleCombinationType", (int)raffleCombinationType3);
		ILRuntimeAPI.CreateSkill(15632001, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnRaffleSkillFinish);
	}

	private void OnRaffleSkillFinish(bool success)
	{
		if (!((PlayerAdventureActor)_actor).isAssistAIFinish)
		{
			return;
		}
		if (success)
		{
			Config_Support.RaffleCombinationType raffleCombinationType = _raffleResultList.Last();
			if (Config_Support.raffleResultSkillIdDic.TryGetValue(raffleCombinationType, out var skillId) && skillId > 0)
			{
				int perkLevel;
				switch (raffleCombinationType)
				{
				case Config_Support.RaffleCombinationType.AAA:
				case Config_Support.RaffleCombinationType.AAB:
				case Config_Support.RaffleCombinationType.ABA:
				case Config_Support.RaffleCombinationType.BAA:
				{
					int buffID2 = 15691011;
					if (CommonUtils.HavePersonalPerk(_actor.dataID, 515621, out perkLevel))
					{
						buffID2 = 15621011;
					}
					foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
					{
						actorL.buffComponent.AddBuff(buffID2, _actor);
					}
					break;
				}
				case Config_Support.RaffleCombinationType.ABB:
				case Config_Support.RaffleCombinationType.BAB:
				case Config_Support.RaffleCombinationType.BBA:
				case Config_Support.RaffleCombinationType.BBB:
				{
					int buffID = 15691012;
					if (CommonUtils.HavePersonalPerk(_actor.dataID, 515624, out perkLevel))
					{
						buffID = 15624011;
					}
					foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
					{
						actorL2.buffComponent.AddBuff(buffID, _actor);
					}
					break;
				}
				}
				ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool skillSuccess) =>
				{
					if (CommonUtils.HavePersonalPerk(_actor.dataID, 515626, out var perkLevel2) && skillId == 15632003)
					{
						ILRuntimeAPI.CreateSkill(15632005, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool heartArrowSuccess) =>
						{
							OnRaffleFinish(_: true);
						});
						(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor).buffComponent.AddBuff(15626011, _actor);
					}
					else if (CommonUtils.HavePersonalPerk(_actor.dataID, 515629, out perkLevel2) && skillId == 15632002)
					{
						ILRuntimeAPI.CreateSkill(15632004, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool heartArrowSuccess) =>
						{
							OnRaffleFinish(_: true);
						});
						(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor).buffComponent.AddBuff(15629011, _actor);
					}
					else
					{
						OnRaffleFinish(_: true);
					}
				});
				return;
			}
		}
		OnRaffleFinish(_: false);
	}

	private void OnRaffleFinish(bool _)
	{
		if (((PlayerAdventureActor)_actor).isAssistAIFinish)
		{
			if (NextRaffleTimes <= 5)
			{
				_raffleIntervalCor = _actor.StartLogicCoroutine(RaffleInterval());
				return;
			}
			NextRaffleTimes = 0;
			_actor.buffComponent.RemoveBuffByBuffId(15691014);
			((PlayerAdventureActor)_actor).isResidentAssist = false;
		}
	}

	private IEnumerator RaffleInterval()
	{
		FP interval = Config_Support.interval_UseRaffleSkill;
		FP idleTime = 0;
		while (interval > 0)
		{
			if (_teleportForBattleReady)
			{
				Teleport();
				_teleportForBattleReady = false;
			}
			else
			{
				LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
				FP fP = _actor.DistanceWithRadius(activedPlayerActor);
				if (fP > Config_Support.maxDistanceWithPlayer_Stroll)
				{
					Teleport();
				}
				else if (_actor.movementState == ActorState.StandBy)
				{
					if (fP < Config_Support.randomRadius_Stroll && idleTime <= 0)
					{
						idleTime = Config_Support.idleTime_BetweenStroll;
					}
					idleTime -= _actor.LogicDeltaTime;
					if (idleTime <= 0)
					{
						BeginStroll();
					}
				}
			}
			interval -= _actor.LogicDeltaTime;
			yield return null;
		}
		_actor.StandBy();
		Raffle(NextRaffleTimes == 5);
	}

	private void Teleport()
	{
		_actor.StandBy();
		TSVector2 randomTargetPosition = GetRandomTargetPosition();
		_actor.Teleport(randomTargetPosition);
		BeginStroll();
	}

	private void BeginStroll()
	{
		TSVector2 randomTargetPosition = GetRandomTargetPosition();
		_actor.MoveTo(randomTargetPosition, 0.1, enableNavigation: true);
	}

	private TSVector2 GetRandomTargetPosition()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			position = activedPlayerActor.tsTransform.Position,
			innerRadius = activedPlayerActor.GetRadius(),
			radius = Config_Support.randomRadius_Stroll
		});
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
		}
		return result;
	}

	private void ForceStopRaffleLogic()
	{
		_actor.StandBy();
		if (_raffleIntervalCor != null)
		{
			_actor.StopLogicCoroutine(_raffleIntervalCor);
		}
		_raffleIntervalCor = null;
		_teleportForBattleReady = false;
		_raffleResultList?.Clear();
		NextRaffleTimes = 0;
		_actor.buffComponent.RemoveBuffByBuffId(15691014);
		((PlayerAdventureActor)_actor).isResidentAssist = false;
	}

	private void OnBattleReady(IEvent _)
	{
		_teleportForBattleReady = true;
	}

	public override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515631, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.SE)
				{
					actorL.buffComponent.RemoveBuffByBuffId(15631011);
				}
			}
		}
		ForceStopRaffleLogic();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ForceStopRaffleLogic();
	}
}

using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class AdventureAutoBattleController : MonoBehaviour
{
	public bool autoBattle;

	private List<AdventureAutoBattleCommands.AutoBattleCommandBase> autoBattleCommands;

	private List<AdventureAutoBattleCommands.AutoBattleCommandBase> autoBattleCommandsDefault;

	private FP _decisionIntervalFP;

	private int commandIndex;

	private int defaultCommandIndex;

	private FP _presetAutoBattleTimeFP;

	private FP _timeScaleFP = FP.One;

	private AdventurePlayerController playerController;

	private MonsterAdventureActor currentTarget;

	private bool isBusy;

	private FP _decisionDurationFP;

	private FP _autoBattleDurationFP;

	public PlayerAdventureActor CurrentPlayer
	{
		get
		{
			if (null == playerController)
			{
				Debug.LogError("角色控制器为空!");
				return null;
			}
			LogicEntity activedPlayerActor = playerController.activedPlayerActor;
			if (null == activedPlayerActor)
			{
				Debug.LogError("当前玩家对象为空!");
				return null;
			}
			return activedPlayerActor as PlayerAdventureActor;
		}
	}

	private AdventureAutoBattleCommands.AutoBattleCommandBase CurrentCommand
	{
		get
		{
			if (commandIndex >= autoBattleCommands.Count)
			{
				commandIndex = 0;
			}
			return autoBattleCommands.get_Item(commandIndex);
		}
	}

	public void Initialize(AdventureAutoBattleConfig config)
	{
		List<AdventureAutoBattleConfig.AutoBattleCommandStruct> list = config.autoBattleCommands;
		if (list == null || list.Count == 0)
		{
			Debug.LogError("自动战斗指令集为空!");
			return;
		}
		List<AdventureAutoBattleConfig.AutoBattleCommandStruct> list2 = config.autoBattleCommandsDefault;
		if (list2 == null || list2.Count == 0)
		{
			Debug.LogError("自动战斗次级指令集为空!");
			return;
		}
		playerController = SceneSingleton<AdventurePlayerController>.Instance;
		_decisionIntervalFP = FP.FromConfigFloat(config.decisionInterval);
		_presetAutoBattleTimeFP = FP.FromConfigFloat(config.presetAutoBattleTime);
		_timeScaleFP = FP.FromConfigFloat(config.timeScale);
		autoBattleCommands = new List<AdventureAutoBattleCommands.AutoBattleCommandBase>();
		AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
		PlayerAdventureActor actor = instance.activedPlayerActor as PlayerAdventureActor;
		int firstSlotActorId = instance.FirstSlotActorId;
		int secondSlotActorId = instance.SecondSlotActorId;
		AdventureAutoBattleCommands.AutoBattleCommandBase autoBattleCommandBase = null;
		for (int i = 0; i < list.Count; i++)
		{
			autoBattleCommandBase = list.get_Item(i).commandType switch
			{
				AdventureAutoBattleCommands.AutoBattleCommandType.Standby => (AdventureAutoBattleCommands.AutoBattleCommandBase)new AdventureAutoBattleCommands.AutoBattleCommand_Standby(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.Attack => new AdventureAutoBattleCommands.AutoBattleCommand_Attack(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.Skill => new AdventureAutoBattleCommands.AutoBattleCommand_Skill(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.SkillUltimate => new AdventureAutoBattleCommands.AutoBattleCommand_SkillUltimate(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.Dodge => new AdventureAutoBattleCommands.AutoBattleCommand_Dodge(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastSkill_1 => new AdventureAutoBattleCommands.AutoBattleCommand_CastSkill_Support1(firstSlotActorId), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastSkill_2 => new AdventureAutoBattleCommands.AutoBattleCommand_CastSkill_Support2(secondSlotActorId), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastUltimate_1 => new AdventureAutoBattleCommands.AutoBattleCommand_Ultimate_Support1(firstSlotActorId), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastUltimate_2 => new AdventureAutoBattleCommands.AutoBattleCommand_Ultimate_Support2(secondSlotActorId), 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			autoBattleCommandBase.holdDuration = list.get_Item(i).holdDuration;
			autoBattleCommands.Add(autoBattleCommandBase);
		}
		autoBattleCommandsDefault = new List<AdventureAutoBattleCommands.AutoBattleCommandBase>();
		for (int j = 0; j < list2.Count; j++)
		{
			autoBattleCommandBase = list2.get_Item(j).commandType switch
			{
				AdventureAutoBattleCommands.AutoBattleCommandType.Standby => (AdventureAutoBattleCommands.AutoBattleCommandBase)new AdventureAutoBattleCommands.AutoBattleCommand_Standby(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.Attack => new AdventureAutoBattleCommands.AutoBattleCommand_Attack(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.Skill => new AdventureAutoBattleCommands.AutoBattleCommand_Skill(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.SkillUltimate => new AdventureAutoBattleCommands.AutoBattleCommand_SkillUltimate(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.Dodge => new AdventureAutoBattleCommands.AutoBattleCommand_Dodge(actor), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastSkill_1 => new AdventureAutoBattleCommands.AutoBattleCommand_CastSkill_Support1(firstSlotActorId), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastSkill_2 => new AdventureAutoBattleCommands.AutoBattleCommand_CastSkill_Support2(secondSlotActorId), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastUltimate_1 => new AdventureAutoBattleCommands.AutoBattleCommand_Ultimate_Support1(firstSlotActorId), 
				AdventureAutoBattleCommands.AutoBattleCommandType.CastUltimate_2 => new AdventureAutoBattleCommands.AutoBattleCommand_Ultimate_Support2(secondSlotActorId), 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			autoBattleCommandBase.holdDuration = list2.get_Item(j).holdDuration;
			autoBattleCommandsDefault.Add(autoBattleCommandBase);
		}
	}

	public void Active()
	{
		autoBattle = true;
		LockStepManager.globalTimeScaleMultiplier = _timeScaleFP;
		Debug.Log("开启自动战斗");
	}

	public void DeActive()
	{
		autoBattle = false;
		LockStepManager.globalTimeScaleMultiplier = FP.One;
		Debug.Log("关闭自动战斗");
	}

	public void Update()
	{
		if (!autoBattle)
		{
			return;
		}
		FP deltaTime = LockStepManager.deltaTime;
		_autoBattleDurationFP += deltaTime;
		PlayerAdventureActor curPlayer;
		if (_autoBattleDurationFP >= _presetAutoBattleTimeFP)
		{
			Stop();
		}
		else
		{
			if (isBusy)
			{
				return;
			}
			_decisionDurationFP += deltaTime;
			if (_decisionDurationFP <= _decisionIntervalFP)
			{
				return;
			}
			_decisionDurationFP = FP.Zero;
			if (null == currentTarget || currentTarget.isDead)
			{
				List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
				if (monsterActors == null || monsterActors.Count == 0)
				{
					return;
				}
				curPlayer = CurrentPlayer;
				if (null == curPlayer)
				{
					return;
				}
				LogicEntity lockingConfrontActor = curPlayer.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
				if (null == lockingConfrontActor)
				{
					FP fP = FP.MaxValue;
					LogicEntity logicEntity = null;
					for (int i = 0; i < monsterActors.Count; i++)
					{
						LogicEntity logicEntity2 = monsterActors.get_Item(i);
						FP fP2 = TSVector2.Distance(curPlayer.tsTransform.Position, logicEntity2.tsTransform.Position);
						if (fP2 < fP)
						{
							fP = fP2;
							logicEntity = logicEntity2;
						}
					}
					if (null != logicEntity)
					{
						currentTarget = logicEntity as MonsterAdventureActor;
					}
					Busy();
					if (!curPlayer.TrackMove(currentTarget, 2, enableNavigation: true, NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate, AdventureActor.MovementMode.Run, MoveComplete, MoveComplete))
					{
						MoveComplete();
					}
				}
				else
				{
					currentTarget = lockingConfrontActor as MonsterAdventureActor;
					curPlayer.attackTarget = currentTarget;
				}
			}
			else if (TSVector2.Distance(CurrentPlayer.tsTransform.Position, currentTarget.tsTransform.Position) > CurrentPlayer.actorSearchTargetInfo.attackRange)
			{
				if (!CurrentPlayer.TrackMove(currentTarget, 2, enableNavigation: true, NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate, AdventureActor.MovementMode.Run, MoveComplete2, MoveComplete2))
				{
					Think();
				}
			}
			else
			{
				Think();
			}
		}
		void MoveComplete()
		{
			curPlayer.attackTarget = currentTarget;
			Idle();
		}
		void MoveComplete2()
		{
			Think();
		}
	}

	private void Think()
	{
		AdventureAutoBattleCommands.AutoBattleCommandBase currentCommand = CurrentCommand;
		commandIndex++;
		if (currentCommand.IsValid)
		{
			Busy();
			currentCommand.Execute(Idle);
			return;
		}
		for (int i = 0; i < autoBattleCommandsDefault.Count; i++)
		{
			currentCommand = autoBattleCommandsDefault.get_Item(i);
			if (currentCommand.IsValid)
			{
				Busy();
				currentCommand.Execute(Idle);
				break;
			}
		}
	}

	private void Idle()
	{
		isBusy = false;
	}

	private void Busy()
	{
		isBusy = true;
	}

	private void Stop()
	{
		Debug.Log("自动战斗结束");
		autoBattle = false;
		_decisionDurationFP = FP.Zero;
		_autoBattleDurationFP = FP.Zero;
		isBusy = false;
	}
}

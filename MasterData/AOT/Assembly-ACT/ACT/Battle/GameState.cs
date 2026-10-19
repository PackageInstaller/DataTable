using System.Collections.Generic;
using ACT.Event;
using ACT.World.StateObject;
using Fundamental;

namespace ACT.Battle;

public class GameState : Singleton<GameState>
{
	private bool _inGuiding;

	private bool _inSystemUnlock;

	private bool _inBlackScreenTransition;

	public GameControlStateMachine GameControlStateMachine;

	private const MonoECS.PlayerTag ExclusivePlayerOperationTags = MonoECS.PlayerTag.Timeline | MonoECS.PlayerTag.MovingPath | MonoECS.PlayerTag.BackTrace | MonoECS.PlayerTag.CameraMoving | MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove | MonoECS.PlayerTag.PathSwitchMove | MonoECS.PlayerTag.CharacterUltraTimeline;

	private int _inPreparePosLogicRef;

	private Dictionary<StateObjectBase, int> _processingStateObjects = new Dictionary<StateObjectBase, int>();

	private bool _inInteractObjectProcessing;

	public bool NewWorldGenModeIsEnable => true;

	public bool InGuiding => _inGuiding;

	public bool InSystemUnlock => _inSystemUnlock;

	public bool InBlackScreenTransition => _inBlackScreenTransition;

	public PlayerLiveState PlayerAlive { get; private set; }

	public GameServerState ServerState { get; private set; } = GameServerState.Disconnected;

	public GameRunningState RunningState { get; private set; }

	public BattleTeamState TeamState { get; private set; }

	public MainPlayerState MainPlayerState { get; private set; }

	public WorldState WorldState { get; private set; }

	public WorldLoadState WorldLoadState { get; private set; }

	public BattleState BattleState { get; private set; }

	public BattleFormState BattleFormState { get; private set; }

	public bool InInteractObjectProcessing
	{
		get
		{
			if (!_inInteractObjectProcessing)
			{
				return _processingStateObjects.Count > 0;
			}
			return true;
		}
	}

	public void SetInGuiding(bool inGuiding)
	{
		_inGuiding = inGuiding;
	}

	public void SetInSystemUnLock(bool inUnlock)
	{
		_inSystemUnlock = inUnlock;
	}

	public void SetBlackScreenTransitionState(bool inBlackScreenTrans)
	{
		_inBlackScreenTransition = inBlackScreenTrans;
	}

	public void SetPlayerAliveState(PlayerLiveState liveState)
	{
		if (PlayerAlive != liveState)
		{
			PlayerAlive = liveState;
		}
	}

	public bool CanEnterPlayerOperation(MonoECS.PlayerTag targetTag)
	{
		return CanEnterPlayerOperation(targetTag, (MonoECS.PlayerTag)0);
	}

	public bool CanEnterPlayerOperation(MonoECS.PlayerTag targetTag, MonoECS.PlayerTag ignoreTags)
	{
		if ((targetTag & (MonoECS.PlayerTag.Timeline | MonoECS.PlayerTag.MovingPath | MonoECS.PlayerTag.BackTrace | MonoECS.PlayerTag.CameraMoving | MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove | MonoECS.PlayerTag.PathSwitchMove | MonoECS.PlayerTag.CharacterUltraTimeline)) == 0)
		{
			return true;
		}
		if ((targetTag & (MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove)) != 0 && Singleton<ProtagonistManager>.HasInstance() && Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return false;
		}
		MonoECS.PlayerTag tags = (MonoECS.PlayerTag.Timeline | MonoECS.PlayerTag.MovingPath | MonoECS.PlayerTag.BackTrace | MonoECS.PlayerTag.CameraMoving | MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove | MonoECS.PlayerTag.PathSwitchMove | MonoECS.PlayerTag.CharacterUltraTimeline) & ~ignoreTags;
		if (PlayerAlive == PlayerLiveState.Normal)
		{
			return !MonoECS.instance.HasAnyPlayerTag(tags);
		}
		return false;
	}

	public bool CanEnterPlayerLiveState(PlayerLiveState targetState)
	{
		if (targetState == PlayerLiveState.Normal)
		{
			return true;
		}
		return !MonoECS.instance.HasAnyPlayerTag(MonoECS.PlayerTag.Timeline | MonoECS.PlayerTag.MovingPath | MonoECS.PlayerTag.BackTrace | MonoECS.PlayerTag.CameraMoving | MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove | MonoECS.PlayerTag.PathSwitchMove | MonoECS.PlayerTag.CharacterUltraTimeline);
	}

	public void SetGameServerState(GameServerState serverState)
	{
		if (ServerState != serverState)
		{
			ServerState = serverState;
		}
	}

	public void SetGameRunningState(GameRunningState runningState)
	{
		if (RunningState != runningState)
		{
			RunningState = runningState;
		}
	}

	public void SetBattleTeamState(BattleTeamState teamState)
	{
		if (TeamState != teamState)
		{
			TeamState = teamState;
		}
	}

	public void SeMainPlayerState(MainPlayerState mainPlayerState)
	{
		if (MainPlayerState != mainPlayerState)
		{
			MainPlayerState = mainPlayerState;
		}
	}

	public void SetWorldState(WorldState worldState)
	{
		if (WorldState != worldState)
		{
			WorldState = worldState;
		}
	}

	public void SetWorldLoadState(WorldLoadState worldLoadState)
	{
		if (worldLoadState == WorldLoadState.None)
		{
			WorldLoadState = WorldLoadState.None;
		}
		else
		{
			WorldLoadState |= worldLoadState;
		}
	}

	public void RemoveWorldLoadState(WorldLoadState worldLoadState)
	{
		if (worldLoadState == WorldLoadState.None)
		{
			WorldLoadState = WorldLoadState.None;
		}
		else
		{
			WorldLoadState &= ~worldLoadState;
		}
	}

	public void SetBattleState(BattleState state)
	{
		if (BattleState != state)
		{
			BattleStateChange evt = Singleton<EventManager>.instance.GetEvt<BattleStateChange>();
			evt.from = BattleState;
			evt.to = state;
			BattleState = state;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BattleStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void SetBattleFormState(BattleFormState formState)
	{
		if (BattleFormState != formState)
		{
			BattleFormStateChange evt = Singleton<EventManager>.instance.GetEvt<BattleFormStateChange>();
			evt.from = BattleFormState;
			evt.to = formState;
			BattleFormState = formState;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BattleFormStateChange, null);
		}
	}

	public override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterLeaveWorld, ResetPlayerAliveState);
		PlayerAlive = PlayerLiveState.Normal;
		ServerState = GameServerState.Disconnected;
		SetInGuiding(inGuiding: false);
		SetInSystemUnLock(inUnlock: false);
		GameControlStateMachine = new GameControlStateMachine();
	}

	public override void UnInit()
	{
		GameControlStateMachine.Reset();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterLeaveWorld, ResetPlayerAliveState);
	}

	public bool InPreparePosLogic()
	{
		return _inPreparePosLogicRef > 0;
	}

	internal void SetInPreparePosLogic(bool inPreparePosLogic)
	{
		_inPreparePosLogicRef += (inPreparePosLogic ? 1 : (-1));
	}

	public void AppendInteractTarget(StateObjectBase target)
	{
		if (_processingStateObjects.TryGetValue(target, out var value))
		{
			_processingStateObjects[target] = value + 1;
		}
		else
		{
			_processingStateObjects[target] = 1;
		}
	}

	public void RemoveInteractTarget(StateObjectBase target)
	{
		if (_processingStateObjects.TryGetValue(target, out var value))
		{
			if (value > 1)
			{
				_processingStateObjects[target] = value - 1;
			}
			else
			{
				_processingStateObjects.Remove(target);
			}
		}
	}

	internal void SetInInteractState(bool isInInteractState)
	{
		_inInteractObjectProcessing = isInInteractState;
	}

	private void ResetPlayerAliveState(BaseEventContent evt)
	{
		SetPlayerAliveState(PlayerLiveState.Normal);
	}
}

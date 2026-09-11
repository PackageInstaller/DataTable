using System.Collections.Generic;

internal class CommandRouterPlayerState
{
	internal enum PlayerRouterState
	{
		Dropped,
		ScheduledForDrop,
		SynchronizingDrop,
		Observing,
		Active
	}

	internal readonly List<NetworkPlayerID> DropConfirmedByPlayers = new List<NetworkPlayerID>(6);

	internal bool CanReceiveCommands
	{
		get
		{
			if (PlayerState != PlayerRouterState.Active)
			{
				return PlayerState == PlayerRouterState.Observing;
			}
			return true;
		}
	}

	internal SimFrameNumber DroppedSimFrame { get; private set; }

	internal SimFrameNumber LastCommandsReceivedOnFrame { get; set; }

	internal NetworkPlayerID PlayerID { get; private set; }

	internal PlayerRouterState PlayerState { get; set; }

	internal CommandRouterPlayerState(NetworkPlayerID playerID)
	{
		PlayerID = playerID;
		PlayerState = PlayerRouterState.Active;
		LastCommandsReceivedOnFrame = SimFrameNumber.Zero;
		DroppedSimFrame = SimFrameNumber.MaximumValue;
	}

	internal bool AddPlayerDropConfirmation(NetworkPlayerID fromPlayerID, SimFrameNumber droppedSimFrame)
	{
		if (PlayerState != PlayerRouterState.Dropped)
		{
			PlayerState = PlayerRouterState.SynchronizingDrop;
			if (droppedSimFrame == DroppedSimFrame)
			{
				if (!DropConfirmedByPlayers.Contains(fromPlayerID))
				{
					DropConfirmedByPlayers.Add(fromPlayerID);
				}
			}
			else
			{
				if (droppedSimFrame < DroppedSimFrame)
				{
					bool flag = DroppedSimFrame == SimFrameNumber.MaximumValue;
					DroppedSimFrame = droppedSimFrame;
					DropConfirmedByPlayers.Clear();
					DropConfirmedByPlayers.Add(fromPlayerID);
					return true;
				}
				bool flag2 = droppedSimFrame > DroppedSimFrame;
			}
		}
		return false;
	}

	internal bool HaveAllPlayersConfirmedDrop(IEnumerable<CommandRouterPlayerState> playerStates)
	{
		bool result = true;
		foreach (CommandRouterPlayerState playerState in playerStates)
		{
			if (!(playerState.PlayerID == PlayerID) && playerState.CanReceiveCommands && !DropConfirmedByPlayers.Contains(playerState.PlayerID))
			{
				result = false;
			}
		}
		return result;
	}
}

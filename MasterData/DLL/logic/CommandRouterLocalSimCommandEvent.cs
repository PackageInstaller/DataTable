internal class CommandRouterLocalSimCommandEvent : CommandRouterNetworkEventBase
{
	internal Command Command { get; set; }

	internal SimFrameNumber ForFrame { get; private set; }

	internal NetworkPlayerID PlayerID { get; private set; }

	internal override EventType UniqueType => EventType.LocalSimCommand;

	internal CommandRouterLocalSimCommandEvent(NetworkPlayerID playerID, Command command, SimFrameNumber forFrame)
	{
		PlayerID = playerID;
		Command = command;
		ForFrame = forFrame;
	}
}

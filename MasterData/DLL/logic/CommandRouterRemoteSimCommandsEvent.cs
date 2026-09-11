internal class CommandRouterRemoteSimCommandsEvent : CommandRouterNetworkEventBase
{
	internal Command[] Commands { get; private set; }

	internal SimFrameNumber ForFrame { get; private set; }

	internal NetworkPlayerID PlayerID { get; private set; }

	internal override EventType UniqueType => EventType.RemoteSimCommands;

	internal CommandRouterRemoteSimCommandsEvent(NetworkPlayerID playerID, Command[] commands, SimFrameNumber forFrame)
	{
		PlayerID = playerID;
		Commands = commands;
		ForFrame = forFrame;
	}
}

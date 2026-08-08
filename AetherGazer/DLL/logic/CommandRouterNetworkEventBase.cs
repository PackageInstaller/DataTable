internal abstract class CommandRouterNetworkEventBase
{
	internal enum EventType
	{
		LocalSimCommand,
		RemoteSimCommands,
		CheckSum,
		PlayerLeave
	}

	internal abstract EventType UniqueType { get; }
}

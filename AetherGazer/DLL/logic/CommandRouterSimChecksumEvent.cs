internal class CommandRouterSimChecksumEvent : CommandRouterNetworkEventBase
{
	internal Checksum Checksum;

	internal SimFrameNumber ForFrame;

	internal NetworkPlayerID PlayerID { get; private set; }

	internal override EventType UniqueType => EventType.CheckSum;

	internal CommandRouterSimChecksumEvent(NetworkPlayerID playerID, Checksum checksum, SimFrameNumber forFrame)
	{
		PlayerID = playerID;
		Checksum = checksum;
		ForFrame = forFrame;
	}
}

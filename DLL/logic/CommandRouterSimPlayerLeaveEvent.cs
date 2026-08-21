internal class CommandRouterSimPlayerLeaveEvent : CommandRouterNetworkEventBase
{
	internal SimFrameNumber DroppedForFrame { get; private set; }

	internal NetworkPlayerID DroppedPlayerID { get; private set; }

	internal NetworkPlayerID OriginPlayerID { get; private set; }

	internal override EventType UniqueType => EventType.PlayerLeave;

	internal CommandRouterSimPlayerLeaveEvent(NetworkPlayerID originPlayerID, NetworkPlayerID droppedPlayerID, SimFrameNumber forFrame)
	{
		OriginPlayerID = originPlayerID;
		DroppedPlayerID = droppedPlayerID;
		DroppedForFrame = forFrame;
	}
}

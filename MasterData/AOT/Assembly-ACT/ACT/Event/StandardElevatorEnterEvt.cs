using System.Collections.Generic;
using ACT.World.Asset;
using ACT.World.StateObject;

namespace ACT.Event;

public class StandardElevatorEnterEvt : BaseEventContent
{
	public bool isEnter;

	public StandardElevatorData data;

	public List<InteractEntry> entries;

	public override void ReleaseEvt()
	{
		isEnter = false;
		data = null;
		entries = null;
		base.ReleaseEvt();
	}
}

using System.Collections.Generic;

namespace ACT.Event;

public class HudPropPickTextLibrary : BaseEventContent
{
	public List<int> unlockTextId;

	public bool isFromAvg;

	public override void ReleaseEvt()
	{
		unlockTextId = null;
		isFromAvg = false;
	}
}

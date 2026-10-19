using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.Event;

public class SyncSystemPropertiesToBattle : BaseEventContent
{
	public Character traget;

	public Dictionary<int, float> properties;

	public bool isRemove;

	public int propertySourceUid;

	public override void ReleaseEvt()
	{
		traget = null;
		isRemove = false;
		propertySourceUid = 0;
		properties = null;
	}
}

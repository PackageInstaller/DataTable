using System.Collections.Generic;
using ACT.Game.Data;
using Pb;

namespace ACT.Game;

public struct ItemCheck
{
	public List<Item> itemList;

	public void ApplyOn(TriggerInteractEventReq triggerInteractEvent)
	{
		if (itemList != null)
		{
			triggerInteractEvent.Items.AddRange(itemList);
		}
	}
}

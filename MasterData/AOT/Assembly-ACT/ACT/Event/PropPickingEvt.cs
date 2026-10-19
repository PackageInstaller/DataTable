using System.Collections.Generic;
using ACT.UI;

namespace ACT.Event;

public class PropPickingEvt : BaseEventContent
{
	public PropPickingWay way;

	public List<ItemAchieveinfo> itemList;
}

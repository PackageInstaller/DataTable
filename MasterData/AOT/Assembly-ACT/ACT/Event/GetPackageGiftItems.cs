using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.Event;

public class GetPackageGiftItems : BaseEventContent
{
	public List<Item> getItems;
}

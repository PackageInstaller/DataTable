using System.Collections.Generic;
using ACT.UI.DataProxy;

namespace ACT.Event;

public class ItemChangeEvt : BaseEventContent
{
	public List<ItemUnifierProxy> ItemProxies { get; set; }
}

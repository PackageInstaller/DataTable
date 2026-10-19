using ACT.Game.Data;
using ACT.UI.DataProxy;

namespace ACT.Event;

public class ItemUnifierProxyEvt : BaseEventContent
{
	public ItemUnifierProxy data;

	public ItemsWays source;
}

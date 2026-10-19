using Runtime.Model;

namespace ACT.Event;

public class RogueRemoveItemEvent : BaseEventContent
{
	public RogueBagItemData RogueBagItem;
}

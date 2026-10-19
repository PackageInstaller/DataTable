using Runtime.Model;

namespace ACT.Event;

public class RogueAddItemEvent : BaseEventContent
{
	public RogueBagItemData RogueBagItem;
}

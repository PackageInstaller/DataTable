using ACT.Model;

namespace ACT.Event;

public class TheOtherWorldChangeEvent : BaseEventContent
{
	public TheOtherWorldModel.TheOtherWorldStatus before;

	public TheOtherWorldModel.TheOtherWorldStatus after;
}

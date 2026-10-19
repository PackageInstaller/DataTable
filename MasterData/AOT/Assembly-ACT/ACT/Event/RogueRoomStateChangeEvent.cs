using Runtime.Model;

namespace ACT.Event;

public class RogueRoomStateChangeEvent : BaseEventContent
{
	public RogueNewModel.RogueRoomState nextState;
}

using Unity.VisualScripting.Community;

namespace ACT.BluePrint;

public class BPGlobalEvent : IDefinedEvent
{
	public int eventID;

	public BPGlobalEvent()
	{
	}

	public BPGlobalEvent(int id)
	{
		eventID = id;
	}
}

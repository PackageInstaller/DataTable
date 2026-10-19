using Unity.VisualScripting.Community;

namespace ACT.BluePrint;

public class BPGlobalStringEvent : IDefinedEvent
{
	public string eventID;

	public BPGlobalStringEvent()
	{
	}

	public BPGlobalStringEvent(string id)
	{
		eventID = id;
	}
}

namespace ACT.Event;

public class LocalStateWorldEvent : BaseEventContent
{
	public ClientEvent eventType;

	public int sourceSwid;

	public int sourceId;

	public VarName eventName;

	public int stateId;
}

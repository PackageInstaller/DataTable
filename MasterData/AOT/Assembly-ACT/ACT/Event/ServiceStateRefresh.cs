namespace ACT.Event;

public class ServiceStateRefresh : BaseEventContent
{
	public int swid;

	public int oldStateId;

	public int stateId;

	public int behaveId;

	public int cleanedTs;
}

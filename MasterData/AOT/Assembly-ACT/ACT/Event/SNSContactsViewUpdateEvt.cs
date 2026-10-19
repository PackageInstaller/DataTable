namespace ACT.Event;

public class SNSContactsViewUpdateEvt : BaseEventContent
{
	public int sessionId;

	public bool needReset;
}

using System.Collections.Generic;

namespace ACT.Event;

public class SNSContinueSessionEvt : BaseEventContent
{
	public int sessionId;

	public List<long> messageIds;

	public bool waitChoice;

	public long choiceMessageId;

	public bool finish;

	public bool needReset;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		sessionId = 0;
		messageIds = null;
		waitChoice = false;
		choiceMessageId = 0L;
		finish = false;
	}
}

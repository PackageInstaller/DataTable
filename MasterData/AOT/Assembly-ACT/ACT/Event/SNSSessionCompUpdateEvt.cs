using ACT.Model;

namespace ACT.Event;

public class SNSSessionCompUpdateEvt : BaseEventContent
{
	public SNSModel.MessageType messageType;

	public int sessionId;

	public long messageId;

	public int rewardId;

	public int rewardCount;
}

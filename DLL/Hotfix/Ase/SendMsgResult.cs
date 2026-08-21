namespace Ase;

public class SendMsgResult
{
	public string msg;

	public int emojiId;

	public bool sendSuccess;

	public long nextCanSendTime;

	public SendMsgResult(string msg, int emojiId, bool sendSuccess, long nextCanSendTime)
	{
		this.msg = msg;
		this.emojiId = emojiId;
		this.sendSuccess = sendSuccess;
		this.nextCanSendTime = nextCanSendTime;
	}
}

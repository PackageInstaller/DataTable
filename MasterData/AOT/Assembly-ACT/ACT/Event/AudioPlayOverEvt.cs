namespace ACT.Event;

public class AudioPlayOverEvt : BaseEventContent
{
	public uint AudioInstanceId;

	public override void ReleaseEvt()
	{
		AudioInstanceId = 0u;
	}
}

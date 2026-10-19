namespace ACT.Event;

public class ShowFps : BaseEventContent
{
	public bool show;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		show = false;
	}
}

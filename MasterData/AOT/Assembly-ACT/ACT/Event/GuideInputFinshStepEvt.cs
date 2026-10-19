namespace ACT.Event;

public class GuideInputFinshStepEvt : BaseEventContent
{
	public string InputActionPath;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		InputActionPath = "";
	}
}

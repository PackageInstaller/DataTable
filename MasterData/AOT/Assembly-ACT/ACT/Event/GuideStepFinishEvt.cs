using ACT.Model;

namespace ACT.Event;

public class GuideStepFinishEvt : BaseEventContent
{
	public int stepId;

	public GuideConsts.GuideType type;

	public bool Iserror;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		type = GuideConsts.GuideType.None;
		stepId = 0;
		Iserror = false;
	}
}

using ACT.Battle;

namespace ACT.Event;

public class TriggerEventEntry : BaseEventContent
{
	public TriggerType triggerType;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		triggerType = (TriggerType)0;
	}
}

using ACT.Game.Data;

namespace ACT.Event;

public class SystemBlockStatusChangedEvt : BaseEventContent
{
	public SystemStatus status;

	public override void ReleaseEvt()
	{
		status = null;
		base.ReleaseEvt();
	}
}

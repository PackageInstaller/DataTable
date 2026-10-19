using ACT.UI;

namespace ACT.Event;

public class UpdateCustomUISchemeEvt : BaseEventContent
{
	public CustomUIScheme scheme;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		scheme = null;
	}
}

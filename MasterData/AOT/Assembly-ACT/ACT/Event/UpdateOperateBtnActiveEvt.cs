using ACT.UI;

namespace ACT.Event;

public class UpdateOperateBtnActiveEvt : BaseEventContent
{
	public CustomUICompType customUICompType;

	public bool active;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		customUICompType = CustomUICompType.None;
		active = false;
	}
}

using ACT.Event;

namespace ACT.UI;

public class JoyStickEffectBtnEvt : BaseEventContent
{
	public bool active;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		active = false;
	}
}

using ACT.Model;
using ACT.UI;

namespace ACT.Event;

public class OnHudForceClose : BaseEventContent
{
	public HudComponentType type;

	public UIPosition position;
}

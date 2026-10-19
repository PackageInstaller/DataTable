using ACT.UI;

namespace ACT.Event;

public class UIEvent : BaseEventContent
{
	public UI_TYPE UIType;

	public uint Uid;

	public override void OnGet()
	{
		UIType = UI_TYPE.UI_NONE;
		Uid = 0u;
	}
}

using ACT.Game.Data;

namespace ACT.Event;

public class RefreshCustomUI : BaseEventContent
{
	public bool replaceBagActive;

	public Weapon weapon;

	public bool playOpenAni;
}

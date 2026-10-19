using ACT.Game.Data;

namespace ACT.Event;

public class WeaponModifyEvt : BaseEventContent
{
	public Character c;

	public Weapon w;
}

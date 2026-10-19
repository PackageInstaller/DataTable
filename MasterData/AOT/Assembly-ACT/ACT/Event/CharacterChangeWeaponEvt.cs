using ACT.Game.Data;

namespace ACT.Event;

public class CharacterChangeWeaponEvt : BaseEventContent
{
	public Character c;

	public Weapon w1;

	public Weapon w2;
}

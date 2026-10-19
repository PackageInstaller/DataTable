using ACT.Game.Data;

namespace ACT.Event;

public class CharacterChangeEquipEvt : BaseEventContent
{
	public Character character;

	public Equip removeEquip;

	public Equip addEquip;

	public override void ReleaseEvt()
	{
		character = null;
		removeEquip = null;
		addEquip = null;
	}
}

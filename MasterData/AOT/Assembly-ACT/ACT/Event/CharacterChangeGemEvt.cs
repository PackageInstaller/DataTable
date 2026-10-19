using ACT.Game.Data;

namespace ACT.Event;

public class CharacterChangeGemEvt : BaseEventContent
{
	public Character character;

	public Gem removeGem;

	public Gem addGem;

	public Equip Equip { get; set; }

	public override void ReleaseEvt()
	{
		character = null;
		Equip = null;
		removeGem = null;
		addGem = null;
	}
}

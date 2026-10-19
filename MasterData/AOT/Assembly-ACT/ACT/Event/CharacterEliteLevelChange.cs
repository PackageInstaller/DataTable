using ACT.Game.Data;

namespace ACT.Event;

public class CharacterEliteLevelChange : BaseEventContent
{
	public Character character;

	public int beforeLevel;

	public int afterLevel;
}

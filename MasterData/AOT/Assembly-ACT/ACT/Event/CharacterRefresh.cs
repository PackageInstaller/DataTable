using ACT.Game.Data;

namespace ACT.Event;

public class CharacterRefresh : BaseEventContent
{
	public int sceneIndex;

	public Character character;
}

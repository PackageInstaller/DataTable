using ACT.Game.Data;

namespace ACT.Event;

public class CharacterChangeEvt : BaseEventContent
{
	public Character c;

	public int curPageIndex;
}

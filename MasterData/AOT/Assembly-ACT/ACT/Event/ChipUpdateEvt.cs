using ACT.Game.Data;

namespace ACT.Event;

public class ChipUpdateEvt : BaseEventContent
{
	public int characterId;

	public Chip chip;
}

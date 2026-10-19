using ACT.Game.Data;
using Bamboo.Collections;

namespace ACT.Event;

public class CharacterChangeChipEvt : BaseEventContent
{
	public Character c;

	public int removeChip;

	public int addChip;

	public BSet<int> lastChip;

	public override void ReleaseEvt()
	{
		c = null;
		removeChip = 0;
		addChip = 0;
		lastChip = null;
	}
}

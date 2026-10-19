using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.EventTrack;

public class ChipLevelUp : ChipEvt<ChipGetEvt>
{
	public int levelAfter;

	public int expAfter;

	public int expBefore;

	public List<Item> costItem;
}

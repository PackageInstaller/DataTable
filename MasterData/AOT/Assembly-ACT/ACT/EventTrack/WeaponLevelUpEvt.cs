using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.EventTrack;

public class WeaponLevelUpEvt : WeaponEvt<WeaponLevelUpEvt>
{
	public int levelBefore;

	public List<Item> costItems;
}

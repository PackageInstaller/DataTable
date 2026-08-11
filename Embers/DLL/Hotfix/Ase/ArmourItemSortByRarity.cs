using System.Collections.Generic;

namespace Ase;

public class ArmourItemSortByRarity : Comparer<ArmourItemData>
{
	public override int Compare(ArmourItemData x, ArmourItemData y)
	{
		return ArmourFilterDataUtil.CompareArmourItems(x, y, KnapsackDefinition.WarehouseScreenType.Rarity, compareScreenResult: false);
	}
}

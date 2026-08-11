using System.Collections.Generic;

namespace Ase;

public class ArmourItemSortByLevel : Comparer<ArmourItemData>
{
	public override int Compare(ArmourItemData x, ArmourItemData y)
	{
		return ArmourFilterDataUtil.CompareArmourItems(x, y, KnapsackDefinition.WarehouseScreenType.Level, compareScreenResult: false);
	}
}

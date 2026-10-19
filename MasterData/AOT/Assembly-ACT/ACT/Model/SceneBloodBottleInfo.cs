using System.Collections.Generic;

namespace ACT.Model;

public struct SceneBloodBottleInfo(Dictionary<int, BloodBottleData> allBottles)
{
	public Dictionary<int, BloodBottleData> _allBottles = allBottles;
}

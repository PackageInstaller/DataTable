using System.Collections.Generic;
using UnityEngine;

namespace ACT.World.Asset;

public abstract class BakeSystem
{
	public abstract IEnumerable<IDataBaker> CollectBakers(GameObject parent);
}

using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ACT.World.Asset;

public class MonoBakeSystem<TMonoBaker> : BakeSystem where TMonoBaker : MonoDataBaker, new()
{
	public sealed override IEnumerable<IDataBaker> CollectBakers(GameObject parent)
	{
		return CollectMonoBakers(parent).Select((TMonoBaker x) =>
		{
			x.Baker.baker = x;
			return x.Baker;
		});
	}

	public IEnumerable<TMonoBaker> CollectMonoBakers(GameObject parent)
	{
		return from x in parent.GetComponentsInChildren<TMonoBaker>(includeInactive: true)
			where x.BakeSystemVisibility
			select x;
	}
}

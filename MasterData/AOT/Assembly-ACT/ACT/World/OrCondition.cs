using System.Linq;
using UnityEngine;

namespace ACT.World;

public class OrCondition : ILoadCondition
{
	[SerializeReference]
	public ILoadCondition[] conditions;

	public bool Return()
	{
		return conditions.Aggregate(seed: false, (bool current, ILoadCondition condition) => current | condition.Return());
	}
}

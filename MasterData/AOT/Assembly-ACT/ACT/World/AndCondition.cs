using System.Linq;
using UnityEngine;

namespace ACT.World;

public class AndCondition : ILoadCondition
{
	[SerializeReference]
	public ILoadCondition[] conditions;

	public bool Return()
	{
		return conditions.Aggregate(seed: true, (bool current, ILoadCondition condition) => current & condition.Return());
	}
}

using UnityEngine;

namespace ACT.World;

public class NonCondition : ILoadCondition
{
	[SerializeReference]
	public ILoadCondition condition;

	public bool Return()
	{
		return !condition.Return();
	}
}

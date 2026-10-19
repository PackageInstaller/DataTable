using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ActionOverrideRootTransformOffset : ConfigAction
{
	public bool reset;

	public Vector3 rootTransformOffset;

	public override void Do(ActionMemory memory)
	{
		CompPhysics compPhysics = memory.owner.GetCompPhysics();
		if (compPhysics != null)
		{
			Vector3 vector = (reset ? Vector3.zero : rootTransformOffset);
			compPhysics.SetRootTransformOffset(vector);
		}
	}
}

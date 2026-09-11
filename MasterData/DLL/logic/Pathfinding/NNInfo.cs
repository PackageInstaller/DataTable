using System;
using UnityEngine;

namespace Pathfinding;

public struct NNInfo
{
	public readonly GraphNode node;

	public readonly Int3 position;

	[Obsolete("This field has been renamed to 'position'")]
	public Int3 clampedPosition => position;

	public NNInfo(NNInfoInternal internalInfo)
	{
		node = internalInfo.node;
		position = internalInfo.clampedPosition;
	}

	public static explicit operator Vector3(NNInfo ob)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return (Vector3)ob.position;
	}

	public static explicit operator GraphNode(NNInfo ob)
	{
		return ob.node;
	}
}

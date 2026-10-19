using UnityEngine;

namespace PathFinding2D.Runtime.Models;

public static class NavigationLinkTypeUtility
{
	public const float SameHeightThreshold = 0.1f;

	public static NavigationLinkType Resolve(NavigationLinkType serialized, Vector3 from, Vector3 to)
	{
		if (serialized != NavigationLinkType.Walk)
		{
			return serialized;
		}
		float num = to.y - from.y;
		if (num > 0.1f)
		{
			return NavigationLinkType.Jump;
		}
		if (num < -0.1f)
		{
			return NavigationLinkType.Drop;
		}
		return NavigationLinkType.Walk;
	}

	public static bool CanTraverse(NavigationMoveCapability capability, NavigationLinkType linkType)
	{
		if (linkType == NavigationLinkType.Jump)
		{
			return capability == NavigationMoveCapability.WalkJumpAndDrop;
		}
		return true;
	}
}

using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Support.DefinedEventSupport")]
internal static class DefinedEventSupport
{
	internal static bool IsOptimized()
	{
		if (Application.isEditor && !CommunityOptionFetcher.DefinedEvent_ForceOptimizedInEditor)
		{
			return false;
		}
		return true;
	}
}

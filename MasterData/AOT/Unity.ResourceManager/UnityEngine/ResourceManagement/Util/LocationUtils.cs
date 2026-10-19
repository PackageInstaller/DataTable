using System.Collections.Generic;
using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.Util;

internal static class LocationUtils
{
	public static bool LocationEquals(IResourceLocation loc1, IResourceLocation loc2)
	{
		if (loc1 == loc2)
		{
			return true;
		}
		if (loc1 == null)
		{
			return false;
		}
		if (loc2 == null)
		{
			return false;
		}
		if (loc1.InternalId.Equals(loc2.InternalId) && loc1.ProviderId.Equals(loc2.ProviderId))
		{
			return loc1.ResourceType.Equals(loc2.ResourceType);
		}
		return false;
	}

	public static bool DependenciesEqual(IList<IResourceLocation> deps1, IList<IResourceLocation> deps2)
	{
		if (deps1 == deps2)
		{
			return true;
		}
		if (deps1 == null)
		{
			return false;
		}
		if (deps2 == null)
		{
			return false;
		}
		if (deps1.Count != deps2.Count)
		{
			return false;
		}
		for (int i = 0; i < deps1.Count; i++)
		{
			if (!LocationEquals(deps1[i], deps2[i]))
			{
				return false;
			}
		}
		return true;
	}
}

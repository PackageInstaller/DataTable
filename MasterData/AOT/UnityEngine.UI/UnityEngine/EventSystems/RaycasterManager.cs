using System.Collections.Generic;

namespace UnityEngine.EventSystems;

public static class RaycasterManager
{
	private static readonly List<BaseRaycaster> s_Raycasters = new List<BaseRaycaster>();

	internal static void AddRaycaster(BaseRaycaster baseRaycaster)
	{
		if (!s_Raycasters.Contains(baseRaycaster))
		{
			s_Raycasters.Add(baseRaycaster);
		}
	}

	public static List<BaseRaycaster> GetRaycasters()
	{
		return s_Raycasters;
	}

	internal static void RemoveRaycasters(BaseRaycaster baseRaycaster)
	{
		if (s_Raycasters.Contains(baseRaycaster))
		{
			s_Raycasters.Remove(baseRaycaster);
		}
	}
}

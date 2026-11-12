using UnityEngine;
using XLua;

public static class DormModuleHelper
{
	public static void SetHudFollowTarget(GameObject go, Transform tr, Vector3 offset)
	{
		HUDFollowTarget_Dorm component = go.GetComponent<HUDFollowTarget_Dorm>();
		if (component != null)
		{
			component.SetFollowTarget(tr, offset);
		}
	}

	public static void UnsetHudFollowTarget(GameObject go)
	{
		HUDFollowTarget_Dorm component = go.GetComponent<HUDFollowTarget_Dorm>();
		if (component != null)
		{
			component.SetFollowTarget(null, Vector3.zero);
		}
	}

	public static void EnableUpdateHudPos(GameObject go, bool bVisible, bool bEnableUpdateHudPos)
	{
		HUDFollowTarget_Dorm component = go.GetComponent<HUDFollowTarget_Dorm>();
		if (component != null)
		{
			component.EnableUpdateHudPos(bVisible, bEnableUpdateHudPos);
		}
	}

	public static void SetDormData(LuaTable data)
	{
		MonoSingleton<GameController>.Instance.dynamicModuleParams = data;
	}

	public static int[] GetDormData()
	{
		int[] result = MonoSingleton<GameController>.Instance.dynamicModuleParams as int[];
		MonoSingleton<GameController>.Instance.dynamicModuleParams = null;
		return result;
	}
}

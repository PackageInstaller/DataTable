#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_LOG
using System;
using UnityEngine;

namespace GameFramework.Runtime;

public static class Helper
{
	public static T CreateHelper<T>(string helperTypeName, T customHelper) where T : MonoBehaviour
	{
		return CreateHelper(helperTypeName, customHelper, 0);
	}

	public static T CreateHelper<T>(string helperTypeName, T customHelper, int index) where T : MonoBehaviour
	{
		T val = null;
		if (!string.IsNullOrEmpty(helperTypeName))
		{
			Type type = Utility.Assembly.GetType(helperTypeName);
			if (type == null)
			{
				Log.Warning("Can not find helper type '{0}'.", helperTypeName);
				return null;
			}
			if (!typeof(T).IsAssignableFrom(type))
			{
				Log.Warning("Type '{0}' is not assignable from '{1}'.", typeof(T).FullName, type.FullName);
				return null;
			}
			val = (T)new GameObject().AddComponent(type);
		}
		else
		{
			if (customHelper == null)
			{
				Log.Warning("You must set custom helper with '{0}' type first.", typeof(T).FullName);
				return null;
			}
			val = ((!customHelper.gameObject.InScene()) ? UnityEngine.Object.Instantiate(customHelper) : ((index > 0) ? UnityEngine.Object.Instantiate(customHelper) : customHelper));
		}
		return val;
	}
}

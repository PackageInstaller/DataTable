using UnityEngine;

namespace Unity.VisualScripting;

public static class UnityObjectOwnershipUtility
{
	public static void CopyOwner(object source, object destination)
	{
		if (destination is IUnityObjectOwnable unityObjectOwnable)
		{
			unityObjectOwnable.owner = GetOwner(source);
		}
	}

	public static void RemoveOwner(object o)
	{
		if (o is IUnityObjectOwnable unityObjectOwnable)
		{
			unityObjectOwnable.owner = null;
		}
	}

	public static Object GetOwner(object o)
	{
		object obj = (o as Component)?.gameObject;
		if (obj == null)
		{
			IUnityObjectOwnable obj2 = o as IUnityObjectOwnable;
			if (obj2 == null)
			{
				return null;
			}
			obj = obj2.owner;
		}
		return (Object)obj;
	}
}

using System;

namespace UnityEngine.Rendering;

public static class DelegateUtility
{
	public static Delegate Cast(Delegate source, Type type)
	{
		if ((object)source == null)
		{
			return null;
		}
		Delegate[] invocationList = source.GetInvocationList();
		if (invocationList.Length == 1)
		{
			return Delegate.CreateDelegate(type, invocationList[0].Target, invocationList[0].Method);
		}
		Delegate[] array = new Delegate[invocationList.Length];
		for (int i = 0; i < invocationList.Length; i++)
		{
			array[i] = Delegate.CreateDelegate(type, invocationList[i].Target, invocationList[i].Method);
		}
		return Delegate.Combine(array);
	}
}

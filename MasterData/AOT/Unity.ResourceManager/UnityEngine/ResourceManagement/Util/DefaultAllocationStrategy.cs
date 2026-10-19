using System;

namespace UnityEngine.ResourceManagement.Util;

public class DefaultAllocationStrategy : IAllocationStrategy
{
	public object New(Type type, int typeHash)
	{
		return Activator.CreateInstance(type);
	}

	public void Release(int typeHash, object obj)
	{
	}
}

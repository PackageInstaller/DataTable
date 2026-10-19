using System;

namespace UnityEngine.ResourceManagement.Util;

public interface IAllocationStrategy
{
	object New(Type type, int typeHash);

	void Release(int typeHash, object obj);
}

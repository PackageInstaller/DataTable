using UnityEngine;

namespace Ase;

public static class CustomTransformExtension
{
	public static CustomTransform ToCustomTransform(Transform tran)
	{
		return new CustomTransform(tran);
	}

	public static void SetCustomTransform(Transform tran, CustomTransform ct)
	{
		ct.SetValueToTransform(tran);
	}
}

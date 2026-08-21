using UnityEngine;

namespace Cinemachine.Utility;

internal class GaussianWindow1D_Quaternion : GaussianWindow1d<Quaternion>
{
	public GaussianWindow1D_Quaternion(float sigma, int maxKernelRadius = 10)
		: base(sigma, maxKernelRadius)
	{
	}

	protected override Quaternion Compute(int windowPos)
	{
		Quaternion q = new Quaternion(0f, 0f, 0f, 0f);
		Quaternion quaternion = mData[mCurrentPos];
		Quaternion quaternion2 = Quaternion.Inverse(quaternion);
		for (int i = 0; i < base.KernelSize; i++)
		{
			float num = mKernel[i];
			Quaternion b = quaternion2 * mData[windowPos];
			if (Quaternion.Dot(Quaternion.identity, b) < 0f)
			{
				num = 0f - num;
			}
			q.x += b.x * num;
			q.y += b.y * num;
			q.z += b.z * num;
			q.w += b.w * num;
			if (++windowPos == base.KernelSize)
			{
				windowPos = 0;
			}
		}
		return quaternion * Quaternion.Normalize(q);
	}
}

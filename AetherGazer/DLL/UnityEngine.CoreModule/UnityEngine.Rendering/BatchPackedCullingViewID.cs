using System;

namespace UnityEngine.Rendering;

public struct BatchPackedCullingViewID : IEquatable<BatchPackedCullingViewID>
{
	internal ulong handle;

	public override int GetHashCode()
	{
		return handle.GetHashCode();
	}

	public bool Equals(BatchPackedCullingViewID other)
	{
		return handle == other.handle;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is BatchPackedCullingViewID))
		{
			return false;
		}
		return Equals((BatchPackedCullingViewID)obj);
	}
}

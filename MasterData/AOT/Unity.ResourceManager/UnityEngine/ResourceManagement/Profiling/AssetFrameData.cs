using System;

namespace UnityEngine.ResourceManagement.Profiling;

internal struct AssetFrameData
{
	public int AssetCode;

	public int BundleCode;

	public int ReferenceCount;

	public float PercentComplete;

	public ContentStatus Status;

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is AssetFrameData assetFrameData)
		{
			if (AssetCode == assetFrameData.AssetCode)
			{
				return BundleCode == assetFrameData.BundleCode;
			}
			return false;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(AssetCode.GetHashCode(), BundleCode.GetHashCode(), ReferenceCount.GetHashCode(), PercentComplete.GetHashCode(), Status.GetHashCode());
	}
}

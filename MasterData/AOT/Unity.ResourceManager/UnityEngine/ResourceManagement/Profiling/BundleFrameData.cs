using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.Profiling;

internal struct BundleFrameData
{
	public int BundleCode;

	public int ReferenceCount;

	public float PercentComplete;

	public ContentStatus Status;

	public BundleSource Source;

	public BundleOptions LoadingOptions;
}

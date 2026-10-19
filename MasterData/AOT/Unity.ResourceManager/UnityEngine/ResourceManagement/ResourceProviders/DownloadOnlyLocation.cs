using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.ResourceProviders;

internal class DownloadOnlyLocation : LocationWrapper
{
	public DownloadOnlyLocation(IResourceLocation location)
		: base(location)
	{
	}
}

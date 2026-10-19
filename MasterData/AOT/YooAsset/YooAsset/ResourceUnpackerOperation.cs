using System.Collections.Generic;

namespace YooAsset;

public sealed class ResourceUnpackerOperation : DownloaderOperation
{
	internal ResourceUnpackerOperation(string packageName, List<BundleInfo> downloadList, int downloadingMaxNumber, int failedTryAgain, int timeout)
		: base(packageName, downloadList, downloadingMaxNumber, failedTryAgain, timeout)
	{
	}

	internal static ResourceUnpackerOperation CreateEmptyUnpacker(string packageName, int upackingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadList = new List<BundleInfo>();
		return new ResourceUnpackerOperation(packageName, downloadList, upackingMaxNumber, failedTryAgain, int.MaxValue);
	}
}

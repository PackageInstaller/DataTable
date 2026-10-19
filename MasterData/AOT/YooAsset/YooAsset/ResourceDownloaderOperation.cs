using System.Collections.Generic;

namespace YooAsset;

public sealed class ResourceDownloaderOperation : DownloaderOperation
{
	internal ResourceDownloaderOperation(string packageName, List<BundleInfo> downloadList, int downloadingMaxNumber, int failedTryAgain, int timeout)
		: base(packageName, downloadList, downloadingMaxNumber, failedTryAgain, timeout)
	{
	}

	internal static ResourceDownloaderOperation CreateEmptyDownloader(string packageName, int downloadingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadList = new List<BundleInfo>();
		return new ResourceDownloaderOperation(packageName, downloadList, downloadingMaxNumber, failedTryAgain, timeout);
	}
}

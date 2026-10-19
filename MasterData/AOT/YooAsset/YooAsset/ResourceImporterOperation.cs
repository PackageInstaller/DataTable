using System.Collections.Generic;

namespace YooAsset;

public sealed class ResourceImporterOperation : DownloaderOperation
{
	internal ResourceImporterOperation(string packageName, List<BundleInfo> downloadList, int downloadingMaxNumber, int failedTryAgain, int timeout)
		: base(packageName, downloadList, downloadingMaxNumber, failedTryAgain, timeout)
	{
	}

	internal static ResourceImporterOperation CreateEmptyImporter(string packageName, int upackingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadList = new List<BundleInfo>();
		return new ResourceImporterOperation(packageName, downloadList, upackingMaxNumber, failedTryAgain, int.MaxValue);
	}
}

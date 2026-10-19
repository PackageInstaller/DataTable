using System.Collections.Generic;
using YooAsset;

namespace ACT;

internal class DownloadAssetContext
{
	internal YooAssetInitData InitData { get; set; }

	internal DownloadData DownloadData => InitData.DownloadData;

	internal ZipDownloadParam ZipDownloadParam => InitData.ZipDownloadParam;

	internal Dictionary<AssetType, PackageInfo> PackageInfos => InitData.PackageInfos;

	internal EPlayMode PlayMode => InitData.YooAssetParam.PlayMode;

	internal bool HasZipPackages { get; set; }

	internal bool HasAppliedPreDownloadedPackages { get; set; }

	internal long ZipTotalBytes { get; set; }

	internal long DownloadedZipBytes { get; set; }

	internal Dictionary<AssetType, string> ZipDownloadDirectories { get; set; }

	internal Dictionary<AssetType, string> ExtractedDirectories { get; set; }

	internal Dictionary<AssetType, string> ZipMarkerDirectories { get; set; }

	internal Dictionary<AssetType, List<ZipPackageInfo>> ZipPackageInfos { get; set; }

	internal HashSet<string> CountedZipMarkerFiles { get; set; }

	internal void Reset()
	{
		HasZipPackages = false;
		HasAppliedPreDownloadedPackages = false;
		ZipTotalBytes = 0L;
		DownloadedZipBytes = 0L;
		ZipDownloadDirectories = null;
		ExtractedDirectories = null;
		ZipMarkerDirectories = null;
		ZipPackageInfos = null;
		CountedZipMarkerFiles = null;
	}
}

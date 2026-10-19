namespace YooAsset;

internal interface IPlayMode
{
	PackageManifest ActiveManifest { get; set; }

	void DestroyFileSystem();

	RequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks, int timeout);

	UpdatePackageManifestOperation UpdatePackageManifestAsync(string packageVersion, int timeout);

	PreDownloadContentOperation PreDownloadContentAsync(string packageVersion, int timeout);

	ClearCacheFilesOperation ClearCacheFilesAsync(ClearCacheFilesOptions options);

	ResourceDownloaderOperation CreateResourceDownloaderByAll(int downloadingMaxNumber, int failedTryAgain, int timeout);

	ResourceDownloaderOperation CreateResourceDownloaderByTags(string[] tags, int downloadingMaxNumber, int failedTryAgain, int timeout);

	ResourceDownloaderOperation CreateResourceDownloaderByDownloadTag(string downloadTag, int downloadingMaxNumber, int failedTryAgain, int timeout);

	ResourceDownloaderOperation CreateResourceDownloaderByDownloadTags(string[] downloadTags, int downloadingMaxNumber, int failedTryAgain, int timeout);

	ResourceDownloaderOperation CreateResourceDownloaderByPaths(AssetInfo[] assetInfos, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout);

	ResourceUnpackerOperation CreateResourceUnpackerByAll(int upackingMaxNumber, int failedTryAgain, int timeout);

	ResourceUnpackerOperation CreateResourceUnpackerByTags(string[] tags, int upackingMaxNumber, int failedTryAgain, int timeout);

	ResourceImporterOperation CreateResourceImporterByFilePaths(string[] filePaths, int importerMaxNumber, int failedTryAgain, int timeout);
}

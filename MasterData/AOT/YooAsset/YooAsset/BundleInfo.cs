namespace YooAsset;

internal class BundleInfo
{
	private readonly IFileSystem _fileSystem;

	private readonly string _importFilePath;

	public readonly PackageBundle Bundle;

	public BundleInfo(IFileSystem fileSystem, PackageBundle bundle)
	{
		_fileSystem = fileSystem;
		Bundle = bundle;
		_importFilePath = null;
	}

	public BundleInfo(IFileSystem fileSystem, PackageBundle bundle, string importFilePath)
	{
		_fileSystem = fileSystem;
		Bundle = bundle;
		_importFilePath = importFilePath;
	}

	public FSLoadBundleOperation LoadBundleFile()
	{
		return _fileSystem.LoadBundleFile(Bundle);
	}

	public FSDownloadFileOperation CreateDownloader(int failedTryAgain, int timeout)
	{
		DownloadFileOptions downloadFileOptions = new DownloadFileOptions(failedTryAgain, timeout);
		downloadFileOptions.ImportFilePath = _importFilePath;
		return _fileSystem.DownloadFileAsync(Bundle, downloadFileOptions);
	}

	public bool IsNeedDownloadFromRemote()
	{
		return _fileSystem.NeedDownload(Bundle);
	}

	public string GetDownloadCombineGUID()
	{
		return $"{_fileSystem.GetHashCode()}_{Bundle.BundleGUID}";
	}
}

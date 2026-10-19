using System;
using System.Collections.Generic;
using System.IO;

namespace YooAsset;

internal class PlayModeImpl : IPlayMode, IBundleQuery
{
	public readonly string PackageName;

	public readonly EPlayMode PlayMode;

	public readonly List<IFileSystem> FileSystems = new List<IFileSystem>(10);

	public PackageManifest ActiveManifest { get; set; }

	public PlayModeImpl(string packageName, EPlayMode playMode)
	{
		PackageName = packageName;
		PlayMode = playMode;
	}

	public InitializationOperation InitializeAsync(FileSystemParameters fileSystemParameter)
	{
		List<FileSystemParameters> list = new List<FileSystemParameters>();
		if (fileSystemParameter != null)
		{
			list.Add(fileSystemParameter);
		}
		return InitializeAsync(list);
	}

	public InitializationOperation InitializeAsync(FileSystemParameters fileSystemParameterA, FileSystemParameters fileSystemParameterB)
	{
		List<FileSystemParameters> list = new List<FileSystemParameters>();
		if (fileSystemParameterA != null)
		{
			list.Add(fileSystemParameterA);
		}
		if (fileSystemParameterB != null)
		{
			list.Add(fileSystemParameterB);
		}
		return InitializeAsync(list);
	}

	public InitializationOperation InitializeAsync(List<FileSystemParameters> fileSystemParameterList)
	{
		return new InitializationOperation(this, fileSystemParameterList);
	}

	void IPlayMode.DestroyFileSystem()
	{
		foreach (IFileSystem fileSystem in FileSystems)
		{
			fileSystem.OnDestroy();
		}
		FileSystems.Clear();
	}

	RequestPackageVersionOperation IPlayMode.RequestPackageVersionAsync(bool appendTimeTicks, int timeout)
	{
		return new RequestPackageVersionImplOperation(this, appendTimeTicks, timeout);
	}

	UpdatePackageManifestOperation IPlayMode.UpdatePackageManifestAsync(string packageVersion, int timeout)
	{
		return new UpdatePackageManifestOperation(this, packageVersion, timeout);
	}

	PreDownloadContentOperation IPlayMode.PreDownloadContentAsync(string packageVersion, int timeout)
	{
		return new PreDownloadContentOperation(this, packageVersion, timeout);
	}

	ClearCacheFilesOperation IPlayMode.ClearCacheFilesAsync(ClearCacheFilesOptions options)
	{
		return new ClearCacheFilesOperation(this, options);
	}

	ResourceDownloaderOperation IPlayMode.CreateResourceDownloaderByAll(int downloadingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadListByAll = GetDownloadListByAll(ActiveManifest);
		return new ResourceDownloaderOperation(PackageName, downloadListByAll, downloadingMaxNumber, failedTryAgain, timeout);
	}

	ResourceDownloaderOperation IPlayMode.CreateResourceDownloaderByTags(string[] tags, int downloadingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadListByTags = GetDownloadListByTags(ActiveManifest, tags);
		return new ResourceDownloaderOperation(PackageName, downloadListByTags, downloadingMaxNumber, failedTryAgain, timeout);
	}

	ResourceDownloaderOperation IPlayMode.CreateResourceDownloaderByDownloadTag(string downloadTag, int downloadingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadListByDownloadTag = GetDownloadListByDownloadTag(ActiveManifest, downloadTag);
		return new ResourceDownloaderOperation(PackageName, downloadListByDownloadTag, downloadingMaxNumber, failedTryAgain, timeout);
	}

	ResourceDownloaderOperation IPlayMode.CreateResourceDownloaderByDownloadTags(string[] downloadTags, int downloadingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadListByDownloadTags = GetDownloadListByDownloadTags(ActiveManifest, downloadTags);
		return new ResourceDownloaderOperation(PackageName, downloadListByDownloadTags, downloadingMaxNumber, failedTryAgain, timeout);
	}

	ResourceDownloaderOperation IPlayMode.CreateResourceDownloaderByPaths(AssetInfo[] assetInfos, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> downloadListByPaths = GetDownloadListByPaths(ActiveManifest, assetInfos, recursiveDownload);
		return new ResourceDownloaderOperation(PackageName, downloadListByPaths, downloadingMaxNumber, failedTryAgain, timeout);
	}

	ResourceUnpackerOperation IPlayMode.CreateResourceUnpackerByAll(int upackingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> unpackListByAll = GetUnpackListByAll(ActiveManifest);
		return new ResourceUnpackerOperation(PackageName, unpackListByAll, upackingMaxNumber, failedTryAgain, timeout);
	}

	ResourceUnpackerOperation IPlayMode.CreateResourceUnpackerByTags(string[] tags, int upackingMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> unpackListByTags = GetUnpackListByTags(ActiveManifest, tags);
		return new ResourceUnpackerOperation(PackageName, unpackListByTags, upackingMaxNumber, failedTryAgain, timeout);
	}

	ResourceImporterOperation IPlayMode.CreateResourceImporterByFilePaths(string[] filePaths, int importerMaxNumber, int failedTryAgain, int timeout)
	{
		List<BundleInfo> importerListByFilePaths = GetImporterListByFilePaths(ActiveManifest, filePaths);
		return new ResourceImporterOperation(PackageName, importerListByFilePaths, importerMaxNumber, failedTryAgain, timeout);
	}

	private BundleInfo CreateBundleInfo(PackageBundle packageBundle)
	{
		if (packageBundle == null)
		{
			throw new Exception("Should never get here !");
		}
		IFileSystem belongFileSystem = GetBelongFileSystem(packageBundle);
		if (belongFileSystem != null)
		{
			return new BundleInfo(belongFileSystem, packageBundle);
		}
		throw new Exception("Can not found belong file system : " + packageBundle.BundleName);
	}

	BundleInfo IBundleQuery.GetMainBundleInfo(AssetInfo assetInfo)
	{
		if (assetInfo == null || assetInfo.IsInvalid)
		{
			throw new Exception("Should never get here !");
		}
		PackageBundle mainPackageBundle = ActiveManifest.GetMainPackageBundle(assetInfo.Asset);
		return CreateBundleInfo(mainPackageBundle);
	}

	BundleInfo[] IBundleQuery.GetDependBundleInfos(AssetInfo assetInfo)
	{
		if (assetInfo == null || assetInfo.IsInvalid)
		{
			throw new Exception("Should never get here !");
		}
		PackageBundle[] allDependencies;
		if (assetInfo.LoadMethod == AssetInfo.ELoadMethod.LoadAllAssets)
		{
			PackageBundle mainPackageBundle = ActiveManifest.GetMainPackageBundle(assetInfo.Asset);
			allDependencies = ActiveManifest.GetAllDependencies(mainPackageBundle);
		}
		else
		{
			allDependencies = ActiveManifest.GetAllDependencies(assetInfo.Asset);
		}
		List<BundleInfo> list = new List<BundleInfo>(allDependencies.Length);
		PackageBundle[] array = allDependencies;
		foreach (PackageBundle packageBundle in array)
		{
			BundleInfo item = CreateBundleInfo(packageBundle);
			list.Add(item);
		}
		return list.ToArray();
	}

	string IBundleQuery.GetMainBundleName(int bundleID)
	{
		return ActiveManifest.GetMainPackageBundle(bundleID).BundleName;
	}

	string IBundleQuery.GetMainBundleName(AssetInfo assetInfo)
	{
		if (assetInfo == null || assetInfo.IsInvalid)
		{
			throw new Exception("Should never get here !");
		}
		return ActiveManifest.GetMainPackageBundle(assetInfo.Asset).BundleName;
	}

	string[] IBundleQuery.GetDependBundleNames(AssetInfo assetInfo)
	{
		if (assetInfo == null || assetInfo.IsInvalid)
		{
			throw new Exception("Should never get here !");
		}
		PackageBundle[] allDependencies = ActiveManifest.GetAllDependencies(assetInfo.Asset);
		List<string> list = new List<string>(allDependencies.Length);
		PackageBundle[] array = allDependencies;
		foreach (PackageBundle packageBundle in array)
		{
			list.Add(packageBundle.BundleName);
		}
		return list.ToArray();
	}

	public IFileSystem GetMainFileSystem()
	{
		int count = FileSystems.Count;
		if (count == 0)
		{
			return null;
		}
		return FileSystems[count - 1];
	}

	public IFileSystem GetBelongFileSystem(PackageBundle packageBundle)
	{
		for (int i = 0; i < FileSystems.Count; i++)
		{
			IFileSystem fileSystem = FileSystems[i];
			if (fileSystem.Belong(packageBundle))
			{
				return fileSystem;
			}
		}
		YooLogger.Error("Can not found belong file system : " + packageBundle.BundleName);
		return null;
	}

	public List<BundleInfo> GetDownloadListByAll(PackageManifest manifest)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<BundleInfo> list = new List<BundleInfo>(1000);
		foreach (PackageBundle bundle in manifest.BundleList)
		{
			IFileSystem belongFileSystem = GetBelongFileSystem(bundle);
			if (belongFileSystem != null && belongFileSystem.NeedDownload(bundle))
			{
				BundleInfo item = new BundleInfo(belongFileSystem, bundle);
				list.Add(item);
			}
		}
		return list;
	}

	public List<BundleInfo> GetDownloadListByTags(PackageManifest manifest, string[] tags)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<BundleInfo> list = new List<BundleInfo>(1000);
		foreach (PackageBundle bundle in manifest.BundleList)
		{
			IFileSystem belongFileSystem = GetBelongFileSystem(bundle);
			if (belongFileSystem != null && belongFileSystem.NeedDownload(bundle))
			{
				if (!bundle.HasAnyTags())
				{
					BundleInfo item = new BundleInfo(belongFileSystem, bundle);
					list.Add(item);
				}
				else if (bundle.HasTag(tags))
				{
					BundleInfo item2 = new BundleInfo(belongFileSystem, bundle);
					list.Add(item2);
				}
			}
		}
		return list;
	}

	public List<BundleInfo> GetDownloadListByDownloadTag(PackageManifest manifest, string downloadTag)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<BundleInfo> list = new List<BundleInfo>(1000);
		foreach (PackageBundle bundle in manifest.BundleList)
		{
			IFileSystem belongFileSystem = GetBelongFileSystem(bundle);
			if (belongFileSystem != null && belongFileSystem.NeedDownload(bundle))
			{
				if (string.IsNullOrEmpty(bundle.DownloadTag))
				{
					BundleInfo item = new BundleInfo(belongFileSystem, bundle);
					list.Add(item);
				}
				else if (bundle.HasDownloadTag(downloadTag))
				{
					BundleInfo item2 = new BundleInfo(belongFileSystem, bundle);
					list.Add(item2);
				}
			}
		}
		return list;
	}

	public List<BundleInfo> GetDownloadListByDownloadTags(PackageManifest manifest, string[] downloadTags)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<BundleInfo> list = new List<BundleInfo>(1000);
		foreach (PackageBundle bundle in manifest.BundleList)
		{
			IFileSystem belongFileSystem = GetBelongFileSystem(bundle);
			if (belongFileSystem != null && belongFileSystem.NeedDownload(bundle) && HasAnyDownloadTag(bundle.DownloadTag, downloadTags))
			{
				BundleInfo item = new BundleInfo(belongFileSystem, bundle);
				list.Add(item);
			}
		}
		return list;
	}

	public List<BundleInfo> GetDownloadListByPaths(PackageManifest manifest, AssetInfo[] assetInfos, bool recursiveDownload)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<PackageBundle> list = new List<PackageBundle>();
		foreach (AssetInfo assetInfo in assetInfos)
		{
			if (assetInfo.IsInvalid)
			{
				YooLogger.Warning(assetInfo.Error);
				continue;
			}
			PackageBundle mainPackageBundle = manifest.GetMainPackageBundle(assetInfo.Asset);
			if (!list.Contains(mainPackageBundle))
			{
				list.Add(mainPackageBundle);
			}
			PackageBundle[] allDependencies = manifest.GetAllDependencies(assetInfo.Asset);
			foreach (PackageBundle item in allDependencies)
			{
				if (!list.Contains(item))
				{
					list.Add(item);
				}
			}
			if (!recursiveDownload)
			{
				continue;
			}
			foreach (PackageAsset includeMainAsset in mainPackageBundle.IncludeMainAssets)
			{
				PackageBundle mainPackageBundle2 = manifest.GetMainPackageBundle(includeMainAsset.BundleID);
				if (!list.Contains(mainPackageBundle2))
				{
					list.Add(mainPackageBundle2);
				}
				allDependencies = manifest.GetAllDependencies(includeMainAsset);
				foreach (PackageBundle item2 in allDependencies)
				{
					if (!list.Contains(item2))
					{
						list.Add(item2);
					}
				}
			}
		}
		List<BundleInfo> list2 = new List<BundleInfo>(1000);
		foreach (PackageBundle item4 in list)
		{
			IFileSystem belongFileSystem = GetBelongFileSystem(item4);
			if (belongFileSystem != null && belongFileSystem.NeedDownload(item4))
			{
				BundleInfo item3 = new BundleInfo(belongFileSystem, item4);
				list2.Add(item3);
			}
		}
		return list2;
	}

	private bool HasAnyDownloadTag(string bundleDownloadTag, string[] requestDownloadTags)
	{
		if (requestDownloadTags == null || requestDownloadTags.Length == 0)
		{
			return false;
		}
		if (string.IsNullOrWhiteSpace(bundleDownloadTag))
		{
			return ContainsDownloadTag(requestDownloadTags, "Default");
		}
		string[] array = bundleDownloadTag.Split('-');
		foreach (string bundleTag in array)
		{
			if (ContainsDownloadTag(requestDownloadTags, bundleTag))
			{
				return true;
			}
		}
		return false;
	}

	private bool ContainsDownloadTag(string[] requestDownloadTags, string bundleTag)
	{
		if (string.IsNullOrWhiteSpace(bundleTag))
		{
			return false;
		}
		string b = bundleTag.Trim();
		foreach (string text in requestDownloadTags)
		{
			if (!string.IsNullOrWhiteSpace(text) && string.Equals(text.Trim(), b, StringComparison.Ordinal))
			{
				return true;
			}
		}
		return false;
	}

	public List<BundleInfo> GetUnpackListByAll(PackageManifest manifest)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<BundleInfo> list = new List<BundleInfo>(1000);
		foreach (PackageBundle bundle in manifest.BundleList)
		{
			IFileSystem belongFileSystem = GetBelongFileSystem(bundle);
			if (belongFileSystem != null && belongFileSystem.NeedUnpack(bundle))
			{
				BundleInfo item = new BundleInfo(belongFileSystem, bundle);
				list.Add(item);
			}
		}
		return list;
	}

	public List<BundleInfo> GetUnpackListByTags(PackageManifest manifest, string[] tags)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<BundleInfo> list = new List<BundleInfo>(1000);
		foreach (PackageBundle bundle in manifest.BundleList)
		{
			IFileSystem belongFileSystem = GetBelongFileSystem(bundle);
			if (belongFileSystem != null && belongFileSystem.NeedUnpack(bundle) && bundle.HasTag(tags))
			{
				BundleInfo item = new BundleInfo(belongFileSystem, bundle);
				list.Add(item);
			}
		}
		return list;
	}

	public List<BundleInfo> GetImporterListByFilePaths(PackageManifest manifest, string[] filePaths)
	{
		if (manifest == null)
		{
			return new List<BundleInfo>();
		}
		List<BundleInfo> list = new List<BundleInfo>();
		foreach (string text in filePaths)
		{
			string fileName = Path.GetFileName(text);
			if (manifest.TryGetPackageBundleByFileName(fileName, out var result))
			{
				IFileSystem belongFileSystem = GetBelongFileSystem(result);
				if (belongFileSystem != null && belongFileSystem.NeedImport(result))
				{
					BundleInfo item = new BundleInfo(belongFileSystem, result, text);
					list.Add(item);
				}
			}
			else
			{
				YooLogger.Warning("Not found package bundle, importer file path : " + text);
			}
		}
		return list;
	}
}

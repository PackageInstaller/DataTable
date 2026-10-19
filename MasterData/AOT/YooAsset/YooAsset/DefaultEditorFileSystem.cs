using System;
using System.IO;
using UnityEngine;

namespace YooAsset;

internal class DefaultEditorFileSystem : IFileSystem
{
	protected string _packageRoot;

	public int _asyncSimulateMinFrame = 1;

	public int _asyncSimulateMaxFrame = 1;

	public string PackageName { get; private set; }

	public string FileRoot => _packageRoot;

	public int FileCount => 0;

	public virtual FSInitializeFileSystemOperation InitializeFileSystemAsync()
	{
		return new DEFSInitializeOperation(this);
	}

	public virtual FSLoadPackageManifestOperation LoadPackageManifestAsync(string packageVersion, int timeout)
	{
		return new DEFSLoadPackageManifestOperation(this, packageVersion);
	}

	public virtual FSRequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks, int timeout)
	{
		return new DEFSRequestPackageVersionOperation(this);
	}

	public virtual FSClearCacheFilesOperation ClearCacheFilesAsync(PackageManifest manifest, ClearCacheFilesOptions options)
	{
		return new FSClearCacheFilesCompleteOperation();
	}

	public virtual FSDownloadFileOperation DownloadFileAsync(PackageBundle bundle, DownloadFileOptions options)
	{
		throw new NotImplementedException();
	}

	public virtual FSLoadBundleOperation LoadBundleFile(PackageBundle bundle)
	{
		if (bundle.BundleType == 1)
		{
			return new DEFSLoadBundleOperation(this, bundle);
		}
		return new FSLoadBundleCompleteOperation(string.Format("{0} not support load bundle type : {1}", "DefaultEditorFileSystem", bundle.BundleType));
	}

	public virtual void SetParameter(string name, object value)
	{
		if (name == "ASYNC_SIMULATE_MIN_FRAME")
		{
			_asyncSimulateMinFrame = Convert.ToInt32(value);
		}
		else if (name == "ASYNC_SIMULATE_MAX_FRAME")
		{
			_asyncSimulateMaxFrame = Convert.ToInt32(value);
		}
		else
		{
			YooLogger.Warning("Invalid parameter : " + name);
		}
	}

	public virtual void OnCreate(string packageName, string packageRoot)
	{
		PackageName = packageName;
		if (string.IsNullOrEmpty(packageRoot))
		{
			throw new Exception("DefaultEditorFileSystem root directory is null or empty !");
		}
		_packageRoot = packageRoot;
	}

	public virtual void OnDestroy()
	{
	}

	public virtual bool Belong(PackageBundle bundle)
	{
		return true;
	}

	public virtual bool Exists(PackageBundle bundle)
	{
		return true;
	}

	public virtual bool NeedDownload(PackageBundle bundle)
	{
		return false;
	}

	public virtual bool NeedUnpack(PackageBundle bundle)
	{
		return false;
	}

	public virtual bool NeedImport(PackageBundle bundle)
	{
		return false;
	}

	public virtual string GetBundleFilePath(PackageBundle bundle)
	{
		if (bundle.IncludeMainAssets.Count == 0)
		{
			return string.Empty;
		}
		return bundle.IncludeMainAssets[0].AssetPath;
	}

	public virtual Stream OpenBundleFileStream(PackageBundle bundle)
	{
		return File.OpenRead(GetBundleFilePath(bundle));
	}

	public virtual byte[] ReadBundleFileData(PackageBundle bundle)
	{
		if (bundle.IncludeMainAssets.Count == 0)
		{
			return null;
		}
		return FileUtility.ReadAllBytes(bundle.IncludeMainAssets[0].AssetPath);
	}

	public virtual string ReadBundleFileText(PackageBundle bundle)
	{
		if (bundle.IncludeMainAssets.Count == 0)
		{
			return null;
		}
		return FileUtility.ReadAllText(bundle.IncludeMainAssets[0].AssetPath);
	}

	public string GetEditorPackageVersionFilePath()
	{
		string packageVersionFileName = YooAssetSettingsData.GetPackageVersionFileName(PackageName);
		return PathUtility.Combine(_packageRoot, packageVersionFileName);
	}

	public string GetEditorPackageHashFilePath(string packageVersion)
	{
		string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(PackageName, packageVersion);
		return PathUtility.Combine(_packageRoot, packageHashFileName);
	}

	public string GetEditorPackageManifestFilePath(string packageVersion)
	{
		string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(PackageName, packageVersion);
		return PathUtility.Combine(_packageRoot, manifestBinaryFileName);
	}

	public int GetAsyncSimulateFrame()
	{
		if (_asyncSimulateMinFrame > _asyncSimulateMaxFrame)
		{
			_asyncSimulateMinFrame = _asyncSimulateMaxFrame;
		}
		return UnityEngine.Random.Range(_asyncSimulateMinFrame, _asyncSimulateMaxFrame + 1);
	}
}

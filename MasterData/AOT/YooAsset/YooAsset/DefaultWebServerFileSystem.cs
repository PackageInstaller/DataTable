using System;
using System.Collections.Generic;
using System.IO;

namespace YooAsset;

internal class DefaultWebServerFileSystem : IFileSystem
{
	public class FileWrapper
	{
		public string FileName { get; private set; }

		public FileWrapper(string fileName)
		{
			FileName = fileName;
		}
	}

	protected readonly Dictionary<string, FileWrapper> _wrappers = new Dictionary<string, FileWrapper>(10000);

	protected readonly Dictionary<string, string> _webFilePathMapping = new Dictionary<string, string>(10000);

	protected string _webPackageRoot = string.Empty;

	public string PackageName { get; private set; }

	public string FileRoot => _webPackageRoot;

	public int FileCount => 0;

	public bool DisableUnityWebCache { get; private set; }

	public IWebDecryptionServices DecryptionServices { get; private set; }

	public virtual FSInitializeFileSystemOperation InitializeFileSystemAsync()
	{
		return new DWSFSInitializeOperation(this);
	}

	public virtual FSLoadPackageManifestOperation LoadPackageManifestAsync(string packageVersion, int timeout)
	{
		return new DWSFSLoadPackageManifestOperation(this, packageVersion, timeout);
	}

	public virtual FSRequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks, int timeout)
	{
		return new DWSFSRequestPackageVersionOperation(this, timeout);
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
		if (bundle.BundleType == 2)
		{
			return new DWSFSLoadAssetBundleOperation(this, bundle);
		}
		return new FSLoadBundleCompleteOperation(string.Format("{0} not support load bundle type : {1}", "DefaultWebServerFileSystem", bundle.BundleType));
	}

	public virtual void SetParameter(string name, object value)
	{
		if (name == "DISABLE_UNITY_WEB_CACHE")
		{
			DisableUnityWebCache = Convert.ToBoolean(value);
		}
		else if (name == "DECRYPTION_SERVICES")
		{
			DecryptionServices = (IWebDecryptionServices)value;
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
			_webPackageRoot = GetDefaultWebPackageRoot(packageName);
		}
		else
		{
			_webPackageRoot = packageRoot;
		}
	}

	public virtual void OnDestroy()
	{
	}

	public virtual bool Belong(PackageBundle bundle)
	{
		return _wrappers.ContainsKey(bundle.BundleGUID);
	}

	public virtual bool Exists(PackageBundle bundle)
	{
		return _wrappers.ContainsKey(bundle.BundleGUID);
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
		throw new NotImplementedException();
	}

	public virtual Stream OpenBundleFileStream(PackageBundle bundle)
	{
		return File.OpenRead(GetBundleFilePath(bundle));
	}

	public virtual byte[] ReadBundleFileData(PackageBundle bundle)
	{
		throw new NotImplementedException();
	}

	public virtual string ReadBundleFileText(PackageBundle bundle)
	{
		throw new NotImplementedException();
	}

	protected string GetDefaultWebPackageRoot(string packageName)
	{
		return PathUtility.Combine(YooAssetSettingsData.GetYooDefaultBuildinRoot(), packageName);
	}

	public string GetWebFileLoadPath(PackageBundle bundle)
	{
		if (!_webFilePathMapping.TryGetValue(bundle.BundleGUID, out var value))
		{
			value = PathUtility.Combine(_webPackageRoot, bundle.FileName);
			_webFilePathMapping.Add(bundle.BundleGUID, value);
		}
		return value;
	}

	public string GetWebPackageVersionFilePath()
	{
		string packageVersionFileName = YooAssetSettingsData.GetPackageVersionFileName(PackageName);
		return PathUtility.Combine(FileRoot, packageVersionFileName);
	}

	public string GetWebPackageHashFilePath(string packageVersion)
	{
		string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(PackageName, packageVersion);
		return PathUtility.Combine(FileRoot, packageHashFileName);
	}

	public string GetWebPackageManifestFilePath(string packageVersion)
	{
		string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(PackageName, packageVersion);
		return PathUtility.Combine(FileRoot, manifestBinaryFileName);
	}

	public string GetCatalogBinaryFileLoadPath()
	{
		return PathUtility.Combine(_webPackageRoot, "BuildinCatalog.bytes");
	}

	public bool RecordCatalogFile(string bundleGUID, FileWrapper wrapper)
	{
		if (_wrappers.ContainsKey(bundleGUID))
		{
			YooLogger.Error("DefaultWebServerFileSystem has element : " + bundleGUID);
			return false;
		}
		_wrappers.Add(bundleGUID, wrapper);
		return true;
	}
}

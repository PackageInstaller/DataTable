using System;
using System.IO;

namespace YooAsset;

internal class DefaultWebRemoteFileSystem : IFileSystem
{
	public string PackageName { get; private set; }

	public string FileRoot => string.Empty;

	public int FileCount => 0;

	public bool DisableUnityWebCache { get; private set; }

	public IRemoteServices RemoteServices { get; private set; }

	public IWebDecryptionServices DecryptionServices { get; private set; }

	public virtual FSInitializeFileSystemOperation InitializeFileSystemAsync()
	{
		return new DWRFSInitializeOperation(this);
	}

	public virtual FSLoadPackageManifestOperation LoadPackageManifestAsync(string packageVersion, int timeout)
	{
		return new DWRFSLoadPackageManifestOperation(this, packageVersion, timeout);
	}

	public virtual FSRequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks, int timeout)
	{
		return new DWRFSRequestPackageVersionOperation(this, appendTimeTicks, timeout);
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
			return new DWRFSLoadAssetBundleOperation(this, bundle);
		}
		return new FSLoadBundleCompleteOperation(string.Format("{0} not support load bundle type : {1}", "DefaultWebRemoteFileSystem", bundle.BundleType));
	}

	public virtual void SetParameter(string name, object value)
	{
		switch (name)
		{
		case "DISABLE_UNITY_WEB_CACHE":
			DisableUnityWebCache = Convert.ToBoolean(value);
			break;
		case "REMOTE_SERVICES":
			RemoteServices = (IRemoteServices)value;
			break;
		case "DECRYPTION_SERVICES":
			DecryptionServices = (IWebDecryptionServices)value;
			break;
		default:
			YooLogger.Warning("Invalid parameter : " + name);
			break;
		}
	}

	public virtual void OnCreate(string packageName, string packageRoot)
	{
		PackageName = packageName;
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
}

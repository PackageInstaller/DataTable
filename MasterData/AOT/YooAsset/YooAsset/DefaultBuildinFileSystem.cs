using System;
using System.Collections.Generic;
using System.IO;

namespace YooAsset;

internal class DefaultBuildinFileSystem : IFileSystem
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

	protected readonly Dictionary<string, string> _buildinFilePathMapping = new Dictionary<string, string>(10000);

	protected IFileSystem _unpackFileSystem;

	protected string _packageRoot;

	public string PackageName { get; private set; }

	public string FileRoot => _packageRoot;

	public int FileCount => _wrappers.Count;

	public EFileVerifyLevel FileVerifyLevel { get; private set; } = EFileVerifyLevel.Middle;

	public EOverwriteInstallClearMode InstallClearMode { get; private set; } = EOverwriteInstallClearMode.ClearAllManifestFiles;

	public bool AppendFileExtension { get; private set; }

	public bool DisableCatalogFile { get; private set; }

	public bool CopyBuildinPackageManifest { get; private set; }

	public string CopyBuildinPackageManifestDestRoot { get; private set; }

	public IDecryptionServices DecryptionServices { get; private set; }

	public virtual FSInitializeFileSystemOperation InitializeFileSystemAsync()
	{
		return new DBFSInitializeOperation(this);
	}

	public virtual FSLoadPackageManifestOperation LoadPackageManifestAsync(string packageVersion, int timeout)
	{
		return new DBFSLoadPackageManifestOperation(this, packageVersion);
	}

	public virtual FSRequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks, int timeout)
	{
		return new DBFSRequestPackageVersionOperation(this);
	}

	public virtual FSClearCacheFilesOperation ClearCacheFilesAsync(PackageManifest manifest, ClearCacheFilesOptions options)
	{
		return _unpackFileSystem.ClearCacheFilesAsync(manifest, options);
	}

	public virtual FSDownloadFileOperation DownloadFileAsync(PackageBundle bundle, DownloadFileOptions options)
	{
		options.ImportFilePath = GetBuildinFileLoadPath(bundle);
		return _unpackFileSystem.DownloadFileAsync(bundle, options);
	}

	public virtual FSLoadBundleOperation LoadBundleFile(PackageBundle bundle)
	{
		if (IsUnpackBundleFile(bundle))
		{
			return _unpackFileSystem.LoadBundleFile(bundle);
		}
		if (bundle.BundleType == 2)
		{
			return new DBFSLoadAssetBundleOperation(this, bundle);
		}
		if (bundle.BundleType == 3)
		{
			return new DBFSLoadRawBundleOperation(this, bundle);
		}
		return new FSLoadBundleCompleteOperation(string.Format("{0} not support load bundle type : {1}", "DefaultBuildinFileSystem", bundle.BundleType));
	}

	public virtual void SetParameter(string name, object value)
	{
		switch (name)
		{
		case "FILE_VERIFY_LEVEL":
			FileVerifyLevel = (EFileVerifyLevel)value;
			break;
		case "INSTALL_CLEAR_MODE":
			InstallClearMode = (EOverwriteInstallClearMode)value;
			break;
		case "APPEND_FILE_EXTENSION":
			AppendFileExtension = Convert.ToBoolean(value);
			break;
		case "DISABLE_CATALOG_FILE":
			DisableCatalogFile = Convert.ToBoolean(value);
			break;
		case "COPY_BUILDIN_PACKAGE_MANIFEST":
			CopyBuildinPackageManifest = Convert.ToBoolean(value);
			break;
		case "COPY_BUILDIN_PACKAGE_MANIFEST_DEST_ROOT":
			CopyBuildinPackageManifestDestRoot = (string)value;
			break;
		case "DECRYPTION_SERVICES":
			DecryptionServices = (IDecryptionServices)value;
			break;
		default:
			YooLogger.Warning("Invalid parameter : " + name);
			break;
		}
	}

	public virtual void OnCreate(string packageName, string packageRoot)
	{
		PackageName = packageName;
		if (string.IsNullOrEmpty(packageRoot))
		{
			_packageRoot = GetDefaultBuildinPackageRoot(packageName);
		}
		else
		{
			_packageRoot = packageRoot;
		}
		DefaultUnpackRemoteServices value = new DefaultUnpackRemoteServices(_packageRoot);
		_unpackFileSystem = new DefaultUnpackFileSystem();
		_unpackFileSystem.SetParameter("REMOTE_SERVICES", value);
		_unpackFileSystem.SetParameter("FILE_VERIFY_LEVEL", FileVerifyLevel);
		_unpackFileSystem.SetParameter("INSTALL_CLEAR_MODE", InstallClearMode);
		_unpackFileSystem.SetParameter("APPEND_FILE_EXTENSION", AppendFileExtension);
		_unpackFileSystem.SetParameter("DECRYPTION_SERVICES", DecryptionServices);
		_unpackFileSystem.OnCreate(packageName, null);
	}

	public virtual void OnDestroy()
	{
	}

	public virtual bool Belong(PackageBundle bundle)
	{
		if (DisableCatalogFile)
		{
			return true;
		}
		return _wrappers.ContainsKey(bundle.BundleGUID);
	}

	public virtual bool Exists(PackageBundle bundle)
	{
		if (DisableCatalogFile)
		{
			return true;
		}
		return _wrappers.ContainsKey(bundle.BundleGUID);
	}

	public virtual bool NeedDownload(PackageBundle bundle)
	{
		return false;
	}

	public virtual bool NeedUnpack(PackageBundle bundle)
	{
		if (IsUnpackBundleFile(bundle))
		{
			return !_unpackFileSystem.Exists(bundle);
		}
		return false;
	}

	public virtual bool NeedImport(PackageBundle bundle)
	{
		return false;
	}

	public virtual string GetBundleFilePath(PackageBundle bundle)
	{
		if (IsUnpackBundleFile(bundle))
		{
			return _unpackFileSystem.GetBundleFilePath(bundle);
		}
		string buildinFileLoadPath = GetBuildinFileLoadPath(bundle);
		if (bundle.Encrypted && DecryptionServices is IRawFileDecryptionServices rawFileDecryptionServices)
		{
			return rawFileDecryptionServices.GetDecryptedRawFilePath(CreateDecryptFileInfo(bundle, buildinFileLoadPath));
		}
		return buildinFileLoadPath;
	}

	public virtual Stream OpenBundleFileStream(PackageBundle bundle)
	{
		if (IsUnpackBundleFile(bundle))
		{
			return _unpackFileSystem.OpenBundleFileStream(bundle);
		}
		string buildinFileLoadPath = GetBuildinFileLoadPath(bundle);
		if (bundle.Encrypted && DecryptionServices is IRawFileDecryptionServices rawFileDecryptionServices)
		{
			return rawFileDecryptionServices.OpenRawFileStream(CreateDecryptFileInfo(bundle, buildinFileLoadPath));
		}
		return File.OpenRead(buildinFileLoadPath);
	}

	public virtual byte[] ReadBundleFileData(PackageBundle bundle)
	{
		if (IsUnpackBundleFile(bundle))
		{
			return _unpackFileSystem.ReadBundleFileData(bundle);
		}
		if (!Exists(bundle))
		{
			return null;
		}
		YooLogger.Error("Android platform not support read buildin bundle file data !");
		return null;
	}

	public virtual string ReadBundleFileText(PackageBundle bundle)
	{
		if (IsUnpackBundleFile(bundle))
		{
			return _unpackFileSystem.ReadBundleFileText(bundle);
		}
		if (!Exists(bundle))
		{
			return null;
		}
		YooLogger.Error("Android platform not support read buildin bundle file text !");
		return null;
	}

	protected string GetDefaultBuildinPackageRoot(string packageName)
	{
		return PathUtility.Combine(YooAssetSettingsData.GetYooDefaultBuildinRoot(), packageName);
	}

	public string GetBuildinFileLoadPath(PackageBundle bundle)
	{
		if (!_buildinFilePathMapping.TryGetValue(bundle.BundleGUID, out var value))
		{
			value = PathUtility.Combine(_packageRoot, bundle.FileName);
			_buildinFilePathMapping.Add(bundle.BundleGUID, value);
		}
		return value;
	}

	private static DecryptFileInfo CreateDecryptFileInfo(PackageBundle bundle, string filePath)
	{
		return new DecryptFileInfo
		{
			BundleName = bundle.BundleName,
			FileLoadCRC = bundle.UnityCRC,
			FileLoadPath = filePath
		};
	}

	public string GetBuildinPackageVersionFilePath()
	{
		string packageVersionFileName = YooAssetSettingsData.GetPackageVersionFileName(PackageName);
		return PathUtility.Combine(_packageRoot, packageVersionFileName);
	}

	public string GetBuildinPackageHashFilePath(string packageVersion)
	{
		string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(PackageName, packageVersion);
		return PathUtility.Combine(_packageRoot, packageHashFileName);
	}

	public string GetBuildinPackageManifestFilePath(string packageVersion)
	{
		string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(PackageName, packageVersion);
		return PathUtility.Combine(_packageRoot, manifestBinaryFileName);
	}

	public string GetCatalogBinaryFileLoadPath()
	{
		return PathUtility.Combine(_packageRoot, "BuildinCatalog.bytes");
	}

	protected bool IsUnpackBundleFile(PackageBundle bundle)
	{
		if (!Belong(bundle))
		{
			return false;
		}
		if (bundle.Encrypted)
		{
			return true;
		}
		if (bundle.BundleType == 3)
		{
			return true;
		}
		return false;
	}

	public bool RecordCatalogFile(string bundleGUID, FileWrapper wrapper)
	{
		if (_wrappers.ContainsKey(bundleGUID))
		{
			YooLogger.Error("DefaultBuildinFileSystem has element : " + bundleGUID);
			return false;
		}
		_wrappers.Add(bundleGUID, wrapper);
		return true;
	}

	public FSInitializeFileSystemOperation InitializeUpackFileSystem()
	{
		return _unpackFileSystem.InitializeFileSystemAsync();
	}

	public DecryptResult LoadEncryptedAssetBundle(PackageBundle bundle)
	{
		string buildinFileLoadPath = GetBuildinFileLoadPath(bundle);
		DecryptFileInfo fileInfo = CreateDecryptFileInfo(bundle, buildinFileLoadPath);
		return DecryptionServices.LoadAssetBundle(fileInfo);
	}

	public DecryptResult LoadEncryptedAssetBundleAsync(PackageBundle bundle)
	{
		string buildinFileLoadPath = GetBuildinFileLoadPath(bundle);
		DecryptFileInfo fileInfo = CreateDecryptFileInfo(bundle, buildinFileLoadPath);
		return DecryptionServices.LoadAssetBundleAsync(fileInfo);
	}
}

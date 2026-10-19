using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace YooAsset;

internal class DefaultCacheFileSystem : IFileSystem
{
	protected readonly Dictionary<string, RecordFileElement> _records = new Dictionary<string, RecordFileElement>(10000);

	protected readonly Dictionary<string, string> _bundleDataFilePathMapping = new Dictionary<string, string>(10000);

	protected readonly Dictionary<string, string> _bundleInfoFilePathMapping = new Dictionary<string, string>(10000);

	protected readonly Dictionary<string, string> _tempFilePathMapping = new Dictionary<string, string>(10000);

	protected string _packageRoot;

	protected string _tempFilesRoot;

	protected string _cacheBundleFilesRoot;

	protected string _cacheManifestFilesRoot;

	private readonly BufferWriter _sharedBuffer = new BufferWriter(1024);

	private const int RecordSnapshotMagic = 1380270916;

	public DownloadCenterOperation DownloadCenter { get; set; }

	public string PackageName { get; private set; }

	public string FileRoot => _packageRoot;

	public int FileCount => _records.Count;

	public IRemoteServices RemoteServices { get; private set; }

	public EFileVerifyLevel FileVerifyLevel { get; private set; } = EFileVerifyLevel.Middle;

	public EOverwriteInstallClearMode InstallClearMode { get; private set; } = EOverwriteInstallClearMode.ClearAllManifestFiles;

	public bool AppendFileExtension { get; private set; }

	public int DownloadMaxConcurrency { get; private set; } = int.MaxValue;

	public int DownloadMaxRequestPerFrame { get; private set; } = int.MaxValue;

	public long ResumeDownloadMinimumSize { get; private set; } = long.MaxValue;

	public List<long> ResumeDownloadResponseCodes { get; private set; }

	public IDecryptionServices DecryptionServices { get; private set; }

	public virtual FSInitializeFileSystemOperation InitializeFileSystemAsync()
	{
		return new DCFSInitializeOperation(this);
	}

	public virtual FSLoadPackageManifestOperation LoadPackageManifestAsync(string packageVersion, int timeout)
	{
		return new DCFSLoadPackageManifestOperation(this, packageVersion, timeout);
	}

	public virtual FSRequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks, int timeout)
	{
		return new DCFSRequestPackageVersionOperation(this, appendTimeTicks, timeout);
	}

	public virtual FSClearCacheFilesOperation ClearCacheFilesAsync(PackageManifest manifest, ClearCacheFilesOptions options)
	{
		if (options.ClearMode == EFileClearMode.ClearAllBundleFiles.ToString())
		{
			return new ClearAllCacheBundleFilesOperation(this);
		}
		if (options.ClearMode == EFileClearMode.ClearUnusedBundleFiles.ToString())
		{
			return new ClearUnusedCacheBundleFilesOperation(this, manifest);
		}
		if (options.ClearMode == EFileClearMode.ClearBundleFilesByTags.ToString())
		{
			return new ClearCacheBundleFilesByTagsOperaiton(this, manifest, options.ClearParam);
		}
		if (options.ClearMode == EFileClearMode.ClearAllManifestFiles.ToString())
		{
			return new ClearAllCacheManifestFilesOperation(this);
		}
		if (options.ClearMode == EFileClearMode.ClearUnusedManifestFiles.ToString())
		{
			return new ClearUnusedCacheManifestFilesOperation(this, manifest);
		}
		return new FSClearCacheFilesCompleteOperation("Invalid clear mode : " + options.ClearMode);
	}

	public virtual FSDownloadFileOperation DownloadFileAsync(PackageBundle bundle, DownloadFileOptions options)
	{
		FSDownloadFileOperation fSDownloadFileOperation = DownloadCenter.DownloadFileAsync(bundle, options);
		fSDownloadFileOperation.Reference();
		return new DownloadFileWrapper(fSDownloadFileOperation);
	}

	public virtual FSLoadBundleOperation LoadBundleFile(PackageBundle bundle)
	{
		if (bundle.BundleType == 2)
		{
			return new DCFSLoadAssetBundleOperation(this, bundle);
		}
		if (bundle.BundleType == 3)
		{
			return new DCFSLoadRawBundleOperation(this, bundle);
		}
		return new FSLoadBundleCompleteOperation(string.Format("{0} not support load bundle type : {1}", "DefaultCacheFileSystem", bundle.BundleType));
	}

	public virtual void SetParameter(string name, object value)
	{
		switch (name)
		{
		case "REMOTE_SERVICES":
			RemoteServices = (IRemoteServices)value;
			break;
		case "FILE_VERIFY_LEVEL":
			FileVerifyLevel = (EFileVerifyLevel)value;
			break;
		case "INSTALL_CLEAR_MODE":
			InstallClearMode = (EOverwriteInstallClearMode)value;
			break;
		case "APPEND_FILE_EXTENSION":
			AppendFileExtension = Convert.ToBoolean(value);
			break;
		case "DOWNLOAD_MAX_CONCURRENCY":
			DownloadMaxConcurrency = Convert.ToInt32(value);
			break;
		case "DOWNLOAD_MAX_REQUEST_PER_FRAME":
			DownloadMaxRequestPerFrame = Convert.ToInt32(value);
			break;
		case "RESUME_DOWNLOAD_MINMUM_SIZE":
			ResumeDownloadMinimumSize = Convert.ToInt64(value);
			break;
		case "RESUME_DOWNLOAD_RESPONSE_CODES":
			ResumeDownloadResponseCodes = (List<long>)value;
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
			_packageRoot = GetDefaultCachePackageRoot(packageName);
		}
		else
		{
			_packageRoot = packageRoot;
		}
		_cacheBundleFilesRoot = PathUtility.Combine(_packageRoot, "BundleFiles");
		_cacheManifestFilesRoot = PathUtility.Combine(_packageRoot, "ManifestFiles");
		_tempFilesRoot = PathUtility.Combine(_packageRoot, "TempFiles");
	}

	public virtual void OnDestroy()
	{
		if (DownloadCenter != null)
		{
			DownloadCenter.AbortOperation();
			DownloadCenter = null;
		}
	}

	public virtual bool Belong(PackageBundle bundle)
	{
		return true;
	}

	public virtual bool Exists(PackageBundle bundle)
	{
		return _records.ContainsKey(bundle.BundleGUID);
	}

	public virtual bool NeedDownload(PackageBundle bundle)
	{
		if (!Belong(bundle))
		{
			return false;
		}
		return !Exists(bundle);
	}

	public virtual bool NeedUnpack(PackageBundle bundle)
	{
		return false;
	}

	public virtual bool NeedImport(PackageBundle bundle)
	{
		if (!Belong(bundle))
		{
			return false;
		}
		return !Exists(bundle);
	}

	public virtual string GetBundleFilePath(PackageBundle bundle)
	{
		string cacheBundleFileLoadPath = GetCacheBundleFileLoadPath(bundle);
		if (bundle.Encrypted && DecryptionServices is IRawFileDecryptionServices rawFileDecryptionServices)
		{
			return rawFileDecryptionServices.GetDecryptedRawFilePath(CreateDecryptFileInfo(bundle, cacheBundleFileLoadPath));
		}
		return cacheBundleFileLoadPath;
	}

	public virtual Stream OpenBundleFileStream(PackageBundle bundle)
	{
		string cacheBundleFileLoadPath = GetCacheBundleFileLoadPath(bundle);
		if (bundle.Encrypted && DecryptionServices is IRawFileDecryptionServices rawFileDecryptionServices)
		{
			return rawFileDecryptionServices.OpenRawFileStream(CreateDecryptFileInfo(bundle, cacheBundleFileLoadPath));
		}
		return File.OpenRead(cacheBundleFileLoadPath);
	}

	public virtual byte[] ReadBundleFileData(PackageBundle bundle)
	{
		if (!Exists(bundle))
		{
			return null;
		}
		if (bundle.Encrypted)
		{
			if (DecryptionServices == null)
			{
				YooLogger.Error("The IDecryptionServices is null !");
				return null;
			}
			string cacheBundleFileLoadPath = GetCacheBundleFileLoadPath(bundle);
			DecryptFileInfo fileInfo = CreateDecryptFileInfo(bundle, cacheBundleFileLoadPath);
			return DecryptionServices.ReadFileData(fileInfo);
		}
		return FileUtility.ReadAllBytes(GetCacheBundleFileLoadPath(bundle));
	}

	public virtual string ReadBundleFileText(PackageBundle bundle)
	{
		if (!Exists(bundle))
		{
			return null;
		}
		if (bundle.Encrypted)
		{
			if (DecryptionServices == null)
			{
				YooLogger.Error("The IDecryptionServices is null !");
				return null;
			}
			string cacheBundleFileLoadPath = GetCacheBundleFileLoadPath(bundle);
			DecryptFileInfo fileInfo = CreateDecryptFileInfo(bundle, cacheBundleFileLoadPath);
			return DecryptionServices.ReadFileText(fileInfo);
		}
		return FileUtility.ReadAllText(GetCacheBundleFileLoadPath(bundle));
	}

	public List<string> GetAllCachedBundleGUIDs()
	{
		return _records.Keys.ToList();
	}

	public RecordFileElement GetRecordFileElement(PackageBundle bundle)
	{
		if (_records.TryGetValue(bundle.BundleGUID, out var value))
		{
			return value;
		}
		return null;
	}

	public string GetTempFilePath(PackageBundle bundle)
	{
		if (!_tempFilePathMapping.TryGetValue(bundle.BundleGUID, out var value))
		{
			value = PathUtility.Combine(_tempFilesRoot, bundle.BundleGUID);
			_tempFilePathMapping.Add(bundle.BundleGUID, value);
		}
		return value;
	}

	public string GetBundleDataFilePath(PackageBundle bundle)
	{
		if (!_bundleDataFilePathMapping.TryGetValue(bundle.BundleGUID, out var value))
		{
			string path = bundle.FileHash.Substring(0, 2);
			value = PathUtility.Combine(_cacheBundleFilesRoot, path, bundle.BundleGUID, "__data");
			if (AppendFileExtension)
			{
				value += bundle.FileExtension;
			}
			_bundleDataFilePathMapping.Add(bundle.BundleGUID, value);
		}
		return value;
	}

	public string GetBundleInfoFilePath(PackageBundle bundle)
	{
		if (!_bundleInfoFilePathMapping.TryGetValue(bundle.BundleGUID, out var value))
		{
			string path = bundle.FileHash.Substring(0, 2);
			value = PathUtility.Combine(_cacheBundleFilesRoot, path, bundle.BundleGUID, "__info");
			_bundleInfoFilePathMapping.Add(bundle.BundleGUID, value);
		}
		return value;
	}

	public bool IsRecordBundleFile(string bundleGUID)
	{
		return _records.ContainsKey(bundleGUID);
	}

	public bool RecordBundleFile(string bundleGUID, RecordFileElement element)
	{
		if (_records.ContainsKey(bundleGUID))
		{
			YooLogger.Error("DefaultCacheFileSystem has element : " + bundleGUID);
			return false;
		}
		_records.Add(bundleGUID, element);
		return true;
	}

	public EFileVerifyResult VerifyCacheFile(PackageBundle bundle)
	{
		if (!_records.TryGetValue(bundle.BundleGUID, out var value))
		{
			return EFileVerifyResult.CacheNotFound;
		}
		return FileVerifyHelper.FileVerify(value.DataFilePath, value.DataFileSize, value.DataFileCRC, EFileVerifyLevel.High);
	}

	public bool WriteCacheBundleFile(PackageBundle bundle, string copyPath)
	{
		if (_records.ContainsKey(bundle.BundleGUID))
		{
			throw new Exception("Should never get here !");
		}
		string bundleInfoFilePath = GetBundleInfoFilePath(bundle);
		string bundleDataFilePath = GetBundleDataFilePath(bundle);
		try
		{
			if (File.Exists(bundleInfoFilePath))
			{
				File.Delete(bundleInfoFilePath);
			}
			if (File.Exists(bundleDataFilePath))
			{
				File.Delete(bundleDataFilePath);
			}
			FileUtility.CreateFileDirectory(bundleDataFilePath);
			new FileInfo(copyPath).CopyTo(bundleDataFilePath);
			WriteBundleInfoFile(bundleInfoFilePath, bundle.FileCRC, bundle.FileSize);
		}
		catch (Exception ex)
		{
			YooLogger.Error("Failed to write cache file ! " + ex.Message);
			return false;
		}
		RecordFileElement element = new RecordFileElement(bundleInfoFilePath, bundleDataFilePath, bundle.FileCRC, bundle.FileSize);
		if (RecordBundleFile(bundle.BundleGUID, element))
		{
			AppendRecordDelta(add: true, bundle.BundleGUID, bundleInfoFilePath, bundleDataFilePath, bundle.FileCRC, bundle.FileSize);
			return true;
		}
		return false;
	}

	public bool DeleteCacheBundleFile(string bundleGUID)
	{
		if (_records.TryGetValue(bundleGUID, out var value))
		{
			_records.Remove(bundleGUID);
			AppendRecordDelta(add: false, bundleGUID, null, null, null, 0L);
			return value.DeleteFolder();
		}
		return false;
	}

	public void WriteBundleInfoFile(string filePath, string dataFileCRC, long dataFileSize)
	{
		using FileStream fileStream = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.Read);
		_sharedBuffer.Clear();
		_sharedBuffer.WriteUTF8(dataFileCRC);
		_sharedBuffer.WriteInt64(dataFileSize);
		_sharedBuffer.WriteToStream(fileStream);
		fileStream.Flush();
	}

	public void ReadBundleInfoFile(string filePath, out string dataFileCRC, out long dataFileSize)
	{
		BufferReader bufferReader = new BufferReader(FileUtility.ReadAllBytes(filePath));
		dataFileCRC = bufferReader.ReadUTF8();
		dataFileSize = bufferReader.ReadInt64();
	}

	public string GetDefaultCachePackageRoot(string packageName)
	{
		return PathUtility.Combine(YooAssetSettingsData.GetYooDefaultCacheRoot(), packageName);
	}

	public string GetCacheBundleFileLoadPath(PackageBundle bundle)
	{
		return GetBundleDataFilePath(bundle);
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

	public string GetCachePackageHashFilePath(string packageVersion)
	{
		string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(PackageName, packageVersion);
		return PathUtility.Combine(_cacheManifestFilesRoot, packageHashFileName);
	}

	public string GetCachePackageManifestFilePath(string packageVersion)
	{
		string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(PackageName, packageVersion);
		return PathUtility.Combine(_cacheManifestFilesRoot, manifestBinaryFileName);
	}

	public string GetSandboxAppFootPrintFilePath()
	{
		return PathUtility.Combine(_cacheManifestFilesRoot, "ApplicationFootPrint.bytes");
	}

	public string GetCacheBundleFilesRoot()
	{
		return _cacheBundleFilesRoot;
	}

	public string GetCacheManifestFilesRoot()
	{
		return _cacheManifestFilesRoot;
	}

	public string GetCacheRecordSnapshotFilePath()
	{
		return PathUtility.Combine(_cacheManifestFilesRoot, "CacheRecords.snapshot");
	}

	public string GetCacheRecordDeltaFilePath()
	{
		return PathUtility.Combine(_cacheManifestFilesRoot, "CacheRecords.delta");
	}

	public bool TryLoadRecordsFromDisk()
	{
		string cacheRecordSnapshotFilePath = GetCacheRecordSnapshotFilePath();
		if (!File.Exists(cacheRecordSnapshotFilePath))
		{
			return false;
		}
		Dictionary<string, RecordFileElement> dictionary = new Dictionary<string, RecordFileElement>();
		try
		{
			using (FileStream input = new FileStream(cacheRecordSnapshotFilePath, FileMode.Open, FileAccess.Read, FileShare.Read))
			{
				using BinaryReader binaryReader = new BinaryReader(input);
				if (binaryReader.ReadInt32() != 1380270916)
				{
					return false;
				}
				int num = binaryReader.ReadInt32();
				if (num < 0)
				{
					return false;
				}
				for (int i = 0; i < num; i++)
				{
					string text = binaryReader.ReadString();
					string text2 = binaryReader.ReadString();
					string text3 = binaryReader.ReadString();
					string dataFileCRC = binaryReader.ReadString();
					long dataFileSize = binaryReader.ReadInt64();
					if (string.IsNullOrEmpty(text) || string.IsNullOrEmpty(text2) || string.IsNullOrEmpty(text3))
					{
						return false;
					}
					dictionary.Add(text, new RecordFileElement(text2, text3, dataFileCRC, dataFileSize));
				}
			}
			string cacheRecordDeltaFilePath = GetCacheRecordDeltaFilePath();
			if (File.Exists(cacheRecordDeltaFilePath))
			{
				using FileStream fileStream = new FileStream(cacheRecordDeltaFilePath, FileMode.Open, FileAccess.Read, FileShare.Read);
				using BinaryReader binaryReader2 = new BinaryReader(fileStream);
				while (fileStream.Position < fileStream.Length)
				{
					switch (binaryReader2.ReadByte())
					{
					case 1:
					{
						string key2 = binaryReader2.ReadString();
						string infoFilePath = binaryReader2.ReadString();
						string dataFilePath = binaryReader2.ReadString();
						string dataFileCRC2 = binaryReader2.ReadString();
						long dataFileSize2 = binaryReader2.ReadInt64();
						dictionary[key2] = new RecordFileElement(infoFilePath, dataFilePath, dataFileCRC2, dataFileSize2);
						break;
					}
					case 2:
					{
						string key = binaryReader2.ReadString();
						dictionary.Remove(key);
						break;
					}
					default:
						return false;
					}
				}
			}
			_records.Clear();
			foreach (KeyValuePair<string, RecordFileElement> item in dictionary)
			{
				_records.Add(item.Key, item.Value);
			}
			return true;
		}
		catch (Exception arg)
		{
			YooLogger.Warning($"Failed to load cache records snapshot : {arg}");
			_records.Clear();
			return false;
		}
	}

	public bool SaveRecordsSnapshot()
	{
		string cacheRecordSnapshotFilePath = GetCacheRecordSnapshotFilePath();
		string text = cacheRecordSnapshotFilePath + ".tmp";
		try
		{
			FileUtility.CreateFileDirectory(cacheRecordSnapshotFilePath);
			using (FileStream fileStream = new FileStream(text, FileMode.Create, FileAccess.Write, FileShare.Read))
			{
				using BinaryWriter binaryWriter = new BinaryWriter(fileStream);
				binaryWriter.Write(1380270916);
				binaryWriter.Write(_records.Count);
				foreach (KeyValuePair<string, RecordFileElement> record in _records)
				{
					RecordFileElement value = record.Value;
					binaryWriter.Write(record.Key);
					binaryWriter.Write(value.InfoFilePath);
					binaryWriter.Write(value.DataFilePath);
					binaryWriter.Write(value.DataFileCRC ?? string.Empty);
					binaryWriter.Write(value.DataFileSize);
				}
				binaryWriter.Flush();
				fileStream.Flush();
			}
			if (File.Exists(cacheRecordSnapshotFilePath))
			{
				File.Delete(cacheRecordSnapshotFilePath);
			}
			File.Move(text, cacheRecordSnapshotFilePath);
			try
			{
				string cacheRecordDeltaFilePath = GetCacheRecordDeltaFilePath();
				if (File.Exists(cacheRecordDeltaFilePath))
				{
					File.Delete(cacheRecordDeltaFilePath);
				}
			}
			catch (Exception arg)
			{
				YooLogger.Warning($"Failed to delete cache record delta : {arg}");
			}
			return true;
		}
		catch (Exception arg2)
		{
			YooLogger.Warning($"Failed to save cache records snapshot : {arg2}");
			return false;
		}
		finally
		{
			if (File.Exists(text))
			{
				try
				{
					File.Delete(text);
				}
				catch (Exception)
				{
				}
			}
		}
	}

	public void RemoveRecordsNotIn(HashSet<string> existingGUIDs)
	{
		if (_records.Count == 0)
		{
			return;
		}
		if (existingGUIDs == null || existingGUIDs.Count == 0)
		{
			_records.Clear();
			return;
		}
		List<string> list = null;
		foreach (KeyValuePair<string, RecordFileElement> record in _records)
		{
			if (!existingGUIDs.Contains(record.Key))
			{
				if (list == null)
				{
					list = new List<string>();
				}
				list.Add(record.Key);
			}
		}
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				_records.Remove(list[i]);
			}
		}
	}

	private void AppendRecordDelta(bool add, string bundleGUID, string infoFilePath, string dataFilePath, string dataFileCRC, long dataFileSize)
	{
		try
		{
			string cacheRecordDeltaFilePath = GetCacheRecordDeltaFilePath();
			FileUtility.CreateFileDirectory(cacheRecordDeltaFilePath);
			using FileStream fileStream = new FileStream(cacheRecordDeltaFilePath, FileMode.Append, FileAccess.Write, FileShare.Read);
			using BinaryWriter binaryWriter = new BinaryWriter(fileStream);
			if (add)
			{
				binaryWriter.Write((byte)1);
				binaryWriter.Write(bundleGUID);
				binaryWriter.Write(infoFilePath);
				binaryWriter.Write(dataFilePath);
				binaryWriter.Write(dataFileCRC ?? string.Empty);
				binaryWriter.Write(dataFileSize);
			}
			else
			{
				binaryWriter.Write((byte)2);
				binaryWriter.Write(bundleGUID);
			}
			binaryWriter.Flush();
			fileStream.Flush();
		}
		catch (Exception arg)
		{
			YooLogger.Warning($"Failed to append cache record delta : {arg}");
		}
	}

	public void DeleteAllBundleFiles()
	{
		if (Directory.Exists(_cacheBundleFilesRoot))
		{
			Directory.Delete(_cacheBundleFilesRoot, recursive: true);
		}
	}

	public void DeleteAllManifestFiles()
	{
		if (Directory.Exists(_cacheManifestFilesRoot))
		{
			Directory.Delete(_cacheManifestFilesRoot, recursive: true);
		}
	}

	public DecryptResult LoadEncryptedAssetBundle(PackageBundle bundle)
	{
		string cacheBundleFileLoadPath = GetCacheBundleFileLoadPath(bundle);
		DecryptFileInfo fileInfo = CreateDecryptFileInfo(bundle, cacheBundleFileLoadPath);
		return DecryptionServices.LoadAssetBundle(fileInfo);
	}

	public DecryptResult LoadEncryptedAssetBundleAsync(PackageBundle bundle)
	{
		string cacheBundleFileLoadPath = GetCacheBundleFileLoadPath(bundle);
		DecryptFileInfo fileInfo = CreateDecryptFileInfo(bundle, cacheBundleFileLoadPath);
		return DecryptionServices.LoadAssetBundleAsync(fileInfo);
	}

	public DecryptResult LoadEncryptedAssetBundleFallback(PackageBundle bundle)
	{
		string cacheBundleFileLoadPath = GetCacheBundleFileLoadPath(bundle);
		DecryptFileInfo fileInfo = CreateDecryptFileInfo(bundle, cacheBundleFileLoadPath);
		return DecryptionServices.LoadAssetBundleFallback(fileInfo);
	}
}

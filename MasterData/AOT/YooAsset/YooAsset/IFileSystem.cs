using System.IO;

namespace YooAsset;

internal interface IFileSystem
{
	string PackageName { get; }

	string FileRoot { get; }

	int FileCount { get; }

	FSInitializeFileSystemOperation InitializeFileSystemAsync();

	FSLoadPackageManifestOperation LoadPackageManifestAsync(string packageVersion, int timeout);

	FSRequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks, int timeout);

	FSClearCacheFilesOperation ClearCacheFilesAsync(PackageManifest manifest, ClearCacheFilesOptions options);

	FSDownloadFileOperation DownloadFileAsync(PackageBundle bundle, DownloadFileOptions options);

	FSLoadBundleOperation LoadBundleFile(PackageBundle bundle);

	void SetParameter(string name, object value);

	void OnCreate(string packageName, string packageRoot);

	void OnDestroy();

	bool Belong(PackageBundle bundle);

	bool Exists(PackageBundle bundle);

	bool NeedDownload(PackageBundle bundle);

	bool NeedUnpack(PackageBundle bundle);

	bool NeedImport(PackageBundle bundle);

	string GetBundleFilePath(PackageBundle bundle);

	Stream OpenBundleFileStream(PackageBundle bundle);

	byte[] ReadBundleFileData(PackageBundle bundle);

	string ReadBundleFileText(PackageBundle bundle);
}

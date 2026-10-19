using System;
using System.IO;

namespace YooAsset;

internal sealed class ClearUnusedCacheManifestFilesOperation : FSClearCacheFilesOperation
{
	private enum ESteps
	{
		None,
		CheckManifest,
		ClearUnusedCacheFiles,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private readonly PackageManifest _manifest;

	private ESteps _steps;

	internal ClearUnusedCacheManifestFilesOperation(DefaultCacheFileSystem fileSystem, PackageManifest manifest)
	{
		_fileSystem = fileSystem;
		_manifest = manifest;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckManifest;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckManifest)
		{
			if (_manifest == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Can not found active package manifest !";
			}
			else
			{
				_steps = ESteps.ClearUnusedCacheFiles;
			}
		}
		if (_steps != ESteps.ClearUnusedCacheFiles)
		{
			return;
		}
		try
		{
			string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(_manifest.PackageName, _manifest.PackageVersion);
			string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(_manifest.PackageName, _manifest.PackageVersion);
			DirectoryInfo directoryInfo = new DirectoryInfo(_fileSystem.GetCacheManifestFilesRoot());
			if (directoryInfo.Exists)
			{
				FileInfo[] files = directoryInfo.GetFiles();
				foreach (FileInfo fileInfo in files)
				{
					string name = fileInfo.Name;
					if (!(name == "ApplicationFootPrint.bytes") && !(name == manifestBinaryFileName) && !(name == packageHashFileName))
					{
						fileInfo.Delete();
					}
				}
			}
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
		catch (Exception ex)
		{
			_steps = ESteps.Done;
			Error = ex.Message;
			Status = EOperationStatus.Failed;
		}
	}
}

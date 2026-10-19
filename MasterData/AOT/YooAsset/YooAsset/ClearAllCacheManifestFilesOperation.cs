using System;
using System.IO;

namespace YooAsset;

internal sealed class ClearAllCacheManifestFilesOperation : FSClearCacheFilesOperation
{
	private enum ESteps
	{
		None,
		ClearAllCacheFiles,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private ESteps _steps;

	internal ClearAllCacheManifestFilesOperation(DefaultCacheFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.ClearAllCacheFiles;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.ClearAllCacheFiles)
		{
			return;
		}
		try
		{
			DirectoryInfo directoryInfo = new DirectoryInfo(_fileSystem.GetCacheManifestFilesRoot());
			if (directoryInfo.Exists)
			{
				FileInfo[] files = directoryInfo.GetFiles();
				foreach (FileInfo fileInfo in files)
				{
					if (!(fileInfo.Name == "ApplicationFootPrint.bytes"))
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

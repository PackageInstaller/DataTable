using System;

namespace YooAsset;

internal sealed class LoadWebServerCatalogFileOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestData,
		LoadCatalog,
		Done
	}

	private readonly DefaultWebServerFileSystem _fileSystem;

	private UnityWebDataRequestOperation _webDataRequestOp;

	private ESteps _steps;

	internal LoadWebServerCatalogFileOperation(DefaultWebServerFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.RequestData;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.RequestData)
		{
			if (_webDataRequestOp == null)
			{
				string url = DownloadSystemHelper.ConvertToWWWPath(_fileSystem.GetCatalogBinaryFileLoadPath());
				_webDataRequestOp = new UnityWebDataRequestOperation(url);
				_webDataRequestOp.StartOperation();
				AddChildOperation(_webDataRequestOp);
			}
			_webDataRequestOp.UpdateOperation();
			if (!_webDataRequestOp.IsDone)
			{
				return;
			}
			if (_webDataRequestOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.LoadCatalog;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _webDataRequestOp.Error;
			}
		}
		if (_steps != ESteps.LoadCatalog)
		{
			return;
		}
		try
		{
			DefaultBuildinFileCatalog defaultBuildinFileCatalog = CatalogTools.DeserializeFromBinary(_webDataRequestOp.Result);
			if (defaultBuildinFileCatalog.PackageName != _fileSystem.PackageName)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Catalog file package name " + defaultBuildinFileCatalog.PackageName + " cannot match the file system package name " + _fileSystem.PackageName;
				return;
			}
			foreach (DefaultBuildinFileCatalog.FileWrapper wrapper2 in defaultBuildinFileCatalog.Wrappers)
			{
				DefaultWebServerFileSystem.FileWrapper wrapper = new DefaultWebServerFileSystem.FileWrapper(wrapper2.FileName);
				_fileSystem.RecordCatalogFile(wrapper2.BundleGUID, wrapper);
			}
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
		catch (Exception ex)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = "Failed to load catalog file : " + ex.Message;
		}
	}
}

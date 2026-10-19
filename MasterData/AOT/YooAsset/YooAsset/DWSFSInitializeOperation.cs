namespace YooAsset;

internal class DWSFSInitializeOperation : FSInitializeFileSystemOperation
{
	private enum ESteps
	{
		None,
		LoadCatalogFile,
		Done
	}

	private readonly DefaultWebServerFileSystem _fileSystem;

	private LoadWebServerCatalogFileOperation _loadCatalogFileOp;

	private ESteps _steps;

	public DWSFSInitializeOperation(DefaultWebServerFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.LoadCatalogFile;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.LoadCatalogFile)
		{
			return;
		}
		if (_loadCatalogFileOp == null)
		{
			_loadCatalogFileOp = new LoadWebServerCatalogFileOperation(_fileSystem);
			_loadCatalogFileOp.StartOperation();
			AddChildOperation(_loadCatalogFileOp);
		}
		_loadCatalogFileOp.UpdateOperation();
		if (_loadCatalogFileOp.IsDone)
		{
			if (_loadCatalogFileOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _loadCatalogFileOp.Error;
			}
		}
	}
}

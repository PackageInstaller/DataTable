namespace YooAsset;

internal class DBFSInitializeOperation : FSInitializeFileSystemOperation
{
	private enum ESteps
	{
		None,
		CopyBuildinManifest,
		InitUnpackFileSystem,
		LoadCatalogFile,
		Done
	}

	private readonly DefaultBuildinFileSystem _fileSystem;

	private CopyBuildinPackageManifestOperation _copyBuildinPackageManifestOp;

	private FSInitializeFileSystemOperation _initUnpackFIleSystemOp;

	private LoadBuildinCatalogFileOperation _loadCatalogFileOp;

	private ESteps _steps;

	internal DBFSInitializeOperation(DefaultBuildinFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		if (_fileSystem.CopyBuildinPackageManifest)
		{
			_steps = ESteps.CopyBuildinManifest;
		}
		else
		{
			_steps = ESteps.InitUnpackFileSystem;
		}
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CopyBuildinManifest)
		{
			if (_copyBuildinPackageManifestOp == null)
			{
				_copyBuildinPackageManifestOp = new CopyBuildinPackageManifestOperation(_fileSystem);
				_copyBuildinPackageManifestOp.StartOperation();
				AddChildOperation(_copyBuildinPackageManifestOp);
			}
			_copyBuildinPackageManifestOp.UpdateOperation();
			if (!_copyBuildinPackageManifestOp.IsDone)
			{
				return;
			}
			if (_copyBuildinPackageManifestOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.InitUnpackFileSystem;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _copyBuildinPackageManifestOp.Error;
			}
		}
		if (_steps == ESteps.InitUnpackFileSystem)
		{
			if (_initUnpackFIleSystemOp == null)
			{
				_initUnpackFIleSystemOp = _fileSystem.InitializeUpackFileSystem();
				_initUnpackFIleSystemOp.StartOperation();
				AddChildOperation(_initUnpackFIleSystemOp);
			}
			_initUnpackFIleSystemOp.UpdateOperation();
			Progress = _initUnpackFIleSystemOp.Progress;
			if (!_initUnpackFIleSystemOp.IsDone)
			{
				return;
			}
			if (_initUnpackFIleSystemOp.Status == EOperationStatus.Succeed)
			{
				if (_fileSystem.DisableCatalogFile)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Succeed;
				}
				else
				{
					_steps = ESteps.LoadCatalogFile;
				}
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _initUnpackFIleSystemOp.Error;
			}
		}
		if (_steps != ESteps.LoadCatalogFile)
		{
			return;
		}
		if (_loadCatalogFileOp == null)
		{
			_loadCatalogFileOp = new LoadBuildinCatalogFileOperation(_fileSystem);
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

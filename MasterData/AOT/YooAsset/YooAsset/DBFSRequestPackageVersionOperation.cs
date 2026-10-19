namespace YooAsset;

internal class DBFSRequestPackageVersionOperation : FSRequestPackageVersionOperation
{
	private enum ESteps
	{
		None,
		RequestPackageVersion,
		Done
	}

	private readonly DefaultBuildinFileSystem _fileSystem;

	private RequestBuildinPackageVersionOperation _requestBuildinPackageVersionOp;

	private ESteps _steps;

	internal DBFSRequestPackageVersionOperation(DefaultBuildinFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.RequestPackageVersion;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.RequestPackageVersion)
		{
			return;
		}
		if (_requestBuildinPackageVersionOp == null)
		{
			_requestBuildinPackageVersionOp = new RequestBuildinPackageVersionOperation(_fileSystem);
			_requestBuildinPackageVersionOp.StartOperation();
			AddChildOperation(_requestBuildinPackageVersionOp);
		}
		_requestBuildinPackageVersionOp.UpdateOperation();
		if (_requestBuildinPackageVersionOp.IsDone)
		{
			if (_requestBuildinPackageVersionOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.Done;
				PackageVersion = _requestBuildinPackageVersionOp.PackageVersion;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _requestBuildinPackageVersionOp.Error;
			}
		}
	}
}

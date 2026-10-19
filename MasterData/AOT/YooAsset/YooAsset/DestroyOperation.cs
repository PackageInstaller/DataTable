using System;

namespace YooAsset;

public class DestroyOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		CheckInitStatus,
		UnloadAllAssets,
		DestroyPackage,
		Done
	}

	private readonly ResourcePackage _resourcePackage;

	private UnloadAllAssetsOperation _unloadAllAssetsOp;

	private ESteps _steps;

	public DestroyOperation(ResourcePackage resourcePackage)
	{
		_resourcePackage = resourcePackage;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckInitStatus;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckInitStatus)
		{
			if (_resourcePackage.InitializeStatus == EOperationStatus.None)
			{
				_steps = ESteps.DestroyPackage;
			}
			else if (_resourcePackage.InitializeStatus == EOperationStatus.Processing)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "The Package is initializing ! Please try to destroy the package again later.";
			}
			else if (_resourcePackage.InitializeStatus == EOperationStatus.Failed)
			{
				_steps = ESteps.DestroyPackage;
			}
			else
			{
				if (_resourcePackage.InitializeStatus != EOperationStatus.Succeed)
				{
					throw new NotImplementedException(_resourcePackage.InitializeStatus.ToString());
				}
				if (_resourcePackage.PackageValid)
				{
					_steps = ESteps.UnloadAllAssets;
				}
				else
				{
					_steps = ESteps.DestroyPackage;
				}
			}
		}
		if (_steps == ESteps.UnloadAllAssets)
		{
			if (_unloadAllAssetsOp == null)
			{
				_unloadAllAssetsOp = _resourcePackage.UnloadAllAssetsAsync();
				_unloadAllAssetsOp.StartOperation();
				AddChildOperation(_unloadAllAssetsOp);
			}
			_unloadAllAssetsOp.UpdateOperation();
			if (!_unloadAllAssetsOp.IsDone)
			{
				return;
			}
			if (_unloadAllAssetsOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.DestroyPackage;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _unloadAllAssetsOp.Error;
			}
		}
		if (_steps == ESteps.DestroyPackage)
		{
			_resourcePackage.DestroyPackage();
			OperationSystem.ClearPackageOperation(_resourcePackage.PackageName);
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}

	internal override string InternalGetDesc()
	{
		return "PackageVersion : " + _resourcePackage.GetPackageVersion();
	}
}

using System;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace YooAsset;

public sealed class UnloadSceneOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		CheckError,
		WaitDone,
		UnLoadScene,
		Done
	}

	private ESteps _steps;

	private readonly string _error;

	private readonly ProviderOperation _provider;

	private AsyncOperation _asyncOp;

	internal UnloadSceneOperation(string error)
	{
		_error = error;
	}

	internal UnloadSceneOperation(ProviderOperation provider)
	{
		_error = null;
		_provider = provider;
		if (provider is SceneProvider)
		{
			(provider as SceneProvider).UnSuspendLoad();
			return;
		}
		throw new NotImplementedException();
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckError;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckError)
		{
			if (!string.IsNullOrEmpty(_error))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _error;
				return;
			}
			_steps = ESteps.WaitDone;
		}
		if (_steps == ESteps.WaitDone)
		{
			if (!_provider.IsDone)
			{
				return;
			}
			if (!_provider.SceneObject.IsValid())
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Scene is invalid !";
				return;
			}
			if (!_provider.SceneObject.isLoaded)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Scene is not loaded !";
				return;
			}
			_steps = ESteps.UnLoadScene;
		}
		if (_steps != ESteps.UnLoadScene)
		{
			return;
		}
		if (_asyncOp == null)
		{
			_asyncOp = SceneManager.UnloadSceneAsync(_provider.SceneObject);
			if (_asyncOp == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Unload scene failed, see the console logs !";
				return;
			}
		}
		Progress = _asyncOp.progress;
		if (_asyncOp.isDone)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}

	internal override string InternalGetDesc()
	{
		return "SceneName : " + _provider.SceneName;
	}
}

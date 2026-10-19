using UnityEngine;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal class AssetBundleLoadSceneOperation : FSLoadSceneOperation
{
	protected enum ESteps
	{
		None,
		LoadScene,
		CheckResult,
		Done
	}

	private readonly AssetInfo _assetInfo;

	private readonly LoadSceneParameters _loadParams;

	private bool _suspendLoad;

	private AsyncOperation _asyncOperation;

	private ESteps _steps;

	public AssetBundleLoadSceneOperation(AssetInfo assetInfo, LoadSceneParameters loadParams, bool suspendLoad)
	{
		_assetInfo = assetInfo;
		_loadParams = loadParams;
		_suspendLoad = suspendLoad;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.LoadScene;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.LoadScene)
		{
			if (IsWaitForAsyncComplete)
			{
				Result = SceneManager.LoadScene(_assetInfo.AssetPath, _loadParams);
				_steps = ESteps.CheckResult;
			}
			else
			{
				_asyncOperation = SceneManager.LoadSceneAsync(_assetInfo.AssetPath, _loadParams);
				if (_asyncOperation != null)
				{
					_asyncOperation.allowSceneActivation = !_suspendLoad;
					_asyncOperation.priority = 100;
					Result = SceneManager.GetSceneAt(SceneManager.sceneCount - 1);
					_steps = ESteps.CheckResult;
				}
				else
				{
					string text = "Failed to load scene : " + _assetInfo.AssetPath;
					YooLogger.Error(text);
					_steps = ESteps.Done;
					Error = text;
					Status = EOperationStatus.Failed;
				}
			}
		}
		if (_steps != ESteps.CheckResult)
		{
			return;
		}
		if (_asyncOperation != null)
		{
			if (IsWaitForAsyncComplete)
			{
				YooLogger.Error("The scene is loading asyn !");
			}
			else
			{
				if (!_asyncOperation.allowSceneActivation && !_suspendLoad)
				{
					_asyncOperation.allowSceneActivation = true;
				}
				Progress = _asyncOperation.progress;
				if (!_asyncOperation.isDone)
				{
					return;
				}
			}
		}
		if (Result.IsValid())
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
			return;
		}
		string text2 = "The loaded scene is invalid : " + _assetInfo.AssetPath;
		YooLogger.Error(text2);
		_steps = ESteps.Done;
		Error = text2;
		Status = EOperationStatus.Failed;
	}

	internal override void InternalWaitForAsyncComplete()
	{
		InternalUpdate();
	}

	public override void UnSuspendLoad()
	{
		_suspendLoad = false;
	}
}

using System.IO;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal sealed class SceneProvider : ProviderOperation
{
	private readonly LoadSceneParameters _loadParams;

	private bool _suspendLoad;

	private FSLoadSceneOperation _loadSceneOp;

	public SceneProvider(ResourceManager manager, string providerGUID, AssetInfo assetInfo, LoadSceneParameters loadParams, bool suspendLoad)
		: base(manager, providerGUID, assetInfo)
	{
		_loadParams = loadParams;
		_suspendLoad = suspendLoad;
		SceneName = Path.GetFileNameWithoutExtension(assetInfo.AssetPath);
	}

	protected override void ProcessBundleResult()
	{
		if (_loadSceneOp == null)
		{
			_loadSceneOp = BundleResultObject.LoadSceneOperation(MainAssetInfo, _loadParams, _suspendLoad);
			_loadSceneOp.StartOperation();
			AddChildOperation(_loadSceneOp);
		}
		if (IsWaitForAsyncComplete)
		{
			_loadSceneOp.WaitForAsyncComplete();
		}
		if (!_suspendLoad)
		{
			_loadSceneOp.UnSuspendLoad();
		}
		_loadSceneOp.UpdateOperation();
		Progress = _loadSceneOp.Progress;
		if (_loadSceneOp.IsDone)
		{
			if (_loadSceneOp.Status != EOperationStatus.Succeed)
			{
				InvokeCompletion(_loadSceneOp.Error, EOperationStatus.Failed);
				return;
			}
			SceneObject = _loadSceneOp.Result;
			InvokeCompletion(string.Empty, EOperationStatus.Succeed);
		}
	}

	public void UnSuspendLoad()
	{
		_suspendLoad = false;
	}
}

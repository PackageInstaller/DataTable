using UnityEngine;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal class VirtualBundleLoadSceneOperation : FSLoadSceneOperation
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

	public VirtualBundleLoadSceneOperation(AssetInfo assetInfo, LoadSceneParameters loadParams, bool suspendLoad)
	{
		_assetInfo = assetInfo;
		_loadParams = loadParams;
		_suspendLoad = suspendLoad;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.Done;
		Error = "VirtualBundleLoadSceneOperation only support unity editor platform !";
		Status = EOperationStatus.Failed;
	}

	internal override void InternalUpdate()
	{
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

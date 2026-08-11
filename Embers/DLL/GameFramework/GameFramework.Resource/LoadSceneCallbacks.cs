namespace GameFramework.Resource;

public sealed class LoadSceneCallbacks
{
	private readonly LoadSceneSuccessCallback m_LoadSceneSuccessCallback;

	private readonly LoadSceneFailureCallback m_LoadSceneFailureCallback;

	private readonly LoadSceneUpdateCallback m_LoadSceneUpdateCallback;

	private readonly LoadSceneDependencyAssetCallback m_LoadSceneDependencyAssetCallback;

	public LoadSceneSuccessCallback LoadSceneSuccessCallback => m_LoadSceneSuccessCallback;

	public LoadSceneFailureCallback LoadSceneFailureCallback => m_LoadSceneFailureCallback;

	public LoadSceneUpdateCallback LoadSceneUpdateCallback => m_LoadSceneUpdateCallback;

	public LoadSceneDependencyAssetCallback LoadSceneDependencyAssetCallback => m_LoadSceneDependencyAssetCallback;

	public LoadSceneCallbacks(LoadSceneSuccessCallback loadSceneSuccessCallback)
		: this(loadSceneSuccessCallback, null, null, null)
	{
	}

	public LoadSceneCallbacks(LoadSceneSuccessCallback loadSceneSuccessCallback, LoadSceneFailureCallback loadSceneFailureCallback)
		: this(loadSceneSuccessCallback, loadSceneFailureCallback, null, null)
	{
	}

	public LoadSceneCallbacks(LoadSceneSuccessCallback loadSceneSuccessCallback, LoadSceneUpdateCallback loadSceneUpdateCallback)
		: this(loadSceneSuccessCallback, null, loadSceneUpdateCallback, null)
	{
	}

	public LoadSceneCallbacks(LoadSceneSuccessCallback loadSceneSuccessCallback, LoadSceneDependencyAssetCallback loadSceneDependencyAssetCallback)
		: this(loadSceneSuccessCallback, null, null, loadSceneDependencyAssetCallback)
	{
	}

	public LoadSceneCallbacks(LoadSceneSuccessCallback loadSceneSuccessCallback, LoadSceneFailureCallback loadSceneFailureCallback, LoadSceneUpdateCallback loadSceneUpdateCallback)
		: this(loadSceneSuccessCallback, loadSceneFailureCallback, loadSceneUpdateCallback, null)
	{
	}

	public LoadSceneCallbacks(LoadSceneSuccessCallback loadSceneSuccessCallback, LoadSceneFailureCallback loadSceneFailureCallback, LoadSceneDependencyAssetCallback loadSceneDependencyAssetCallback)
		: this(loadSceneSuccessCallback, loadSceneFailureCallback, null, loadSceneDependencyAssetCallback)
	{
	}

	public LoadSceneCallbacks(LoadSceneSuccessCallback loadSceneSuccessCallback, LoadSceneFailureCallback loadSceneFailureCallback, LoadSceneUpdateCallback loadSceneUpdateCallback, LoadSceneDependencyAssetCallback loadSceneDependencyAssetCallback)
	{
		if (loadSceneSuccessCallback == null)
		{
			throw new GameFrameworkException("Load scene success callback is invalid.");
		}
		m_LoadSceneSuccessCallback = loadSceneSuccessCallback;
		m_LoadSceneFailureCallback = loadSceneFailureCallback;
		m_LoadSceneUpdateCallback = loadSceneUpdateCallback;
		m_LoadSceneDependencyAssetCallback = loadSceneDependencyAssetCallback;
	}
}

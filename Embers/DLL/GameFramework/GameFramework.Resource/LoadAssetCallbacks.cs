namespace GameFramework.Resource;

public sealed class LoadAssetCallbacks
{
	private readonly LoadAssetSuccessCallback m_LoadAssetSuccessCallback;

	private readonly LoadAssetFailureCallback m_LoadAssetFailureCallback;

	private readonly LoadAssetUpdateCallback m_LoadAssetUpdateCallback;

	private readonly LoadAssetDependencyAssetCallback m_LoadAssetDependencyAssetCallback;

	public LoadAssetSuccessCallback LoadAssetSuccessCallback => m_LoadAssetSuccessCallback;

	public LoadAssetFailureCallback LoadAssetFailureCallback => m_LoadAssetFailureCallback;

	public LoadAssetUpdateCallback LoadAssetUpdateCallback => m_LoadAssetUpdateCallback;

	public LoadAssetDependencyAssetCallback LoadAssetDependencyAssetCallback => m_LoadAssetDependencyAssetCallback;

	public LoadAssetCallbacks(LoadAssetSuccessCallback loadAssetSuccessCallback)
		: this(loadAssetSuccessCallback, null, null, null)
	{
	}

	public LoadAssetCallbacks(LoadAssetSuccessCallback loadAssetSuccessCallback, LoadAssetFailureCallback loadAssetFailureCallback)
		: this(loadAssetSuccessCallback, loadAssetFailureCallback, null, null)
	{
	}

	public LoadAssetCallbacks(LoadAssetSuccessCallback loadAssetSuccessCallback, LoadAssetUpdateCallback loadAssetUpdateCallback)
		: this(loadAssetSuccessCallback, null, loadAssetUpdateCallback, null)
	{
	}

	public LoadAssetCallbacks(LoadAssetSuccessCallback loadAssetSuccessCallback, LoadAssetDependencyAssetCallback loadAssetDependencyAssetCallback)
		: this(loadAssetSuccessCallback, null, null, loadAssetDependencyAssetCallback)
	{
	}

	public LoadAssetCallbacks(LoadAssetSuccessCallback loadAssetSuccessCallback, LoadAssetFailureCallback loadAssetFailureCallback, LoadAssetUpdateCallback loadAssetUpdateCallback)
		: this(loadAssetSuccessCallback, loadAssetFailureCallback, loadAssetUpdateCallback, null)
	{
	}

	public LoadAssetCallbacks(LoadAssetSuccessCallback loadAssetSuccessCallback, LoadAssetFailureCallback loadAssetFailureCallback, LoadAssetDependencyAssetCallback loadAssetDependencyAssetCallback)
		: this(loadAssetSuccessCallback, loadAssetFailureCallback, null, loadAssetDependencyAssetCallback)
	{
	}

	public LoadAssetCallbacks(LoadAssetSuccessCallback loadAssetSuccessCallback, LoadAssetFailureCallback loadAssetFailureCallback, LoadAssetUpdateCallback loadAssetUpdateCallback, LoadAssetDependencyAssetCallback loadAssetDependencyAssetCallback)
	{
		if (loadAssetSuccessCallback == null)
		{
			throw new GameFrameworkException("Load asset success callback is invalid.");
		}
		m_LoadAssetSuccessCallback = loadAssetSuccessCallback;
		m_LoadAssetFailureCallback = loadAssetFailureCallback;
		m_LoadAssetUpdateCallback = loadAssetUpdateCallback;
		m_LoadAssetDependencyAssetCallback = loadAssetDependencyAssetCallback;
	}
}

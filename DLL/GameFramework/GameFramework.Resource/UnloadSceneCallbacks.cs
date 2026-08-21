namespace GameFramework.Resource;

public sealed class UnloadSceneCallbacks
{
	private readonly UnloadSceneSuccessCallback m_UnloadSceneSuccessCallback;

	private readonly UnloadSceneFailureCallback m_UnloadSceneFailureCallback;

	private readonly UnloadSceneUpdateCallback m_UnloadSceneUpdateCallback;

	public UnloadSceneSuccessCallback UnloadSceneSuccessCallback => m_UnloadSceneSuccessCallback;

	public UnloadSceneFailureCallback UnloadSceneFailureCallback => m_UnloadSceneFailureCallback;

	public UnloadSceneUpdateCallback UnloadSceneUpdateCallback => m_UnloadSceneUpdateCallback;

	public UnloadSceneCallbacks(UnloadSceneSuccessCallback unloadSceneSuccessCallback)
		: this(unloadSceneSuccessCallback, null)
	{
	}

	public UnloadSceneCallbacks(UnloadSceneSuccessCallback unloadSceneSuccessCallback, UnloadSceneFailureCallback unloadSceneFailureCallback)
	{
		if (unloadSceneSuccessCallback == null)
		{
			throw new GameFrameworkException("Unload scene success callback is invalid.");
		}
		m_UnloadSceneSuccessCallback = unloadSceneSuccessCallback;
		m_UnloadSceneFailureCallback = unloadSceneFailureCallback;
	}

	public UnloadSceneCallbacks(UnloadSceneSuccessCallback unloadSceneSuccessCallback, UnloadSceneFailureCallback unloadSceneFailureCallback, UnloadSceneUpdateCallback unloadSceneUpdateCallback)
	{
		if (unloadSceneSuccessCallback == null)
		{
			throw new GameFrameworkException("Unload scene success callback is invalid.");
		}
		m_UnloadSceneSuccessCallback = unloadSceneSuccessCallback;
		m_UnloadSceneFailureCallback = unloadSceneFailureCallback;
		m_UnloadSceneUpdateCallback = unloadSceneUpdateCallback;
	}
}

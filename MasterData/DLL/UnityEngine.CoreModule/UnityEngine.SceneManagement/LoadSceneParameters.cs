using System;

namespace UnityEngine.SceneManagement;

[Serializable]
public struct LoadSceneParameters
{
	[SerializeField]
	private LoadSceneMode m_LoadSceneMode;

	[SerializeField]
	private LocalPhysicsMode m_LocalPhysicsMode;

	public LoadSceneMode loadSceneMode
	{
		get
		{
			return m_LoadSceneMode;
		}
		set
		{
			m_LoadSceneMode = value;
		}
	}

	public LocalPhysicsMode localPhysicsMode
	{
		get
		{
			return m_LocalPhysicsMode;
		}
		set
		{
			m_LocalPhysicsMode = value;
		}
	}

	public LoadSceneParameters(LoadSceneMode mode)
	{
		m_LoadSceneMode = mode;
		m_LocalPhysicsMode = LocalPhysicsMode.None;
	}

	public LoadSceneParameters(LoadSceneMode mode, LocalPhysicsMode physicsMode)
	{
		m_LoadSceneMode = mode;
		m_LocalPhysicsMode = physicsMode;
	}
}

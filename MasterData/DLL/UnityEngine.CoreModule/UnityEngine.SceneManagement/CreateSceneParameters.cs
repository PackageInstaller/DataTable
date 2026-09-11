using System;

namespace UnityEngine.SceneManagement;

[Serializable]
public struct CreateSceneParameters
{
	[SerializeField]
	private LocalPhysicsMode m_LocalPhysicsMode;

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

	public CreateSceneParameters(LocalPhysicsMode physicsMode)
	{
		m_LocalPhysicsMode = physicsMode;
	}
}

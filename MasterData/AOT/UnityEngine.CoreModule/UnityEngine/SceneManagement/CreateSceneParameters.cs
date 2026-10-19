using System;

namespace UnityEngine.SceneManagement;

[Serializable]
public struct CreateSceneParameters(LocalPhysicsMode physicsMode)
{
	[SerializeField]
	private LocalPhysicsMode m_LocalPhysicsMode = physicsMode;
}

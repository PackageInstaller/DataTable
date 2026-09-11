using System;

namespace UnityEngine.SceneManagement;

[Flags]
public enum UnloadSceneOptions
{
	None = 0,
	UnloadAllEmbeddedSceneObjects = 1
}

using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.SceneManagement;

[NativeHeader("Runtime/Export/SceneManager/SceneUtility.bindings.h")]
public static class SceneUtility
{
	[MethodImpl((MethodImplOptions)4096)]
	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern string GetScenePathByBuildIndex(int buildIndex);
}

using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.SceneManagement;

[NativeHeader("Runtime/Export/SceneManager/SceneManager.bindings.h")]
[NativeHeader("Runtime/SceneManager/SceneManager.h")]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
internal static class SceneManagerAPIInternal
{
	[MethodImpl((MethodImplOptions)4096)]
	public static extern int GetNumScenesInBuildSettings();

	[NativeThrows]
	public static Scene GetSceneByBuildIndex(int buildIndex)
	{
		GetSceneByBuildIndex_Injected(buildIndex, out var ret);
		return ret;
	}

	[NativeThrows]
	public static AsyncOperation LoadSceneAsyncNameIndexInternal(string sceneName, int sceneBuildIndex, LoadSceneParameters parameters, bool mustCompleteNextFrame)
	{
		return LoadSceneAsyncNameIndexInternal_Injected(sceneName, sceneBuildIndex, ref parameters, mustCompleteNextFrame);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	public static extern AsyncOperation UnloadSceneNameIndexInternal(string sceneName, int sceneBuildIndex, bool immediately, UnloadSceneOptions options, out bool outSuccess);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetSceneByBuildIndex_Injected(int buildIndex, out Scene ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern AsyncOperation LoadSceneAsyncNameIndexInternal_Injected(string sceneName, int sceneBuildIndex, ref LoadSceneParameters parameters, bool mustCompleteNextFrame);
}

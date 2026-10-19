using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.SceneManagement;

namespace UnityEngine.ResourceManagement.ResourceProviders;

internal static class SceneProviderExtensions
{
	public static AsyncOperationHandle<SceneInstance> ReleaseScene(this ISceneProvider provider, ResourceManager resourceManager, AsyncOperationHandle<SceneInstance> sceneLoadHandle, UnloadSceneOptions unloadOptions)
	{
		if (provider is ISceneProvider2)
		{
			return ((ISceneProvider2)provider).ReleaseScene(resourceManager, sceneLoadHandle, unloadOptions);
		}
		return provider.ReleaseScene(resourceManager, sceneLoadHandle);
	}
}

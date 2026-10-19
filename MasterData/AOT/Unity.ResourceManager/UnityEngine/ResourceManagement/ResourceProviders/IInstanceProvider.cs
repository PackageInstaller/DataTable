using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.ResourceManagement.ResourceProviders;

public interface IInstanceProvider
{
	GameObject ProvideInstance(ResourceManager resourceManager, AsyncOperationHandle<GameObject> prefabHandle, InstantiationParameters instantiateParameters);

	void ReleaseInstance(ResourceManager resourceManager, GameObject instance);
}

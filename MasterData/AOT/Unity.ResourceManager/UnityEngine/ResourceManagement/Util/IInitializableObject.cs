using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.ResourceManagement.Util;

public interface IInitializableObject
{
	bool Initialize(string id, string data);

	AsyncOperationHandle<bool> InitializeAsync(ResourceManager rm, string id, string data);
}

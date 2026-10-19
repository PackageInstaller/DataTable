using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

public abstract class LocalizedAssetBase : LocalizedReference
{
	public abstract AsyncOperationHandle<Object> LoadAssetAsObjectAsync();
}

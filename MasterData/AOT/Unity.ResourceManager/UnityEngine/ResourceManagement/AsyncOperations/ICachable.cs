using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.AsyncOperations;

internal interface ICachable
{
	IOperationCacheKey Key { get; set; }
}

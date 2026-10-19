using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace UnityEngine.ResourceManagement.AsyncOperations;

internal interface IAsyncOperation
{
	Type ResultType { get; }

	int Version { get; }

	string DebugName { get; }

	int ReferenceCount { get; }

	float PercentComplete { get; }

	AsyncOperationStatus Status { get; }

	Exception OperationException { get; }

	bool IsDone { get; }

	Action<IAsyncOperation> OnDestroy { set; }

	bool IsRunning { get; }

	Task<object> Task { get; }

	AsyncOperationHandle Handle { get; }

	event Action<AsyncOperationHandle> CompletedTypeless;

	event Action<AsyncOperationHandle> Destroyed;

	object GetResultAsObject();

	void DecrementReferenceCount();

	void IncrementReferenceCount();

	DownloadStatus GetDownloadStatus(HashSet<object> visited);

	void GetDependencies(List<AsyncOperationHandle> deps);

	void InvokeCompletionEvent();

	void Start(ResourceManager rm, AsyncOperationHandle dependency, DelegateList<float> updateCallbacks);

	void WaitForCompletion();
}

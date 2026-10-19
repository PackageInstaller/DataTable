using System;
using System.Collections.Generic;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.ResourceProviders;

namespace UnityEngine.ResourceManagement.AsyncOperations;

internal interface IGenericProviderOperation
{
	int ProvideHandleVersion { get; }

	IResourceLocation Location { get; }

	int DependencyCount { get; }

	Type RequestedType { get; }

	void Init(ResourceManager rm, IResourceProvider provider, IResourceLocation location, AsyncOperationHandle<IList<AsyncOperationHandle>> depOp);

	void Init(ResourceManager rm, IResourceProvider provider, IResourceLocation location, AsyncOperationHandle<IList<AsyncOperationHandle>> depOp, bool releaseDependenciesOnFailure);

	void GetDependencies(IList<object> dstList);

	TDepObject GetDependency<TDepObject>(int index);

	void SetProgressCallback(Func<float> callback);

	void ProviderCompleted<T>(T result, bool status, Exception e);

	void SetDownloadProgressCallback(Func<DownloadStatus> callback);

	void SetWaitForCompletionCallback(Func<bool> callback);
}

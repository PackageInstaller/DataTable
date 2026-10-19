using System;
using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.ResourceProviders;

public interface IResourceProvider
{
	string ProviderId { get; }

	ProviderBehaviourFlags BehaviourFlags { get; }

	Type GetDefaultType(IResourceLocation location);

	bool CanProvide(Type type, IResourceLocation location);

	void Provide(ProvideHandle provideHandle);

	void Release(IResourceLocation location, object asset);
}

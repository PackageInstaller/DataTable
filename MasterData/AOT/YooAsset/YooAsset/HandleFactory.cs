using System;
using System.Collections.Generic;

namespace YooAsset;

internal static class HandleFactory
{
	private static readonly Dictionary<Type, Func<ProviderOperation, HandleBase>> _handleFactory = new Dictionary<Type, Func<ProviderOperation, HandleBase>>
	{
		{
			typeof(AssetHandle),
			(ProviderOperation op) => new AssetHandle(op)
		},
		{
			typeof(SceneHandle),
			(ProviderOperation op) => new SceneHandle(op)
		},
		{
			typeof(SubAssetsHandle),
			(ProviderOperation op) => new SubAssetsHandle(op)
		},
		{
			typeof(AllAssetsHandle),
			(ProviderOperation op) => new AllAssetsHandle(op)
		},
		{
			typeof(RawFileHandle),
			(ProviderOperation op) => new RawFileHandle(op)
		}
	};

	public static HandleBase CreateHandle(ProviderOperation operation, Type type)
	{
		if (!_handleFactory.TryGetValue(type, out var value))
		{
			throw new NotImplementedException("Handle type " + type.FullName + " is not supported.");
		}
		return value(operation);
	}
}

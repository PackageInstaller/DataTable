using System;
using System.ComponentModel;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[DisplayName("Binary Asset Provider")]
internal class BinaryAssetProvider<TAdapter> : BinaryDataProvider where TAdapter : BinaryStorageBuffer.ISerializationAdapter, new()
{
	public override object Convert(Type type, byte[] data)
	{
		return new BinaryStorageBuffer.Reader(data, 512, new TAdapter()).ReadObject(type, 0u, cacheValue: false);
	}
}

using System;
using System.ComponentModel;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.Util;
using UnityEngine.U2D;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[DisplayName("Sprites from Atlases Provider")]
public class AtlasSpriteProvider : ResourceProviderBase
{
	public override void Provide(ProvideHandle providerInterface)
	{
		SpriteAtlas dependency = providerInterface.GetDependency<SpriteAtlas>(0);
		if (dependency == null)
		{
			providerInterface.Complete<Sprite>(null, status: false, new Exception("Sprite atlas failed to load for location " + providerInterface.Location.PrimaryKey + "."));
			return;
		}
		ResourceManagerConfig.ExtractKeyAndSubKey(providerInterface.ResourceManager.TransformInternalId(providerInterface.Location), out var mainKey, out var subKey);
		string name = (string.IsNullOrEmpty(subKey) ? mainKey : subKey);
		Sprite sprite = dependency.GetSprite(name);
		providerInterface.Complete(sprite, sprite != null, (sprite != null) ? null : new Exception("Sprite failed to load for location " + providerInterface.Location.PrimaryKey + "."));
	}

	public override void Release(IResourceLocation location, object obj)
	{
		if (obj is Sprite obj2)
		{
			Object.Destroy(obj2);
		}
	}
}

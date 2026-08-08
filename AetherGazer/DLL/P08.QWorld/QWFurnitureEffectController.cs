using System.Collections.Generic;
using UnityEngine;

public class QWFurnitureEffectController
{
	public struct EffectBundle
	{
		public GameObject bundleUnpack;

		public int refCount;
	}

	public Dictionary<string, EffectBundle> effectBundle;

	public GameObject InstantiateEffect(string effectPath, Transform parent = null)
	{
		if (effectBundle == null)
		{
			effectBundle = new Dictionary<string, EffectBundle>();
		}
		GameObject gameObject = null;
		EffectBundle value = new EffectBundle
		{
			refCount = 0
		};
		if (effectBundle.TryGetValue(effectPath, out value))
		{
			gameObject = value.bundleUnpack;
		}
		else
		{
			effectBundle.Add(effectPath, value);
		}
		if (gameObject == null)
		{
			gameObject = Asset.Load(effectPath) as GameObject;
		}
		value.bundleUnpack = gameObject;
		value.refCount++;
		effectBundle[effectPath] = value;
		return Object.Instantiate(gameObject, parent);
	}

	public void RemoveEffect(string effectPath)
	{
		if (effectBundle != null && effectPath != null && effectBundle.TryGetValue(effectPath, out var value))
		{
			Asset.Unload(effectPath);
			value.refCount--;
			if (value.refCount <= 0)
			{
				effectBundle.Remove(effectPath);
			}
		}
	}

	public void Dispose()
	{
		if (effectBundle == null)
		{
			return;
		}
		foreach (KeyValuePair<string, EffectBundle> item in effectBundle)
		{
			Asset.Unload(item.Key);
		}
		effectBundle.Clear();
	}
}

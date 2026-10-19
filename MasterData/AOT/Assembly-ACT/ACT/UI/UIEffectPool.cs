using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ACT.UI;

public class UIEffectPool
{
	private int maxPoolSize = 8;

	private Transform parent;

	private Dictionary<int, List<UIEffect>> poolDictionary = new Dictionary<int, List<UIEffect>>();

	public UIEffectPool(Transform root)
	{
		parent = root;
	}

	public UIEffect GetObject(UIEffect prefab)
	{
		int hashCode = prefab.GetHashCode();
		if (poolDictionary.ContainsKey(hashCode))
		{
			foreach (UIEffect item in poolDictionary[hashCode])
			{
				if (item.IsUsed)
				{
					item.UsedTimes++;
					continue;
				}
				item.IsUsed = true;
				item.UsedTimes++;
				return item;
			}
			if (poolDictionary[hashCode].Count < maxPoolSize)
			{
				return CreatInstance(hashCode, prefab);
			}
			return poolDictionary[hashCode].Aggregate((UIEffect max, UIEffect uIEffect) => (uIEffect.UsedTimes <= max.UsedTimes) ? max : uIEffect);
		}
		poolDictionary.Add(hashCode, new List<UIEffect>());
		return CreatInstance(hashCode, prefab);
	}

	public void Recycle(UIEffect effect)
	{
		effect.IsUsed = false;
		effect.UsedTimes = 0;
		effect.transform.SetParent(parent, worldPositionStays: false);
	}

	private UIEffect CreatInstance(int mapKey, UIEffect prefab)
	{
		UIEffect uIEffect = Object.Instantiate(prefab, parent);
		uIEffect.Init(this);
		poolDictionary[mapKey].Add(uIEffect);
		return uIEffect;
	}

	public void RecycleAll()
	{
		foreach (List<UIEffect> value in poolDictionary.Values)
		{
			foreach (UIEffect item in value)
			{
				if (item.IsUsed)
				{
					item.Stop();
					Recycle(item);
				}
			}
		}
	}

	public void Clear()
	{
		foreach (List<UIEffect> value in poolDictionary.Values)
		{
			foreach (UIEffect item in value)
			{
				Object.Destroy(item);
			}
			value.Clear();
		}
		poolDictionary.Clear();
	}
}

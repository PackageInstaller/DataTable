using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

internal class EffectPool<T> where T : EffectParameters, new()
{
	private const int _poolCapacity = 8;

	private Dictionary<int, List<T>> _poolDic;

	private int curEffect;

	private Transform _parent;

	public EffectPool(Transform parent)
	{
		_parent = parent;
		_poolDic = new Dictionary<int, List<T>>();
	}

	public T Get(GameObject prefab)
	{
		int hashCode = prefab.GetHashCode();
		if (_poolDic.ContainsKey(hashCode))
		{
			foreach (T item in _poolDic[hashCode])
			{
				if (!item.IsUsing)
				{
					item.IsUsing = true;
					curEffect = _poolDic[hashCode].IndexOf(item);
					return item;
				}
			}
			if (_poolDic[hashCode].Count < 8)
			{
				return CreateNew(hashCode, prefab);
			}
			curEffect = (curEffect + 1) % 8;
			return _poolDic[hashCode][curEffect];
		}
		_poolDic.Add(hashCode, new List<T>());
		return CreateNew(hashCode, prefab);
	}

	public void Recycle(T _obj)
	{
		if (_obj != null)
		{
			_obj.IsUsing = false;
			_obj.UnInit();
		}
	}

	private T CreateNew(int dicKey, GameObject prefab)
	{
		T val = new T
		{
			IsUsing = true,
			Obj = Object.Instantiate(prefab, _parent)
		};
		val.Init();
		_poolDic[dicKey].Add(val);
		curEffect = _poolDic[dicKey].IndexOf(val);
		return val;
	}
}

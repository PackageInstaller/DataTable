using System.Collections.Generic;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.UI;

public abstract class BaseBuffList : MonoBehaviour
{
	[SerializeField]
	protected Transform _content;

	[SerializeField]
	protected BuffUIV3 _prefab;

	[SerializeField]
	protected Transform _recycleContent;

	[SerializeField]
	protected int _maxCount;

	protected ImageAssetStation _station;

	protected EntityBuffIconData _data;

	private Dictionary<string, BuffUIV3> _buffMap = new Dictionary<string, BuffUIV3>();

	private static readonly UnityEngine.Pool.ObjectPool<Stack<BuffUIV3>> _buffUIObjectPoolStack = new UnityEngine.Pool.ObjectPool<Stack<BuffUIV3>>(() => new Stack<BuffUIV3>(), (Stack<BuffUIV3> x) =>
	{
		x.Clear();
	}, (Stack<BuffUIV3> x) =>
	{
		x.Clear();
	});

	private Stack<BuffUIV3> _buffPool;

	protected virtual void Update()
	{
		if (_data != null && Singleton<NewUIManager>.instance != null && Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_BATTLEMAIN) == UIState.Opened && _data.RefreshFromEntity())
		{
			UpdateUIFromBuffList(_data.GetSortedBuffList(), _maxCount);
		}
	}

	public void UpdateUIFromEntityData(EntityBuffIconData entityBuffData)
	{
		if (entityBuffData != null)
		{
			entityBuffData.RefreshFromEntity();
			List<BuffIconInfo> sortedBuffList = entityBuffData.GetSortedBuffList();
			UpdateUIFromBuffList(sortedBuffList, _maxCount);
		}
	}

	private void UpdateUIFromBuffList(List<BuffIconInfo> newBuffList, int maxCount)
	{
		if (newBuffList == null)
		{
			return;
		}
		HashSet<string> hashSet = BuffListOptimizer.GetHashSet();
		int num = Mathf.Min(newBuffList.Count, maxCount);
		for (int i = 0; i < num; i++)
		{
			hashSet.Add(newBuffList[i].AbilityName);
		}
		List<string> list = BuffListOptimizer.CalculateRemovedKeys(_buffMap, hashSet);
		BuffListOptimizer.BatchRemove(list, _buffMap, ReleaseToPool);
		for (int j = 0; j < num; j++)
		{
			BuffIconInfo buffIconInfo = newBuffList[j];
			string abilityName = buffIconInfo.AbilityName;
			if (!_buffMap.TryGetValue(abilityName, out var value))
			{
				value = GetBuffUIInstance();
				_buffMap[abilityName] = value;
				value.transform.SetParent(_content.transform, worldPositionStays: false);
			}
			value.Refresh(buffIconInfo.IconId, buffIconInfo, _station);
			value.transform.SetSiblingIndex(j);
		}
		BuffListOptimizer.ReleaseHashSet(hashSet);
		BuffListOptimizer.ReleaseStringList(list);
	}

	private BuffUIV3 GetBuffUIInstance()
	{
		BuffUIV3 buffUIV = ((_buffPool.Count > 0) ? _buffPool.Pop() : Object.Instantiate(_prefab, _content.transform, worldPositionStays: false));
		buffUIV.transform.localScale = Vector3.one;
		buffUIV.transform.localPosition = Vector3.zero;
		buffUIV.Init();
		return buffUIV;
	}

	private void ReleaseToPool(BuffUIV3 buffUI)
	{
		if (!(buffUI == null))
		{
			buffUI.UnInit();
			buffUI.transform.SetParent(_recycleContent, worldPositionStays: false);
			_buffPool.Push(buffUI);
		}
	}

	protected void ClearAllBuffUIs()
	{
		foreach (BuffUIV3 value in _buffMap.Values)
		{
			ReleaseToPool(value);
		}
		_buffMap.Clear();
	}

	protected void GetObjectPool()
	{
		if (_buffPool == null)
		{
			_buffPool = _buffUIObjectPoolStack.Get();
		}
	}

	protected void ReleaseObjectPool()
	{
		if (_buffPool != null)
		{
			_buffUIObjectPoolStack.Release(_buffPool);
			_buffPool = null;
		}
	}
}

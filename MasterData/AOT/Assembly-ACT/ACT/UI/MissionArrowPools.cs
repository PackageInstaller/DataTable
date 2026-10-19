using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.UI;

public class MissionArrowPools
{
	private class MissionArrowPool
	{
		private Transform _arrowRoot;

		private GameObject _prefab;

		internal Stack<MissionArrow> _pool;

		public MissionArrowPool(Transform arrowRoot, GameObject prefab)
		{
			_arrowRoot = arrowRoot;
			_prefab = prefab;
			_pool = new Stack<MissionArrow>();
		}

		internal MissionArrow Get()
		{
			if (_pool.Count <= 0)
			{
				return UnityEngine.Object.Instantiate(_prefab, _arrowRoot).GetComponent<MissionArrow>();
			}
			return _pool.Pop();
		}

		internal void Release(MissionArrow arrow)
		{
			_pool.Push(arrow);
			if (arrow is MissionArrowUAV missionArrowUAV)
			{
				missionArrowUAV.UnShow();
			}
			else if ((bool)arrow)
			{
				arrow.gameObject.SetActive(value: false);
			}
		}
	}

	private MissionArrowPool _normalPool;

	private MissionArrowPool _uavPool;

	public MissionArrowPools(Transform arrowRoot, GameObject normalPrefab, GameObject uavPrefab)
	{
		_normalPool = new MissionArrowPool(arrowRoot, normalPrefab);
		_uavPool = new MissionArrowPool(arrowRoot, uavPrefab);
	}

	public MissionArrow GetArrow(Type missionPointType)
	{
		if (missionPointType.IsAssignableFrom(typeof(MissionPointData)))
		{
			return null;
		}
		if (!(missionPointType == typeof(ChaseMissionPoint)))
		{
			return _normalPool.Get();
		}
		return _uavPool.Get();
	}

	public void ReleaseArrow(MissionArrow arrow)
	{
		if (arrow is MissionArrowUAV)
		{
			_uavPool.Release(arrow);
		}
		else
		{
			_normalPool.Release(arrow);
		}
	}

	public void Clear()
	{
		while (_uavPool._pool.Count > 0)
		{
			MissionArrow missionArrow = _uavPool._pool.Pop();
			if (missionArrow != null && (bool)missionArrow.gameObject)
			{
				UnityEngine.Object.Destroy(missionArrow.gameObject);
			}
		}
		while (_normalPool._pool.Count > 0)
		{
			MissionArrow missionArrow2 = _normalPool._pool.Pop();
			if (missionArrow2 != null && (bool)missionArrow2.gameObject)
			{
				UnityEngine.Object.Destroy(missionArrow2.gameObject);
			}
		}
	}
}

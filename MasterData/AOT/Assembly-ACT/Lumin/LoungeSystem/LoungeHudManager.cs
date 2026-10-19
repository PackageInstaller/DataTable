using System;
using System.Collections.Generic;
using ACT.Model;
using UnityEngine;

namespace Lumin.LoungeSystem;

public class LoungeHudManager : MonoBehaviour
{
	[Header("配置")]
	[Tooltip("HUD预制体")]
	public GameObject hudPrefab;

	[Tooltip("HUD父节点")]
	public Transform hudRoot;

	[Tooltip("对象池初始大小")]
	public int poolInitialSize = 10;

	[Tooltip("HUD相对3D位置的高度偏移")]
	public float heightOffset = 2.2f;

	[Tooltip("屏幕边缘裁剪边距")]
	public float screenEdgeMargin = 50f;

	[Tooltip("最大显示距离")]
	public float maxVisibleDistance = 50f;

	[Tooltip("淡入淡出起始距离")]
	public float fadeStartDistance = 30f;

	private Queue<LoungeHudCell> _hudPool;

	private Dictionary<int, LoungeHudCell> _activeHuds;

	private Dictionary<int, LoungePoint> _pointDataCache;

	private Dictionary<int, Transform> _pointTransformCache;

	private Camera _mainCamera;

	private bool _isInitialized;

	public event Action<int, LoungePoint> OnHudClicked;

	public event Action<int, int, LoungePoint> OnCharacterHudClicked;

	public event Action<int, LoungePoint> OnEmptyPointHudClicked;

	public void Init()
	{
		if (!_isInitialized)
		{
			_hudPool = new Queue<LoungeHudCell>();
			_activeHuds = new Dictionary<int, LoungeHudCell>();
			_pointDataCache = new Dictionary<int, LoungePoint>();
			_pointTransformCache = new Dictionary<int, Transform>();
			_mainCamera = Camera.main;
			InitializePool();
			_isInitialized = true;
			Debug.Log("<color=cyan>[LoungeHudManager] 初始化完成</color>");
		}
	}

	private void InitializePool()
	{
		if (hudPrefab == null)
		{
			Debug.LogError("[LoungeHudManager] HUD预制体为空！");
			return;
		}
		for (int i = 0; i < poolInitialSize; i++)
		{
			LoungeHudCell item = CreateHudInstance();
			_hudPool.Enqueue(item);
		}
	}

	private LoungeHudCell CreateHudInstance()
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(hudPrefab, hudRoot);
		LoungeHudCell loungeHudCell = gameObject.GetComponent<LoungeHudCell>();
		if (loungeHudCell == null)
		{
			loungeHudCell = gameObject.AddComponent<LoungeHudCell>();
		}
		gameObject.SetActive(value: false);
		return loungeHudCell;
	}

	private void LateUpdate()
	{
		if (_isInitialized)
		{
			UpdateAllHudPositions();
		}
	}

	private void OnDestroy()
	{
		Clear();
	}

	public void RegisterPoint(int pointId, LoungePoint pointData, Transform worldTransform)
	{
		if (!_isInitialized)
		{
			Debug.LogWarning("[LoungeHudManager] 未初始化！");
			return;
		}
		if (_activeHuds.ContainsKey(pointId))
		{
			UnregisterPoint(pointId);
		}
		_pointDataCache[pointId] = pointData;
		_pointTransformCache[pointId] = worldTransform;
		LoungeHudCell hudFromPool = GetHudFromPool();
		_activeHuds[pointId] = hudFromPool;
		hudFromPool.Init(pointData);
		hudFromPool.gameObject.SetActive(value: true);
		UpdateHudPosition(pointId);
		Debug.Log($"<color=green>[LoungeHudManager] 注册点位: {pointId}</color>");
	}

	public void RegisterPoints(Dictionary<int, LoungePoint> pointsData, Dictionary<int, Transform> pointTransforms)
	{
		foreach (KeyValuePair<int, LoungePoint> pointsDatum in pointsData)
		{
			int key = pointsDatum.Key;
			if (pointTransforms.TryGetValue(key, out var value))
			{
				RegisterPoint(key, pointsDatum.Value, value);
			}
		}
	}

	public void UnregisterPoint(int pointId)
	{
		if (_activeHuds.TryGetValue(pointId, out var value))
		{
			ReturnHudToPool(value);
			_activeHuds.Remove(pointId);
		}
		_pointDataCache.Remove(pointId);
		_pointTransformCache.Remove(pointId);
	}

	public void UpdatePointData(int pointId, LoungePoint newData)
	{
		_pointDataCache[pointId] = newData;
		if (_activeHuds.TryGetValue(pointId, out var value))
		{
			value.Init(newData);
		}
	}

	public void SetHudVisible(int pointId, bool visible)
	{
		if (_activeHuds.TryGetValue(pointId, out var value))
		{
			value.gameObject.SetActive(visible);
		}
	}

	public void SetAllHudsVisible(bool visible)
	{
		foreach (LoungeHudCell value in _activeHuds.Values)
		{
			value.gameObject.SetActive(visible);
		}
	}

	public LoungePoint GetPointData(int pointId)
	{
		if (!_pointDataCache.TryGetValue(pointId, out var value))
		{
			return null;
		}
		return value;
	}

	public void Clear()
	{
		foreach (LoungeHudCell value in _activeHuds.Values)
		{
			if (value != null)
			{
				ReturnHudToPool(value);
			}
		}
		_activeHuds.Clear();
		_pointDataCache.Clear();
		_pointTransformCache.Clear();
	}

	public void RefreshFromModel()
	{
		foreach (KeyValuePair<int, LoungePoint> item in Model<LoungeModel>.Interface.IndexToCharacter)
		{
			int key = item.Key;
			LoungePoint value = item.Value;
			if (_activeHuds.ContainsKey(key))
			{
				UpdatePointData(key, value);
			}
		}
	}

	private LoungeHudCell GetHudFromPool()
	{
		if (_hudPool.Count > 0)
		{
			return _hudPool.Dequeue();
		}
		return CreateHudInstance();
	}

	private void ReturnHudToPool(LoungeHudCell hudCell)
	{
		if (!(hudCell == null))
		{
			hudCell.gameObject.SetActive(value: false);
			_hudPool.Enqueue(hudCell);
		}
	}

	private void UpdateAllHudPositions()
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
			if (_mainCamera == null)
			{
				return;
			}
		}
		foreach (int key in _activeHuds.Keys)
		{
			UpdateHudPosition(key);
		}
	}

	private void UpdateHudPosition(int pointId)
	{
		if (!_activeHuds.TryGetValue(pointId, out var value) || !_pointTransformCache.TryGetValue(pointId, out var value2) || value2 == null)
		{
			return;
		}
		Vector3 vector = value2.position + Vector3.up * heightOffset;
		Vector3 vector2 = _mainCamera.WorldToViewportPoint(vector);
		bool flag = vector2.z > 0f;
		bool flag2 = vector2.x >= 0f && vector2.x <= 1f && vector2.y >= 0f && vector2.y <= 1f;
		if (!flag || !flag2)
		{
			value.gameObject.SetActive(value: false);
			return;
		}
		float num = Vector3.Distance(_mainCamera.transform.position, vector);
		if (num > maxVisibleDistance)
		{
			value.gameObject.SetActive(value: false);
			return;
		}
		value.gameObject.SetActive(value: true);
		Vector3 position = _mainCamera.WorldToScreenPoint(vector);
		position.x = Mathf.Clamp(position.x, screenEdgeMargin, (float)Screen.width - screenEdgeMargin);
		position.y = Mathf.Clamp(position.y, screenEdgeMargin, (float)Screen.height - screenEdgeMargin);
		if (value.transform is RectTransform rectTransform)
		{
			rectTransform.position = position;
		}
		else
		{
			value.transform.position = position;
		}
		if (num > fadeStartDistance)
		{
			float value3 = 1f - (num - fadeStartDistance) / (maxVisibleDistance - fadeStartDistance);
			value3 = Mathf.Clamp(value3, 0.5f, 1f);
			value.transform.localScale = Vector3.one * value3;
		}
		else
		{
			value.transform.localScale = Vector3.one;
		}
	}
}

using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.UI.InputController;
using Bamboo.Chronos;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class SeparateSegment : MonoBehaviour
{
	public List<Point> allPoints;

	public SeparateSegmentConfig separateSegmentConfig;

	public GameObject EffectPrefab;

	[SerializeField]
	private float _completeEffectTime;

	[NonSerialized]
	private List<Segment> _segments = new List<Segment>();

	[NonSerialized]
	private HashSet<int> _temp = new HashSet<int>();

	private Action m_Callback;

	private int _currSelected = -1;

	private Tweener _timer;

	private bool _selectMoving;

	private List<Vector3> _intersections = new List<Vector3>();

	private List<GameObject> _intersectionEffects = new List<GameObject>();

	private Canvas _segmentCanvas;

	private int _sortingLayerID;

	private int _connectCount;

	public int CurrentSelect => _currSelected;

	public event Action OnCurrentSelectChanged;

	public void Init(Action callback, SeparateSegmentConfig segmentConfig)
	{
		if (segmentConfig != null)
		{
			separateSegmentConfig = segmentConfig;
		}
		_segmentCanvas = transform.GetComponentInParent<Canvas>();
		ConnectionMiniGameView componentInParent = transform.GetComponentInParent<ConnectionMiniGameView>();
		_sortingLayerID = 0;
		if (componentInParent != null && _segmentCanvas != null && _segmentCanvas != componentInParent.ContentCanvas)
		{
			_segmentCanvas.overrideSorting = true;
			int sortingLayerID = (_segmentCanvas.sortingLayerID = componentInParent.ContentCanvas.sortingLayerID);
			_sortingLayerID = sortingLayerID;
			_segmentCanvas.sortingOrder = 3;
		}
		m_Callback = callback;
		_segments.Clear();
		_selectMoving = false;
		_currSelected = -1;
		OnCurrentSelectChanged?.Invoke();
		_connectCount = 0;
		List<PointData> polygonGroup = separateSegmentConfig.polygonGroup;
		int num = 0;
		foreach (PointData item2 in polygonGroup)
		{
			int num2 = num;
			int endIndex = num + item2.posList.Count - 1;
			for (int i = 0; i < item2.posList.Count; i++)
			{
				if (num + 1 >= allPoints.Count)
				{
					Point item = UnityEngine.Object.Instantiate(allPoints[0], allPoints[0].transform.parent, worldPositionStays: false);
					allPoints.Add(item);
				}
				Segment segment = new Segment();
				bool flag = i + 1 == item2.posList.Count;
				Point point = allPoints[num];
				Point e = allPoints[flag ? num2 : (num + 1)];
				point.Init(num, num2, endIndex, item2.posList[i], OnSelected);
				segment.Init(point, e, _sortingLayerID);
				_segments.Add(segment);
				num++;
			}
		}
		for (int j = num; j < allPoints.Count; j++)
		{
			allPoints[j].UnInit();
		}
		foreach (Segment segment2 in _segments)
		{
			segment2.RefreshSegmentPos();
		}
		CheckAnyIntersection(_segments, _temp, separateSegmentConfig.precision);
	}

	public void SetSortingLayer(int sortingLayerID)
	{
		_sortingLayerID = sortingLayerID;
		foreach (Segment segment in _segments)
		{
			segment.SetSortingLayer(sortingLayerID);
		}
		foreach (GameObject intersectionEffect in _intersectionEffects)
		{
			SetIntersectionEffectSortingLayer(intersectionEffect);
		}
	}

	private void SetIntersectionEffectSortingLayer(GameObject effect)
	{
		if (!(effect == null))
		{
			int sortingOrder = ((!(_segmentCanvas != null)) ? 1 : (_segmentCanvas.sortingOrder + 1));
			Renderer[] componentsInChildren = effect.GetComponentsInChildren<Renderer>(includeInactive: true);
			foreach (Renderer obj in componentsInChildren)
			{
				obj.sortingLayerID = _sortingLayerID;
				obj.sortingOrder = sortingOrder;
			}
		}
	}

	private void Update()
	{
		if (separateSegmentConfig == null)
		{
			return;
		}
		CheckAnyIntersection(_segments, _temp, separateSegmentConfig.precision, _intersections);
		for (int i = 0; i < _intersections.Count - _intersectionEffects.Count; i++)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(EffectPrefab, transform);
			SetIntersectionEffectSortingLayer(gameObject);
			_intersectionEffects.Add(gameObject);
		}
		for (int j = 0; j < _intersectionEffects.Count; j++)
		{
			if (j >= _intersections.Count)
			{
				_intersectionEffects[j].SetActive(value: false);
				continue;
			}
			_intersectionEffects[j].SetActive(value: true);
			_intersectionEffects[j].transform.position = _intersections[j];
		}
	}

	public void OnSelected(int index)
	{
		if (_currSelected != -1)
		{
			if (_currSelected != index)
			{
				allPoints[index].Select(active: true);
				PointChange(index);
			}
			else
			{
				allPoints[_currSelected].Select(active: false);
			}
			_currSelected = -1;
			OnCurrentSelectChanged?.Invoke();
		}
		else
		{
			_currSelected = index;
			allPoints[_currSelected].Select(active: true);
			OnCurrentSelectChanged?.Invoke();
		}
	}

	private void PointChange(int index)
	{
		EventSystemHelper.SetSelectedGameObject(null);
		int durationMs = Mathf.RoundToInt(separateSegmentConfig.duration * 1000f);
		Point curr = allPoints[_currSelected];
		Vector3 currPos = curr.Pos;
		Point other = allPoints[index];
		Vector3 otherPos = other.Pos;
		if (!_timer.IsValid())
		{
			MonoECS.instance.PushPauseUIInput();
			_connectCount++;
			_timer = UpdateTimer.Default.TweenMs(durationMs, (int t) =>
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/UAV/UAV_Click_Zap");
				curr.Pos = Vector3.Lerp(currPos, otherPos, (float)t / 1000f);
				other.Pos = Vector3.Lerp(otherPos, currPos, (float)t / 1000f);
				_segments[curr.StartSegmentIndex].RefreshSegmentPos();
				_segments[curr.EndSegmentIndex].RefreshSegmentPos();
				_segments[other.StartSegmentIndex].RefreshSegmentPos();
				_segments[other.EndSegmentIndex].RefreshSegmentPos();
			}, (bool _) =>
			{
				curr.Select(active: false);
				other.Select(active: false);
				MonoECS.instance.PopPauseUIInput();
				_timer.Cancel();
				if (CheckAnyIntersection(_segments, _temp, separateSegmentConfig.precision))
				{
					Success().Forget();
				}
			});
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("已经有跑的PointChange");
		}
	}

	public void UnSelected()
	{
		if (!_selectMoving && _currSelected >= 0)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/UAV/UAV_Click");
			allPoints[_currSelected].Select(active: false);
			_currSelected = -1;
			OnCurrentSelectChanged?.Invoke();
		}
	}

	public void SelectCurrent()
	{
		if (!_selectMoving)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			Point point = (currentSelected ? currentSelected.GetComponentInParent<Point>() : null);
			if (!(point == null) && point.gameObject.activeInHierarchy)
			{
				OnSelected(point.Index);
			}
		}
	}

	public int GetConnectCount()
	{
		return _connectCount;
	}

	public static bool CheckAnyIntersection(List<Segment> segments, HashSet<int> temp, float precision, List<Vector3> intersections = null)
	{
		temp.Clear();
		intersections?.Clear();
		bool result = true;
		for (int i = 0; i < segments.Count; i++)
		{
			bool flag = false;
			for (int j = i + 1; j < segments.Count; j++)
			{
				if (Segment.GetIntersection(segments[i].P1, segments[i].P2, segments[j].P1, segments[j].P2, precision, out var intersection))
				{
					flag = true;
					temp.Add(j);
					intersections?.Add(intersection);
				}
			}
			if (flag || temp.Contains(i))
			{
				segments[i].SetIntersectState(value: true);
			}
			else
			{
				segments[i].SetIntersectState(value: false);
			}
			if (flag)
			{
				result = false;
			}
		}
		return result;
	}

	private async UniTaskVoid Success()
	{
		MonoECS.instance.PushPauseUIInput();
		foreach (Point allPoint in allPoints)
		{
			allPoint.CompleteEffect();
		}
		await UniTask.Delay(TimeSpan.FromSeconds(_completeEffectTime));
		MonoECS.instance.PopPauseUIInput();
		m_Callback?.Invoke();
	}
}

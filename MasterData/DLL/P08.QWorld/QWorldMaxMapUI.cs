using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class QWorldMaxMapUI : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler, IPointerClickHandler
{
	private const string MINI_MAP_UNIT_PATH = "Widget/System/SandPlay/SandPlay_Map/item/SandPlay_MapNodeShow";

	public Image image;

	public RectTransform agentIcon;

	public RectTransform agentIcon_D;

	public RectTransform agentArrow;

	public RectTransform agentPlayer;

	public Button addRateBtn;

	public Button reduceRateBtn;

	public RectTransform mapContent;

	public static Vector2 MapContentHalfSize;

	private Vector2 mapContentSize;

	public RectTransform mapImag;

	private float base_width = 3738f;

	private float base_height = 5040f;

	public Slider slider;

	public Action OnMapUnitSelectAction;

	private float map_rate;

	public static float MAX_MAP_RATIO = 1f;

	public static Vector3 AGENT_POSITION_OFFSET = new Vector3(-7.66f, 0f, -35.6f);

	private List<QWorldMaxMapUnitDisplay> pool;

	private Dictionary<QWorldMiniMapUnit, QWorldMaxMapUnitDisplay> unitDict;

	private Transform agent;

	private QWorldMap qWorldMap;

	public float zoomSpeed = 0.02f;

	private Vector2 lastMousePostion;

	private List<int> m_pointClickResult = new List<int>();

	private void Awake()
	{
		pool = new List<QWorldMaxMapUnitDisplay>();
		unitDict = new Dictionary<QWorldMiniMapUnit, QWorldMaxMapUnitDisplay>();
		mapContentSize = mapContent.rect.size;
		Vector2 vector = new Vector2(60f, 60f);
		MapContentHalfSize = mapContent.rect.size * 0.5f - vector;
	}

	private void Start()
	{
		slider.onValueChanged.AddListener(SliderValueChanged);
		if (addRateBtn != null)
		{
			addRateBtn.onClick.AddListener(delegate
			{
				slider.value += 0.1f;
			});
		}
		if (reduceRateBtn != null)
		{
			reduceRateBtn.onClick.AddListener(delegate
			{
				slider.value -= 0.1f;
			});
		}
	}

	public void Init(string path, float width, float height, float map_rate, Vector3 center_offset, float initialscale, float maxscale, float miniscale)
	{
		base_width = width;
		base_height = height;
		mapImag.sizeDelta = new Vector2(base_width, base_height);
		this.map_rate = map_rate;
		AGENT_POSITION_OFFSET = center_offset;
		slider.maxValue = maxscale;
		slider.minValue = miniscale;
		slider.value = initialscale;
		SliderValueChanged(initialscale);
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.GetMap() != null)
		{
			QWorldMap map = qWorldScene.GetMap();
			map.MiniMapUpdateAction = (Action<List<QWorldMiniMapUnit>>)Delegate.Combine(map.MiniMapUpdateAction, new Action<List<QWorldMiniMapUnit>>(UpdateMaxsMap));
			UpdateMaxsMap(qWorldScene.GetMap().miniMapUnitsList);
			agent = qWorldScene.Agent.transform;
		}
		AtlasManager.GetSpriteWithoutAtlas(image, path);
	}

	public void Dispose()
	{
		unitDict.Clear();
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.GetMap() != null)
		{
			QWorldMap map = qWorldScene.GetMap();
			map.MiniMapUpdateAction = (Action<List<QWorldMiniMapUnit>>)Delegate.Remove(map.MiniMapUpdateAction, new Action<List<QWorldMiniMapUnit>>(UpdateMaxsMap));
		}
	}

	private void UpdateMaxsMap(List<QWorldMiniMapUnit> miniMapUnitsList)
	{
		unitDict.Clear();
		int count = miniMapUnitsList.Count;
		int count2 = pool.Count;
		for (int i = 0; i < count; i++)
		{
			QWorldMiniMapUnit qWorldMiniMapUnit = miniMapUnitsList[i];
			QWorldMaxMapUnitDisplay qWorldMaxMapUnitDisplay;
			if (i < count2)
			{
				qWorldMaxMapUnitDisplay = pool[i];
			}
			else
			{
				qWorldMaxMapUnitDisplay = CreateMaxDisplay();
				pool.Add(qWorldMaxMapUnitDisplay);
			}
			qWorldMaxMapUnitDisplay.Render(qWorldMiniMapUnit);
			qWorldMaxMapUnitDisplay.UpdatePosition(qWorldMiniMapUnit.Position, qWorldMiniMapUnit.IsTrack);
			unitDict.Add(qWorldMiniMapUnit, qWorldMaxMapUnitDisplay);
		}
		for (int j = count; j < count2; j++)
		{
			pool[j].OnReturn();
		}
		UpdateMapRate();
	}

	private QWorldMaxMapUnitDisplay CreateMaxDisplay()
	{
		GameObject obj = Asset.Instantiate("Widget/System/SandPlay/SandPlay_Map/item/SandPlay_MapNodeShow");
		obj.transform.SetParent(mapImag, worldPositionStays: false);
		QWorldMaxMapUnitDisplay component = obj.GetComponent<QWorldMaxMapUnitDisplay>();
		component.Init(this, mapContent);
		return component;
	}

	private void SliderValueChanged(float value)
	{
		mapImag.sizeDelta = new Vector2(base_width * value, base_height * value);
		Vector2 vector = (mapImag.rect.size - mapContentSize) / 2f;
		Vector2 anchoredPosition = mapImag.anchoredPosition;
		float x = (float)((!(anchoredPosition.x < 0f)) ? 1 : (-1)) * Mathf.Min(Mathf.Abs(anchoredPosition.x), vector.x);
		float y = (float)((!(anchoredPosition.y < 0f)) ? 1 : (-1)) * Mathf.Min(Mathf.Abs(anchoredPosition.y), vector.y);
		mapImag.anchoredPosition = new Vector2(x, y);
		UpdateMapRate();
	}

	private void UpdateMapRate()
	{
		float value = slider.value;
		MAX_MAP_RATIO = base_width * value / map_rate;
		foreach (KeyValuePair<QWorldMiniMapUnit, QWorldMaxMapUnitDisplay> item in unitDict)
		{
			QWorldMiniMapUnit key = item.Key;
			item.Value.UpdateMapRate(key);
		}
	}

	private void Update()
	{
		if (null == agent)
		{
			return;
		}
		Vector3 eulerAngles = agent.eulerAngles;
		agentIcon.eulerAngles = new Vector3(0f, 180f, eulerAngles.y);
		agentPlayer.eulerAngles = new Vector3(0f, 180f, eulerAngles.y);
		Vector3 vector = (agent.position - AGENT_POSITION_OFFSET) * MAX_MAP_RATIO;
		vector = new Vector3(vector.x, vector.z, 0f);
		agentIcon.localPosition = vector;
		Vector3 position = mapImag.TransformPoint(vector);
		Vector3 vector2 = mapContent.InverseTransformPoint(position);
		float num = Mathf.Clamp(vector2.x, 0f - MapContentHalfSize.x, MapContentHalfSize.x);
		float num2 = Mathf.Clamp(vector2.y, 0f - MapContentHalfSize.y, MapContentHalfSize.y);
		if (vector2.x != num || vector2.y != num2)
		{
			Vector3 position2 = mapContent.TransformPoint(new Vector3(num, num2, 0f));
			Vector3 vector3 = mapImag.InverseTransformPoint(position2);
			float angleBetweenVectors = GetAngleBetweenVectors(vector - vector3, Vector3.up, Vector3.forward);
			agentArrow.eulerAngles = new Vector3(0f, 0f, angleBetweenVectors);
			agentIcon_D.gameObject.SetActive(value: true);
			agentIcon_D.localPosition = vector3;
		}
		else
		{
			agentIcon_D.gameObject.SetActive(value: false);
		}
		foreach (KeyValuePair<QWorldMiniMapUnit, QWorldMaxMapUnitDisplay> item in unitDict)
		{
			QWorldMiniMapUnit key = item.Key;
			QWorldMaxMapUnitDisplay value = item.Value;
			if (key.m_maxDirty || value.track_show != key.IsTrack)
			{
				value.Render(key);
				key.m_maxDirty = false;
			}
			value.UpdatePosition(key.Position, key.IsTrack);
		}
		if (Input.touchCount == 2)
		{
			Touch touch = Input.GetTouch(0);
			Touch touch2 = Input.GetTouch(1);
			float magnitude = (touch.position - touch.deltaPosition - (touch2.position - touch2.deltaPosition)).magnitude;
			float num3 = ((touch.position - touch2.position).magnitude - magnitude) * zoomSpeed;
			slider.value += num3;
		}
	}

	public static float GetAngleBetweenVectors(Vector3 a, Vector3 b, Vector3 axis)
	{
		if (a == Vector3.zero || b == Vector3.zero)
		{
			return 0f;
		}
		float num = Mathf.Acos(Mathf.Clamp(Vector3.Dot(a.normalized, b.normalized), -1f, 1f));
		float num2 = ((Vector3.Dot(Vector3.Cross(a, b), axis) >= 0f) ? (-1f) : 1f);
		return num * 57.29578f * num2;
	}

	public void SelectInMaxMap(int entityId)
	{
		foreach (KeyValuePair<QWorldMiniMapUnit, QWorldMaxMapUnitDisplay> item in unitDict)
		{
			QWorldMiniMapUnit key = item.Key;
			QWorldMaxMapUnitDisplay value = item.Value;
			if (key.EntityEntityId == entityId)
			{
				value.SelectInMap();
				break;
			}
		}
	}

	public void SelectPlayerInMaxMap()
	{
		SetMapPos(-1f * agentIcon.localPosition);
	}

	[NoToLua]
	public void OnBeginDrag(PointerEventData eventData)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(mapContent, eventData.position, eventData.pressEventCamera, out lastMousePostion);
	}

	[NoToLua]
	public void OnDrag(PointerEventData eventData)
	{
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(mapContent, eventData.position, eventData.pressEventCamera, out var localPoint))
		{
			Vector2 vector = (mapImag.rect.size - mapContentSize) / 2f;
			Vector2 vector2 = mapImag.anchoredPosition + localPoint - lastMousePostion;
			float x = Mathf.Sign(vector2.x) * Mathf.Min(Mathf.Abs(vector2.x), vector.x);
			float y = Mathf.Sign(vector2.y) * Mathf.Min(Mathf.Abs(vector2.y), vector.y);
			mapImag.anchoredPosition = new Vector2(x, y);
			lastMousePostion = localPoint;
			UpdateDrag();
		}
	}

	[NoToLua]
	public void OnEndDrag(PointerEventData eventData)
	{
	}

	public void SetMapPos(Vector2 pos)
	{
		Vector2 vector = (mapImag.rect.size - mapContentSize) / 2f;
		Vector2 vector2 = pos;
		float x = Mathf.Sign(vector2.x) * Mathf.Min(Mathf.Abs(vector2.x), vector.x);
		float y = Mathf.Sign(vector2.y) * Mathf.Min(Mathf.Abs(vector2.y), vector.y);
		mapImag.anchoredPosition = new Vector2(x, y);
		UpdateDrag();
	}

	private void UpdateDrag()
	{
		foreach (KeyValuePair<QWorldMiniMapUnit, QWorldMaxMapUnitDisplay> item in unitDict)
		{
			QWorldMiniMapUnit key = item.Key;
			QWorldMaxMapUnitDisplay value = item.Value;
			if (key.IsTrack)
			{
				value.UpdatePosition(key.Position, key.IsTrack);
			}
		}
	}

	[NoToLua]
	public void OnPointerClick(PointerEventData eventData)
	{
		m_pointClickResult.Clear();
		Vector3 vector = eventData.position;
		Camera pressEventCamera = eventData.pressEventCamera;
		foreach (KeyValuePair<QWorldMiniMapUnit, QWorldMaxMapUnitDisplay> item in unitDict)
		{
			QWorldMiniMapUnit key = item.Key;
			Image clickSprite = item.Value.clickSprite;
			if (clickSprite.gameObject.activeInHierarchy && RectTransformUtility.RectangleContainsScreenPoint(clickSprite.rectTransform, vector, pressEventCamera, clickSprite.raycastPadding))
			{
				m_pointClickResult.Add(key.EntityEntityId);
			}
		}
		OnMapUnitSelectAction?.Invoke();
	}

	public int[] GetSelectEntityEntityIds()
	{
		return m_pointClickResult.ToArray();
	}

	public void SelectEntityEntityId(int id)
	{
		m_pointClickResult.Clear();
		m_pointClickResult.Add(id);
		OnMapUnitSelectAction?.Invoke();
	}
}

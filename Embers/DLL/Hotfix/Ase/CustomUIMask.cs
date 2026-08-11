using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class CustomUIMask : Graphic, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IPointerEnterHandler, IPointerExitHandler, IBeginDragHandler, IDragHandler, IEndDragHandler
{
	[Range(0f, 30f)]
	public float radiusX = 10f;

	[Range(0f, 30f)]
	public float radiusY = 10f;

	[Range(1f, 30f)]
	public int triangleNum = 6;

	public Vector2 center;

	public Vector2 offset;

	public Vector2 size;

	private RectTransform outer_trans;

	private Vector2 inner_rt;

	private Vector2 inner_lb;

	private Vector2 outer_rt;

	private Vector2 outer_lb;

	private Bounds bounds;

	[Space(25f)]
	public bool realtimeRefresh;

	[Space(25f)]
	public bool ShowHollowOut = true;

	public bool LockHollowOut;

	public RectTransform outline;

	public Vector2 arrowOverSize = new Vector2(10f, 10f);

	public RectTransform arrowRoot;

	public Vector2 arrowOffset;

	public int arrowDirect;

	private readonly int[] direct = new int[5] { 0, 0, -90, -180, -270 };

	public RectTransform target;

	[NonSerialized]
	[HideInInspector]
	public bool NeedExecuteInputCommand = true;

	public bool isPointDown;

	public bool cliclAnyWhere;

	public bool eventClickLockCenter;

	public Action OnClickCallback;

	public Action<PointerEventData> OnPointDown;

	public Action<PointerEventData> OnPointDownBefore;

	public Action OnClickUpBefore;

	private RectTransform Outer_trans
	{
		get
		{
			if (outer_trans == null)
			{
				outer_trans = GetComponent<RectTransform>();
			}
			return outer_trans;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		if (outer_trans == null)
		{
			outer_trans = GetComponent<RectTransform>();
		}
		CalcBounds();
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		//IL_0140: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_019e: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_021c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0246: Unknown result type (might be due to invalid IL or missing references)
		//IL_05bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0602: Unknown result type (might be due to invalid IL or missing references)
		//IL_069e: Unknown result type (might be due to invalid IL or missing references)
		//IL_06bb: Unknown result type (might be due to invalid IL or missing references)
		vh.Clear();
		float num = Mathf.Abs(inner_lb.x - inner_rt.x);
		float num2 = Mathf.Abs(inner_lb.y - inner_rt.y);
		float num3 = num / 2f;
		float num4 = num2 / 2f;
		if (radiusX < 0f)
		{
			radiusX = 0f;
		}
		float num5 = radiusX;
		if (num5 > num3)
		{
			num5 = num3;
		}
		if (num5 < 0f)
		{
			num5 = 0f;
		}
		if (radiusY < 0f)
		{
			radiusY = 0f;
		}
		float num6 = radiusY;
		if (num6 > num4)
		{
			num6 = num4;
		}
		if (num6 < 0f)
		{
			num6 = 0f;
		}
		if (triangleNum <= 0)
		{
			triangleNum = 1;
		}
		UIVertex simpleVert = UIVertex.simpleVert;
		simpleVert.color = color;
		simpleVert.position = new Vector2(outer_lb.x, outer_lb.y);
		vh.AddVert(simpleVert);
		simpleVert.position = new Vector2(outer_lb.x, outer_rt.y);
		vh.AddVert(simpleVert);
		simpleVert.position = new Vector2(outer_rt.x, outer_rt.y);
		vh.AddVert(simpleVert);
		simpleVert.position = new Vector2(outer_rt.x, outer_lb.y);
		vh.AddVert(simpleVert);
		simpleVert.position = new Vector3(inner_lb.x, inner_lb.y);
		vh.AddVert(simpleVert);
		simpleVert.position = new Vector3(inner_lb.x, inner_rt.y);
		vh.AddVert(simpleVert);
		simpleVert.position = new Vector3(inner_rt.x, inner_rt.y);
		vh.AddVert(simpleVert);
		simpleVert.position = new Vector3(inner_rt.x, inner_lb.y);
		vh.AddVert(simpleVert);
		if (!ShowHollowOut || LockHollowOut)
		{
			vh.AddTriangle(0, 1, 2);
			vh.AddTriangle(2, 3, 0);
			return;
		}
		vh.AddTriangle(0, 1, 4);
		vh.AddTriangle(1, 4, 5);
		vh.AddTriangle(1, 5, 2);
		vh.AddTriangle(2, 5, 6);
		vh.AddTriangle(2, 6, 3);
		vh.AddTriangle(6, 3, 7);
		vh.AddTriangle(4, 7, 3);
		vh.AddTriangle(0, 4, 3);
		List<Vector2> list = new List<Vector2>();
		Vector2 item = new Vector2(inner_lb.x, inner_lb.y);
		Vector2 item2 = new Vector2(inner_lb.x, inner_lb.y + num6);
		list.Add(item);
		list.Add(item2);
		item = new Vector2(inner_lb.x, inner_rt.y);
		item2 = new Vector2(inner_lb.x + num5, inner_rt.y);
		list.Add(item);
		list.Add(item2);
		item = new Vector2(inner_rt.x, inner_rt.y);
		item2 = new Vector2(inner_rt.x, inner_rt.y - num6);
		list.Add(item);
		list.Add(item2);
		item = new Vector2(inner_rt.x, inner_lb.y);
		item2 = new Vector2(inner_rt.x - num5, inner_lb.y);
		list.Add(item);
		list.Add(item2);
		List<Vector2> list2 = new List<Vector2>();
		item = new Vector2(inner_lb.x + num5, inner_lb.y + num6);
		item2 = new Vector2(inner_lb.x, inner_lb.y + num6);
		list2.Add(item);
		list2.Add(item2);
		item = new Vector2(inner_lb.x + num5, inner_rt.y - num6);
		item2 = new Vector2(inner_lb.x + num5, inner_rt.y);
		list2.Add(item);
		list2.Add(item2);
		item = new Vector2(inner_rt.x - num5, inner_rt.y - num6);
		item2 = new Vector2(inner_rt.x, inner_rt.y - num6);
		list2.Add(item);
		list2.Add(item2);
		item = new Vector2(inner_rt.x - num5, inner_lb.y + num6);
		item2 = new Vector2(inner_rt.x - num5, inner_lb.y);
		list2.Add(item);
		list2.Add(item2);
		float num7 = MathF.PI / 2f / (float)triangleNum;
		List<float> list3 = new List<float>
		{
			MathF.PI,
			MathF.PI / 2f,
			0f,
			4.712389f
		};
		for (int i = 0; i < list2.Count; i += 2)
		{
			float num8 = list3[i / 2];
			AddVert(list[i], num, num2, vh, simpleVert);
			int num9 = vh.currentVertCount;
			int idx = vh.currentVertCount - 1;
			List<Vector2> list4 = new List<Vector2>();
			for (int j = 0; j < triangleNum; j++)
			{
				num8 += num7;
				if (list4.Count == 0)
				{
					AddVert(list2[i + 1], num, num2, vh, simpleVert);
				}
				else
				{
					simpleVert.position = list4[j - 1];
					simpleVert.uv0 = new Vector2(list4[j - 1].x + 0.5f, list4[j - 1].y + 0.5f);
				}
				Vector2 pos = new Vector2(list2[i].x + num5 * Mathf.Cos(num8), list2[i].y + num6 * Mathf.Sin(num8));
				AddVert(pos, num, num2, vh, simpleVert);
				vh.AddTriangle(idx, num9, num9 + 1);
				num9++;
				list4.Add(simpleVert.position);
			}
		}
	}

	protected Vector2[] GetTextureUVS(Vector2[] vhs, float tw, float th)
	{
		Vector2[] array = new Vector2[vhs.Length];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = new Vector2(vhs[i].x / tw + 0.5f, vhs[i].y / th + 0.5f);
		}
		return array;
	}

	protected void AddVert(Vector2 pos0, float tw, float th, VertexHelper vh, UIVertex vert)
	{
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		vert.position = pos0;
		vert.uv0 = GetTextureUVS(new Vector2[1]
		{
			new Vector2(pos0.x, pos0.y)
		}, tw, th)[0];
		vh.AddVert(vert);
	}

	private void CalcBounds()
	{
		CheckHollow();
		inner_rt = center + offset + size / 2f;
		inner_lb = center + offset - size / 2f;
		outer_rt = Outer_trans.rect.max;
		outer_lb = Outer_trans.rect.min;
	}

	private bool CheckPressPoint(Vector2 point)
	{
		point = UIUtilly.GetUICamera().ScreenToViewportPoint(point);
		point.x = point.x * UIUtilly.uiCanvasSize.x - UIUtilly.uiCanvasSize.x / 2f;
		point.y = point.y * UIUtilly.uiCanvasSize.y - UIUtilly.uiCanvasSize.y / 2f;
		if (point.y > inner_lb.y && point.y < inner_rt.y && point.x > inner_lb.x)
		{
			return point.x < inner_rt.x;
		}
		return false;
	}

	private void OnSizeModify()
	{
		if (size.x < radiusX * 2f + 10f)
		{
			size.x = radiusX * 2f + 10f;
		}
		if (size.y < radiusY * 2f + 10f)
		{
			size.y = radiusY * 2f + 10f;
		}
	}

	private void Update()
	{
		if (realtimeRefresh)
		{
			Refresh();
		}
	}

	public void Refresh()
	{
		CalcBounds();
		SetAllDirty();
		UpdateOutline();
		UpdateArrow();
	}

	private void CheckHollow()
	{
		if (target != null)
		{
			Vector3[] array = new Vector3[4];
			target.GetWorldCorners(array);
			Matrix4x4 worldToLocalMatrix = Outer_trans.worldToLocalMatrix;
			Vector3 rhs = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
			Vector3 vector = new Vector3(float.MinValue, float.MinValue, float.MinValue);
			for (int i = 0; i < 4; i++)
			{
				Vector3 lhs = worldToLocalMatrix.MultiplyPoint3x4(array[i]);
				rhs = Vector3.Min(lhs, rhs);
				vector = Vector3.Max(lhs, vector);
			}
			bounds = new Bounds(rhs, Vector3.zero);
			bounds.Encapsulate(vector);
			center = bounds.center;
		}
	}

	private void UpdateOutline()
	{
		outline.anchoredPosition = center + offset;
		outline.sizeDelta = size + arrowOverSize;
		outline.gameObject.SetActive(ShowHollowOut && !LockHollowOut && !size.Equals(Vector3.zero));
	}

	private void UpdateArrow()
	{
		if (!(arrowRoot == null))
		{
			arrowRoot.anchoredPosition = center + arrowOffset;
			arrowRoot.rotation = Quaternion.Euler(0f, 0f, (arrowDirect < direct.Length) ? direct[arrowDirect] : 0);
			arrowRoot.gameObject.SetActive(arrowDirect > 0 && arrowDirect < direct.Length);
		}
	}

	public bool CanPassEvent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		if (cliclAnyWhere || !NeedExecuteInputCommand)
		{
			return false;
		}
		bool result = false;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(data, list);
		_ = data.pointerCurrentRaycast.gameObject;
		for (int i = 0; i < list.Count; i++)
		{
			if (target != null && target.gameObject == list[i].gameObject)
			{
				if (!eventClickLockCenter)
				{
					result = true;
				}
				else if (CheckPressPoint(data.position))
				{
					PointerEventData pointerEventData = new PointerEventData(EventSystem.current);
					pointerEventData.position = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), target.TransformPoint(center + offset));
					pointerEventData.pressPosition = pointerEventData.position;
					result = true;
				}
			}
		}
		return result;
	}

	public bool PassEvent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		if (cliclAnyWhere || !NeedExecuteInputCommand)
		{
			return false;
		}
		bool result = false;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(data, list);
		_ = data.pointerCurrentRaycast.gameObject;
		for (int i = 0; i < list.Count; i++)
		{
			if (target != null && target.gameObject == list[i].gameObject)
			{
				if (!eventClickLockCenter)
				{
					ExecuteInputCommand(list[i].gameObject, data, function);
					result = true;
				}
				else if (CheckPressPoint(data.position))
				{
					PointerEventData pointerEventData = new PointerEventData(EventSystem.current);
					pointerEventData.position = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), target.TransformPoint(center + offset));
					pointerEventData.pressPosition = pointerEventData.position;
					ExecuteInputCommand(list[i].gameObject, pointerEventData, function);
					result = true;
				}
			}
		}
		return result;
	}

	private void ExecuteInputCommand<T>(GameObject target, PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		ExecuteEvents.ExecuteHierarchy(target, data, function);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.pointerClickHandler);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (CanPassEvent(eventData, ExecuteEvents.pointerDownHandler))
		{
			OnPointDownBefore?.Invoke(eventData);
		}
		if (PassEvent(eventData, ExecuteEvents.pointerDownHandler))
		{
			isPointDown = true;
		}
		OnPointDown?.Invoke(eventData);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		OnClickUpBefore?.Invoke();
		bool flag = PassEvent(eventData, ExecuteEvents.pointerUpHandler);
		if (isPointDown && !flag && target != null)
		{
			ExecuteInputCommand(target.gameObject, eventData, ExecuteEvents.pointerUpHandler);
		}
		if (((isPointDown & flag) || cliclAnyWhere) && OnClickCallback != null)
		{
			OnClickCallback();
			OnClickCallback = null;
		}
		isPointDown = false;
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.pointerEnterHandler);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.pointerExitHandler);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.beginDragHandler);
	}

	public void OnDrag(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.dragHandler);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.endDragHandler);
	}
}

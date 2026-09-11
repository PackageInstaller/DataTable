using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

[RequireComponent(typeof(CinemachineSmoothPath))]
public class DragOnSmoothPathHandler : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler, IDragHandler, IInitializePotentialDragHandler
{
	public Transform[] nodes;

	[SerializeField]
	private CinemachineSmoothPath dragPath;

	[Range(0f, 1f)]
	public float dragFinishThreashold = 0.9f;

	private int prevDragOverSeg;

	private bool dragFinish;

	private bool dragStarted;

	public UnityEvent<float> onValueChange;

	public UnityEvent onDragFinish;

	public UnityEvent onEndDrag;

	public bool useSmoothValue;

	private float progress;

	private float v;

	private float current;

	[Range(0.1f, 2.5f)]
	public float smoothTime = 0.2f;

	public void OnBeginDrag(PointerEventData eventData)
	{
		dragStarted = true;
	}

	public void OnDrag(PointerEventData eventData)
	{
		Vector3 worldPosition = eventData.pointerCurrentRaycast.worldPosition;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(eventData, list);
		progress = 0f;
		foreach (RaycastResult item in list)
		{
			if ((bool)item.gameObject.GetComponent<BoxCollider>())
			{
				worldPosition = item.worldPosition;
				float b = dragPath.FromPathNativeUnits(dragPath.FindClosestPoint(worldPosition, prevDragOverSeg, -1, 0), CinemachinePathBase.PositionUnits.Normalized);
				progress = Mathf.Max(progress, b);
				prevDragOverSeg = Mathf.FloorToInt(progress * (float)dragPath.m_Resolution * (float)dragPath.m_Waypoints.Length);
			}
		}
		if (!useSmoothValue)
		{
			OnProgressUpdate(progress);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		dragStarted = false;
		onEndDrag?.Invoke();
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
	}

	private void OnProgressUpdate(float progress)
	{
		onValueChange?.Invoke(progress);
		if (!dragFinish && progress >= dragFinishThreashold)
		{
			onDragFinish?.Invoke();
			dragFinish = true;
		}
	}

	private void Start()
	{
		if (!dragPath)
		{
			dragPath = GetComponent<CinemachineSmoothPath>();
		}
	}

	private void OnEnable()
	{
		CalcDragPath(dragPath, nodes);
		ResetDrag();
	}

	public void Invoke()
	{
		if (!dragPath)
		{
			dragPath = GetComponent<CinemachineSmoothPath>();
		}
		OnEnable();
	}

	private void ResetDrag()
	{
		dragStarted = false;
		prevDragOverSeg = 0;
		dragFinish = false;
		progress = 0f;
		current = 0f;
		v = 0f;
	}

	private void Update()
	{
		if (dragStarted && useSmoothValue)
		{
			current = Mathf.SmoothDamp(current, progress, ref v, smoothTime);
			OnProgressUpdate(current);
		}
	}

	private static void CalcDragPath(CinemachineSmoothPath dragPath, Transform[] nodes)
	{
		if ((nodes == null || nodes.Length != 0) && !(dragPath == null))
		{
			dragPath.m_Waypoints = new CinemachineSmoothPath.Waypoint[nodes.Length];
			for (int i = 0; i < nodes.Length; i++)
			{
				dragPath.m_Waypoints[i] = CalcWayPoint(dragPath.transform, nodes[i]);
			}
			dragPath.m_Looped = false;
			dragPath.m_Resolution = 8;
			dragPath.InvalidateDistanceCache();
		}
	}

	private static CinemachineSmoothPath.Waypoint CalcWayPoint(Transform pathRoot, Transform node)
	{
		Vector3 position = pathRoot.InverseTransformPoint(node.position);
		return new CinemachineSmoothPath.Waypoint
		{
			position = position
		};
	}
}

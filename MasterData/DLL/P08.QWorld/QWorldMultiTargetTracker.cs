using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class QWorldMultiTargetTracker : MonoBehaviour
{
	[Header("Tracker Settings")]
	public Canvas canvas;

	public GameObject iconPrefab;

	public Vector2 ellipseRadius = new Vector2(200f, 150f);

	private List<QWorldMultiTargetTrackerDisplay> trackedTargets;

	private static Vector2 outSizeVector2 = new Vector2(99999f, 99999f);

	private List<QWorldMapEntity> trackingTargets;

	private Transform agent;

	public static string MeterUnitStr = "m";

	private void Awake()
	{
		trackedTargets = new List<QWorldMultiTargetTrackerDisplay>();
		trackingTargets = new List<QWorldMapEntity>();
	}

	private void Start()
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.GetMap() != null)
		{
			agent = qWorldScene.Agent.transform;
		}
		Rect rect = (canvas.transform as RectTransform).rect;
		ellipseRadius.x = rect.width * 0.28f;
		ellipseRadius.y = rect.height * 0.35f;
		MeterUnitStr = LuaHelper.CallFunction("GetTips", "SANDPLAY_DISTANCE_METRE")[0].ToString();
	}

	public void UpdateTrack(int[] trackEntityIds)
	{
		if (trackEntityIds == null)
		{
			return;
		}
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene == null || qWorldScene.GetMapManager() == null)
		{
			return;
		}
		QWorldMapManager mapManager = qWorldScene.GetMapManager();
		trackingTargets.Clear();
		foreach (int entityId in trackEntityIds)
		{
			QWorldMapEntity mapEntityByEntityId = mapManager.GetMapEntityByEntityId(entityId);
			if (null != mapEntityByEntityId)
			{
				trackingTargets.Add(mapEntityByEntityId);
			}
		}
		SetTargetList(trackingTargets);
	}

	public void SetTargetList(List<QWorldMapEntity> targets)
	{
		int count = targets.Count;
		int count2 = trackedTargets.Count;
		for (int i = 0; i < count; i++)
		{
			QWorldMapEntity entity = targets[i];
			if (i < count2)
			{
				trackedTargets[i].Refresh(entity);
				trackedTargets[i].SetActive(value: true);
				continue;
			}
			QWorldMultiTargetTrackerDisplay component = Object.Instantiate(iconPrefab, canvas.transform).GetComponent<QWorldMultiTargetTrackerDisplay>();
			component.Init();
			component.Refresh(entity);
			component.SetActive(value: true);
			trackedTargets.Add(component);
		}
		for (int j = count; j < count2; j++)
		{
			trackedTargets[j].Reset();
			trackedTargets[j].SetActive(value: false);
		}
	}

	public void ClearTargetList()
	{
		int count = trackedTargets.Count;
		for (int i = 0; i < count; i++)
		{
			trackedTargets[i].SetActive(value: false);
		}
	}

	private void Update()
	{
		Camera mainCamera = QWorldCameraManager.Instance.MainCamera;
		Camera uiCamera = CanvasManager.Instance.uiCamera;
		foreach (QWorldMultiTargetTrackerDisplay trackedTarget in trackedTargets)
		{
			if (!trackedTarget.IsEnable)
			{
				continue;
			}
			Vector3 flowPosition = trackedTarget.GetFlowPosition();
			Vector3 vector = mainCamera.WorldToScreenPoint(flowPosition);
			float num = Vector3.Distance(agent.position.NewY(0f), flowPosition.NewY(0f));
			if (num <= 3f)
			{
				LuaHelper.CallFunction("CancelTrack", trackedTarget.trackEntitiy.entityId);
			}
			bool num2 = vector.z > 0f;
			Vector2 localPoint = Vector2.zero;
			bool flag;
			if (num2)
			{
				flag = RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.transform as RectTransform, vector, uiCamera, out localPoint);
				if (flag && IsInsideEllipse(localPoint, ellipseRadius))
				{
					SetIconPosition(trackedTarget, localPoint, localPoint, isInSide: true, num);
					continue;
				}
			}
			else
			{
				Vector3 direction = flowPosition - mainCamera.transform.position;
				direction = -mainCamera.transform.InverseTransformDirection(direction).normalized;
				Vector3 vector2 = mainCamera.WorldToScreenPoint(mainCamera.transform.position + mainCamera.transform.TransformDirection(direction));
				flag = RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.transform as RectTransform, vector2, uiCamera, out localPoint);
				localPoint = -localPoint;
			}
			if (flag)
			{
				Vector2 normalized = localPoint.normalized;
				Vector2 pointOnEllipse = GetPointOnEllipse(normalized, ellipseRadius);
				SetIconPosition(trackedTarget, pointOnEllipse, normalized, isInSide: false, num);
			}
			else
			{
				SetIconPosition(trackedTarget, outSizeVector2, Vector2.zero, isInSide: false, num);
			}
		}
	}

	private void SetIconPosition(QWorldMultiTargetTrackerDisplay target, Vector2 position, Vector2 direction, bool isInSide, float distance)
	{
		target.SetIconPosition(position, direction, isInSide, distance);
	}

	private bool IsInsideEllipse(Vector2 point, Vector2 radii)
	{
		return Mathf.Pow(point.x / radii.x, 2f) + Mathf.Pow(point.y / radii.y, 2f) <= 1f;
	}

	private Vector2 GetPointOnEllipse(Vector2 direction, Vector2 radius)
	{
		float x = direction.x;
		float y = direction.y;
		float num = Mathf.Sqrt(1f / (Mathf.Pow(x / radius.x, 2f) + Mathf.Pow(y / radius.y, 2f)));
		float x2 = num * x;
		float y2 = num * y;
		return new Vector2(x2, y2);
	}
}

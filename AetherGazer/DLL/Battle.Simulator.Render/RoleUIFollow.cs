using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class RoleUIFollow : MonoBehaviour
{
	public Transform targetGo;

	public Vector3 offset = Vector3.zero;

	public RectTransform uiTran;

	public RectTransform parentTran;

	public float deadZoom;

	public float slowMoveZoom = 200f;

	public float lerpTime = 0.5f;

	private Vector3 vector = Vector3.zero;

	private Camera uiCamera;

	public void Init(Transform target, Vector3 offset, RectTransform uiTran, RectTransform parentTran, float deadZoom, float slowMoveZoom, float lerpTime)
	{
		targetGo = target;
		this.offset = offset;
		this.uiTran = uiTran;
		this.deadZoom = deadZoom;
		this.slowMoveZoom = slowMoveZoom;
		this.lerpTime = lerpTime;
		this.parentTran = parentTran;
	}

	private void Update()
	{
		if (targetGo == null || uiTran == null || parentTran == null)
		{
			return;
		}
		Vector3 vector = Camera.main.WorldToScreenPoint(targetGo.position + offset);
		if (uiCamera == null)
		{
			uiCamera = CanvasManager.Instance.uiCamera;
		}
		if (isInScreen(vector))
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(parentTran, vector, uiCamera, out var localPoint);
			vector = localPoint;
			float magnitude = (vector - uiTran.localPosition).magnitude;
			if (magnitude > slowMoveZoom)
			{
				Vector3 localPosition = vector + (uiTran.localPosition - vector).normalized * slowMoveZoom;
				uiTran.localPosition = localPosition;
			}
			else if (magnitude > deadZoom)
			{
				uiTran.localPosition = Vector3.SmoothDamp(uiTran.localPosition, vector, ref this.vector, lerpTime);
			}
		}
	}

	public bool isInScreen(Vector3 pos)
	{
		if (pos.z > 0f && pos.x > 0f && pos.x < (float)Screen.width && pos.y > 0f)
		{
			return pos.y < (float)Screen.height;
		}
		return false;
	}
}

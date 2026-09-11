using UnityEngine;

public class BezierLineRenderer : MonoBehaviour
{
	public float Height = 5f;

	public int SegmentNum = 26;

	public LineRenderer LineRenderer;

	public Transform start;

	public float startOffsetY;

	public Transform end;

	public float endOffsetY;

	private void LateUpdate()
	{
		if (start == null || end == null || LineRenderer == null)
		{
			base.enabled = false;
			return;
		}
		if (LineRenderer.positionCount != SegmentNum + 1)
		{
			LineRenderer.positionCount = SegmentNum + 1;
		}
		DrawCurve();
	}

	private void DrawCurve()
	{
		Vector3 vector = start.transform.position.AddY(startOffsetY);
		Vector3 vector2 = end.transform.position.AddY(endOffsetY);
		Vector3 p = ((vector + vector2) / 2f).AddY(Height);
		for (int i = 0; i <= SegmentNum; i++)
		{
			float t = (float)i / (float)SegmentNum;
			Vector3 position = CalculateCubicBezierPoint(t, vector, p, vector2);
			LineRenderer.SetPosition(i, position);
		}
	}

	private Vector3 CalculateCubicBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2)
	{
		float num = 1f - t;
		float num2 = t * t;
		return num * num * p0 + 2f * num * t * p1 + num2 * p2;
	}
}

using UnityEngine;

public struct Line
{
	public Vector3 StartPoint;

	public Vector3 EndPoint;

	public Vector3 FLine => EndPoint - StartPoint;

	public Vector3 Direction => (EndPoint - StartPoint).normalized;

	public float Length => (EndPoint - StartPoint).magnitude;

	public Line(Vector3 start, Vector3 end)
	{
		StartPoint = start;
		EndPoint = end;
	}

	public void UpdatePoint(Vector3 start, Vector3 end)
	{
		StartPoint = start;
		EndPoint = end;
	}
}

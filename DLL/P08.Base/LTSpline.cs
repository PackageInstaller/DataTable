using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class LTSpline
{
	public static int DISTANCE_COUNT = 3;

	public static int SUBLINE_COUNT = 20;

	public float distance;

	public bool constantSpeed = true;

	public Vector3[] pts;

	[NonSerialized]
	public Vector3[] ptsAdj;

	public int ptsAdjLength;

	public bool orientToPath;

	public bool orientToPath2d;

	private int numSections;

	private int currPt;

	public LTSpline(Vector3[] pts)
	{
		init(pts, constantSpeed: true);
	}

	public LTSpline(Vector3[] pts, bool constantSpeed)
	{
		this.constantSpeed = constantSpeed;
		init(pts, constantSpeed);
	}

	private void init(Vector3[] pts, bool constantSpeed)
	{
		if (pts.Length < 4)
		{
			LeanTween.logError("LeanTween - When passing values for a spline path, you must pass four or more values!");
			return;
		}
		this.pts = new Vector3[pts.Length];
		Array.Copy(pts, this.pts, pts.Length);
		numSections = pts.Length - 3;
		float num = float.PositiveInfinity;
		Vector3 b = this.pts[1];
		float num2 = 0f;
		for (int i = 1; i < this.pts.Length - 1; i++)
		{
			float num3 = Vector3.Distance(this.pts[i], b);
			if (num3 < num)
			{
				num = num3;
			}
			num2 += num3;
		}
		if (!constantSpeed)
		{
			return;
		}
		num = num2 / (float)(numSections * SUBLINE_COUNT);
		float num4 = num / (float)SUBLINE_COUNT;
		int num5 = (int)Mathf.Ceil(num2 / num4) * DISTANCE_COUNT;
		if (num5 <= 1)
		{
			num5 = 2;
		}
		ptsAdj = new Vector3[num5];
		b = interp(0f);
		int num6 = 1;
		ptsAdj[0] = b;
		distance = 0f;
		for (int j = 0; j < num5 + 1; j++)
		{
			float num7 = (float)j / (float)num5;
			Vector3 vector = interp(num7);
			float num8 = Vector3.Distance(vector, b);
			if (num8 >= num4 || num7 >= 1f)
			{
				ptsAdj[num6] = vector;
				distance += num8;
				b = vector;
				num6++;
			}
		}
		ptsAdjLength = num6;
	}

	public Vector3 map(float u)
	{
		if (u >= 1f)
		{
			return pts[pts.Length - 2];
		}
		float num = u * (float)(ptsAdjLength - 1);
		int num2 = (int)Mathf.Floor(num);
		int num3 = (int)Mathf.Ceil(num);
		if (num2 < 0)
		{
			num2 = 0;
		}
		Vector3 vector = ptsAdj[num2];
		Vector3 vector2 = ptsAdj[num3];
		float num4 = num - (float)num2;
		return vector + (vector2 - vector) * num4;
	}

	public Vector3 interp(float t)
	{
		currPt = Mathf.Min(Mathf.FloorToInt(t * (float)numSections), numSections - 1);
		float num = t * (float)numSections - (float)currPt;
		Vector3 vector = pts[currPt];
		Vector3 vector2 = pts[currPt + 1];
		Vector3 vector3 = pts[currPt + 2];
		Vector3 vector4 = pts[currPt + 3];
		return 0.5f * ((-vector + 3f * vector2 - 3f * vector3 + vector4) * (num * num * num) + (2f * vector - 5f * vector2 + 4f * vector3 - vector4) * (num * num) + (-vector + vector3) * num + 2f * vector2);
	}

	public float ratioAtPoint(Vector3 pt)
	{
		float num = float.MaxValue;
		int num2 = 0;
		for (int i = 0; i < ptsAdjLength; i++)
		{
			float num3 = Vector3.Distance(pt, ptsAdj[i]);
			if (num3 < num)
			{
				num = num3;
				num2 = i;
			}
		}
		return (float)num2 / (float)(ptsAdjLength - 1);
	}

	public Vector3 point(float ratio)
	{
		float num = ((ratio > 1f) ? 1f : ratio);
		if (!constantSpeed)
		{
			return interp(num);
		}
		return map(num);
	}

	public void place2d(Transform transform, float ratio)
	{
		transform.position = point(ratio);
		ratio += 0.001f;
		if (ratio <= 1f)
		{
			Vector3 vector = point(ratio) - transform.position;
			float z = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
			transform.eulerAngles = new Vector3(0f, 0f, z);
		}
	}

	public void placeLocal2d(Transform transform, float ratio)
	{
		if (transform.parent == null)
		{
			place2d(transform, ratio);
			return;
		}
		transform.localPosition = point(ratio);
		ratio += 0.001f;
		if (ratio <= 1f)
		{
			Vector3 vector = point(ratio) - transform.localPosition;
			float z = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
			transform.localEulerAngles = new Vector3(0f, 0f, z);
		}
	}

	public void place(Transform transform, float ratio)
	{
		place(transform, ratio, Vector3.up);
	}

	public void place(Transform transform, float ratio, Vector3 worldUp)
	{
		transform.position = point(ratio);
		ratio += 0.001f;
		if (ratio <= 1f)
		{
			transform.LookAt(point(ratio), worldUp);
		}
	}

	public void placeLocal(Transform transform, float ratio)
	{
		placeLocal(transform, ratio, Vector3.up);
	}

	public void placeLocal(Transform transform, float ratio, Vector3 worldUp)
	{
		transform.localPosition = point(ratio);
		ratio += 0.001f;
		if (ratio <= 1f)
		{
			transform.LookAt(transform.parent.TransformPoint(point(ratio)), worldUp);
		}
	}

	public void gizmoDraw(float t = -1f)
	{
		if (ptsAdj != null && ptsAdj.Length != 0)
		{
			Vector3 vector = ptsAdj[0];
			for (int i = 0; i < ptsAdjLength; i++)
			{
				Vector3 vector2 = ptsAdj[i];
				Gizmos.DrawLine(vector, vector2);
				vector = vector2;
			}
		}
	}

	public void drawGizmo(Color color)
	{
		if (ptsAdjLength >= 4)
		{
			Vector3 vector = ptsAdj[0];
			Color color2 = Gizmos.color;
			Gizmos.color = color;
			for (int i = 0; i < ptsAdjLength; i++)
			{
				Vector3 vector2 = ptsAdj[i];
				Gizmos.DrawLine(vector, vector2);
				vector = vector2;
			}
			Gizmos.color = color2;
		}
	}

	public static void drawGizmo(Transform[] arr, Color color)
	{
		if (arr.Length >= 4)
		{
			Vector3[] array = new Vector3[arr.Length];
			for (int i = 0; i < arr.Length; i++)
			{
				array[i] = arr[i].position;
			}
			LTSpline lTSpline = new LTSpline(array);
			Vector3 vector = lTSpline.ptsAdj[0];
			Color color2 = Gizmos.color;
			Gizmos.color = color;
			for (int j = 0; j < lTSpline.ptsAdjLength; j++)
			{
				Vector3 vector2 = lTSpline.ptsAdj[j];
				Gizmos.DrawLine(vector, vector2);
				vector = vector2;
			}
			Gizmos.color = color2;
		}
	}

	public static void drawLine(Transform[] arr, float width, Color color)
	{
		_ = arr.Length;
		_ = 4;
	}

	public void drawLinesGLLines(Material outlineMaterial, Color color, float width)
	{
		GL.PushMatrix();
		outlineMaterial.SetPass(0);
		GL.LoadPixelMatrix();
		GL.Begin(1);
		GL.Color(color);
		if (constantSpeed)
		{
			if (ptsAdjLength >= 4)
			{
				Vector3 v = ptsAdj[0];
				for (int i = 0; i < ptsAdjLength; i++)
				{
					Vector3 vector = ptsAdj[i];
					GL.Vertex(v);
					GL.Vertex(vector);
					v = vector;
				}
			}
		}
		else if (pts.Length >= 4)
		{
			Vector3 v2 = pts[0];
			float num = 1f / ((float)pts.Length * 10f);
			for (float num2 = 0f; num2 < 1f; num2 += num)
			{
				float t = num2 / 1f;
				Vector3 vector2 = interp(t);
				GL.Vertex(v2);
				GL.Vertex(vector2);
				v2 = vector2;
			}
		}
		GL.End();
		GL.PopMatrix();
	}

	public Vector3[] generateVectors()
	{
		if (pts.Length >= 4)
		{
			List<Vector3> list = new List<Vector3>();
			Vector3 item = pts[0];
			list.Add(item);
			float num = 1f / ((float)pts.Length * 10f);
			for (float num2 = 0f; num2 < 1f; num2 += num)
			{
				float t = num2 / 1f;
				Vector3 item2 = interp(t);
				list.Add(item2);
			}
			list.ToArray();
		}
		return null;
	}
}

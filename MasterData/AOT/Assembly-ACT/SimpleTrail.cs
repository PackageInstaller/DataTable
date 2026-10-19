using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class SimpleTrail : MonoBehaviour
{
	public enum shapeType
	{
		One,
		Linear,
		Curve
	}

	private class spinePoint
	{
		public Vector3 position { get; set; }

		public float weight { get; set; }

		public Vector3 normal { get; set; }

		public spinePoint(Vector3 pos, float width, Vector3 Normal)
		{
			position = pos;
			weight = width;
			normal = Normal;
		}
	}

	public struct CatmullRomCurve(Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, float alpha)
	{
		public Vector3 p0 = p0;

		public Vector3 p1 = p1;

		public Vector3 p2 = p2;

		public Vector3 p3 = p3;

		public float alpha = alpha;

		public Vector3 GetPoint(float t)
		{
			float knotInterval = GetKnotInterval(p0, p1);
			float num = GetKnotInterval(p1, p2) + knotInterval;
			float b = GetKnotInterval(p2, p3) + num;
			float u = Mathf.LerpUnclamped(knotInterval, num, t);
			Vector3 c = Remap(0f, knotInterval, p0, p1, u);
			Vector3 vector = Remap(knotInterval, num, p1, p2, u);
			Vector3 d = Remap(num, b, p2, p3, u);
			Vector3 c2 = Remap(0f, num, c, vector, u);
			Vector3 d2 = Remap(knotInterval, b, vector, d, u);
			return Remap(knotInterval, num, c2, d2, u);
		}

		private static Vector3 Remap(float a, float b, Vector3 c, Vector3 d, float u)
		{
			return Vector3.LerpUnclamped(c, d, (u - a) / Mathf.Max(b - a, 0.001f));
		}

		private float GetKnotInterval(Vector3 a, Vector3 b)
		{
			return Mathf.Pow(Vector3.SqrMagnitude(a - b), 0.5f * alpha);
		}
	}

	public bool smoothEnd;

	[Range(1f, 10f)]
	public int smoothStep = 3;

	public int LifeTimeFrame = 15;

	public GameObject startObject;

	public GameObject endObject;

	public Material trailMat;

	public shapeType CurveType;

	public AnimationCurve Curve;

	[GradientUsage(true)]
	public Gradient ColorOverLife;

	public bool refreshEveryFrame;

	private Mesh simpleTrailMesh;

	private GameObject trailObject;

	private List<spinePoint> spineLineOriginal;

	private List<spinePoint> spineLineSmooth;

	private List<spinePoint> activeSpineLine;

	private Vector3[] vertics;

	private int verticsCount;

	private int[] triangles;

	private int trianglesCount;

	private Color[] vertColors;

	private int vertColorsCount;

	private Vector2[] vertUV;

	private int vertUVCount;

	private int currectEndPointIndex;

	private int age;

	private int smoothStopAge;

	private MeshFilter _meshFilter;

	private Transform startPoint;

	private Transform endPoint;

	private bool actived;

	private void OnEnable()
	{
		if (!(startObject == null) && !(endObject == null))
		{
			activeTaril();
		}
	}

	private void Update()
	{
		if (startObject == null || endObject == null)
		{
			return;
		}
		if (smoothStopAge == LifeTimeFrame && smoothEnd)
		{
			releaseData();
			return;
		}
		if (smoothEnd)
		{
			smoothStopAge += 2;
			smoothStopAge = (int)MathF.Min(LifeTimeFrame, smoothStopAge);
		}
		else
		{
			activeTaril();
			smoothStopAge = 0;
		}
		activeSpineLine = spineLineSmooth;
		age++;
		Vector3 position = startPoint.position;
		Vector3 position2 = endPoint.position;
		bool flag = age <= LifeTimeFrame;
		age = Mathf.Min(age, LifeTimeFrame);
		if (flag)
		{
			addToSpine(position, position2, spineLineOriginal);
			for (int i = 0; i < smoothStep; i++)
			{
				addToSpine(new Vector3(0f, 0f, 0f), spineLineSmooth);
			}
		}
		else
		{
			pickFristToLast(spineLineOriginal, position, position2);
			for (int j = 0; j < smoothStep; j++)
			{
				pickFristToLast(spineLineSmooth);
			}
		}
		updateSpine(spineLineOriginal);
		smoothNormal(spineLineOriginal);
		renewSmoothSpineLastParts(spineLineOriginal, spineLineSmooth, 0.5f, smoothStep);
		updateSmoothSpine(spineLineOriginal, activeSpineLine);
		for (int k = 0; k < smoothStep; k++)
		{
			if (flag)
			{
				currectEndPointIndex += 2;
				addToVertics(position, position2);
				addToTriangles(currectEndPointIndex);
				addColor();
				addUV();
			}
		}
		updateVertics(activeSpineLine);
		if (refreshEveryFrame | flag)
		{
			updateColor(activeSpineLine);
			updateUV(activeSpineLine);
		}
		simpleTrailMesh.vertices = vertics;
		simpleTrailMesh.triangles = triangles;
		simpleTrailMesh.uv = vertUV;
		simpleTrailMesh.colors = vertColors;
		simpleTrailMesh.RecalculateBounds();
		_meshFilter.sharedMesh = simpleTrailMesh;
	}

	private void OnDisable()
	{
		releaseData();
	}

	private void activeTaril()
	{
		if (!actived)
		{
			vertics = new Vector3[LifeTimeFrame * smoothStep * 2 + 2];
			triangles = new int[LifeTimeFrame * smoothStep * 6];
			spineLineOriginal = new List<spinePoint>();
			spineLineSmooth = new List<spinePoint>();
			vertColors = new Color[LifeTimeFrame * smoothStep * 2 + 2];
			vertUV = new Vector2[LifeTimeFrame * smoothStep * 2 + 2];
			verticsCount = 0;
			trianglesCount = 0;
			vertColorsCount = 0;
			vertUVCount = 0;
			age = 0;
			smoothStopAge = 0;
			startPoint = startObject.transform;
			endPoint = endObject.transform;
			Vector3 position = startPoint.position;
			Vector3 position2 = endPoint.position;
			currectEndPointIndex = 1;
			actived = true;
			addToSpine(position, position2, spineLineOriginal);
			addToSpine(position, position2, spineLineSmooth);
			addToVertics(position, position2);
			addColor();
			addUV();
			trailObject = new GameObject("Taril Object" + name);
			trailObject.AddComponent<MeshFilter>();
			trailObject.AddComponent<MeshRenderer>();
			trailObject.GetComponent<MeshRenderer>().material = trailMat;
			_meshFilter = trailObject.GetComponent<MeshFilter>();
			simpleTrailMesh = new Mesh();
		}
	}

	private void addToSpine(Vector3 startPos, Vector3 endPos, List<spinePoint> spineList)
	{
		spinePoint item = new spinePoint((startPos + endPos) / 2f, 1f, (startPos - endPos) / 2f);
		spineList.Add(item);
	}

	private void addToSpine(Vector3 Pos, List<spinePoint> spineList)
	{
		addToSpine(Pos, 1f, new Vector3(0f, 1f, 0f), spineList);
	}

	private void addToSpine(Vector3 pos, float width, Vector3 normal, List<spinePoint> spineList)
	{
		spinePoint item = new spinePoint(pos, width, normal);
		spineList.Add(item);
	}

	private void updateSpine(List<spinePoint> spineList)
	{
		if (!smoothEnd)
		{
			for (int i = 0; i < spineList.Count; i++)
			{
				spineList[i].weight = (float)i / ((float)spineList.Count - 1f);
			}
		}
		else
		{
			for (int j = 0; j < spineList.Count; j++)
			{
				spineList[j].weight = (float)Mathf.Max(0, j - smoothStopAge) / Mathf.Max(1f, (float)spineList.Count - 1f - (float)smoothStopAge);
			}
		}
	}

	private void smoothNormal(List<spinePoint> spineList)
	{
		if (spineList.Count > 2)
		{
			Vector3 normal = spineList[spineList.Count - 1].normal;
			Vector3 normal2 = spineList[spineList.Count - 3].normal;
			spineList[spineList.Count - 2].normal = Vector3.Lerp(normal, normal2, 0.5f);
		}
	}

	private void updateSmoothSpine(List<spinePoint> sourceSpine, List<spinePoint> smoothSpine)
	{
		for (int i = 0; i < sourceSpine.Count; i++)
		{
			if (i == sourceSpine.Count - 1)
			{
				smoothSpine[i * smoothStep].weight = 1f;
				continue;
			}
			for (int j = 0; j < smoothStep; j++)
			{
				smoothSpine[i * smoothStep + j].weight = Mathf.Lerp(sourceSpine[i].weight, sourceSpine[i + 1].weight, (float)j / (float)smoothStep);
			}
		}
	}

	private void renewSmoothSpine(List<spinePoint> sourceSpine, List<spinePoint> smoothSpine, float alpha, int smoothStepCount)
	{
		for (int i = 0; i < sourceSpine.Count; i++)
		{
			if (i != sourceSpine.Count - 1)
			{
				Vector3 position = sourceSpine[i].position;
				Vector3 position2 = sourceSpine[i + 1].position;
				Vector3 p = ((i - 1 >= 0) ? sourceSpine[i - 1].position : (position + position - position2));
				Vector3 p2 = ((i + 2 < sourceSpine.Count) ? sourceSpine[i + 2].position : (position2 + position2 - position));
				CatmullRomCurve catmullRomCurve = new CatmullRomCurve(p, position, position2, p2, alpha);
				for (int j = 0; j < smoothStepCount; j++)
				{
					int num = i * smoothStepCount + j;
					float t = (float)j / (float)smoothStepCount;
					smoothSpine[num].position = catmullRomCurve.GetPoint(t);
					smoothSpine[num].normal = Vector3.Lerp(sourceSpine[i].normal, sourceSpine[i + 1].normal, t);
					smoothSpine[num].weight = (float)num / (float)(smoothSpine.Count - 1);
				}
			}
			else
			{
				int index = i * smoothStepCount;
				smoothSpine[index].position = sourceSpine[i].position;
				smoothSpine[index].normal = sourceSpine[i].normal;
				smoothSpine[index].weight = 1f;
			}
		}
	}

	private void renewSmoothSpineLastParts(List<spinePoint> sourceSpine, List<spinePoint> smoothSpine, float alpha, int smoothStepCount)
	{
		for (int i = sourceSpine.Count - 3; i < sourceSpine.Count; i++)
		{
			if (i < 0)
			{
				continue;
			}
			if (i != sourceSpine.Count - 1)
			{
				Vector3 position = sourceSpine[i].position;
				Vector3 position2 = sourceSpine[i + 1].position;
				Vector3 p = ((i - 1 >= 0) ? sourceSpine[i - 1].position : (position + position - position2));
				Vector3 p2 = ((i + 2 < sourceSpine.Count) ? sourceSpine[i + 2].position : (position2 + position2 - position));
				CatmullRomCurve catmullRomCurve = new CatmullRomCurve(p, position, position2, p2, alpha);
				for (int j = 0; j < smoothStepCount; j++)
				{
					int index = i * smoothStepCount + j;
					float t = (float)j / (float)smoothStepCount;
					smoothSpine[index].position = catmullRomCurve.GetPoint(t);
					smoothSpine[index].normal = Vector3.Lerp(sourceSpine[i].normal, sourceSpine[i + 1].normal, t);
				}
			}
			else
			{
				int index2 = i * smoothStepCount;
				smoothSpine[index2].position = sourceSpine[i].position;
				smoothSpine[index2].normal = sourceSpine[i].normal;
			}
		}
	}

	private void removeSpinePoint(List<spinePoint> spineList)
	{
		spineList.RemoveAt(0);
	}

	private void pickFristToLast(List<spinePoint> spineList)
	{
		spinePoint item = spineList[0];
		spineList.RemoveAt(0);
		spineList.Add(item);
	}

	private void pickFristToLast(List<spinePoint> spineList, Vector3 startPos, Vector3 endPos)
	{
		spinePoint spinePoint2 = spineList[0];
		spinePoint2.position = (startPos + endPos) / 2f;
		spinePoint2.weight = 1f;
		spinePoint2.normal = (startPos - endPos) / 2f;
		spineList.RemoveAt(0);
		spineList.Add(spinePoint2);
	}

	private void addToVertics(Vector3 startPos, Vector3 endPos)
	{
		vertics[verticsCount] = startPos;
		vertics[verticsCount + 1] = endPos;
		verticsCount += 2;
	}

	private void updateVertics(List<spinePoint> spineList)
	{
		for (int i = 0; i < vertics.Length; i++)
		{
			int num = Mathf.FloorToInt((float)i / 2f);
			if (num < spineList.Count)
			{
				float num2;
				if (CurveType == shapeType.Curve)
				{
					num2 = Curve.Evaluate(1f - spineList[num].weight);
				}
				else
				{
					num2 = ((CurveType != shapeType.One) ? spineList[num].weight : 1f);
				}
				vertics[i] = spineList[num].position + Mathf.Lerp(1f, -1f, i % 2) * spineList[num].normal * num2;
			}
		}
	}

	private void addToTriangles(int currectEndIndex)
	{
		int preStartIndex = currectEndIndex - 3;
		int preEndIndex = currectEndIndex - 2;
		int currectStartIndex = currectEndIndex - 1;
		addToTriangles(preStartIndex, preEndIndex, currectStartIndex, currectEndIndex);
	}

	private void addToTriangles(int preStartIndex, int preEndIndex, int currectStartIndex, int currectEndIndex)
	{
		triangles[trianglesCount] = preStartIndex;
		triangles[trianglesCount + 1] = currectStartIndex;
		triangles[trianglesCount + 2] = preEndIndex;
		triangles[trianglesCount + 3] = currectStartIndex;
		triangles[trianglesCount + 4] = currectEndIndex;
		triangles[trianglesCount + 5] = preEndIndex;
		trianglesCount += 6;
	}

	private void releaseData()
	{
		if (actived)
		{
			simpleTrailMesh = null;
			spineLineOriginal = null;
			spineLineSmooth = null;
			vertics = null;
			triangles = null;
			currectEndPointIndex = 0;
			verticsCount = 0;
			trianglesCount = 0;
			vertColors = null;
			vertUV = null;
			actived = false;
			UnityEngine.Object.DestroyImmediate(trailObject);
		}
	}

	private void addColor()
	{
	}

	private void updateColor(List<spinePoint> spineList)
	{
		for (int i = 0; i < vertColors.Length; i++)
		{
			int num = Mathf.FloorToInt((float)i / 2f);
			if (num < spineList.Count)
			{
				vertColors[i] = ColorOverLife.Evaluate(1f - spineList[num].weight);
			}
		}
	}

	private void addUV()
	{
	}

	private void updateUV(List<spinePoint> spineList)
	{
		for (int i = 0; i < vertUV.Length; i++)
		{
			int num = Mathf.FloorToInt((float)i / 2f);
			if (num < spineList.Count)
			{
				vertUV[i] = new Vector2(spineList[num].weight, (i + 1) % 2);
			}
		}
	}
}

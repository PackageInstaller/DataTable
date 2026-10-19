using System.Collections.Generic;
using UnityEngine;

public class SimpleTrailByLineRender : MonoBehaviour
{
	public enum SamplingMode
	{
		SingleStart,
		SingleEnd,
		Midpoint,
		Both
	}

	[Header("采样目标")]
	public GameObject startObject;

	public GameObject endObject;

	[Header("轨迹设置")]
	public LineRenderer lineRenderer;

	public int lifeFrames = 15;

	[Range(1f, 8f)]
	public int smoothStep = 3;

	public float minSampleDistance = 0.01f;

	public bool refreshEveryFrame = true;

	[Header("采样模式")]
	public SamplingMode samplingMode = SamplingMode.Midpoint;

	public Gradient colorOverLife;

	public float startWidth = 0.2f;

	public float endWidth;

	private readonly List<Vector3> spine = new List<Vector3>();

	private int maxSpineCount => Mathf.Max(1, lifeFrames);

	private void Start()
	{
		if (lineRenderer == null)
		{
			lineRenderer = GetComponent<LineRenderer>();
		}
		if (lineRenderer != null)
		{
			lineRenderer.positionCount = 0;
			lineRenderer.widthCurve = AnimationCurve.Linear(0f, startWidth, 1f, endWidth);
			if (colorOverLife != null)
			{
				lineRenderer.colorGradient = colorOverLife;
			}
		}
	}

	private void Update()
	{
		if (lineRenderer == null)
		{
			return;
		}
		bool flag = startObject != null;
		bool flag2 = endObject != null;
		Vector3 vector = (flag ? startObject.transform.position : Vector3.zero);
		Vector3 vector2 = (flag2 ? endObject.transform.position : Vector3.zero);
		switch (samplingMode)
		{
		case SamplingMode.SingleStart:
			if (flag)
			{
				TryInsertSample(vector);
			}
			break;
		case SamplingMode.SingleEnd:
			if (flag2)
			{
				TryInsertSample(vector2);
			}
			break;
		case SamplingMode.Midpoint:
			if (flag & flag2)
			{
				TryInsertSample((vector + vector2) * 0.5f);
			}
			else if (flag)
			{
				TryInsertSample(vector);
			}
			else if (flag2)
			{
				TryInsertSample(vector2);
			}
			break;
		case SamplingMode.Both:
			if (flag)
			{
				TryInsertSample(vector);
			}
			if (flag2)
			{
				TryInsertSample(vector2);
			}
			break;
		default:
			if (flag & flag2)
			{
				TryInsertSample((vector + vector2) * 0.5f);
			}
			else if (flag)
			{
				TryInsertSample(vector);
			}
			else if (flag2)
			{
				TryInsertSample(vector2);
			}
			break;
		}
		List<Vector3> list = new List<Vector3>();
		for (int i = 0; i < spine.Count; i++)
		{
			Vector3 vector3 = spine[i];
			Vector3 b = ((i + 1 < spine.Count) ? spine[i + 1] : spine[i]);
			list.Add(vector3);
			for (int j = 1; j < smoothStep; j++)
			{
				float t = (float)j / (float)smoothStep;
				list.Add(Vector3.Lerp(vector3, b, t));
			}
		}
		lineRenderer.positionCount = list.Count;
		lineRenderer.SetPositions(list.ToArray());
		if (refreshEveryFrame)
		{
			if (colorOverLife != null)
			{
				lineRenderer.colorGradient = colorOverLife;
			}
			lineRenderer.widthCurve = AnimationCurve.Linear(0f, startWidth, 1f, endWidth);
		}
		void TryInsertSample(Vector3 s)
		{
			if (spine.Count == 0 || Vector3.Distance(s, spine[0]) >= minSampleDistance)
			{
				spine.Insert(0, s);
				if (spine.Count > maxSpineCount)
				{
					spine.RemoveRange(maxSpineCount, spine.Count - maxSpineCount);
				}
			}
		}
	}
}

using System;
using UnityEngine;

[RequireComponent(typeof(BezierSpline))]
public class SplineProgressBar : MonoBehaviour
{
	[SerializeField]
	public BezierSpline spline;

	[SerializeField]
	public RectTransform container;

	[SerializeField]
	public RectTransform handle;

	[SerializeField]
	private float progressValue = 0.5f;

	[SerializeField]
	private AnimationCurve curveOfProgress;

	public float ProgressValue
	{
		get
		{
			return progressValue;
		}
		set
		{
			progressValue = value;
			if (container != null)
			{
				Vector2 sizeDelta = container.sizeDelta;
				Vector3 point = spline.GetPoint(curveOfProgress.Evaluate(progressValue));
				sizeDelta.x = Math.Abs(point.x);
				sizeDelta.y = Math.Abs(point.y);
				container.sizeDelta = sizeDelta;
			}
		}
	}

	public float GetValue()
	{
		return progressValue;
	}

	public void SetValue(float value)
	{
		value = Math.Min(1f, value);
		value = Math.Max(0f, value);
		progressValue = value;
		if (container != null)
		{
			Vector2 sizeDelta = container.sizeDelta;
			Vector3 point = spline.GetPoint(curveOfProgress.Evaluate(progressValue));
			sizeDelta.x = Math.Abs(point.x);
			sizeDelta.y = Math.Abs(point.y);
			container.sizeDelta = sizeDelta;
		}
	}

	private void Awake()
	{
		spline = GetComponent<BezierSpline>();
	}
}

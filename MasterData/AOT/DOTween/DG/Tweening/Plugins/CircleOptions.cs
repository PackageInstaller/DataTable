using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public struct CircleOptions : IPlugOptions
{
	public float endValueDegrees;

	public bool relativeCenter;

	public bool snapping;

	internal Vector2 center;

	internal float radius;

	internal float startValueDegrees;

	internal bool initialized;

	public void Reset()
	{
		initialized = false;
		startValueDegrees = (endValueDegrees = 0f);
		relativeCenter = false;
		snapping = false;
	}

	public void Initialize(Vector2 startValue, Vector2 endValue)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		initialized = true;
		center = endValue;
		if (relativeCenter)
		{
			center = startValue + center;
		}
		radius = Vector2.Distance(center, startValue);
		Vector2 val = startValue - center;
		startValueDegrees = Mathf.Atan2(val.x, val.y) * 57.29578f;
	}
}

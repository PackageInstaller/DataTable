using DG.Tweening.Core.Easing;
using UnityEngine;

namespace DG.Tweening;

public static class DOVirtual
{
	public static Tweener Float(float from, float to, float duration, TweenCallback<float> onVirtualUpdate)
	{
		return DOTween.To(() => from, delegate(float x)
		{
			from = x;
		}, to, duration).OnUpdate(delegate
		{
			onVirtualUpdate(from);
		});
	}

	public static Tweener Int(int from, int to, float duration, TweenCallback<int> onVirtualUpdate)
	{
		return DOTween.To(() => from, delegate(int x)
		{
			from = x;
		}, to, duration).OnUpdate(delegate
		{
			onVirtualUpdate(from);
		});
	}

	public static Tweener Vector2(Vector2 from, Vector2 to, float duration, TweenCallback<Vector2> onVirtualUpdate)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return from;
		}, delegate(Vector2 x)
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			from = x;
		}, to, duration).OnUpdate(delegate
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			onVirtualUpdate(from);
		});
	}

	public static Tweener Vector3(Vector3 from, Vector3 to, float duration, TweenCallback<Vector3> onVirtualUpdate)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return from;
		}, delegate(Vector3 x)
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			from = x;
		}, to, duration).OnUpdate(delegate
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			onVirtualUpdate(from);
		});
	}

	public static Tweener Color(Color from, Color to, float duration, TweenCallback<Color> onVirtualUpdate)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return from;
		}, delegate(Color x)
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			from = x;
		}, to, duration).OnUpdate(delegate
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			onVirtualUpdate(from);
		});
	}

	public static float EasedValue(float from, float to, float lifetimePercentage, Ease easeType)
	{
		return from + (to - from) * EaseManager.Evaluate(easeType, null, lifetimePercentage, 1f, DOTween.defaultEaseOvershootOrAmplitude, DOTween.defaultEasePeriod);
	}

	public static float EasedValue(float from, float to, float lifetimePercentage, Ease easeType, float overshoot)
	{
		return from + (to - from) * EaseManager.Evaluate(easeType, null, lifetimePercentage, 1f, overshoot, DOTween.defaultEasePeriod);
	}

	public static float EasedValue(float from, float to, float lifetimePercentage, Ease easeType, float amplitude, float period)
	{
		return from + (to - from) * EaseManager.Evaluate(easeType, null, lifetimePercentage, 1f, amplitude, period);
	}

	public static float EasedValue(float from, float to, float lifetimePercentage, AnimationCurve easeCurve)
	{
		return from + (to - from) * EaseManager.Evaluate(Ease.INTERNAL_Custom, new EaseCurve(easeCurve).Evaluate, lifetimePercentage, 1f, DOTween.defaultEaseOvershootOrAmplitude, DOTween.defaultEasePeriod);
	}

	public static Vector3 EasedValue(Vector3 from, Vector3 to, float lifetimePercentage, Ease easeType)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		return from + (to - from) * EaseManager.Evaluate(easeType, null, lifetimePercentage, 1f, DOTween.defaultEaseOvershootOrAmplitude, DOTween.defaultEasePeriod);
	}

	public static Vector3 EasedValue(Vector3 from, Vector3 to, float lifetimePercentage, Ease easeType, float overshoot)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		return from + (to - from) * EaseManager.Evaluate(easeType, null, lifetimePercentage, 1f, overshoot, DOTween.defaultEasePeriod);
	}

	public static Vector3 EasedValue(Vector3 from, Vector3 to, float lifetimePercentage, Ease easeType, float amplitude, float period)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		return from + (to - from) * EaseManager.Evaluate(easeType, null, lifetimePercentage, 1f, amplitude, period);
	}

	public static Vector3 EasedValue(Vector3 from, Vector3 to, float lifetimePercentage, AnimationCurve easeCurve)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		return from + (to - from) * EaseManager.Evaluate(Ease.INTERNAL_Custom, new EaseCurve(easeCurve).Evaluate, lifetimePercentage, 1f, DOTween.defaultEaseOvershootOrAmplitude, DOTween.defaultEasePeriod);
	}

	public static Tween DelayedCall(float delay, TweenCallback callback, bool ignoreTimeScale = true)
	{
		return DOTween.Sequence().AppendInterval(delay).OnStepComplete(callback)
			.SetUpdate(UpdateType.Normal, ignoreTimeScale)
			.SetAutoKill(autoKillOnCompletion: true);
	}
}

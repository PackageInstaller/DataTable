using DG.Tweening.Core;
using DG.Tweening.Core.Enums;
using DG.Tweening.CustomPlugins;
using DG.Tweening.Plugins;
using DG.Tweening.Plugins.Core.PathCore;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening;

public static class ShortcutExtensions
{
	public static TweenerCore<float, float, FloatOptions> DOAspect(this Camera target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.aspect, delegate(float x)
		{
			target.aspect = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Color, Color, ColorOptions> DOColor(this Camera target, Color endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.backgroundColor;
		}, delegate(Color x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.backgroundColor = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOFarClipPlane(this Camera target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.farClipPlane, delegate(float x)
		{
			target.farClipPlane = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOFieldOfView(this Camera target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.fieldOfView, delegate(float x)
		{
			target.fieldOfView = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DONearClipPlane(this Camera target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.nearClipPlane, delegate(float x)
		{
			target.nearClipPlane = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOOrthoSize(this Camera target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.orthographicSize, delegate(float x)
		{
			target.orthographicSize = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Rect, Rect, RectOptions> DOPixelRect(this Camera target, Rect endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Rect, Rect, RectOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.pixelRect;
		}, delegate(Rect x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.pixelRect = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Rect, Rect, RectOptions> DORect(this Camera target, Rect endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Rect, Rect, RectOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.rect;
		}, delegate(Rect x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.rect = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static Tweener DOShakePosition(this Camera target, float duration, float strength = 3f, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakePosition: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			return ((Component)target).transform.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			((Component)target).transform.localPosition = x;
		}, duration, strength, vibrato, randomness, ignoreZAxis: true, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetCameraShakePosition);
	}

	public static Tweener DOShakePosition(this Camera target, float duration, Vector3 strength, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakePosition: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			return ((Component)target).transform.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			((Component)target).transform.localPosition = x;
		}, duration, strength, vibrato, randomness, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetCameraShakePosition);
	}

	public static Tweener DOShakeRotation(this Camera target, float duration, float strength = 90f, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakeRotation: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			return ((Component)target).transform.localEulerAngles;
		}, delegate(Vector3 x)
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			((Component)target).transform.localRotation = Quaternion.Euler(x);
		}, duration, strength, vibrato, randomness, ignoreZAxis: false, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake);
	}

	public static Tweener DOShakeRotation(this Camera target, float duration, Vector3 strength, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakeRotation: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			return ((Component)target).transform.localEulerAngles;
		}, delegate(Vector3 x)
		{
			//IL_000b: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			((Component)target).transform.localRotation = Quaternion.Euler(x);
		}, duration, strength, vibrato, randomness, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake);
	}

	public static TweenerCore<Color, Color, ColorOptions> DOColor(this Light target, Color endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.color;
		}, delegate(Color x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.color = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOIntensity(this Light target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.intensity, delegate(float x)
		{
			target.intensity = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOShadowStrength(this Light target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.shadowStrength, delegate(float x)
		{
			target.shadowStrength = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static Tweener DOColor(this LineRenderer target, Color2 startValue, Color2 endValue, float duration)
	{
		return DOTween.To(() => startValue, delegate(Color2 x)
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			target.startColor = x.ca;
			target.endColor = x.cb;
		}, endValue, duration).SetTarget(target);
	}

	public static TweenerCore<Color, Color, ColorOptions> DOColor(this Material target, Color endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.color;
		}, delegate(Color x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.color = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Color, Color, ColorOptions> DOColor(this Material target, Color endValue, string property, float duration)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(property))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(property);
			}
			return null;
		}
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetColor(property);
		}, delegate(Color x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetColor(property, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Color, Color, ColorOptions> DOColor(this Material target, Color endValue, int propertyID, float duration)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(propertyID))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(propertyID);
			}
			return null;
		}
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetColor(propertyID);
		}, delegate(Color x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetColor(propertyID, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Color, Color, ColorOptions> DOFade(this Material target, float endValue, float duration)
	{
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.ToAlpha(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.color;
		}, delegate(Color x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.color = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Color, Color, ColorOptions> DOFade(this Material target, float endValue, string property, float duration)
	{
		if (!target.HasProperty(property))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(property);
			}
			return null;
		}
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.ToAlpha(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetColor(property);
		}, delegate(Color x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetColor(property, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Color, Color, ColorOptions> DOFade(this Material target, float endValue, int propertyID, float duration)
	{
		if (!target.HasProperty(propertyID))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(propertyID);
			}
			return null;
		}
		TweenerCore<Color, Color, ColorOptions> tweenerCore = DOTween.ToAlpha(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetColor(propertyID);
		}, delegate(Color x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetColor(propertyID, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOFloat(this Material target, float endValue, string property, float duration)
	{
		if (!target.HasProperty(property))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(property);
			}
			return null;
		}
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.GetFloat(property), delegate(float x)
		{
			target.SetFloat(property, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOFloat(this Material target, float endValue, int propertyID, float duration)
	{
		if (!target.HasProperty(propertyID))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(propertyID);
			}
			return null;
		}
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.GetFloat(propertyID), delegate(float x)
		{
			target.SetFloat(propertyID, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector2, Vector2, VectorOptions> DOOffset(this Material target, Vector2 endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector2, Vector2, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.mainTextureOffset;
		}, delegate(Vector2 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.mainTextureOffset = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector2, Vector2, VectorOptions> DOOffset(this Material target, Vector2 endValue, string property, float duration)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(property))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(property);
			}
			return null;
		}
		TweenerCore<Vector2, Vector2, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetTextureOffset(property);
		}, delegate(Vector2 x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetTextureOffset(property, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector2, Vector2, VectorOptions> DOTiling(this Material target, Vector2 endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector2, Vector2, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.mainTextureScale;
		}, delegate(Vector2 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.mainTextureScale = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector2, Vector2, VectorOptions> DOTiling(this Material target, Vector2 endValue, string property, float duration)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(property))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(property);
			}
			return null;
		}
		TweenerCore<Vector2, Vector2, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetTextureScale(property);
		}, delegate(Vector2 x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetTextureScale(property, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector4, Vector4, VectorOptions> DOVector(this Material target, Vector4 endValue, string property, float duration)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(property))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(property);
			}
			return null;
		}
		TweenerCore<Vector4, Vector4, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetVector(property);
		}, delegate(Vector4 x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetVector(property, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector4, Vector4, VectorOptions> DOVector(this Material target, Vector4 endValue, int propertyID, float duration)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(propertyID))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(propertyID);
			}
			return null;
		}
		TweenerCore<Vector4, Vector4, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			return target.GetVector(propertyID);
		}, delegate(Vector4 x)
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			target.SetVector(propertyID, x);
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static Tweener DOResize(this TrailRenderer target, float toStartWidth, float toEndWidth, float duration)
	{
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		return DOTween.To(delegate
		{
			//IL_0016: Unknown result type (might be due to invalid IL or missing references)
			return new Vector2(target.startWidth, target.endWidth);
		}, delegate(Vector2 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_0017: Unknown result type (might be due to invalid IL or missing references)
			target.startWidth = x.x;
			target.endWidth = x.y;
		}, new Vector2(toStartWidth, toEndWidth), duration).SetTarget(target);
	}

	public static TweenerCore<float, float, FloatOptions> DOTime(this TrailRenderer target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.time, delegate(float x)
		{
			target.time = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOMove(this Transform target, Vector3 endValue, float duration, bool snapping = false)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, endValue, duration);
		tweenerCore.SetOptions(snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOMoveX(this Transform target, float endValue, float duration, bool snapping = false)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, new Vector3(endValue, 0f, 0f), duration);
		tweenerCore.SetOptions(AxisConstraint.X, snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOMoveY(this Transform target, float endValue, float duration, bool snapping = false)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, new Vector3(0f, endValue, 0f), duration);
		tweenerCore.SetOptions(AxisConstraint.Y, snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOMoveZ(this Transform target, float endValue, float duration, bool snapping = false)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, new Vector3(0f, 0f, endValue), duration);
		tweenerCore.SetOptions(AxisConstraint.Z, snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOLocalMove(this Transform target, Vector3 endValue, float duration, bool snapping = false)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, endValue, duration);
		tweenerCore.SetOptions(snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOLocalMoveX(this Transform target, float endValue, float duration, bool snapping = false)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, new Vector3(endValue, 0f, 0f), duration);
		tweenerCore.SetOptions(AxisConstraint.X, snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOLocalMoveY(this Transform target, float endValue, float duration, bool snapping = false)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, new Vector3(0f, endValue, 0f), duration);
		tweenerCore.SetOptions(AxisConstraint.Y, snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOLocalMoveZ(this Transform target, float endValue, float duration, bool snapping = false)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, new Vector3(0f, 0f, endValue), duration);
		tweenerCore.SetOptions(AxisConstraint.Z, snapping).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Quaternion, Vector3, QuaternionOptions> DORotate(this Transform target, Vector3 endValue, float duration, RotateMode mode = RotateMode.Fast)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Quaternion, Vector3, QuaternionOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.rotation;
		}, delegate(Quaternion x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.rotation = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		tweenerCore.plugOptions.rotateMode = mode;
		return tweenerCore;
	}

	public static TweenerCore<Quaternion, Quaternion, NoOptions> DORotateQuaternion(this Transform target, Quaternion endValue, float duration)
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Quaternion, Quaternion, NoOptions> tweenerCore = DOTween.To(PureQuaternionPlugin.Plug(), delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.rotation;
		}, delegate(Quaternion x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.rotation = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Quaternion, Vector3, QuaternionOptions> DOLocalRotate(this Transform target, Vector3 endValue, float duration, RotateMode mode = RotateMode.Fast)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Quaternion, Vector3, QuaternionOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localRotation;
		}, delegate(Quaternion x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localRotation = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		tweenerCore.plugOptions.rotateMode = mode;
		return tweenerCore;
	}

	public static TweenerCore<Quaternion, Quaternion, NoOptions> DOLocalRotateQuaternion(this Transform target, Quaternion endValue, float duration)
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Quaternion, Quaternion, NoOptions> tweenerCore = DOTween.To(PureQuaternionPlugin.Plug(), delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localRotation;
		}, delegate(Quaternion x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localRotation = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOScale(this Transform target, Vector3 endValue, float duration)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOScale(this Transform target, float endValue, float duration)
	{
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		Vector3 endValue2 = default(Vector3);
		((Vector3)(ref endValue2))._002Ector(endValue, endValue, endValue);
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, endValue2, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOScaleX(this Transform target, float endValue, float duration)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, new Vector3(endValue, 0f, 0f), duration);
		tweenerCore.SetOptions(AxisConstraint.X).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOScaleY(this Transform target, float endValue, float duration)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, new Vector3(0f, endValue, 0f), duration);
		tweenerCore.SetOptions(AxisConstraint.Y).SetTarget(target);
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> DOScaleZ(this Transform target, float endValue, float duration)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, new Vector3(0f, 0f, endValue), duration);
		tweenerCore.SetOptions(AxisConstraint.Z).SetTarget(target);
		return tweenerCore;
	}

	public static Tweener DOLookAt(this Transform target, Vector3 towards, float duration, AxisConstraint axisConstraint = AxisConstraint.None, Vector3? up = null)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return target.LookAt(towards, duration, axisConstraint, up, dynamic: false);
	}

	public static Tweener DODynamicLookAt(this Transform target, Vector3 towards, float duration, AxisConstraint axisConstraint = AxisConstraint.None, Vector3? up = null)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return target.LookAt(towards, duration, axisConstraint, up, dynamic: true);
	}

	private static Tweener LookAt(this Transform target, Vector3 towards, float duration, AxisConstraint axisConstraint, Vector3? up, bool dynamic)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Quaternion, Vector3, QuaternionOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.rotation;
		}, delegate(Quaternion x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.rotation = x;
		}, towards, duration).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetLookAt);
		tweenerCore.plugOptions.axisConstraint = axisConstraint;
		tweenerCore.plugOptions.up = ((!up.HasValue) ? Vector3.up : up.Value);
		if (dynamic)
		{
			tweenerCore.plugOptions.dynamicLookAt = true;
			tweenerCore.plugOptions.dynamicLookAtWorldPosition = towards;
		}
		else
		{
			tweenerCore.plugOptions.dynamicLookAt = false;
		}
		return tweenerCore;
	}

	public static Tweener DOPunchPosition(this Transform target, Vector3 punch, float duration, int vibrato = 10, float elasticity = 1f, bool snapping = false)
	{
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOPunchPosition: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Punch(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, punch, duration, vibrato, elasticity).SetTarget(target).SetOptions(snapping);
	}

	public static Tweener DOPunchScale(this Transform target, Vector3 punch, float duration, int vibrato = 10, float elasticity = 1f)
	{
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOPunchScale: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Punch(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, punch, duration, vibrato, elasticity).SetTarget(target);
	}

	public static Tweener DOPunchRotation(this Transform target, Vector3 punch, float duration, int vibrato = 10, float elasticity = 1f)
	{
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOPunchRotation: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Punch(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localEulerAngles;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			target.localRotation = Quaternion.Euler(x);
		}, punch, duration, vibrato, elasticity).SetTarget(target);
	}

	public static Tweener DOShakePosition(this Transform target, float duration, float strength = 1f, int vibrato = 10, float randomness = 90f, bool snapping = false, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakePosition: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, duration, strength, vibrato, randomness, ignoreZAxis: false, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake)
			.SetOptions(snapping);
	}

	public static Tweener DOShakePosition(this Transform target, float duration, Vector3 strength, int vibrato = 10, float randomness = 90f, bool snapping = false, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakePosition: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, duration, strength, vibrato, randomness, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake)
			.SetOptions(snapping);
	}

	public static Tweener DOShakeRotation(this Transform target, float duration, float strength = 90f, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakeRotation: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localEulerAngles;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			target.localRotation = Quaternion.Euler(x);
		}, duration, strength, vibrato, randomness, ignoreZAxis: false, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake);
	}

	public static Tweener DOShakeRotation(this Transform target, float duration, Vector3 strength, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakeRotation: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localEulerAngles;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			target.localRotation = Quaternion.Euler(x);
		}, duration, strength, vibrato, randomness, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake);
	}

	public static Tweener DOShakeScale(this Transform target, float duration, float strength = 1f, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		if (duration <= 0f)
		{
			Debug.Log((object)Debugger.logPriority);
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakeScale: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, duration, strength, vibrato, randomness, ignoreZAxis: false, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake);
	}

	public static Tweener DOShakeScale(this Transform target, float duration, Vector3 strength, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOShakeScale: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		return DOTween.Shake(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localScale;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localScale = x;
		}, duration, strength, vibrato, randomness, fadeOut, randomnessMode).SetTarget(target).SetSpecialStartupMode(SpecialStartupMode.SetShake);
	}

	public static Sequence DOJump(this Transform target, Vector3 endValue, float jumpPower, int numJumps, float duration, bool snapping = false)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0134: Unknown result type (might be due to invalid IL or missing references)
		if (numJumps < 1)
		{
			numJumps = 1;
		}
		float startPosY = target.position.y;
		float offsetY = -1f;
		bool offsetYSet = false;
		Sequence s = DOTween.Sequence();
		Tween yTween = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, new Vector3(0f, jumpPower, 0f), duration / (float)(numJumps * 2)).SetOptions(AxisConstraint.Y, snapping).SetEase(Ease.OutQuad)
			.SetRelative()
			.SetLoops(numJumps * 2, LoopType.Yoyo)
			.OnStart(delegate
			{
				//IL_0007: Unknown result type (might be due to invalid IL or missing references)
				startPosY = target.position.y;
			});
		s.Append(DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, new Vector3(endValue.x, 0f, 0f), duration).SetOptions(AxisConstraint.X, snapping).SetEase(Ease.Linear)).Join(DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, new Vector3(0f, 0f, endValue.z), duration).SetOptions(AxisConstraint.Z, snapping).SetEase(Ease.Linear)).Join(yTween)
			.SetTarget(target)
			.SetEase(DOTween.defaultEaseType);
		yTween.OnUpdate(delegate
		{
			//IL_0047: Unknown result type (might be due to invalid IL or missing references)
			//IL_004c: Unknown result type (might be due to invalid IL or missing references)
			//IL_007b: Unknown result type (might be due to invalid IL or missing references)
			if (!offsetYSet)
			{
				offsetYSet = true;
				offsetY = (s.isRelative ? endValue.y : (endValue.y - startPosY));
			}
			Vector3 position = target.position;
			position.y += DOVirtual.EasedValue(0f, offsetY, yTween.ElapsedPercentage(), Ease.OutQuad);
			target.position = position;
		});
		return s;
	}

	public static Sequence DOLocalJump(this Transform target, Vector3 endValue, float jumpPower, int numJumps, float duration, bool snapping = false)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0134: Unknown result type (might be due to invalid IL or missing references)
		if (numJumps < 1)
		{
			numJumps = 1;
		}
		float startPosY = target.localPosition.y;
		float offsetY = -1f;
		bool offsetYSet = false;
		Sequence s = DOTween.Sequence();
		Tween yTween = DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, new Vector3(0f, jumpPower, 0f), duration / (float)(numJumps * 2)).SetOptions(AxisConstraint.Y, snapping).SetEase(Ease.OutQuad)
			.SetRelative()
			.SetLoops(numJumps * 2, LoopType.Yoyo)
			.OnStart(delegate
			{
				//IL_0007: Unknown result type (might be due to invalid IL or missing references)
				startPosY = target.localPosition.y;
			});
		s.Append(DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, new Vector3(endValue.x, 0f, 0f), duration).SetOptions(AxisConstraint.X, snapping).SetEase(Ease.Linear)).Join(DOTween.To(delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, new Vector3(0f, 0f, endValue.z), duration).SetOptions(AxisConstraint.Z, snapping).SetEase(Ease.Linear)).Join(yTween)
			.SetTarget(target)
			.SetEase(DOTween.defaultEaseType);
		yTween.OnUpdate(delegate
		{
			//IL_0047: Unknown result type (might be due to invalid IL or missing references)
			//IL_004c: Unknown result type (might be due to invalid IL or missing references)
			//IL_007b: Unknown result type (might be due to invalid IL or missing references)
			if (!offsetYSet)
			{
				offsetYSet = true;
				offsetY = (s.isRelative ? endValue.y : (endValue.y - startPosY));
			}
			Vector3 localPosition = target.localPosition;
			localPosition.y += DOVirtual.EasedValue(0f, offsetY, yTween.ElapsedPercentage(), Ease.OutQuad);
			target.localPosition = localPosition;
		});
		return s;
	}

	public static TweenerCore<Vector3, Path, PathOptions> DOPath(this Transform target, Vector3[] path, float duration, PathType pathType = PathType.Linear, PathMode pathMode = PathMode.Full3D, int resolution = 10, Color? gizmoColor = null)
	{
		if (resolution < 1)
		{
			resolution = 1;
		}
		TweenerCore<Vector3, Path, PathOptions> tweenerCore = DOTween.To(PathPlugin.Get(), delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, new Path(pathType, path, resolution, gizmoColor), duration).SetTarget(target);
		tweenerCore.plugOptions.mode = pathMode;
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Path, PathOptions> DOLocalPath(this Transform target, Vector3[] path, float duration, PathType pathType = PathType.Linear, PathMode pathMode = PathMode.Full3D, int resolution = 10, Color? gizmoColor = null)
	{
		if (resolution < 1)
		{
			resolution = 1;
		}
		TweenerCore<Vector3, Path, PathOptions> tweenerCore = DOTween.To(PathPlugin.Get(), delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, new Path(pathType, path, resolution, gizmoColor), duration).SetTarget(target);
		tweenerCore.plugOptions.mode = pathMode;
		tweenerCore.plugOptions.useLocalPosition = true;
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Path, PathOptions> DOPath(this Transform target, Path path, float duration, PathMode pathMode = PathMode.Full3D)
	{
		TweenerCore<Vector3, Path, PathOptions> tweenerCore = DOTween.To(PathPlugin.Get(), delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.position;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.position = x;
		}, path, duration).SetTarget(target);
		tweenerCore.plugOptions.mode = pathMode;
		return tweenerCore;
	}

	public static TweenerCore<Vector3, Path, PathOptions> DOLocalPath(this Transform target, Path path, float duration, PathMode pathMode = PathMode.Full3D)
	{
		TweenerCore<Vector3, Path, PathOptions> tweenerCore = DOTween.To(PathPlugin.Get(), delegate
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			return target.localPosition;
		}, delegate(Vector3 x)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			target.localPosition = x;
		}, path, duration).SetTarget(target);
		tweenerCore.plugOptions.mode = pathMode;
		tweenerCore.plugOptions.useLocalPosition = true;
		return tweenerCore;
	}

	public static TweenerCore<float, float, FloatOptions> DOTimeScale(this Tween target, float endValue, float duration)
	{
		TweenerCore<float, float, FloatOptions> tweenerCore = DOTween.To(() => target.timeScale, delegate(float x)
		{
			target.timeScale = x;
		}, endValue, duration);
		tweenerCore.SetTarget(target);
		return tweenerCore;
	}

	public static Tweener DOBlendableColor(this Light target, Color endValue, float duration)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		endValue -= target.color;
		Color to = new Color(0f, 0f, 0f, 0f);
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Color x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0020: Unknown result type (might be due to invalid IL or missing references)
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			Color val = x - to;
			to = x;
			Light obj = target;
			obj.color += val;
		}, endValue, duration).Blendable().SetTarget(target);
	}

	public static Tweener DOBlendableColor(this Material target, Color endValue, float duration)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		endValue -= target.color;
		Color to = new Color(0f, 0f, 0f, 0f);
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Color x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0020: Unknown result type (might be due to invalid IL or missing references)
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			Color val = x - to;
			to = x;
			Material obj = target;
			obj.color += val;
		}, endValue, duration).Blendable().SetTarget(target);
	}

	public static Tweener DOBlendableColor(this Material target, Color endValue, string property, float duration)
	{
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(property))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(property);
			}
			return null;
		}
		endValue -= target.GetColor(property);
		Color to = new Color(0f, 0f, 0f, 0f);
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Color x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_002c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0031: Unknown result type (might be due to invalid IL or missing references)
			//IL_0032: Unknown result type (might be due to invalid IL or missing references)
			Color val = x - to;
			to = x;
			target.SetColor(property, target.GetColor(property) + val);
		}, endValue, duration).Blendable().SetTarget(target);
	}

	public static Tweener DOBlendableColor(this Material target, Color endValue, int propertyID, float duration)
	{
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		if (!target.HasProperty(propertyID))
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogMissingMaterialProperty(propertyID);
			}
			return null;
		}
		endValue -= target.GetColor(propertyID);
		Color to = new Color(0f, 0f, 0f, 0f);
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Color x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_002c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0031: Unknown result type (might be due to invalid IL or missing references)
			//IL_0032: Unknown result type (might be due to invalid IL or missing references)
			Color val = x - to;
			to = x;
			target.SetColor(propertyID, target.GetColor(propertyID) + val);
		}, endValue, duration).Blendable().SetTarget(target);
	}

	public static Tweener DOBlendableMoveBy(this Transform target, Vector3 byValue, float duration, bool snapping = false)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		Vector3 to = Vector3.zero;
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Vector3 x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0020: Unknown result type (might be due to invalid IL or missing references)
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			Vector3 val = x - to;
			to = x;
			Transform obj = target;
			obj.position += val;
		}, byValue, duration).Blendable().SetOptions(snapping)
			.SetTarget(target);
	}

	public static Tweener DOBlendableLocalMoveBy(this Transform target, Vector3 byValue, float duration, bool snapping = false)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		Vector3 to = Vector3.zero;
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Vector3 x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0020: Unknown result type (might be due to invalid IL or missing references)
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			Vector3 val = x - to;
			to = x;
			Transform obj = target;
			obj.localPosition += val;
		}, byValue, duration).Blendable().SetOptions(snapping)
			.SetTarget(target);
	}

	public static Tweener DOBlendableRotateBy(this Transform target, Vector3 byValue, float duration, RotateMode mode = RotateMode.Fast)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		Quaternion to = Quaternion.identity;
		TweenerCore<Quaternion, Vector3, QuaternionOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Quaternion x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0011: Unknown result type (might be due to invalid IL or missing references)
			//IL_0013: Unknown result type (might be due to invalid IL or missing references)
			//IL_0014: Unknown result type (might be due to invalid IL or missing references)
			//IL_001f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0024: Unknown result type (might be due to invalid IL or missing references)
			//IL_002b: Unknown result type (might be due to invalid IL or missing references)
			//IL_002c: Unknown result type (might be due to invalid IL or missing references)
			//IL_002d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0032: Unknown result type (might be due to invalid IL or missing references)
			//IL_0037: Unknown result type (might be due to invalid IL or missing references)
			//IL_0038: Unknown result type (might be due to invalid IL or missing references)
			//IL_003d: Unknown result type (might be due to invalid IL or missing references)
			//IL_003e: Unknown result type (might be due to invalid IL or missing references)
			Quaternion val = x * Quaternion.Inverse(to);
			to = x;
			Quaternion rotation = target.rotation;
			target.rotation = rotation * Quaternion.Inverse(rotation) * val * rotation;
		}, byValue, duration).Blendable().SetTarget(target);
		tweenerCore.plugOptions.rotateMode = mode;
		return tweenerCore;
	}

	public static Tweener DOBlendableLocalRotateBy(this Transform target, Vector3 byValue, float duration, RotateMode mode = RotateMode.Fast)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		Quaternion to = Quaternion.identity;
		TweenerCore<Quaternion, Vector3, QuaternionOptions> tweenerCore = DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Quaternion x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0011: Unknown result type (might be due to invalid IL or missing references)
			//IL_0013: Unknown result type (might be due to invalid IL or missing references)
			//IL_0014: Unknown result type (might be due to invalid IL or missing references)
			//IL_001f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0024: Unknown result type (might be due to invalid IL or missing references)
			//IL_002b: Unknown result type (might be due to invalid IL or missing references)
			//IL_002c: Unknown result type (might be due to invalid IL or missing references)
			//IL_002d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0032: Unknown result type (might be due to invalid IL or missing references)
			//IL_0037: Unknown result type (might be due to invalid IL or missing references)
			//IL_0038: Unknown result type (might be due to invalid IL or missing references)
			//IL_003d: Unknown result type (might be due to invalid IL or missing references)
			//IL_003e: Unknown result type (might be due to invalid IL or missing references)
			Quaternion val = x * Quaternion.Inverse(to);
			to = x;
			Quaternion localRotation = target.localRotation;
			target.localRotation = localRotation * Quaternion.Inverse(localRotation) * val * localRotation;
		}, byValue, duration).Blendable().SetTarget(target);
		tweenerCore.plugOptions.rotateMode = mode;
		return tweenerCore;
	}

	public static Tweener DOBlendablePunchRotation(this Transform target, Vector3 punch, float duration, int vibrato = 10, float elasticity = 1f)
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		if (duration <= 0f)
		{
			if (Debugger.logPriority > 0)
			{
				Debug.LogWarning((object)"DOBlendablePunchRotation: duration can't be 0, returning NULL without creating a tween");
			}
			return null;
		}
		Vector3 to = Vector3.zero;
		return DOTween.Punch(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Vector3 v)
		{
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			//IL_0026: Unknown result type (might be due to invalid IL or missing references)
			//IL_0027: Unknown result type (might be due to invalid IL or missing references)
			//IL_002d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0033: Unknown result type (might be due to invalid IL or missing references)
			//IL_0039: Unknown result type (might be due to invalid IL or missing references)
			//IL_003e: Unknown result type (might be due to invalid IL or missing references)
			//IL_003f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0044: Unknown result type (might be due to invalid IL or missing references)
			//IL_0049: Unknown result type (might be due to invalid IL or missing references)
			//IL_004b: Unknown result type (might be due to invalid IL or missing references)
			//IL_004c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0057: Unknown result type (might be due to invalid IL or missing references)
			//IL_005c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0063: Unknown result type (might be due to invalid IL or missing references)
			//IL_0064: Unknown result type (might be due to invalid IL or missing references)
			//IL_0065: Unknown result type (might be due to invalid IL or missing references)
			//IL_006a: Unknown result type (might be due to invalid IL or missing references)
			//IL_006f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0070: Unknown result type (might be due to invalid IL or missing references)
			//IL_0075: Unknown result type (might be due to invalid IL or missing references)
			//IL_0076: Unknown result type (might be due to invalid IL or missing references)
			Quaternion val = Quaternion.Euler(to.x, to.y, to.z);
			Quaternion val2 = Quaternion.Euler(v.x, v.y, v.z) * Quaternion.Inverse(val);
			to = v;
			Quaternion rotation = target.rotation;
			target.rotation = rotation * Quaternion.Inverse(rotation) * val2 * rotation;
		}, punch, duration, vibrato, elasticity).Blendable().SetTarget(target);
	}

	public static Tweener DOBlendableScaleBy(this Transform target, Vector3 byValue, float duration)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		Vector3 to = Vector3.zero;
		return DOTween.To(delegate
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return to;
		}, delegate(Vector3 x)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0020: Unknown result type (might be due to invalid IL or missing references)
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			Vector3 val = x - to;
			to = x;
			Transform obj = target;
			obj.localScale += val;
		}, byValue, duration).Blendable().SetTarget(target);
	}

	public static int DOComplete(this Component target, bool withCallbacks = false)
	{
		return DOTween.Complete(target, withCallbacks);
	}

	public static int DOComplete(this Material target, bool withCallbacks = false)
	{
		return DOTween.Complete(target, withCallbacks);
	}

	public static int DOKill(this Component target, bool complete = false)
	{
		return DOTween.Kill(target, complete);
	}

	public static int DOKill(this Material target, bool complete = false)
	{
		return DOTween.Kill(target, complete);
	}

	public static int DOFlip(this Component target)
	{
		return DOTween.Flip(target);
	}

	public static int DOFlip(this Material target)
	{
		return DOTween.Flip(target);
	}

	public static int DOGoto(this Component target, float to, bool andPlay = false)
	{
		return DOTween.Goto(target, to, andPlay);
	}

	public static int DOGoto(this Material target, float to, bool andPlay = false)
	{
		return DOTween.Goto(target, to, andPlay);
	}

	public static int DOPause(this Component target)
	{
		return DOTween.Pause(target);
	}

	public static int DOPause(this Material target)
	{
		return DOTween.Pause(target);
	}

	public static int DOPlay(this Component target)
	{
		return DOTween.Play(target);
	}

	public static int DOPlay(this Material target)
	{
		return DOTween.Play(target);
	}

	public static int DOPlayBackwards(this Component target)
	{
		return DOTween.PlayBackwards(target);
	}

	public static int DOPlayBackwards(this Material target)
	{
		return DOTween.PlayBackwards(target);
	}

	public static int DOPlayForward(this Component target)
	{
		return DOTween.PlayForward(target);
	}

	public static int DOPlayForward(this Material target)
	{
		return DOTween.PlayForward(target);
	}

	public static int DORestart(this Component target, bool includeDelay = true)
	{
		return DOTween.Restart(target, includeDelay);
	}

	public static int DORestart(this Material target, bool includeDelay = true)
	{
		return DOTween.Restart(target, includeDelay);
	}

	public static int DORewind(this Component target, bool includeDelay = true)
	{
		return DOTween.Rewind(target, includeDelay);
	}

	public static int DORewind(this Material target, bool includeDelay = true)
	{
		return DOTween.Rewind(target, includeDelay);
	}

	public static int DOSmoothRewind(this Component target)
	{
		return DOTween.SmoothRewind(target);
	}

	public static int DOSmoothRewind(this Material target)
	{
		return DOTween.SmoothRewind(target);
	}

	public static int DOTogglePause(this Component target)
	{
		return DOTween.TogglePause(target);
	}

	public static int DOTogglePause(this Material target)
	{
		return DOTween.TogglePause(target);
	}
}

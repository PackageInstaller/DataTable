using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeType("Modules/Animation/AnimationClip.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AnimationClip.bindings.h")]
public sealed class AnimationClip : Motion
{
	[NativeProperty("Length", false, TargetType.Function)]
	public extern float length
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("StartTime", false, TargetType.Function)]
	internal extern float startTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("StopTime", false, TargetType.Function)]
	internal extern float stopTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("SampleRate", false, TargetType.Function)]
	public extern float frameRate
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("WrapMode", false, TargetType.Function)]
	public extern WrapMode wrapMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("Bounds", false, TargetType.Function)]
	public Bounds localBounds
	{
		get
		{
			get_localBounds_Injected(out var ret);
			return ret;
		}
		set
		{
			set_localBounds_Injected(ref value);
		}
	}

	public new extern bool legacy
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsLegacy")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("SetLegacy")]
		set;
	}

	public extern bool humanMotion
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsHumanMotion")]
		get;
	}

	public extern bool empty
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsEmpty")]
		get;
	}

	public extern bool hasGenericRootTransform
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("HasGenericRootTransform")]
		get;
	}

	public extern bool hasMotionFloatCurves
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("HasMotionFloatCurves")]
		get;
	}

	public extern bool hasMotionCurves
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("HasMotionCurves")]
		get;
	}

	public extern bool hasRootCurves
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("HasRootCurves")]
		get;
	}

	internal extern bool hasRootMotion
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "AnimationClipBindings::Internal_GetHasRootMotion", HasExplicitThis = true)]
		get;
	}

	public AnimationEvent[] events
	{
		get
		{
			return (AnimationEvent[])GetEventsInternal();
		}
		set
		{
			SetEventsInternal(value);
		}
	}

	public AnimationClip()
	{
		Internal_CreateAnimationClip(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationClipBindings::Internal_CreateAnimationClip")]
	private static extern void Internal_CreateAnimationClip([Writable] AnimationClip self);

	public void SampleAnimation(GameObject go, float time)
	{
		SampleAnimation(go, this, time, wrapMode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeHeader("Modules/Animation/AnimationUtility.h")]
	[FreeFunction]
	internal static extern void SampleAnimation([NotNull("ArgumentNullException")] GameObject go, [NotNull("ArgumentNullException")] AnimationClip clip, float inTime, WrapMode wrapMode);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationClipBindings::Internal_SetCurve", HasExplicitThis = true)]
	public extern void SetCurve([NotNull("ArgumentNullException")] string relativePath, [NotNull("ArgumentNullException")] Type type, [NotNull("ArgumentNullException")] string propertyName, AnimationCurve curve);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void EnsureQuaternionContinuity();

	[MethodImpl((MethodImplOptions)4096)]
	public extern void ClearCurves();

	public void AddEvent(AnimationEvent evt)
	{
		if (evt == null)
		{
			throw new ArgumentNullException("evt");
		}
		AddEventInternal(evt);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "AnimationClipBindings::AddEventInternal", HasExplicitThis = true)]
	private extern void AddEventInternal(object evt);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "AnimationClipBindings::SetEventsInternal", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetEventsInternal(Array value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "AnimationClipBindings::GetEventsInternal", HasExplicitThis = true)]
	private extern Array GetEventsInternal();

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localBounds_Injected(out Bounds ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_localBounds_Injected(ref Bounds value);
}

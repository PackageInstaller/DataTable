using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Modules/Animation/Motion.h")]
public class Motion : Object
{
	public extern float averageDuration
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern float averageAngularSpeed
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public Vector3 averageSpeed
	{
		get
		{
			get_averageSpeed_Injected(out var ret);
			return ret;
		}
	}

	public extern float apparentSpeed
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern bool isLooping
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsLooping")]
		get;
	}

	public extern bool legacy
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsLegacy")]
		get;
	}

	public extern bool isHumanMotion
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsHumanMotion")]
		get;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("isAnimatorMotion is not supported anymore, please use !legacy instead.", true)]
	public bool isAnimatorMotion { get; }

	protected Motion()
	{
	}

	[Obsolete("ValidateIfRetargetable is not supported anymore, please use isHumanMotion instead.", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public bool ValidateIfRetargetable(bool val)
	{
		return false;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_averageSpeed_Injected(out Vector3 ret);
}

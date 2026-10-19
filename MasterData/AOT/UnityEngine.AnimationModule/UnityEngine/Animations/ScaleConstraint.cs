using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/Constraints/Constraint.bindings.h")]
[RequireComponent(typeof(Transform))]
[NativeHeader("Modules/Animation/Constraints/ScaleConstraint.h")]
[UsedByNativeCode]
public sealed class ScaleConstraint : Behaviour, IConstraint, IConstraintInternal
{
	public extern float weight
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Vector3 scaleAtRest
	{
		get
		{
			get_scaleAtRest_Injected(out var ret);
			return ret;
		}
		set
		{
			set_scaleAtRest_Injected(ref value);
		}
	}

	public Vector3 scaleOffset
	{
		get
		{
			get_scaleOffset_Injected(out var ret);
			return ret;
		}
		set
		{
			set_scaleOffset_Injected(ref value);
		}
	}

	public extern Axis scalingAxis
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool constraintActive
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool locked
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_scaleAtRest_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_scaleAtRest_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_scaleOffset_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_scaleOffset_Injected(ref Vector3 value);
}

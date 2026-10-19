using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/Constraints/Constraint.bindings.h")]
[NativeHeader("Modules/Animation/Constraints/RotationConstraint.h")]
[UsedByNativeCode]
[RequireComponent(typeof(Transform))]
public sealed class RotationConstraint : Behaviour, IConstraint, IConstraintInternal
{
	public extern float weight
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Vector3 rotationAtRest
	{
		get
		{
			get_rotationAtRest_Injected(out var ret);
			return ret;
		}
		set
		{
			set_rotationAtRest_Injected(ref value);
		}
	}

	public Vector3 rotationOffset
	{
		get
		{
			get_rotationOffset_Injected(out var ret);
			return ret;
		}
		set
		{
			set_rotationOffset_Injected(ref value);
		}
	}

	public extern Axis rotationAxis
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
	private extern void get_rotationAtRest_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_rotationAtRest_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_rotationOffset_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_rotationOffset_Injected(ref Vector3 value);
}

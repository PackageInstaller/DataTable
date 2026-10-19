using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/Constraints/Constraint.bindings.h")]
[NativeHeader("Modules/Animation/Constraints/PositionConstraint.h")]
[RequireComponent(typeof(Transform))]
[UsedByNativeCode]
public sealed class PositionConstraint : Behaviour, IConstraint, IConstraintInternal
{
	public extern float weight
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Vector3 translationAtRest
	{
		get
		{
			get_translationAtRest_Injected(out var ret);
			return ret;
		}
		set
		{
			set_translationAtRest_Injected(ref value);
		}
	}

	public Vector3 translationOffset
	{
		get
		{
			get_translationOffset_Injected(out var ret);
			return ret;
		}
		set
		{
			set_translationOffset_Injected(ref value);
		}
	}

	public extern Axis translationAxis
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
	private extern void get_translationAtRest_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_translationAtRest_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_translationOffset_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_translationOffset_Injected(ref Vector3 value);
}

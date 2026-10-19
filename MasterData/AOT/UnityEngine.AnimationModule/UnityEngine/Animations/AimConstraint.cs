using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[UsedByNativeCode]
[NativeHeader("Modules/Animation/Constraints/Constraint.bindings.h")]
[RequireComponent(typeof(Transform))]
[NativeHeader("Modules/Animation/Constraints/AimConstraint.h")]
public sealed class AimConstraint : Behaviour, IConstraint, IConstraintInternal
{
	public enum WorldUpType
	{
		SceneUp,
		ObjectUp,
		ObjectRotationUp,
		Vector,
		None
	}

	public extern float weight
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

	public Vector3 aimVector
	{
		get
		{
			get_aimVector_Injected(out var ret);
			return ret;
		}
		set
		{
			set_aimVector_Injected(ref value);
		}
	}

	public Vector3 upVector
	{
		get
		{
			get_upVector_Injected(out var ret);
			return ret;
		}
		set
		{
			set_upVector_Injected(ref value);
		}
	}

	public Vector3 worldUpVector
	{
		get
		{
			get_worldUpVector_Injected(out var ret);
			return ret;
		}
		set
		{
			set_worldUpVector_Injected(ref value);
		}
	}

	public extern Transform worldUpObject
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern WorldUpType worldUpType
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

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_aimVector_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_aimVector_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_upVector_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_upVector_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_worldUpVector_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_worldUpVector_Injected(ref Vector3 value);
}

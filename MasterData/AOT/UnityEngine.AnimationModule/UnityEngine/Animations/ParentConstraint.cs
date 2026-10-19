using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[RequireComponent(typeof(Transform))]
[NativeHeader("Modules/Animation/Constraints/ParentConstraint.h")]
[NativeHeader("Modules/Animation/Constraints/Constraint.bindings.h")]
[UsedByNativeCode]
public sealed class ParentConstraint : Behaviour, IConstraint, IConstraintInternal
{
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

	public int sourceCount => GetSourceCountInternal(this);

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

	public extern Vector3[] translationOffsets
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Vector3[] rotationOffsets
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Axis translationAxis
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Axis rotationAxis
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	private ParentConstraint()
	{
		Internal_Create(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Internal_Create([Writable] ParentConstraint self);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ConstraintBindings::GetSourceCount")]
	private static extern int GetSourceCountInternal([NotNull("ArgumentNullException")] ParentConstraint self);

	public Vector3 GetTranslationOffset(int index)
	{
		ValidateSourceIndex(index);
		return GetTranslationOffsetInternal(index);
	}

	public void SetTranslationOffset(int index, Vector3 value)
	{
		ValidateSourceIndex(index);
		SetTranslationOffsetInternal(index, value);
	}

	[NativeName("GetTranslationOffset")]
	private Vector3 GetTranslationOffsetInternal(int index)
	{
		GetTranslationOffsetInternal_Injected(index, out var ret);
		return ret;
	}

	[NativeName("SetTranslationOffset")]
	private void SetTranslationOffsetInternal(int index, Vector3 value)
	{
		SetTranslationOffsetInternal_Injected(index, ref value);
	}

	public Vector3 GetRotationOffset(int index)
	{
		ValidateSourceIndex(index);
		return GetRotationOffsetInternal(index);
	}

	public void SetRotationOffset(int index, Vector3 value)
	{
		ValidateSourceIndex(index);
		SetRotationOffsetInternal(index, value);
	}

	[NativeName("GetRotationOffset")]
	private Vector3 GetRotationOffsetInternal(int index)
	{
		GetRotationOffsetInternal_Injected(index, out var ret);
		return ret;
	}

	[NativeName("SetRotationOffset")]
	private void SetRotationOffsetInternal(int index, Vector3 value)
	{
		SetRotationOffsetInternal_Injected(index, ref value);
	}

	private void ValidateSourceIndex(int index)
	{
		if (sourceCount == 0)
		{
			throw new InvalidOperationException("The ParentConstraint component has no sources.");
		}
		if (index < 0 || index >= sourceCount)
		{
			throw new ArgumentOutOfRangeException("index", $"Constraint source index {index} is out of bounds (0-{sourceCount}).");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ConstraintBindings::GetSources", HasExplicitThis = true)]
	public extern void GetSources([NotNull("ArgumentNullException")] List<ConstraintSource> sources);

	public void SetSources(List<ConstraintSource> sources)
	{
		if (sources == null)
		{
			throw new ArgumentNullException("sources");
		}
		SetSourcesInternal(this, sources);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ConstraintBindings::SetSources", ThrowsException = true)]
	private static extern void SetSourcesInternal([NotNull("ArgumentNullException")] ParentConstraint self, List<ConstraintSource> sources);

	public int AddSource(ConstraintSource source)
	{
		return AddSource_Injected(ref source);
	}

	public void RemoveSource(int index)
	{
		ValidateSourceIndex(index);
		RemoveSourceInternal(index);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("RemoveSource")]
	private extern void RemoveSourceInternal(int index);

	public ConstraintSource GetSource(int index)
	{
		ValidateSourceIndex(index);
		return GetSourceInternal(index);
	}

	[NativeName("GetSource")]
	private ConstraintSource GetSourceInternal(int index)
	{
		GetSourceInternal_Injected(index, out var ret);
		return ret;
	}

	public void SetSource(int index, ConstraintSource source)
	{
		ValidateSourceIndex(index);
		SetSourceInternal(index, source);
	}

	[NativeName("SetSource")]
	private void SetSourceInternal(int index, ConstraintSource source)
	{
		SetSourceInternal_Injected(index, ref source);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_translationAtRest_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_translationAtRest_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_rotationAtRest_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_rotationAtRest_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetTranslationOffsetInternal_Injected(int index, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetTranslationOffsetInternal_Injected(int index, ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetRotationOffsetInternal_Injected(int index, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetRotationOffsetInternal_Injected(int index, ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern int AddSource_Injected(ref ConstraintSource source);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetSourceInternal_Injected(int index, out ConstraintSource ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetSourceInternal_Injected(int index, ref ConstraintSource source);
}

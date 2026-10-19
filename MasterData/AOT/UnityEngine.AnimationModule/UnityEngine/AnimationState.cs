using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Modules/Animation/AnimationState.h")]
public sealed class AnimationState : TrackedReference
{
	public extern bool enabled
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float weight
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern WrapMode wrapMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float time
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float normalizedTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float speed
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float normalizedSpeed
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float length
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int layer
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern AnimationClip clip
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern string name
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern AnimationBlendMode blendMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[ExcludeFromDocs]
	public void AddMixingTransform(Transform mix)
	{
		AddMixingTransform(mix, recursive: true);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void AddMixingTransform([NotNull("NullExceptionObject")] Transform mix, [DefaultValue("true")] bool recursive);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void RemoveMixingTransform([NotNull("NullExceptionObject")] Transform mix);
}

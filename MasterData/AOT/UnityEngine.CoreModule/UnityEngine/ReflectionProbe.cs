using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/ReflectionProbes.h")]
public sealed class ReflectionProbe : Behaviour
{
	public enum ReflectionProbeEvent
	{
		ReflectionProbeAdded,
		ReflectionProbeRemoved
	}

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action<ReflectionProbe, ReflectionProbeEvent> reflectionProbeChanged;

	private static Dictionary<int, Action<Texture>> registeredDefaultReflectionSetActions = new Dictionary<int, Action<Texture>>();

	private static List<Action<Texture>> registeredDefaultReflectionTextureActions = new List<Action<Texture>>();

	[NativeName("BoxSize")]
	public Vector3 size
	{
		get
		{
			get_size_Injected(out var ret);
			return ret;
		}
		set
		{
			set_size_Injected(ref value);
		}
	}

	[NativeName("BoxOffset")]
	public Vector3 center
	{
		get
		{
			get_center_Injected(out var ret);
			return ret;
		}
		set
		{
			set_center_Injected(ref value);
		}
	}

	[NativeName("Near")]
	public extern float nearClipPlane
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeName("Far")]
	public extern float farClipPlane
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeName("IntensityMultiplier")]
	public extern float intensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeName("HDR")]
	public extern bool hdr
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float shadowDistance
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int resolution
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int cullingMask
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern ReflectionProbeClearFlags clearFlags
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Color backgroundColor
	{
		get
		{
			get_backgroundColor_Injected(out var ret);
			return ret;
		}
		set
		{
			set_backgroundColor_Injected(ref value);
		}
	}

	public extern float blendDistance
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool boxProjection
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern ReflectionProbeMode mode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int importance
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Texture customBakedTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[StaticAccessor("GetReflectionProbes()")]
	public static Vector4 defaultTextureHDRDecodeValues
	{
		get
		{
			get_defaultTextureHDRDecodeValues_Injected(out var ret);
			return ret;
		}
	}

	[StaticAccessor("GetReflectionProbes()")]
	public static extern Texture defaultTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[RequiredByNativeCode]
	private static void CallReflectionProbeEvent(ReflectionProbe probe, ReflectionProbeEvent probeEvent)
	{
		reflectionProbeChanged?.Invoke(probe, probeEvent);
	}

	[RequiredByNativeCode]
	private static void CallSetDefaultReflection(Texture defaultReflectionCubemap)
	{
		foreach (Action<Texture> registeredDefaultReflectionTextureAction in registeredDefaultReflectionTextureActions)
		{
			registeredDefaultReflectionTextureAction(defaultReflectionCubemap);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_size_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_size_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_center_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_center_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_backgroundColor_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_backgroundColor_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_defaultTextureHDRDecodeValues_Injected(out Vector4 ret);
}

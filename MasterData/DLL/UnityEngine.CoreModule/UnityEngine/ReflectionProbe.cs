using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
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

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<ReflectionProbe, ReflectionProbeEvent> reflectionProbeChanged;

	private static Dictionary<int, Action<Texture>> registeredDefaultReflectionSetActions = new Dictionary<int, Action<Texture>>();

	private static List<Action<Texture>> registeredDefaultReflectionTextureActions = new List<Action<Texture>>();

	[NativeName("BoxOffset")]
	public Vector3 center
	{
		get
		{
			get_center_Injected(out var ret);
			return ret;
		}
	}

	[NativeName("GlobalAABB")]
	public Bounds bounds
	{
		get
		{
			get_bounds_Injected(out var ret);
			return ret;
		}
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
	private extern void get_center_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_bounds_Injected(out Bounds ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_defaultTextureHDRDecodeValues_Injected(out Vector4 ret);
}

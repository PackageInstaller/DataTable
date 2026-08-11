using System;
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

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<Texture> defaultReflectionTexture;

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
		defaultReflectionTexture?.Invoke(defaultReflectionCubemap);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_defaultTextureHDRDecodeValues_Injected(out Vector4 ret);
}

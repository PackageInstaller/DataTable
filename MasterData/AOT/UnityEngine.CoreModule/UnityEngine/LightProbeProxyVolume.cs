using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/LightProbeProxyVolume.h")]
public sealed class LightProbeProxyVolume : Behaviour
{
	public enum ResolutionMode
	{
		Automatic,
		Custom
	}

	public enum BoundingBoxMode
	{
		AutomaticLocal,
		AutomaticWorld,
		Custom
	}

	public enum ProbePositionMode
	{
		CellCorner,
		CellCenter
	}

	public enum RefreshMode
	{
		Automatic,
		EveryFrame,
		ViaScripting
	}

	public enum QualityMode
	{
		Low,
		Normal
	}

	public enum DataFormat
	{
		HalfFloat,
		Float
	}

	public extern float probeDensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern BoundingBoxMode boundingBoxMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern ResolutionMode resolutionMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern ProbePositionMode probePositionMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern RefreshMode refreshMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern QualityMode qualityMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern DataFormat dataFormat
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}
}

using System;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeType("Runtime/GfxDevice/GfxDeviceTypes.h")]
public enum ComputeBufferMode
{
	Immutable,
	Dynamic,
	[Obsolete("ComputeBufferMode.Circular is deprecated (legacy mode)")]
	Circular,
	[Obsolete("ComputeBufferMode.StreamOut is deprecated (internal use only)")]
	StreamOut,
	SubUpdates
}

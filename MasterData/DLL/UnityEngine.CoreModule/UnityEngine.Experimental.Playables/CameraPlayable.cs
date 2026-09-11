using System;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.Playables;

[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[NativeHeader("Runtime/Camera//Director/CameraPlayable.h")]
[StaticAccessor("CameraPlayableBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Runtime/Export/Director/CameraPlayable.bindings.h")]
[RequiredByNativeCode]
public struct CameraPlayable : IPlayable, IEquatable<CameraPlayable>
{
	private PlayableHandle m_Handle;

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public bool Equals(CameraPlayable other)
	{
		return GetHandle() == other.GetHandle();
	}
}

using System;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.Playables;

[RequiredByNativeCode]
[NativeHeader("Runtime/Export/Director/MaterialEffectPlayable.bindings.h")]
[NativeHeader("Runtime/Shaders/Director/MaterialEffectPlayable.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[StaticAccessor("MaterialEffectPlayableBindings", StaticAccessorType.DoubleColon)]
public struct MaterialEffectPlayable : IPlayable, IEquatable<MaterialEffectPlayable>
{
	private PlayableHandle m_Handle;

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public bool Equals(MaterialEffectPlayable other)
	{
		return GetHandle() == other.GetHandle();
	}
}

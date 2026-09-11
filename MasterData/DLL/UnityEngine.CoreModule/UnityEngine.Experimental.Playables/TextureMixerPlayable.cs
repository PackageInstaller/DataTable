using System;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.Playables;

[RequiredByNativeCode]
[StaticAccessor("TextureMixerPlayableBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[NativeHeader("Runtime/Graphics/Director/TextureMixerPlayable.h")]
[NativeHeader("Runtime/Export/Director/TextureMixerPlayable.bindings.h")]
public struct TextureMixerPlayable : IPlayable, IEquatable<TextureMixerPlayable>
{
	private PlayableHandle m_Handle;

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public bool Equals(TextureMixerPlayable other)
	{
		return GetHandle() == other.GetHandle();
	}
}

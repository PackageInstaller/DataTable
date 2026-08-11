using System;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.Playables;

[NativeHeader("Runtime/Export/Director/TextureMixerPlayable.bindings.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[RequiredByNativeCode]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
[NativeHeader("Runtime/Graphics/Director/TextureMixerPlayable.h")]
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

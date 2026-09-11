using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[RequiredByNativeCode]
public struct PlayableOutput : IPlayableOutput, IEquatable<PlayableOutput>
{
	private PlayableOutputHandle m_Handle;

	private static readonly PlayableOutput m_NullPlayableOutput = new PlayableOutput(PlayableOutputHandle.Null);

	public static PlayableOutput Null => m_NullPlayableOutput;

	[VisibleToOtherModules]
	internal PlayableOutput(PlayableOutputHandle handle)
	{
		m_Handle = handle;
	}

	public PlayableOutputHandle GetHandle()
	{
		return m_Handle;
	}

	public bool IsPlayableOutputOfType<T>() where T : struct, IPlayableOutput
	{
		return GetHandle().IsPlayableOutputOfType<T>();
	}

	public Type GetPlayableOutputType()
	{
		return GetHandle().GetPlayableOutputType();
	}

	public bool Equals(PlayableOutput other)
	{
		return GetHandle() == other.GetHandle();
	}
}

using System;
using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[RequiredByNativeCode]
public struct ScriptPlayableOutput : IPlayableOutput
{
	private PlayableOutputHandle m_Handle;

	public static ScriptPlayableOutput Null => new ScriptPlayableOutput(PlayableOutputHandle.Null);

	public static ScriptPlayableOutput Create(PlayableGraph graph, string name)
	{
		if (!graph.CreateScriptOutputInternal(name, out var handle))
		{
			return Null;
		}
		return new ScriptPlayableOutput(handle);
	}

	internal ScriptPlayableOutput(PlayableOutputHandle handle)
	{
		if (handle.IsValid() && !handle.IsPlayableOutputOfType<ScriptPlayableOutput>())
		{
			throw new InvalidCastException("Can't set handle: the playable is not a ScriptPlayableOutput.");
		}
		m_Handle = handle;
	}

	public PlayableOutputHandle GetHandle()
	{
		return m_Handle;
	}

	public static implicit operator PlayableOutput(ScriptPlayableOutput output)
	{
		return new PlayableOutput(output.GetHandle());
	}
}

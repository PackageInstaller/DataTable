using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/ScriptBindings/AnimationOffsetPlayable.bindings.h")]
[StaticAccessor("AnimationOffsetPlayableBindings", StaticAccessorType.DoubleColon)]
[RequiredByNativeCode]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[NativeHeader("Modules/Animation/Director/AnimationOffsetPlayable.h")]
internal struct AnimationOffsetPlayable : IPlayable, IEquatable<AnimationOffsetPlayable>
{
	private PlayableHandle m_Handle;

	private static readonly AnimationOffsetPlayable m_NullPlayable = new AnimationOffsetPlayable(PlayableHandle.Null);

	public static AnimationOffsetPlayable Create(PlayableGraph graph, Vector3 position, Quaternion rotation, int inputCount)
	{
		PlayableHandle handle = CreateHandle(graph, position, rotation, inputCount);
		return new AnimationOffsetPlayable(handle);
	}

	private static PlayableHandle CreateHandle(PlayableGraph graph, Vector3 position, Quaternion rotation, int inputCount)
	{
		PlayableHandle handle = PlayableHandle.Null;
		if (!CreateHandleInternal(graph, position, rotation, ref handle))
		{
			return PlayableHandle.Null;
		}
		handle.SetInputCount(inputCount);
		return handle;
	}

	internal AnimationOffsetPlayable(PlayableHandle handle)
	{
		if (handle.IsValid() && !handle.IsPlayableOfType<AnimationOffsetPlayable>())
		{
			throw new InvalidCastException("Can't set handle: the playable is not an AnimationOffsetPlayable.");
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public static implicit operator Playable(AnimationOffsetPlayable playable)
	{
		return new Playable(playable.GetHandle());
	}

	public bool Equals(AnimationOffsetPlayable other)
	{
		return Equals(other.GetHandle());
	}

	[NativeThrows]
	private static bool CreateHandleInternal(PlayableGraph graph, Vector3 position, Quaternion rotation, ref PlayableHandle handle)
	{
		return CreateHandleInternal_Injected(ref graph, ref position, ref rotation, ref handle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CreateHandleInternal_Injected(ref PlayableGraph graph, ref Vector3 position, ref Quaternion rotation, ref PlayableHandle handle);
}

using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[RequiredByNativeCode]
[StaticAccessor("AnimationRemoveScalePlayableBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[NativeHeader("Modules/Animation/Director/AnimationRemoveScalePlayable.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AnimationRemoveScalePlayable.bindings.h")]
internal struct AnimationRemoveScalePlayable : IPlayable, IEquatable<AnimationRemoveScalePlayable>
{
	private PlayableHandle m_Handle;

	private static readonly AnimationRemoveScalePlayable m_NullPlayable = new AnimationRemoveScalePlayable(PlayableHandle.Null);

	public static AnimationRemoveScalePlayable Create(PlayableGraph graph, int inputCount)
	{
		PlayableHandle handle = CreateHandle(graph, inputCount);
		return new AnimationRemoveScalePlayable(handle);
	}

	private static PlayableHandle CreateHandle(PlayableGraph graph, int inputCount)
	{
		PlayableHandle handle = PlayableHandle.Null;
		if (!CreateHandleInternal(graph, ref handle))
		{
			return PlayableHandle.Null;
		}
		handle.SetInputCount(inputCount);
		return handle;
	}

	internal AnimationRemoveScalePlayable(PlayableHandle handle)
	{
		if (handle.IsValid() && !handle.IsPlayableOfType<AnimationRemoveScalePlayable>())
		{
			throw new InvalidCastException("Can't set handle: the playable is not an AnimationRemoveScalePlayable.");
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public static implicit operator Playable(AnimationRemoveScalePlayable playable)
	{
		return new Playable(playable.GetHandle());
	}

	public bool Equals(AnimationRemoveScalePlayable other)
	{
		return Equals(other.GetHandle());
	}

	[NativeThrows]
	private static bool CreateHandleInternal(PlayableGraph graph, ref PlayableHandle handle)
	{
		return CreateHandleInternal_Injected(ref graph, ref handle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CreateHandleInternal_Injected(ref PlayableGraph graph, ref PlayableHandle handle);
}

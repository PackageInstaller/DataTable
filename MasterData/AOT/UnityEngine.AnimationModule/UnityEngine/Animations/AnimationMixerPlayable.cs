using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[RequiredByNativeCode]
[NativeHeader("Modules/Animation/Director/AnimationMixerPlayable.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AnimationMixerPlayable.bindings.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[StaticAccessor("AnimationMixerPlayableBindings", StaticAccessorType.DoubleColon)]
public struct AnimationMixerPlayable : IPlayable, IEquatable<AnimationMixerPlayable>
{
	private PlayableHandle m_Handle;

	private static readonly AnimationMixerPlayable m_NullPlayable = new AnimationMixerPlayable(PlayableHandle.Null);

	public static AnimationMixerPlayable Null => m_NullPlayable;

	[Obsolete("normalizeWeights is obsolete. It has no effect and will be removed.")]
	public static AnimationMixerPlayable Create(PlayableGraph graph, int inputCount, bool normalizeWeights)
	{
		return Create(graph, inputCount);
	}

	public static AnimationMixerPlayable Create(PlayableGraph graph, int inputCount = 0)
	{
		PlayableHandle handle = CreateHandle(graph, inputCount);
		return new AnimationMixerPlayable(handle);
	}

	private static PlayableHandle CreateHandle(PlayableGraph graph, int inputCount = 0)
	{
		PlayableHandle handle = PlayableHandle.Null;
		if (!CreateHandleInternal(graph, ref handle))
		{
			return PlayableHandle.Null;
		}
		handle.SetInputCount(inputCount);
		return handle;
	}

	internal AnimationMixerPlayable(PlayableHandle handle)
	{
		if (handle.IsValid() && !handle.IsPlayableOfType<AnimationMixerPlayable>())
		{
			throw new InvalidCastException("Can't set handle: the playable is not an AnimationMixerPlayable.");
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public static implicit operator Playable(AnimationMixerPlayable playable)
	{
		return new Playable(playable.GetHandle());
	}

	public static explicit operator AnimationMixerPlayable(Playable playable)
	{
		return new AnimationMixerPlayable(playable.GetHandle());
	}

	public bool Equals(AnimationMixerPlayable other)
	{
		return GetHandle() == other.GetHandle();
	}

	[NativeThrows]
	private static bool CreateHandleInternal(PlayableGraph graph, ref PlayableHandle handle)
	{
		return CreateHandleInternal_Injected(ref graph, ref handle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CreateHandleInternal_Injected(ref PlayableGraph graph, ref PlayableHandle handle);
}

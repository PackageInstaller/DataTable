using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[StaticAccessor("AnimationMotionXToDeltaPlayableBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Modules/Animation/ScriptBindings/AnimationMotionXToDeltaPlayable.bindings.h")]
[RequiredByNativeCode]
internal struct AnimationMotionXToDeltaPlayable : IPlayable, IEquatable<AnimationMotionXToDeltaPlayable>
{
	private PlayableHandle m_Handle;

	private static readonly AnimationMotionXToDeltaPlayable m_NullPlayable = new AnimationMotionXToDeltaPlayable(PlayableHandle.Null);

	public static AnimationMotionXToDeltaPlayable Create(PlayableGraph graph)
	{
		PlayableHandle handle = CreateHandle(graph);
		return new AnimationMotionXToDeltaPlayable(handle);
	}

	private static PlayableHandle CreateHandle(PlayableGraph graph)
	{
		PlayableHandle handle = PlayableHandle.Null;
		if (!CreateHandleInternal(graph, ref handle))
		{
			return PlayableHandle.Null;
		}
		handle.SetInputCount(1);
		return handle;
	}

	private AnimationMotionXToDeltaPlayable(PlayableHandle handle)
	{
		if (handle.IsValid() && !handle.IsPlayableOfType<AnimationMotionXToDeltaPlayable>())
		{
			throw new InvalidCastException("Can't set handle: the playable is not an AnimationMotionXToDeltaPlayable.");
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public static implicit operator Playable(AnimationMotionXToDeltaPlayable playable)
	{
		return new Playable(playable.GetHandle());
	}

	public bool Equals(AnimationMotionXToDeltaPlayable other)
	{
		return GetHandle() == other.GetHandle();
	}

	public void SetAbsoluteMotion(bool value)
	{
		SetAbsoluteMotionInternal(ref m_Handle, value);
	}

	[NativeThrows]
	private static bool CreateHandleInternal(PlayableGraph graph, ref PlayableHandle handle)
	{
		return CreateHandleInternal_Injected(ref graph, ref handle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	private static extern void SetAbsoluteMotionInternal(ref PlayableHandle handle, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CreateHandleInternal_Injected(ref PlayableGraph graph, ref PlayableHandle handle);
}

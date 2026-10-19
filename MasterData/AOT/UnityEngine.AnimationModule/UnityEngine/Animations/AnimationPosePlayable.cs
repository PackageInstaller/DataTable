using System;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/ScriptBindings/AnimationPosePlayable.bindings.h")]
[RequiredByNativeCode]
[StaticAccessor("AnimationPosePlayableBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Modules/Animation/Director/AnimationPosePlayable.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
internal struct AnimationPosePlayable : IPlayable, IEquatable<AnimationPosePlayable>
{
	private PlayableHandle m_Handle;

	private static readonly AnimationPosePlayable m_NullPlayable = new AnimationPosePlayable(PlayableHandle.Null);

	internal AnimationPosePlayable(PlayableHandle handle)
	{
		if (handle.IsValid() && !handle.IsPlayableOfType<AnimationPosePlayable>())
		{
			throw new InvalidCastException("Can't set handle: the playable is not an AnimationPosePlayable.");
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public bool Equals(AnimationPosePlayable other)
	{
		return Equals(other.GetHandle());
	}
}

using System;
using System.Collections;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;

namespace UnityEngine;

[NativeHeader("Modules/Animation/Animation.h")]
public sealed class Animation : Behaviour, IEnumerable
{
	private sealed class Enumerator : IEnumerator
	{
		private Animation m_Outer;

		private int m_CurrentIndex = -1;

		public object Current => m_Outer.GetStateAtIndex(m_CurrentIndex);

		internal Enumerator(Animation outer)
		{
			m_Outer = outer;
		}

		public bool MoveNext()
		{
			int stateCount = m_Outer.GetStateCount();
			m_CurrentIndex++;
			return m_CurrentIndex < stateCount;
		}

		public void Reset()
		{
			m_CurrentIndex = -1;
		}
	}

	public extern AnimationClip clip
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool playAutomatically
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern WrapMode wrapMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool isPlaying
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsPlaying")]
		get;
	}

	public AnimationState this[string name] => GetState(name);

	public extern bool animatePhysics
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[Obsolete("Use cullingType instead")]
	public extern bool animateOnlyIfVisible
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("AnimationBindings::GetAnimateOnlyIfVisible", HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("AnimationBindings::SetAnimateOnlyIfVisible", HasExplicitThis = true)]
		set;
	}

	public extern AnimationCullingType cullingType
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Bounds localBounds
	{
		[NativeName("GetLocalAABB")]
		get
		{
			get_localBounds_Injected(out var ret);
			return ret;
		}
		[NativeName("SetLocalAABB")]
		set
		{
			set_localBounds_Injected(ref value);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void Stop();

	public void Stop(string name)
	{
		StopNamed(name);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("Stop")]
	private extern void StopNamed(string name);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void Rewind();

	public void Rewind(string name)
	{
		RewindNamed(name);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("Rewind")]
	private extern void RewindNamed(string name);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void Sample();

	[MethodImpl((MethodImplOptions)4096)]
	public extern bool IsPlaying(string name);

	[ExcludeFromDocs]
	public bool Play()
	{
		return Play(PlayMode.StopSameLayer);
	}

	public bool Play([DefaultValue("PlayMode.StopSameLayer")] PlayMode mode)
	{
		return PlayDefaultAnimation(mode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("Play")]
	private extern bool PlayDefaultAnimation(PlayMode mode);

	[ExcludeFromDocs]
	public bool Play(string animation)
	{
		return Play(animation, PlayMode.StopSameLayer);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern bool Play(string animation, [DefaultValue("PlayMode.StopSameLayer")] PlayMode mode);

	[ExcludeFromDocs]
	public void CrossFade(string animation)
	{
		CrossFade(animation, 0.3f);
	}

	[ExcludeFromDocs]
	public void CrossFade(string animation, float fadeLength)
	{
		CrossFade(animation, fadeLength, PlayMode.StopSameLayer);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void CrossFade(string animation, [DefaultValue("0.3F")] float fadeLength, [DefaultValue("PlayMode.StopSameLayer")] PlayMode mode);

	[ExcludeFromDocs]
	public void Blend(string animation)
	{
		Blend(animation, 1f);
	}

	[ExcludeFromDocs]
	public void Blend(string animation, float targetWeight)
	{
		Blend(animation, targetWeight, 0.3f);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void Blend(string animation, [DefaultValue("1.0F")] float targetWeight, [DefaultValue("0.3F")] float fadeLength);

	[ExcludeFromDocs]
	public AnimationState CrossFadeQueued(string animation)
	{
		return CrossFadeQueued(animation, 0.3f);
	}

	[ExcludeFromDocs]
	public AnimationState CrossFadeQueued(string animation, float fadeLength)
	{
		return CrossFadeQueued(animation, fadeLength, QueueMode.CompleteOthers);
	}

	[ExcludeFromDocs]
	public AnimationState CrossFadeQueued(string animation, float fadeLength, QueueMode queue)
	{
		return CrossFadeQueued(animation, fadeLength, queue, PlayMode.StopSameLayer);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationBindings::CrossFadeQueuedImpl", HasExplicitThis = true)]
	public extern AnimationState CrossFadeQueued(string animation, [DefaultValue("0.3F")] float fadeLength, [DefaultValue("QueueMode.CompleteOthers")] QueueMode queue, [DefaultValue("PlayMode.StopSameLayer")] PlayMode mode);

	[ExcludeFromDocs]
	public AnimationState PlayQueued(string animation)
	{
		return PlayQueued(animation, QueueMode.CompleteOthers);
	}

	[ExcludeFromDocs]
	public AnimationState PlayQueued(string animation, QueueMode queue)
	{
		return PlayQueued(animation, queue, PlayMode.StopSameLayer);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationBindings::PlayQueuedImpl", HasExplicitThis = true)]
	public extern AnimationState PlayQueued(string animation, [DefaultValue("QueueMode.CompleteOthers")] QueueMode queue, [DefaultValue("PlayMode.StopSameLayer")] PlayMode mode);

	public void AddClip(AnimationClip clip, string newName)
	{
		AddClip(clip, newName, int.MinValue, int.MaxValue);
	}

	[ExcludeFromDocs]
	public void AddClip(AnimationClip clip, string newName, int firstFrame, int lastFrame)
	{
		AddClip(clip, newName, firstFrame, lastFrame, addLoopFrame: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void AddClip([NotNull("NullExceptionObject")] AnimationClip clip, string newName, int firstFrame, int lastFrame, [DefaultValue("false")] bool addLoopFrame);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void RemoveClip([NotNull("NullExceptionObject")] AnimationClip clip);

	public void RemoveClip(string clipName)
	{
		RemoveClipNamed(clipName);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("RemoveClip")]
	private extern void RemoveClipNamed(string clipName);

	[MethodImpl((MethodImplOptions)4096)]
	public extern int GetClipCount();

	[Obsolete("use PlayMode instead of AnimationPlayMode.")]
	public bool Play(AnimationPlayMode mode)
	{
		return PlayDefaultAnimation((PlayMode)mode);
	}

	[Obsolete("use PlayMode instead of AnimationPlayMode.")]
	public bool Play(string animation, AnimationPlayMode mode)
	{
		return Play(animation, (PlayMode)mode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SyncLayer(int layer);

	public IEnumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationBindings::GetState", HasExplicitThis = true)]
	internal extern AnimationState GetState(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationBindings::GetStateAtIndex", HasExplicitThis = true, ThrowsException = true)]
	internal extern AnimationState GetStateAtIndex(int index);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetAnimationStateCount")]
	internal extern int GetStateCount();

	public AnimationClip GetClip(string name)
	{
		AnimationState state = GetState(name);
		if ((bool)state)
		{
			return state.clip;
		}
		return null;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localBounds_Injected(out Bounds ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_localBounds_Injected(ref Bounds value);
}

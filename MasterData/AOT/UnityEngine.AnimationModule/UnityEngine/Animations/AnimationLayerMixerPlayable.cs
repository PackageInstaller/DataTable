using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/ScriptBindings/AnimationLayerMixerPlayable.bindings.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[StaticAccessor("AnimationLayerMixerPlayableBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Modules/Animation/Director/AnimationLayerMixerPlayable.h")]
[RequiredByNativeCode]
public struct AnimationLayerMixerPlayable : IPlayable, IEquatable<AnimationLayerMixerPlayable>
{
	private PlayableHandle m_Handle;

	private static readonly AnimationLayerMixerPlayable m_NullPlayable = new AnimationLayerMixerPlayable(PlayableHandle.Null);

	public static AnimationLayerMixerPlayable Null => m_NullPlayable;

	public static AnimationLayerMixerPlayable Create(PlayableGraph graph, int inputCount = 0)
	{
		return Create(graph, inputCount, singleLayerOptimization: true);
	}

	public static AnimationLayerMixerPlayable Create(PlayableGraph graph, int inputCount, bool singleLayerOptimization)
	{
		PlayableHandle handle = CreateHandle(graph, inputCount);
		return new AnimationLayerMixerPlayable(handle, singleLayerOptimization);
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

	internal AnimationLayerMixerPlayable(PlayableHandle handle, bool singleLayerOptimization = true)
	{
		if (handle.IsValid())
		{
			if (!handle.IsPlayableOfType<AnimationLayerMixerPlayable>())
			{
				throw new InvalidCastException("Can't set handle: the playable is not an AnimationLayerMixerPlayable.");
			}
			SetSingleLayerOptimizationInternal(ref handle, singleLayerOptimization);
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public static implicit operator Playable(AnimationLayerMixerPlayable playable)
	{
		return new Playable(playable.GetHandle());
	}

	public static explicit operator AnimationLayerMixerPlayable(Playable playable)
	{
		return new AnimationLayerMixerPlayable(playable.GetHandle());
	}

	public bool Equals(AnimationLayerMixerPlayable other)
	{
		return GetHandle() == other.GetHandle();
	}

	public bool IsLayerAdditive(uint layerIndex)
	{
		if (layerIndex >= m_Handle.GetInputCount())
		{
			throw new ArgumentOutOfRangeException("layerIndex", $"layerIndex {layerIndex} must be in the range of 0 to {m_Handle.GetInputCount() - 1}.");
		}
		return IsLayerAdditiveInternal(ref m_Handle, layerIndex);
	}

	public void SetLayerAdditive(uint layerIndex, bool value)
	{
		if (layerIndex >= m_Handle.GetInputCount())
		{
			throw new ArgumentOutOfRangeException("layerIndex", $"layerIndex {layerIndex} must be in the range of 0 to {m_Handle.GetInputCount() - 1}.");
		}
		SetLayerAdditiveInternal(ref m_Handle, layerIndex, value);
	}

	public void SetLayerMaskFromAvatarMask(uint layerIndex, AvatarMask mask)
	{
		if (layerIndex >= m_Handle.GetInputCount())
		{
			throw new ArgumentOutOfRangeException("layerIndex", $"layerIndex {layerIndex} must be in the range of 0 to {m_Handle.GetInputCount() - 1}.");
		}
		if (mask == null)
		{
			throw new ArgumentNullException("mask");
		}
		SetLayerMaskFromAvatarMaskInternal(ref m_Handle, layerIndex, mask);
	}

	[NativeThrows]
	private static bool CreateHandleInternal(PlayableGraph graph, ref PlayableHandle handle)
	{
		return CreateHandleInternal_Injected(ref graph, ref handle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	private static extern bool IsLayerAdditiveInternal(ref PlayableHandle handle, uint layerIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	private static extern void SetLayerAdditiveInternal(ref PlayableHandle handle, uint layerIndex, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	private static extern void SetSingleLayerOptimizationInternal(ref PlayableHandle handle, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	private static extern void SetLayerMaskFromAvatarMaskInternal(ref PlayableHandle handle, uint layerIndex, AvatarMask mask);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CreateHandleInternal_Injected(ref PlayableGraph graph, ref PlayableHandle handle);
}

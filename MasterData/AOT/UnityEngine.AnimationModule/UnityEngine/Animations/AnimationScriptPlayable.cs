using System;
using System.Runtime.CompilerServices;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[StaticAccessor("AnimationScriptPlayableBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Runtime/Director/Core/HPlayableGraph.h")]
[MovedFrom("UnityEngine.Experimental.Animations")]
[NativeHeader("Modules/Animation/ScriptBindings/AnimationScriptPlayable.bindings.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[RequiredByNativeCode]
public struct AnimationScriptPlayable : IAnimationJobPlayable, IPlayable, IEquatable<AnimationScriptPlayable>
{
	private PlayableHandle m_Handle;

	private static readonly AnimationScriptPlayable m_NullPlayable = new AnimationScriptPlayable(PlayableHandle.Null);

	public static AnimationScriptPlayable Null => m_NullPlayable;

	public static AnimationScriptPlayable Create<T>(PlayableGraph graph, T jobData, int inputCount = 0) where T : struct, IAnimationJob
	{
		PlayableHandle handle = CreateHandle<T>(graph, inputCount);
		AnimationScriptPlayable result = new AnimationScriptPlayable(handle);
		result.SetJobData(jobData);
		return result;
	}

	private static PlayableHandle CreateHandle<T>(PlayableGraph graph, int inputCount) where T : struct, IAnimationJob
	{
		IntPtr jobReflectionData = ProcessAnimationJobStruct<T>.GetJobReflectionData();
		PlayableHandle handle = PlayableHandle.Null;
		if (!CreateHandleInternal(graph, ref handle, jobReflectionData))
		{
			return PlayableHandle.Null;
		}
		handle.SetInputCount(inputCount);
		return handle;
	}

	internal AnimationScriptPlayable(PlayableHandle handle)
	{
		if (handle.IsValid() && !handle.IsPlayableOfType<AnimationScriptPlayable>())
		{
			throw new InvalidCastException("Can't set handle: the playable is not an AnimationScriptPlayable.");
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	private void CheckJobTypeValidity<T>()
	{
		Type jobType = GetHandle().GetJobType();
		if (jobType != typeof(T))
		{
			throw new ArgumentException($"Wrong type: the given job type ({typeof(T).FullName}) is different from the creation job type ({jobType.FullName}).");
		}
	}

	public unsafe T GetJobData<T>() where T : struct, IAnimationJob
	{
		CheckJobTypeValidity<T>();
		UnsafeUtility.CopyPtrToStructure<T>((void*)GetHandle().GetJobData(), out var output);
		return output;
	}

	public unsafe void SetJobData<T>(T jobData) where T : struct, IAnimationJob
	{
		CheckJobTypeValidity<T>();
		UnsafeUtility.CopyStructureToPtr(ref jobData, (void*)GetHandle().GetJobData());
	}

	public static implicit operator Playable(AnimationScriptPlayable playable)
	{
		return new Playable(playable.GetHandle());
	}

	public static explicit operator AnimationScriptPlayable(Playable playable)
	{
		return new AnimationScriptPlayable(playable.GetHandle());
	}

	public bool Equals(AnimationScriptPlayable other)
	{
		return GetHandle() == other.GetHandle();
	}

	public void SetProcessInputs(bool value)
	{
		SetProcessInputsInternal(GetHandle(), value);
	}

	public bool GetProcessInputs()
	{
		return GetProcessInputsInternal(GetHandle());
	}

	[NativeThrows]
	private static bool CreateHandleInternal(PlayableGraph graph, ref PlayableHandle handle, IntPtr jobReflectionData)
	{
		return CreateHandleInternal_Injected(ref graph, ref handle, jobReflectionData);
	}

	[NativeThrows]
	private static void SetProcessInputsInternal(PlayableHandle handle, bool value)
	{
		SetProcessInputsInternal_Injected(ref handle, value);
	}

	[NativeThrows]
	private static bool GetProcessInputsInternal(PlayableHandle handle)
	{
		return GetProcessInputsInternal_Injected(ref handle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CreateHandleInternal_Injected(ref PlayableGraph graph, ref PlayableHandle handle, IntPtr jobReflectionData);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetProcessInputsInternal_Injected(ref PlayableHandle handle, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetProcessInputsInternal_Injected(ref PlayableHandle handle);
}

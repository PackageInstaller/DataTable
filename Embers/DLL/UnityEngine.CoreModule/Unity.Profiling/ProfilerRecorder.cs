using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Burst;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[DebuggerTypeProxy(typeof(ProfilerRecorderDebugView))]
[NativeHeader("Runtime/Profiler/ScriptBindings/ProfilerRecorder.bindings.h")]
[DebuggerDisplay("Count = {Count}")]
[UsedByNativeCode]
public struct ProfilerRecorder : IDisposable
{
	internal enum ControlOptions
	{
		Start = 0,
		Stop = 1,
		Reset = 2,
		Release = 4,
		SetFilterToCurrentThread = 5,
		SetToCollectFromAllThreads = 6
	}

	internal enum CountOptions
	{
		Count,
		MaxCount
	}

	internal ulong handle;

	internal const ProfilerRecorderOptions SharedRecorder = (ProfilerRecorderOptions)128;

	public bool Valid => handle != 0L && GetValid(this);

	public long LastValue
	{
		get
		{
			CheckInitializedAndThrow();
			return GetLastValue(this);
		}
	}

	public int Count
	{
		get
		{
			CheckInitializedAndThrow();
			return GetCount(this, CountOptions.Count);
		}
	}

	public bool IsRunning
	{
		get
		{
			CheckInitializedAndThrow();
			return GetRunning(this);
		}
	}

	public ProfilerRecorder(ProfilerRecorderHandle statHandle, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
	{
		this = Create(statHandle, capacity, options);
	}

	public void Start()
	{
		CheckInitializedAndThrow();
		Control(this, ControlOptions.Start);
	}

	public void Stop()
	{
		CheckInitializedAndThrow();
		Control(this, ControlOptions.Stop);
	}

	public ProfilerRecorderSample GetSample(int index)
	{
		CheckInitializedAndThrow();
		return GetSampleInternal(this, index);
	}

	[NativeMethod(IsThreadSafe = true, ThrowsException = true)]
	private static ProfilerRecorder Create(ProfilerRecorderHandle statHandle, int maxSampleCount, ProfilerRecorderOptions options)
	{
		Create_Injected(ref statHandle, maxSampleCount, options, out var ret);
		return ret;
	}

	[NativeMethod(IsThreadSafe = true)]
	private static void Control(ProfilerRecorder handle, ControlOptions options)
	{
		Control_Injected(ref handle, options);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static long GetLastValue(ProfilerRecorder handle)
	{
		return GetLastValue_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static int GetCount(ProfilerRecorder handle, CountOptions countOptions)
	{
		return GetCount_Injected(ref handle, countOptions);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static bool GetValid(ProfilerRecorder handle)
	{
		return GetValid_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static bool GetRunning(ProfilerRecorder handle)
	{
		return GetRunning_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true, ThrowsException = true)]
	private static ProfilerRecorderSample GetSampleInternal(ProfilerRecorder handle, int index)
	{
		GetSampleInternal_Injected(ref handle, index, out var ret);
		return ret;
	}

	public void Dispose()
	{
		if (handle != 0)
		{
			Control(this, ControlOptions.Release);
			handle = 0uL;
		}
	}

	[BurstDiscard]
	private void CheckInitializedAndThrow()
	{
		if (handle == 0)
		{
			throw new InvalidOperationException("ProfilerRecorder object is not initialized or has been disposed.");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Create_Injected(ref ProfilerRecorderHandle statHandle, int maxSampleCount, ProfilerRecorderOptions options, out ProfilerRecorder ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Control_Injected(ref ProfilerRecorder handle, ControlOptions options);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern long GetLastValue_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetCount_Injected(ref ProfilerRecorder handle, CountOptions countOptions);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetValid_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetRunning_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetSampleInternal_Injected(ref ProfilerRecorder handle, int index, out ProfilerRecorderSample ret);
}

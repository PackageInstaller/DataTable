using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Burst;
using Unity.Profiling.LowLevel;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[UsedByNativeCode]
[DebuggerTypeProxy(typeof(ProfilerRecorderDebugView))]
[NativeHeader("Runtime/Profiler/ScriptBindings/ProfilerRecorder.bindings.h")]
[DebuggerDisplay("Count = {Count}")]
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

	public ProfilerMarkerDataType DataType
	{
		get
		{
			CheckInitializedAndThrow();
			return GetValueDataType(this);
		}
	}

	public ProfilerMarkerDataUnit UnitType
	{
		get
		{
			CheckInitializedAndThrow();
			return GetValueUnitType(this);
		}
	}

	public long CurrentValue
	{
		get
		{
			CheckInitializedAndThrow();
			return GetCurrentValue(this);
		}
	}

	public double CurrentValueAsDouble
	{
		get
		{
			CheckInitializedAndThrow();
			return GetCurrentValueAsDouble(this);
		}
	}

	public long LastValue
	{
		get
		{
			CheckInitializedAndThrow();
			return GetLastValue(this);
		}
	}

	public double LastValueAsDouble
	{
		get
		{
			CheckInitializedAndThrow();
			return GetLastValueAsDouble(this);
		}
	}

	public int Capacity
	{
		get
		{
			CheckInitializedAndThrow();
			return GetCount(this, CountOptions.MaxCount);
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

	public bool WrappedAround
	{
		get
		{
			CheckInitializedAndThrow();
			return GetWrapped(this);
		}
	}

	internal ProfilerRecorder(ProfilerRecorderOptions options)
	{
		this = Create(default(ProfilerRecorderHandle), 0, options);
	}

	public ProfilerRecorder(string statName, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
		: this(ProfilerCategory.Any, statName, capacity, options)
	{
	}

	public ProfilerRecorder(string categoryName, string statName, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
		: this(new ProfilerCategory(categoryName), statName, capacity, options)
	{
	}

	public ProfilerRecorder(ProfilerCategory category, string statName, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
	{
		ProfilerRecorderHandle byName = ProfilerRecorderHandle.GetByName(category, statName);
		this = Create(byName, capacity, options);
	}

	public unsafe ProfilerRecorder(ProfilerCategory category, char* statName, int statNameLen, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
	{
		ProfilerRecorderHandle byName = ProfilerRecorderHandle.GetByName(category, statName, statNameLen);
		this = Create(byName, capacity, options);
	}

	public ProfilerRecorder(ProfilerMarker marker, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
	{
		this = Create(ProfilerRecorderHandle.Get(marker), capacity, options);
	}

	public ProfilerRecorder(ProfilerRecorderHandle statHandle, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
	{
		this = Create(statHandle, capacity, options);
	}

	public unsafe static ProfilerRecorder StartNew(ProfilerCategory category, string statName, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
	{
		fixed (char* statName2 = statName)
		{
			return new ProfilerRecorder(category, statName2, statName.Length, capacity, options | ProfilerRecorderOptions.StartImmediately);
		}
	}

	public static ProfilerRecorder StartNew(ProfilerMarker marker, int capacity = 1, ProfilerRecorderOptions options = ProfilerRecorderOptions.Default)
	{
		return new ProfilerRecorder(marker, capacity, options | ProfilerRecorderOptions.StartImmediately);
	}

	internal static ProfilerRecorder StartNew()
	{
		return Create(default(ProfilerRecorderHandle), 0, ProfilerRecorderOptions.StartImmediately);
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

	public void Reset()
	{
		CheckInitializedAndThrow();
		Control(this, ControlOptions.Reset);
	}

	public ProfilerRecorderSample GetSample(int index)
	{
		CheckInitializedAndThrow();
		return GetSampleInternal(this, index);
	}

	public void CopyTo(List<ProfilerRecorderSample> outSamples, bool reset = false)
	{
		if (outSamples == null)
		{
			throw new ArgumentNullException("outSamples");
		}
		CheckInitializedAndThrow();
		CopyTo_List(this, outSamples, reset);
	}

	public unsafe int CopyTo(ProfilerRecorderSample* dest, int destSize, bool reset = false)
	{
		CheckInitializedWithParamsAndThrow(dest);
		return CopyTo_Pointer(this, dest, destSize, reset);
	}

	public unsafe ProfilerRecorderSample[] ToArray()
	{
		CheckInitializedAndThrow();
		int count = Count;
		ProfilerRecorderSample[] array = new ProfilerRecorderSample[count];
		fixed (ProfilerRecorderSample* outSamples = array)
		{
			CopyTo_Pointer(this, outSamples, count, reset: false);
		}
		return array;
	}

	internal void FilterToCurrentThread()
	{
		CheckInitializedAndThrow();
		Control(this, ControlOptions.SetFilterToCurrentThread);
	}

	internal void CollectFromAllThreads()
	{
		CheckInitializedAndThrow();
		Control(this, ControlOptions.SetToCollectFromAllThreads);
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
	private static ProfilerMarkerDataUnit GetValueUnitType(ProfilerRecorder handle)
	{
		return GetValueUnitType_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static ProfilerMarkerDataType GetValueDataType(ProfilerRecorder handle)
	{
		return GetValueDataType_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static long GetCurrentValue(ProfilerRecorder handle)
	{
		return GetCurrentValue_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static double GetCurrentValueAsDouble(ProfilerRecorder handle)
	{
		return GetCurrentValueAsDouble_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static long GetLastValue(ProfilerRecorder handle)
	{
		return GetLastValue_Injected(ref handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	private static double GetLastValueAsDouble(ProfilerRecorder handle)
	{
		return GetLastValueAsDouble_Injected(ref handle);
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
	private static bool GetWrapped(ProfilerRecorder handle)
	{
		return GetWrapped_Injected(ref handle);
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

	[NativeMethod(IsThreadSafe = true)]
	private static void CopyTo_List(ProfilerRecorder handle, List<ProfilerRecorderSample> outSamples, bool reset)
	{
		CopyTo_List_Injected(ref handle, outSamples, reset);
	}

	[NativeMethod(IsThreadSafe = true)]
	private unsafe static int CopyTo_Pointer(ProfilerRecorder handle, ProfilerRecorderSample* outSamples, int outSamplesSize, bool reset)
	{
		return CopyTo_Pointer_Injected(ref handle, outSamples, outSamplesSize, reset);
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
	private unsafe void CheckInitializedWithParamsAndThrow(ProfilerRecorderSample* dest)
	{
		if (handle == 0)
		{
			throw new InvalidOperationException("ProfilerRecorder object is not initialized or has been disposed.");
		}
		if (dest == null)
		{
			throw new ArgumentNullException("dest");
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
	private static extern ProfilerMarkerDataUnit GetValueUnitType_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern ProfilerMarkerDataType GetValueDataType_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern long GetCurrentValue_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double GetCurrentValueAsDouble_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern long GetLastValue_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double GetLastValueAsDouble_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetCount_Injected(ref ProfilerRecorder handle, CountOptions countOptions);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetValid_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetWrapped_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetRunning_Injected(ref ProfilerRecorder handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetSampleInternal_Injected(ref ProfilerRecorder handle, int index, out ProfilerRecorderSample ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CopyTo_List_Injected(ref ProfilerRecorder handle, List<ProfilerRecorderSample> outSamples, bool reset);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int CopyTo_Pointer_Injected(ref ProfilerRecorder handle, ProfilerRecorderSample* outSamples, int outSamplesSize, bool reset);
}

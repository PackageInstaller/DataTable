using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.Jobs.LowLevel.Unsafe;

[NativeType(Header = "Runtime/Jobs/ScriptBindings/JobsBindings.h")]
[NativeHeader("Runtime/Jobs/JobSystem.h")]
public static class JobsUtility
{
	public unsafe struct JobScheduleParameters(void* i_jobData, IntPtr i_reflectionData, JobHandle i_dependency, ScheduleMode i_scheduleMode)
	{
		public JobHandle Dependency = i_dependency;

		public int ScheduleMode = (int)i_scheduleMode;

		public IntPtr ReflectionData = i_reflectionData;

		public unsafe IntPtr JobDataPtr = (IntPtr)i_jobData;
	}

	internal delegate void PanicFunction_();

	internal static PanicFunction_ PanicFunction;

	public static extern bool JobCompilerEnabled
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction]
		set;
	}

	public unsafe static void GetJobRange(ref JobRanges ranges, int jobIndex, out int beginIndex, out int endIndex)
	{
		int* ptr = (int*)(void*)ranges.StartEndIndex;
		beginIndex = ptr[jobIndex * 2];
		endIndex = ptr[jobIndex * 2 + 1];
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(IsFreeFunction = true, IsThreadSafe = true)]
	public static extern bool GetWorkStealingRange(ref JobRanges ranges, int jobIndex, out int beginIndex, out int endIndex);

	[FreeFunction("ScheduleManagedJob", ThrowsException = true, IsThreadSafe = true)]
	public static JobHandle Schedule(ref JobScheduleParameters parameters)
	{
		Schedule_Injected(ref parameters, out var ret);
		return ret;
	}

	[FreeFunction("ScheduleManagedJobParallelFor", ThrowsException = true, IsThreadSafe = true)]
	public static JobHandle ScheduleParallelFor(ref JobScheduleParameters parameters, int arrayLength, int innerloopBatchCount)
	{
		ScheduleParallelFor_Injected(ref parameters, arrayLength, innerloopBatchCount, out var ret);
		return ret;
	}

	[FreeFunction("ScheduleManagedJobParallelForTransform", ThrowsException = true)]
	public static JobHandle ScheduleParallelForTransform(ref JobScheduleParameters parameters, IntPtr transfromAccesssArray)
	{
		ScheduleParallelForTransform_Injected(ref parameters, transfromAccesssArray, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(ThrowsException = true, IsThreadSafe = true)]
	private static extern IntPtr CreateJobReflectionData(Type wrapperJobType, Type userJobType, object managedJobFunction0, object managedJobFunction1, object managedJobFunction2);

	public static IntPtr CreateJobReflectionData(Type type, object managedJobFunction0, object managedJobFunction1 = null, object managedJobFunction2 = null)
	{
		return CreateJobReflectionData(type, type, managedJobFunction0, managedJobFunction1, managedJobFunction2);
	}

	[RequiredByNativeCode]
	private static void InvokePanicFunction()
	{
		PanicFunction?.Invoke();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Schedule_Injected(ref JobScheduleParameters parameters, out JobHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ScheduleParallelFor_Injected(ref JobScheduleParameters parameters, int arrayLength, int innerloopBatchCount, out JobHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ScheduleParallelForTransform_Injected(ref JobScheduleParameters parameters, IntPtr transfromAccesssArray, out JobHandle ret);
}

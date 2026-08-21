using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;

namespace Unity.Jobs;

[NativeType(Header = "Runtime/Jobs/ScriptBindings/JobsBindings.h")]
public struct JobHandle
{
	[NativeDisableUnsafePtrRestriction]
	internal IntPtr jobGroup;

	internal int version;

	public bool IsCompleted => ScheduleBatchedJobsAndIsCompleted(ref this);

	public void Complete()
	{
		if (!(jobGroup == IntPtr.Zero))
		{
			ScheduleBatchedJobsAndComplete(ref this);
		}
	}

	public unsafe static void CompleteAll(NativeArray<JobHandle> jobs)
	{
		ScheduleBatchedJobsAndCompleteAll(jobs.GetUnsafeReadOnlyPtr(), jobs.Length);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ScheduleBatchedScriptingJobs", IsFreeFunction = true, IsThreadSafe = true)]
	public static extern void ScheduleBatchedJobs();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ScheduleBatchedScriptingJobsAndComplete", IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private static extern void ScheduleBatchedJobsAndComplete(ref JobHandle job);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ScheduleBatchedScriptingJobsAndIsCompleted", IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private static extern bool ScheduleBatchedJobsAndIsCompleted(ref JobHandle job);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ScheduleBatchedScriptingJobsAndCompleteAll", IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private unsafe static extern void ScheduleBatchedJobsAndCompleteAll(void* jobs, int count);

	public static JobHandle CombineDependencies(JobHandle job0, JobHandle job1)
	{
		return CombineDependenciesInternal2(ref job0, ref job1);
	}

	[NativeMethod(IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private static JobHandle CombineDependenciesInternal2(ref JobHandle job0, ref JobHandle job1)
	{
		CombineDependenciesInternal2_Injected(ref job0, ref job1, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CombineDependenciesInternal2_Injected(ref JobHandle job0, ref JobHandle job1, out JobHandle ret);
}

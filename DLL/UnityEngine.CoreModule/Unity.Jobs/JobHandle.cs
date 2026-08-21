using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;

namespace Unity.Jobs;

[NativeType(Header = "Runtime/Jobs/ScriptBindings/JobsBindings.h")]
public struct JobHandle : IEquatable<JobHandle>
{
	internal ulong jobGroup;

	internal int version;

	public bool IsCompleted => ScheduleBatchedJobsAndIsCompleted(ref this);

	public void Complete()
	{
		if (jobGroup != 0)
		{
			ScheduleBatchedJobsAndComplete(ref this);
		}
	}

	public unsafe static void CompleteAll(ref JobHandle job0, ref JobHandle job1)
	{
		JobHandle* ptr = stackalloc JobHandle[2];
		*ptr = job0;
		ptr[1] = job1;
		ScheduleBatchedJobsAndCompleteAll(ptr, 2);
		job0 = default(JobHandle);
		job1 = default(JobHandle);
	}

	public unsafe static void CompleteAll(ref JobHandle job0, ref JobHandle job1, ref JobHandle job2)
	{
		JobHandle* ptr = stackalloc JobHandle[3];
		*ptr = job0;
		ptr[1] = job1;
		ptr[2] = job2;
		ScheduleBatchedJobsAndCompleteAll(ptr, 3);
		job0 = default(JobHandle);
		job1 = default(JobHandle);
		job2 = default(JobHandle);
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

	public static JobHandle CombineDependencies(JobHandle job0, JobHandle job1, JobHandle job2)
	{
		return CombineDependenciesInternal3(ref job0, ref job1, ref job2);
	}

	public unsafe static JobHandle CombineDependencies(NativeArray<JobHandle> jobs)
	{
		return CombineDependenciesInternalPtr(jobs.GetUnsafeReadOnlyPtr(), jobs.Length);
	}

	public unsafe static JobHandle CombineDependencies(NativeSlice<JobHandle> jobs)
	{
		return CombineDependenciesInternalPtr(jobs.GetUnsafeReadOnlyPtr(), jobs.Length);
	}

	[NativeMethod(IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private static JobHandle CombineDependenciesInternal2(ref JobHandle job0, ref JobHandle job1)
	{
		CombineDependenciesInternal2_Injected(ref job0, ref job1, out var ret);
		return ret;
	}

	[NativeMethod(IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private static JobHandle CombineDependenciesInternal3(ref JobHandle job0, ref JobHandle job1, ref JobHandle job2)
	{
		CombineDependenciesInternal3_Injected(ref job0, ref job1, ref job2, out var ret);
		return ret;
	}

	[NativeMethod(IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	internal unsafe static JobHandle CombineDependenciesInternalPtr(void* jobs, int count)
	{
		CombineDependenciesInternalPtr_Injected(jobs, count, out var ret);
		return ret;
	}

	[NativeMethod(IsFreeFunction = true, IsThreadSafe = true)]
	public static bool CheckFenceIsDependencyOrDidSyncFence(JobHandle jobHandle, JobHandle dependsOn)
	{
		return CheckFenceIsDependencyOrDidSyncFence_Injected(ref jobHandle, ref dependsOn);
	}

	public bool Equals(JobHandle other)
	{
		return jobGroup == other.jobGroup;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CombineDependenciesInternal2_Injected(ref JobHandle job0, ref JobHandle job1, out JobHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CombineDependenciesInternal3_Injected(ref JobHandle job0, ref JobHandle job1, ref JobHandle job2, out JobHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void CombineDependenciesInternalPtr_Injected(void* jobs, int count, out JobHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CheckFenceIsDependencyOrDidSyncFence_Injected(ref JobHandle jobHandle, ref JobHandle dependsOn);
}

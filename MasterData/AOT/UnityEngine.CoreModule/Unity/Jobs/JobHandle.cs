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

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ScheduleBatchedScriptingJobs", IsFreeFunction = true, IsThreadSafe = true)]
	public static extern void ScheduleBatchedJobs();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ScheduleBatchedScriptingJobsAndComplete", IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private static extern void ScheduleBatchedJobsAndComplete(ref JobHandle job);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ScheduleBatchedScriptingJobsAndIsCompleted", IsFreeFunction = true, IsThreadSafe = true, ThrowsException = true)]
	private static extern bool ScheduleBatchedJobsAndIsCompleted(ref JobHandle job);

	public static JobHandle CombineDependencies(JobHandle job0, JobHandle job1)
	{
		return CombineDependenciesInternal2(ref job0, ref job1);
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
	internal unsafe static JobHandle CombineDependenciesInternalPtr(void* jobs, int count)
	{
		CombineDependenciesInternalPtr_Injected(jobs, count, out var ret);
		return ret;
	}

	public bool Equals(JobHandle other)
	{
		return jobGroup == other.jobGroup;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CombineDependenciesInternal2_Injected(ref JobHandle job0, ref JobHandle job1, out JobHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void CombineDependenciesInternalPtr_Injected(void* jobs, int count, out JobHandle ret);
}

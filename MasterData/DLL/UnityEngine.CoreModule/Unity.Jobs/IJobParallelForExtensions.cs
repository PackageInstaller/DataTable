using System;
using System.Runtime.InteropServices;
using Unity.Burst;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs.LowLevel.Unsafe;

namespace Unity.Jobs;

public static class IJobParallelForExtensions
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct ParallelForJobStruct<T> where T : struct, IJobParallelFor
	{
		public delegate void ExecuteJobFunction(ref T data, IntPtr additionalPtr, IntPtr bufferRangePatchData, ref JobRanges ranges, int jobIndex);

		internal static readonly BurstLike.SharedStatic<IntPtr> jobReflectionData = BurstLike.SharedStatic<IntPtr>.GetOrCreate<ParallelForJobStruct<T>>();

		[BurstDiscard]
		internal static void Initialize()
		{
			if (jobReflectionData.Data == IntPtr.Zero)
			{
				jobReflectionData.Data = JobsUtility.CreateJobReflectionData(typeof(T), new ExecuteJobFunction(Execute));
			}
		}

		public static void Execute(ref T jobData, IntPtr additionalPtr, IntPtr bufferRangePatchData, ref JobRanges ranges, int jobIndex)
		{
			int beginIndex;
			int endIndex;
			while (JobsUtility.GetWorkStealingRange(ref ranges, jobIndex, out beginIndex, out endIndex))
			{
				int num = endIndex;
				for (int i = beginIndex; i < num; i++)
				{
					jobData.Execute(i);
				}
			}
		}
	}

	public static void EarlyJobInit<T>() where T : struct, IJobParallelFor
	{
		ParallelForJobStruct<T>.Initialize();
	}

	private static IntPtr GetReflectionData<T>() where T : struct, IJobParallelFor
	{
		ParallelForJobStruct<T>.Initialize();
		return ParallelForJobStruct<T>.jobReflectionData.Data;
	}

	public unsafe static JobHandle Schedule<T>(this T jobData, int arrayLength, int innerloopBatchCount, JobHandle dependsOn = default(JobHandle)) where T : struct, IJobParallelFor
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), dependsOn, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelFor(ref parameters, arrayLength, innerloopBatchCount);
	}

	public unsafe static void Run<T>(this T jobData, int arrayLength) where T : struct, IJobParallelFor
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), default(JobHandle), ScheduleMode.Run);
		JobsUtility.ScheduleParallelFor(ref parameters, arrayLength, arrayLength);
	}
}

using System;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs.LowLevel.Unsafe;

namespace Unity.Jobs;

public static class IJobParallelForExtensions
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct ParallelForJobStruct<T> where T : struct, IJobParallelFor
	{
		public delegate void ExecuteJobFunction(ref T data, IntPtr additionalPtr, IntPtr bufferRangePatchData, ref JobRanges ranges, int jobIndex);

		public static readonly IntPtr jobReflectionData = JobsUtility.CreateJobReflectionData(typeof(T), new ExecuteJobFunction(Execute));

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

	public unsafe static JobHandle Schedule<T>(this T jobData, int arrayLength, int innerloopBatchCount, JobHandle dependsOn = default(JobHandle)) where T : struct, IJobParallelFor
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), ParallelForJobStruct<T>.jobReflectionData, dependsOn, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelFor(ref parameters, arrayLength, innerloopBatchCount);
	}
}

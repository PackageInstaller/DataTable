using System;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs.LowLevel.Unsafe;

namespace Unity.Jobs;

public static class IJobForExtensions
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct ForJobStruct<T> where T : struct, IJobFor
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

	public unsafe static JobHandle ScheduleParallel<T>(this T jobData, int arrayLength, int innerloopBatchCount, JobHandle dependency) where T : struct, IJobFor
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), ForJobStruct<T>.jobReflectionData, dependency, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelFor(ref parameters, arrayLength, innerloopBatchCount);
	}
}

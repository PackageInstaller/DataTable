using System;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs;
using Unity.Jobs.LowLevel.Unsafe;

namespace UnityEngine.Jobs;

public static class IJobParallelForTransformExtensions
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct TransformParallelForLoopStruct<T> where T : struct, IJobParallelForTransform
	{
		private struct TransformJobData
		{
			public IntPtr TransformAccessArray;

			public int IsReadOnly;
		}

		public delegate void ExecuteJobFunction(ref T jobData, IntPtr additionalPtr, IntPtr bufferRangePatchData, ref JobRanges ranges, int jobIndex);

		public static IntPtr jobReflectionData;

		public static IntPtr Initialize()
		{
			if (jobReflectionData == IntPtr.Zero)
			{
				jobReflectionData = JobsUtility.CreateJobReflectionData(typeof(T), new ExecuteJobFunction(Execute));
			}
			return jobReflectionData;
		}

		public unsafe static void Execute(ref T jobData, IntPtr jobData2, IntPtr bufferRangePatchData, ref JobRanges ranges, int jobIndex)
		{
			UnsafeUtility.CopyPtrToStructure<TransformJobData>((void*)jobData2, out var output);
			int* ptr = (int*)(void*)TransformAccessArray.GetSortedToUserIndex(output.TransformAccessArray);
			TransformAccess* ptr2 = (TransformAccess*)(void*)TransformAccessArray.GetSortedTransformAccess(output.TransformAccessArray);
			if (output.IsReadOnly == 1)
			{
				int beginIndex;
				int endIndex;
				while (JobsUtility.GetWorkStealingRange(ref ranges, jobIndex, out beginIndex, out endIndex))
				{
					int num = endIndex;
					for (int i = beginIndex; i < num; i++)
					{
						int num2 = i;
						int index = ptr[num2];
						TransformAccess transform = ptr2[num2];
						jobData.Execute(index, transform);
					}
				}
			}
			else
			{
				JobsUtility.GetJobRange(ref ranges, jobIndex, out var beginIndex2, out var endIndex2);
				for (int j = beginIndex2; j < endIndex2; j++)
				{
					int num3 = j;
					int index2 = ptr[num3];
					TransformAccess transform2 = ptr2[num3];
					jobData.Execute(index2, transform2);
				}
			}
		}
	}

	public unsafe static JobHandle Schedule<T>(this T jobData, TransformAccessArray transforms, JobHandle dependsOn = default(JobHandle)) where T : struct, IJobParallelForTransform
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), TransformParallelForLoopStruct<T>.Initialize(), dependsOn, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelForTransform(ref parameters, transforms.GetTransformAccessArrayForSchedule());
	}
}

using System;
using System.Runtime.InteropServices;
using Unity.Burst;
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

		internal static readonly BurstLike.SharedStatic<IntPtr> jobReflectionData = BurstLike.SharedStatic<IntPtr>.GetOrCreate<TransformParallelForLoopStruct<T>>();

		[BurstDiscard]
		internal static void Initialize()
		{
			if (jobReflectionData.Data == IntPtr.Zero)
			{
				jobReflectionData.Data = JobsUtility.CreateJobReflectionData(typeof(T), new ExecuteJobFunction(Execute));
			}
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

	public static void EarlyJobInit<T>() where T : struct, IJobParallelForTransform
	{
		TransformParallelForLoopStruct<T>.Initialize();
	}

	private static IntPtr GetReflectionData<T>() where T : struct, IJobParallelForTransform
	{
		TransformParallelForLoopStruct<T>.Initialize();
		return TransformParallelForLoopStruct<T>.jobReflectionData.Data;
	}

	public unsafe static JobHandle Schedule<T>(this T jobData, TransformAccessArray transforms, JobHandle dependsOn = default(JobHandle)) where T : struct, IJobParallelForTransform
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), dependsOn, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelForTransform(ref parameters, transforms.GetTransformAccessArrayForSchedule());
	}

	public unsafe static JobHandle ScheduleReadOnly<T>(this T jobData, TransformAccessArray transforms, int batchSize, JobHandle dependsOn = default(JobHandle)) where T : struct, IJobParallelForTransform
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), dependsOn, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelForTransformReadOnly(ref parameters, transforms.GetTransformAccessArrayForSchedule(), batchSize);
	}

	public unsafe static void RunReadOnly<T>(this T jobData, TransformAccessArray transforms) where T : struct, IJobParallelForTransform
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), default(JobHandle), ScheduleMode.Run);
		JobsUtility.ScheduleParallelForTransformReadOnly(ref parameters, transforms.GetTransformAccessArrayForSchedule(), transforms.length);
	}

	public unsafe static JobHandle ScheduleByRef<T>(this ref T jobData, TransformAccessArray transforms, JobHandle dependsOn = default(JobHandle)) where T : struct, IJobParallelForTransform
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), dependsOn, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelForTransform(ref parameters, transforms.GetTransformAccessArrayForSchedule());
	}

	public unsafe static JobHandle ScheduleReadOnlyByRef<T>(this ref T jobData, TransformAccessArray transforms, int batchSize, JobHandle dependsOn = default(JobHandle)) where T : struct, IJobParallelForTransform
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), dependsOn, ScheduleMode.Batched);
		return JobsUtility.ScheduleParallelForTransformReadOnly(ref parameters, transforms.GetTransformAccessArrayForSchedule(), batchSize);
	}

	public unsafe static void RunReadOnlyByRef<T>(this ref T jobData, TransformAccessArray transforms) where T : struct, IJobParallelForTransform
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), default(JobHandle), ScheduleMode.Run);
		JobsUtility.ScheduleParallelForTransformReadOnly(ref parameters, transforms.GetTransformAccessArrayForSchedule(), transforms.length);
	}
}

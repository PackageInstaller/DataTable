using System;
using System.Runtime.InteropServices;
using Unity.Burst;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs.LowLevel.Unsafe;

namespace Unity.Jobs;

public static class IJobExtensions
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct JobStruct<T> where T : struct, IJob
	{
		internal delegate void ExecuteJobFunction(ref T data, IntPtr additionalPtr, IntPtr bufferRangePatchData, ref JobRanges ranges, int jobIndex);

		internal static readonly BurstLike.SharedStatic<IntPtr> jobReflectionData = BurstLike.SharedStatic<IntPtr>.GetOrCreate<JobStruct<T>>();

		[BurstDiscard]
		internal static void Initialize()
		{
			if (jobReflectionData.Data == IntPtr.Zero)
			{
				jobReflectionData.Data = JobsUtility.CreateJobReflectionData(typeof(T), new ExecuteJobFunction(Execute));
			}
		}

		public static void Execute(ref T data, IntPtr additionalPtr, IntPtr bufferRangePatchData, ref JobRanges ranges, int jobIndex)
		{
			data.Execute();
		}
	}

	public static void EarlyJobInit<T>() where T : struct, IJob
	{
		JobStruct<T>.Initialize();
	}

	private static IntPtr GetReflectionData<T>() where T : struct, IJob
	{
		JobStruct<T>.Initialize();
		return JobStruct<T>.jobReflectionData.Data;
	}

	public unsafe static JobHandle Schedule<T>(this T jobData, JobHandle dependsOn = default(JobHandle)) where T : struct, IJob
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), dependsOn, ScheduleMode.Single);
		return JobsUtility.Schedule(ref parameters);
	}

	public unsafe static void Run<T>(this T jobData) where T : struct, IJob
	{
		JobsUtility.JobScheduleParameters parameters = new JobsUtility.JobScheduleParameters(UnsafeUtility.AddressOf(ref jobData), GetReflectionData<T>(), default(JobHandle), ScheduleMode.Run);
		JobsUtility.Schedule(ref parameters);
	}
}

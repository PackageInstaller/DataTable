using System;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs.LowLevel.Unsafe;

namespace UnityEngine.Animations;

[StructLayout(LayoutKind.Sequential, Size = 1)]
internal struct ProcessAnimationJobStruct<T> where T : struct, IAnimationJob
{
	public delegate void ExecuteJobFunction(ref T data, IntPtr animationStreamPtr, IntPtr unusedPtr, ref JobRanges ranges, int jobIndex);

	private static IntPtr jobReflectionData;

	public static IntPtr GetJobReflectionData()
	{
		if (jobReflectionData == IntPtr.Zero)
		{
			jobReflectionData = JobsUtility.CreateJobReflectionData(typeof(T), new ExecuteJobFunction(Execute));
		}
		return jobReflectionData;
	}

	public unsafe static void Execute(ref T data, IntPtr animationStreamPtr, IntPtr methodIndex, ref JobRanges ranges, int jobIndex)
	{
		UnsafeUtility.CopyPtrToStructure<AnimationStream>((void*)animationStreamPtr, out var output);
		switch ((JobMethodIndex)methodIndex.ToInt32())
		{
		case JobMethodIndex.ProcessRootMotionMethodIndex:
			data.ProcessRootMotion(output);
			break;
		case JobMethodIndex.ProcessAnimationMethodIndex:
			data.ProcessAnimation(output);
			break;
		default:
			throw new NotImplementedException("Invalid Animation jobs method index.");
		}
	}
}

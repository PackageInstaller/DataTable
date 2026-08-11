using System;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Jobs;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
[NativeHeader("Runtime/Math/Matrix4x4.h")]
public class BatchRendererGroup
{
	public delegate JobHandle OnPerformCulling(BatchRendererGroup rendererGroup, BatchCullingContext cullingContext);

	private IntPtr m_GroupHandle;

	private OnPerformCulling m_PerformCulling;

	[RequiredByNativeCode]
	private unsafe static void InvokeOnPerformCulling(BatchRendererGroup group, ref BatchRendererCullingOutput context, ref LODParameters lodParameters)
	{
		NativeArray<Plane> inCullingPlanes = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<Plane>(context.cullingPlanes, context.cullingPlanesCount, Allocator.Invalid);
		NativeArray<BatchVisibility> inOutBatchVisibility = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<BatchVisibility>(context.batchVisibility, context.batchVisibilityCount, Allocator.Invalid);
		NativeArray<int> outVisibleIndices = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<int>(context.visibleIndices, context.visibleIndicesCount, Allocator.Invalid);
		NativeArray<int> outVisibleIndicesY = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<int>(context.visibleIndicesY, context.visibleIndicesCount, Allocator.Invalid);
		try
		{
			context.cullingJobsFence = group.m_PerformCulling(group, new BatchCullingContext(inCullingPlanes, inOutBatchVisibility, outVisibleIndices, outVisibleIndicesY, lodParameters, context.cullingMatrix, context.nearPlane));
		}
		finally
		{
			JobHandle.ScheduleBatchedJobs();
		}
	}
}

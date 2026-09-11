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
[NativeHeader("Runtime/Math/Matrix4x4.h")]
[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
public class BatchRendererGroup
{
	public delegate JobHandle OnPerformCulling(BatchRendererGroup rendererGroup, BatchCullingContext cullingContext, BatchCullingOutput cullingOutput, IntPtr userContext);

	private IntPtr m_GroupHandle;

	private OnPerformCulling m_PerformCulling;

	[RequiredByNativeCode]
	private unsafe static void InvokeOnPerformCulling(BatchRendererGroup group, ref BatchRendererCullingOutput context, ref LODParameters lodParameters, IntPtr userContext)
	{
		NativeArray<Plane> inCullingPlanes = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<Plane>(context.cullingPlanes, context.cullingPlaneCount, Allocator.Invalid);
		NativeArray<CullingSplit> inCullingSplits = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<CullingSplit>(context.cullingSplits, context.cullingSplitCount, Allocator.Invalid);
		NativeArray<BatchCullingOutputDrawCommands> drawCommands = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<BatchCullingOutputDrawCommands>(context.drawCommands, 1, Allocator.Invalid);
		try
		{
			BatchCullingOutput cullingOutput = new BatchCullingOutput
			{
				drawCommands = drawCommands
			};
			context.cullingJobsFence = group.m_PerformCulling(group, new BatchCullingContext(inCullingPlanes, inCullingSplits, lodParameters, context.localToWorldMatrix, context.viewType, context.projectionType, context.cullingFlags, context.viewID, context.cullingLayerMask, context.sceneCullingMask, context.receiverPlaneOffset, context.receiverPlaneCount), cullingOutput, userContext);
		}
		finally
		{
			JobHandle.ScheduleBatchedJobs();
		}
	}
}

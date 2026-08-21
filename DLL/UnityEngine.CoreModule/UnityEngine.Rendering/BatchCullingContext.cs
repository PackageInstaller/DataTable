using Unity.Collections;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
public struct BatchCullingContext
{
	public readonly NativeArray<Plane> cullingPlanes;

	public NativeArray<BatchVisibility> batchVisibility;

	public NativeArray<int> visibleIndices;

	public NativeArray<int> visibleIndicesY;

	public readonly LODParameters lodParameters;

	public readonly Matrix4x4 cullingMatrix;

	public readonly float nearPlane;

	internal BatchCullingContext(NativeArray<Plane> inCullingPlanes, NativeArray<BatchVisibility> inOutBatchVisibility, NativeArray<int> outVisibleIndices, NativeArray<int> outVisibleIndicesY, LODParameters inLodParameters, Matrix4x4 inCullingMatrix, float inNearPlane)
	{
		cullingPlanes = inCullingPlanes;
		batchVisibility = inOutBatchVisibility;
		visibleIndices = outVisibleIndices;
		visibleIndicesY = outVisibleIndicesY;
		lodParameters = inLodParameters;
		cullingMatrix = inCullingMatrix;
		nearPlane = inNearPlane;
	}
}

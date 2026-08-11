using Unity.Jobs;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
internal struct BatchRendererCullingOutput
{
	public JobHandle cullingJobsFence;

	public Matrix4x4 cullingMatrix;

	public unsafe Plane* cullingPlanes;

	public unsafe BatchVisibility* batchVisibility;

	public unsafe int* visibleIndices;

	public unsafe int* visibleIndicesY;

	public int cullingPlanesCount;

	public int batchVisibilityCount;

	public int visibleIndicesCount;

	public float nearPlane;
}

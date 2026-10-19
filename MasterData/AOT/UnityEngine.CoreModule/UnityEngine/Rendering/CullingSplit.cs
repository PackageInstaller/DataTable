using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
[UsedByNativeCode]
public struct CullingSplit
{
	public Vector3 sphereCenter;

	public float sphereRadius;

	public int cullingPlaneOffset;

	public int cullingPlaneCount;

	public float cascadeBlendCullingFactor;

	public float nearPlane;

	public Matrix4x4 cullingMatrix;
}

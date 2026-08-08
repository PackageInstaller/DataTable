using Unity.Jobs;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
[UsedByNativeCode]
internal struct BatchRendererCullingOutput
{
	public JobHandle cullingJobsFence;

	public Matrix4x4 localToWorldMatrix;

	public unsafe Plane* cullingPlanes;

	public int cullingPlaneCount;

	public int receiverPlaneOffset;

	public int receiverPlaneCount;

	public unsafe CullingSplit* cullingSplits;

	public int cullingSplitCount;

	public BatchCullingViewType viewType;

	public BatchCullingProjectionType projectionType;

	public BatchCullingFlags cullingFlags;

	public ulong viewID;

	public uint cullingLayerMask;

	public ulong sceneCullingMask;

	public unsafe BatchCullingOutputDrawCommands* drawCommands;
}

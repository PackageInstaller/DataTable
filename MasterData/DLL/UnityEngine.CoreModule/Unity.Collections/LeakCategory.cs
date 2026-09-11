using UnityEngine.Scripting;

namespace Unity.Collections;

[UsedByNativeCode]
internal enum LeakCategory
{
	Invalid,
	Malloc,
	TempJob,
	Persistent,
	LightProbesQuery,
	NativeTest,
	MeshDataArray,
	TransformAccessArray,
	NavMeshQuery
}

using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[StaticAccessor("GetLODGroupManager()", StaticAccessorType.Dot)]
[NativeHeader("Runtime/Graphics/LOD/LODGroup.h")]
[NativeHeader("Runtime/Graphics/LOD/LODUtility.h")]
[NativeHeader("Runtime/Graphics/LOD/LODGroupManager.h")]
public class LODGroup : Component
{
	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UpdateLODGroupBoundingBox", HasExplicitThis = true)]
	public extern void RecalculateBounds();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SetLODs_Binding", HasExplicitThis = true)]
	public extern void SetLODs([Unmarshalled] LOD[] lods);
}

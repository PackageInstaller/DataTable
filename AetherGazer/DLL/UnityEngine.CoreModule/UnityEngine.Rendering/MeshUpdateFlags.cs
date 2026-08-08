using System;

namespace UnityEngine.Rendering;

[Flags]
public enum MeshUpdateFlags
{
	Default = 0,
	DontValidateIndices = 1,
	DontResetBoneBounds = 2,
	DontNotifyMeshUsers = 4,
	DontRecalculateBounds = 8
}

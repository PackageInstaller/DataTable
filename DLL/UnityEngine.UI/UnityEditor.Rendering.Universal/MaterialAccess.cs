using UnityEngine;

namespace UnityEditor.Rendering.Universal;

internal static class MaterialAccess
{
	internal static int ReadMaterialRawRenderQueue(Material mat)
	{
		return mat.rawRenderQueue;
	}
}

using UnityEngine;

namespace UnityEditor.Rendering.BuiltIn.ShaderGraph;

internal static class MaterialAccess
{
	internal static int ReadMaterialRawRenderQueue(Material mat)
	{
		return mat.rawRenderQueue;
	}
}

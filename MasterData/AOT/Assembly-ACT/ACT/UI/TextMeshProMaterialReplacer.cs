using UnityEngine;
using UnityEngine.Scripting;

namespace ACT.UI;

[Preserve]
[GlobalMaterialReplacer]
public class TextMeshProMaterialReplacer : IMaterialReplacer
{
	public int order => 10;

	public Material Replace(Material material)
	{
		if ((bool)material && (bool)material.shader && material.shader.name.StartsWith("TextMeshPro/"))
		{
			Material material2 = new Material(material);
			material2.CopyPropertiesFromMaterial(material);
			return material2;
		}
		return null;
	}
}

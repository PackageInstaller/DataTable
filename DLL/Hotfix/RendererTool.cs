using UnityEngine;

public static class RendererTool
{
	public static Material GetMaterial(this Renderer renderer)
	{
		return renderer.sharedMaterial;
	}
}

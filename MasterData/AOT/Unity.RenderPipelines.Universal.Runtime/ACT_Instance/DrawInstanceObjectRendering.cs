using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace ACT_Instance;

public static class DrawInstanceObjectRendering
{
	public static List<DrawInstanceObject> ObjectList = new List<DrawInstanceObject>();

	private static Plane[] s_CachedPlanes = new Plane[6];

	public static void RenderObject(CommandBuffer cmd, int shaderPass, DrawInstanceObject.RenderType renderType, Camera camera)
	{
		if (ObjectList.Count <= 0)
		{
			return;
		}
		GeometryUtility.CalculateFrustumPlanes(camera, s_CachedPlanes);
		for (int i = 0; i < ObjectList.Count; i++)
		{
			DrawInstanceObject drawInstanceObject = ObjectList[i];
			if (drawInstanceObject.objectToDraw.renderType == renderType && GeometryUtility.TestPlanesAABB(s_CachedPlanes, drawInstanceObject.objectToDraw.bounds))
			{
				drawInstanceObject.DrawInstance(cmd, Culling: true, shaderPass);
			}
		}
	}

	public static void CullingShadow(CommandBuffer cmd, Bounds shadowBound)
	{
		for (int i = 0; i < ObjectList.Count; i++)
		{
			DrawInstanceObject drawInstanceObject = ObjectList[i];
			if (drawInstanceObject.objectToDraw.renderShadow)
			{
				drawInstanceObject.DoShadowCulling(cmd, shadowBound);
			}
		}
	}

	public static void RenderShadow(CommandBuffer cmd, int shaderPass)
	{
		for (int i = 0; i < ObjectList.Count; i++)
		{
			DrawInstanceObject drawInstanceObject = ObjectList[i];
			if (drawInstanceObject.objectToDraw.renderShadow)
			{
				drawInstanceObject.DrawShadowInstance(cmd, shaderPass);
			}
		}
	}

	public static void ClearList()
	{
		ObjectList.Clear();
	}
}

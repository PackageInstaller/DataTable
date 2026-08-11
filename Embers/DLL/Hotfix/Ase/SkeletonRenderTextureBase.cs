using System;
using Spine.Unity;
using UnityEngine;
using UnityEngine.Rendering;

namespace Ase;

public abstract class SkeletonRenderTextureBase : MonoBehaviour
{
	public Color color = Color.white;

	public Vector2Int maxRenderTextureSize = new Vector2Int(1024, 1024);

	public GameObject quad;

	protected Mesh quadMesh;

	public RenderTexture renderTexture;

	public Camera targetCamera;

	protected CommandBuffer commandBuffer;

	protected Vector2Int screenSize;

	protected Vector2Int usedRenderTextureSize;

	protected Vector2Int allocatedRenderTextureSize;

	protected Vector2 downScaleFactor = Vector2.one;

	protected Vector3 worldCornerNoDistortion0;

	protected Vector3 worldCornerNoDistortion1;

	protected Vector3 worldCornerNoDistortion2;

	protected Vector3 worldCornerNoDistortion3;

	protected Vector2 uvCorner0;

	protected Vector2 uvCorner1;

	protected Vector2 uvCorner2;

	protected Vector2 uvCorner3;

	protected virtual void Awake()
	{
		commandBuffer = new CommandBuffer();
	}

	private void OnDestroy()
	{
		if ((bool)renderTexture)
		{
			RenderTexture.ReleaseTemporary(renderTexture);
		}
	}

	protected void PrepareTextureMapping(out Vector3 screenSpaceMin, out Vector3 screenSpaceMax, Vector3 screenCorner0, Vector3 screenCorner1, Vector3 screenCorner2, Vector3 screenCorner3)
	{
		screenSpaceMin = Vector3.Min(screenCorner0, Vector3.Min(screenCorner1, Vector3.Min(screenCorner2, screenCorner3)));
		screenSpaceMax = Vector3.Max(screenCorner0, Vector3.Max(screenCorner1, Vector3.Max(screenCorner2, screenCorner3)));
		screenSpaceMin.x = Mathf.Floor(screenSpaceMin.x);
		screenSpaceMin.y = Mathf.Floor(screenSpaceMin.y);
		screenSpaceMax.x = Mathf.Ceil(screenSpaceMax.x);
		screenSpaceMax.y = Mathf.Ceil(screenSpaceMax.y);
		uvCorner0 = MathUtilities.InverseLerp(screenSpaceMin, screenSpaceMax, screenCorner0);
		uvCorner1 = MathUtilities.InverseLerp(screenSpaceMin, screenSpaceMax, screenCorner1);
		uvCorner2 = MathUtilities.InverseLerp(screenSpaceMin, screenSpaceMax, screenCorner2);
		uvCorner3 = MathUtilities.InverseLerp(screenSpaceMin, screenSpaceMax, screenCorner3);
		screenSize = new Vector2Int(Math.Abs((int)screenSpaceMax.x - (int)screenSpaceMin.x), Math.Abs((int)screenSpaceMax.y - (int)screenSpaceMin.y));
		usedRenderTextureSize = new Vector2Int(Math.Min(maxRenderTextureSize.x, screenSize.x), Math.Min(maxRenderTextureSize.y, screenSize.y));
		downScaleFactor = new Vector2((float)usedRenderTextureSize.x / (float)screenSize.x, (float)usedRenderTextureSize.y / (float)screenSize.y);
		PrepareRenderTexture();
	}

	protected void PrepareRenderTexture()
	{
		Vector2Int vector2Int = new Vector2Int(Mathf.NextPowerOfTwo(usedRenderTextureSize.x), Mathf.NextPowerOfTwo(usedRenderTextureSize.y));
		if (vector2Int != allocatedRenderTextureSize)
		{
			if ((bool)renderTexture)
			{
				RenderTexture.ReleaseTemporary(renderTexture);
			}
			renderTexture = RenderTexture.GetTemporary(vector2Int.x, vector2Int.y);
			renderTexture.filterMode = FilterMode.Point;
			allocatedRenderTextureSize = vector2Int;
		}
	}

	protected void AssignAtQuad()
	{
		Transform obj = quad.transform;
		obj.position = base.transform.position;
		obj.rotation = base.transform.rotation;
		obj.localScale = base.transform.localScale;
		Vector3 vector = obj.InverseTransformPoint(worldCornerNoDistortion0);
		Vector3 vector2 = obj.InverseTransformPoint(worldCornerNoDistortion1);
		Vector3 vector3 = obj.InverseTransformPoint(worldCornerNoDistortion2);
		Vector3 vector4 = obj.InverseTransformPoint(worldCornerNoDistortion3);
		Vector3[] vertices = new Vector3[4] { vector, vector2, vector3, vector4 };
		quadMesh.vertices = vertices;
		int[] triangles = new int[6] { 0, 1, 2, 2, 1, 3 };
		quadMesh.triangles = triangles;
		Vector3[] normals = new Vector3[4]
		{
			-Vector3.forward,
			-Vector3.forward,
			-Vector3.forward,
			-Vector3.forward
		};
		quadMesh.normals = normals;
		float num = (float)usedRenderTextureSize.x / (float)allocatedRenderTextureSize.x;
		float num2 = (float)usedRenderTextureSize.y / (float)allocatedRenderTextureSize.y;
		if (downScaleFactor.x < 1f || downScaleFactor.y < 1f)
		{
			num = downScaleFactor.x * (float)screenSize.x / (float)allocatedRenderTextureSize.x;
			num2 = downScaleFactor.y * (float)screenSize.y / (float)allocatedRenderTextureSize.y;
		}
		Vector2[] uv = new Vector2[4]
		{
			new Vector2(uvCorner0.x * num, uvCorner0.y * num2),
			new Vector2(uvCorner1.x * num, uvCorner1.y * num2),
			new Vector2(uvCorner2.x * num, uvCorner2.y * num2),
			new Vector2(uvCorner3.x * num, uvCorner3.y * num2)
		};
		quadMesh.uv = uv;
		AssignMeshAtRenderer();
	}

	protected abstract void AssignMeshAtRenderer();
}

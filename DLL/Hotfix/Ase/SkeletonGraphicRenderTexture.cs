using System;
using System.Collections.Generic;
using Spine.Unity;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(SkeletonGraphic))]
public class SkeletonGraphicRenderTexture : SkeletonRenderTextureBase
{
	[Serializable]
	public struct TextureMaterialPair(Texture texture, Material material)
	{
		public Texture texture = texture;

		public Material material = material;
	}

	public RectTransform customRenderRect;

	protected SkeletonGraphic skeletonGraphic;

	public List<TextureMaterialPair> meshRendererMaterialForTexture = new List<TextureMaterialPair>();

	protected CanvasRenderer quadCanvasRenderer;

	protected RawImage quadRawImage;

	protected readonly Vector3[] worldCorners = new Vector3[4];

	protected override void Awake()
	{
		base.Awake();
		skeletonGraphic = GetComponent<SkeletonGraphic>();
		if (targetCamera == null)
		{
			targetCamera = ((Graphic)(object)skeletonGraphic).canvas.worldCamera;
			if (targetCamera == null)
			{
				targetCamera = Camera.main;
			}
		}
		CreateQuadChild();
	}

	private void CreateQuadChild()
	{
		quad = new GameObject(base.name + " RenderTexture", typeof(CanvasRenderer), typeof(RawImage));
		quad.transform.SetParent(base.transform.parent, worldPositionStays: false);
		quad.transform.SetSiblingIndex(base.transform.GetSiblingIndex());
		quadCanvasRenderer = quad.GetComponent<CanvasRenderer>();
		quadRawImage = quad.GetComponent<RawImage>();
		quadMesh = new Mesh();
		quadMesh.MarkDynamic();
		quadMesh.name = "RenderTexture Quad";
		quadMesh.hideFlags = HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild;
	}

	private void Reset()
	{
		skeletonGraphic = GetComponent<SkeletonGraphic>();
		AtlasAssetBase[] atlasAssets = skeletonGraphic.SkeletonDataAsset.atlasAssets;
		for (int i = 0; i < atlasAssets.Length; i++)
		{
			foreach (Material material in atlasAssets[i].Materials)
			{
				if (material.mainTexture != null)
				{
					meshRendererMaterialForTexture.Add(new TextureMaterialPair(material.mainTexture, material));
				}
			}
		}
	}

	private void OnEnable()
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Expected O, but got Unknown
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Expected O, but got Unknown
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Expected O, but got Unknown
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Expected O, but got Unknown
		skeletonGraphic.OnInstructionsPrepared += new InstructionDelegate(PrepareQuad);
		skeletonGraphic.AssignMeshOverrideSingleRenderer += new MeshAssignmentDelegateSingle(RenderSingleMeshToRenderTexture);
		skeletonGraphic.AssignMeshOverrideMultipleRenderers += new MeshAssignmentDelegateMultiple(RenderMultipleMeshesToRenderTexture);
		skeletonGraphic.disableMeshAssignmentOnOverride = true;
		skeletonGraphic.OnMeshAndMaterialsUpdated += new SkeletonRendererDelegate(RenderOntoQuad);
		List<CanvasRenderer> canvasRenderers = skeletonGraphic.canvasRenderers;
		for (int i = 0; i < canvasRenderers.Count; i++)
		{
			canvasRenderers[i].cull = true;
		}
		if ((bool)(UnityEngine.Object)(object)quadCanvasRenderer)
		{
			((Component)(object)quadCanvasRenderer).gameObject.SetActive(value: true);
		}
	}

	private void OnDisable()
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Expected O, but got Unknown
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Expected O, but got Unknown
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Expected O, but got Unknown
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Expected O, but got Unknown
		skeletonGraphic.OnInstructionsPrepared -= new InstructionDelegate(PrepareQuad);
		skeletonGraphic.AssignMeshOverrideSingleRenderer -= new MeshAssignmentDelegateSingle(RenderSingleMeshToRenderTexture);
		skeletonGraphic.AssignMeshOverrideMultipleRenderers -= new MeshAssignmentDelegateMultiple(RenderMultipleMeshesToRenderTexture);
		skeletonGraphic.disableMeshAssignmentOnOverride = false;
		skeletonGraphic.OnMeshAndMaterialsUpdated -= new SkeletonRendererDelegate(RenderOntoQuad);
		List<CanvasRenderer> canvasRenderers = skeletonGraphic.canvasRenderers;
		for (int i = 0; i < canvasRenderers.Count; i++)
		{
			canvasRenderers[i].cull = false;
		}
		if ((bool)(UnityEngine.Object)(object)quadCanvasRenderer)
		{
			((Component)(object)quadCanvasRenderer).gameObject.SetActive(value: false);
		}
		if ((bool)renderTexture)
		{
			RenderTexture.ReleaseTemporary(renderTexture);
		}
		allocatedRenderTextureSize = Vector2Int.zero;
	}

	private void PrepareQuad(SkeletonRendererInstruction instruction)
	{
		PrepareForMesh();
		SetupQuad();
	}

	private void RenderOntoQuad(SkeletonGraphic skeletonRenderer)
	{
		AssignAtQuad();
	}

	protected void PrepareForMesh()
	{
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		(customRenderRect ? customRenderRect : ((Graphic)(object)skeletonGraphic).rectTransform).GetWorldCorners(worldCorners);
		RenderMode renderMode = ((Graphic)(object)skeletonGraphic).canvas.renderMode;
		Vector3 vector;
		Vector3 vector2;
		Vector3 vector3;
		Vector3 vector4;
		if ((int)renderMode == 0)
		{
			vector = worldCorners[0];
			vector2 = worldCorners[3];
			vector3 = worldCorners[1];
			vector4 = worldCorners[2];
		}
		else
		{
			vector = targetCamera.WorldToScreenPoint(worldCorners[0]);
			vector2 = targetCamera.WorldToScreenPoint(worldCorners[3]);
			vector3 = targetCamera.WorldToScreenPoint(worldCorners[1]);
			vector4 = targetCamera.WorldToScreenPoint(worldCorners[2]);
		}
		float z = (vector.z + vector2.z + vector3.z + vector4.z) / 4f;
		vector.z = (vector2.z = (vector3.z = (vector4.z = z)));
		if ((int)renderMode == 0)
		{
			worldCornerNoDistortion0 = vector;
			worldCornerNoDistortion1 = vector2;
			worldCornerNoDistortion2 = vector3;
			worldCornerNoDistortion3 = vector4;
		}
		else
		{
			worldCornerNoDistortion0 = targetCamera.ScreenToWorldPoint(vector);
			worldCornerNoDistortion1 = targetCamera.ScreenToWorldPoint(vector2);
			worldCornerNoDistortion2 = targetCamera.ScreenToWorldPoint(vector3);
			worldCornerNoDistortion3 = targetCamera.ScreenToWorldPoint(vector4);
		}
		PrepareTextureMapping(out var screenSpaceMin, out var screenSpaceMax, vector, vector2, vector3, vector4);
		PrepareCommandBuffer(targetCamera, screenSpaceMin, screenSpaceMax);
	}

	protected Material MeshRendererMaterialForTexture(Texture texture)
	{
		return meshRendererMaterialForTexture.Find((TextureMaterialPair x) => x.texture == texture).material;
	}

	protected void RenderSingleMeshToRenderTexture(Mesh mesh, Material graphicMaterial, Texture texture)
	{
		Material material = MeshRendererMaterialForTexture(texture);
		commandBuffer.DrawMesh(mesh, base.transform.localToWorldMatrix, material, 0, -1);
		Graphics.ExecuteCommandBuffer(commandBuffer);
	}

	protected void RenderMultipleMeshesToRenderTexture(int meshCount, Mesh[] meshes, Material[] graphicMaterials, Texture[] textures)
	{
		for (int i = 0; i < meshCount; i++)
		{
			Material material = MeshRendererMaterialForTexture(textures[i]);
			commandBuffer.DrawMesh(meshes[i], base.transform.localToWorldMatrix, material, 0, -1);
		}
		Graphics.ExecuteCommandBuffer(commandBuffer);
	}

	protected void SetupQuad()
	{
		quadRawImage.texture = renderTexture;
		quadRawImage.color = color;
		quadCanvasRenderer.SetColor(color);
		RectTransform rectTransform = ((Graphic)(object)skeletonGraphic).rectTransform;
		RectTransform rectTransform2 = quadRawImage.rectTransform;
		rectTransform2.anchorMin = rectTransform.anchorMin;
		rectTransform2.anchorMax = rectTransform.anchorMax;
		rectTransform2.anchoredPosition = rectTransform.anchoredPosition;
		rectTransform2.pivot = rectTransform.pivot;
		rectTransform2.localScale = rectTransform.localScale;
		rectTransform2.sizeDelta = rectTransform.sizeDelta;
		rectTransform2.rotation = rectTransform.rotation;
	}

	protected void PrepareCommandBuffer(Camera targetCamera, Vector3 screenSpaceMin, Vector3 screenSpaceMax)
	{
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		commandBuffer.Clear();
		commandBuffer.SetRenderTarget(renderTexture);
		commandBuffer.ClearRenderTarget(clearDepth: true, clearColor: true, Color.clear);
		Rect pixelRect = ((Graphic)(object)skeletonGraphic).canvas.pixelRect;
		Matrix4x4 projectionMatrix = Matrix4x4.Ortho(pixelRect.x, pixelRect.x + pixelRect.width, pixelRect.y, pixelRect.y + pixelRect.height, float.MinValue, float.MaxValue);
		if ((int)((Graphic)(object)skeletonGraphic).canvas.renderMode == 0)
		{
			commandBuffer.SetViewMatrix(Matrix4x4.identity);
			commandBuffer.SetProjectionMatrix(projectionMatrix);
		}
		else
		{
			commandBuffer.SetViewMatrix(targetCamera.worldToCameraMatrix);
			commandBuffer.SetProjectionMatrix(targetCamera.projectionMatrix);
		}
		Vector2 size = targetCamera.pixelRect.size;
		Rect viewport = new Rect(-screenSpaceMin * downScaleFactor, size * downScaleFactor);
		commandBuffer.SetViewport(viewport);
	}

	protected override void AssignMeshAtRenderer()
	{
		quadCanvasRenderer.SetMesh(quadMesh);
	}
}

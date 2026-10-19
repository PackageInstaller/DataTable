using System;
using System.Collections.Generic;
using RenderProject.Rendering.CustomSkinning;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public class MaterialOverride : MonoBehaviour
{
	public class OverrideData
	{
		public List<Material> _MatList;

		public MeshRenderer[] MeshRenderers;

		public CustomSkinRenderer[] CustomSkinRenderers;

		public MaterialPropertyBlock[] MeshRendererPropertyBlocks;

		public Mesh[] meshes;

		public Transform[] MeshTransforms;

		public SkinnedMeshRenderer[] skinnedMeshs;

		public Transform[] RootMeshTransforms;

		public Color CustomBufferColor;
	}

	public List<Material> _MatList;

	[ColorUsage(true, true)]
	public Color _CustomBufferColor = new Color(1f, 1f, 1f, 1f);

	private MeshRenderer[] m_meshRenderers;

	private SkinnedMeshRenderer[] m_skinnedMeshs;

	private List<MaterialPropertyBlock> m_blocks;

	private OverrideData localOverrideData;

	private static int DyanamicDataTag = Shader.PropertyToID("_DynamicDataBuffer");

	private static int StaticDataTag = Shader.PropertyToID("_StaticDataBuffer");

	private static int VertexBufferTag = Shader.PropertyToID("_CustomVertexBuffer");

	private static int StaticStreamOffsetTag = Shader.PropertyToID("_StaticStreamOffset");

	private static int DynamicStreamOffsetTag = Shader.PropertyToID("_DynamicStreamOffset");

	private static int CustomBufferColorTag = Shader.PropertyToID("_CustomBufferColor");

	public static List<OverrideData> _OverrideToDraw = new List<OverrideData>();

	private static GlobalKeyword OverrideKeyword;

	private static bool keywordCreat;

	public static Func<Renderer, bool> ShouldSkipRenderer;

	private void OnEnable()
	{
		m_meshRenderers = GetComponentsInChildren<MeshRenderer>();
		m_skinnedMeshs = GetComponentsInChildren<SkinnedMeshRenderer>();
		localOverrideData = new OverrideData();
		localOverrideData._MatList = _MatList;
		localOverrideData.MeshRenderers = m_meshRenderers;
		localOverrideData.skinnedMeshs = m_skinnedMeshs;
		Mesh[] array = new Mesh[localOverrideData.MeshRenderers.Length];
		Transform[] array2 = new Transform[localOverrideData.MeshRenderers.Length];
		CustomSkinRenderer[] array3 = new CustomSkinRenderer[localOverrideData.MeshRenderers.Length];
		MaterialPropertyBlock[] array4 = new MaterialPropertyBlock[localOverrideData.MeshRenderers.Length];
		Transform[] array5 = new Transform[localOverrideData.skinnedMeshs.Length];
		for (int i = 0; i < localOverrideData.skinnedMeshs.Length; i++)
		{
			Transform rootBone = localOverrideData.skinnedMeshs[i].rootBone;
			if (rootBone != null)
			{
				array5[i] = rootBone;
			}
			else
			{
				array5[i] = localOverrideData.skinnedMeshs[i].transform;
			}
		}
		localOverrideData.RootMeshTransforms = array5;
		for (int j = 0; j < localOverrideData.MeshRenderers.Length; j++)
		{
			array[j] = localOverrideData.MeshRenderers[j].GetComponent<MeshFilter>().sharedMesh;
			array2[j] = localOverrideData.MeshRenderers[j].transform;
			array3[j] = localOverrideData.MeshRenderers[j].GetComponent<CustomSkinRenderer>();
			array4[j] = new MaterialPropertyBlock();
		}
		localOverrideData.meshes = array;
		localOverrideData.MeshTransforms = array2;
		localOverrideData.CustomSkinRenderers = array3;
		localOverrideData.MeshRendererPropertyBlocks = array4;
		_OverrideToDraw.Add(localOverrideData);
	}

	private void OnDisable()
	{
		_OverrideToDraw.Remove(localOverrideData);
	}

	private void Update()
	{
		localOverrideData._MatList = _MatList;
		localOverrideData.CustomBufferColor = _CustomBufferColor;
	}

	internal static bool HasRenderableOverride()
	{
		for (int i = 0; i < _OverrideToDraw.Count; i++)
		{
			OverrideData overrideData = _OverrideToDraw[i];
			if (overrideData == null || !HasValidMaterial(overrideData._MatList))
			{
				continue;
			}
			MeshRenderer[] meshRenderers = overrideData.MeshRenderers;
			Mesh[] meshes = overrideData.meshes;
			if (meshRenderers != null && meshes != null)
			{
				int num = math.min(meshRenderers.Length, meshes.Length);
				for (int j = 0; j < num; j++)
				{
					if (CanDrawOverride(meshRenderers[j]) && meshes[j] != null)
					{
						return true;
					}
				}
			}
			SkinnedMeshRenderer[] skinnedMeshs = overrideData.skinnedMeshs;
			Transform[] rootMeshTransforms = overrideData.RootMeshTransforms;
			if (skinnedMeshs == null || rootMeshTransforms == null)
			{
				continue;
			}
			int num2 = math.min(skinnedMeshs.Length, rootMeshTransforms.Length);
			for (int k = 0; k < num2; k++)
			{
				SkinnedMeshRenderer skinnedMeshRenderer = skinnedMeshs[k];
				if (CanDrawOverride(skinnedMeshRenderer) && skinnedMeshRenderer.sharedMesh != null && rootMeshTransforms[k] != null)
				{
					return true;
				}
			}
		}
		return false;
	}

	private static bool CanDrawOverride(Renderer renderer)
	{
		if (renderer != null && renderer.enabled && renderer.isVisible)
		{
			if (ShouldSkipRenderer != null)
			{
				return !ShouldSkipRenderer(renderer);
			}
			return true;
		}
		return false;
	}

	private static bool HasValidMaterial(List<Material> materials)
	{
		if (materials == null)
		{
			return false;
		}
		for (int i = 0; i < materials.Count; i++)
		{
			if (materials[i] != null)
			{
				return true;
			}
		}
		return false;
	}

	public static void DrawOverride(CommandBuffer cmd)
	{
		if (!keywordCreat)
		{
			OverrideKeyword = GlobalKeyword.Create("_CUSTOM_OVERRIDE_MAT");
			keywordCreat = true;
		}
		foreach (OverrideData item in _OverrideToDraw)
		{
			if (item._MatList == null || item._MatList.Count <= 0)
			{
				continue;
			}
			cmd.SetGlobalVector(CustomBufferColorTag, item.CustomBufferColor);
			cmd.SetKeyword(in OverrideKeyword, value: true);
			MeshRenderer[] meshRenderers = item.MeshRenderers;
			CustomSkinRenderer[] customSkinRenderers = item.CustomSkinRenderers;
			MaterialPropertyBlock[] meshRendererPropertyBlocks = item.MeshRendererPropertyBlocks;
			SkinnedMeshRenderer[] skinnedMeshs = item.skinnedMeshs;
			List<Material> matList = item._MatList;
			for (int i = 0; i < meshRenderers.Length; i++)
			{
				if (!CanDrawOverride(meshRenderers[i]))
				{
					continue;
				}
				Mesh mesh = item.meshes[i];
				Transform transform = item.MeshTransforms[i];
				CustomSkinRenderer customSkinRenderer = ((customSkinRenderers != null && i < customSkinRenderers.Length) ? customSkinRenderers[i] : null);
				MaterialPropertyBlock materialPropertyBlock = ((meshRendererPropertyBlocks != null && i < meshRendererPropertyBlocks.Length) ? meshRendererPropertyBlocks[i] : null);
				bool flag = customSkinRenderer != null && customSkinRenderer.TryGetCurrentSkinningProperties(materialPropertyBlock);
				int subMeshCount = mesh.subMeshCount;
				foreach (Material item2 in matList)
				{
					if (item2 != null)
					{
						for (int j = 0; j < subMeshCount; j++)
						{
							cmd.DrawMesh(mesh, transform.localToWorldMatrix, item2, j, 0, flag ? materialPropertyBlock : null);
						}
					}
				}
			}
			cmd.SetKeyword(in OverrideKeyword, value: false);
			for (int k = 0; k < skinnedMeshs.Length; k++)
			{
				SkinnedMeshRenderer skinnedMeshRenderer = skinnedMeshs[k];
				if (!CanDrawOverride(skinnedMeshRenderer))
				{
					continue;
				}
				cmd.SetGlobalVector(VertexBufferTag, new Vector4(1f, 1f, 0f, 0f));
				Mesh sharedMesh = skinnedMeshRenderer.sharedMesh;
				if (sharedMesh == null)
				{
					continue;
				}
				Transform transform2 = item.RootMeshTransforms[k];
				if (transform2 == null)
				{
					continue;
				}
				Matrix4x4 matrix = Matrix4x4.TRS(transform2.position, transform2.rotation, Vector3.one);
				skinnedMeshRenderer.vertexBufferTarget |= GraphicsBuffer.Target.Raw;
				GraphicsBuffer vertexBuffer = skinnedMeshRenderer.GetVertexBuffer();
				if (vertexBuffer == null)
				{
					continue;
				}
				sharedMesh.vertexBufferTarget |= GraphicsBuffer.Target.Raw;
				int vertexAttributeStream = sharedMesh.GetVertexAttributeStream(VertexAttribute.TexCoord0);
				GraphicsBuffer vertexBuffer2 = sharedMesh.GetVertexBuffer(vertexAttributeStream);
				if (vertexBuffer2 == null)
				{
					vertexBuffer.Dispose();
					continue;
				}
				int stride = vertexBuffer2.stride;
				int vertexAttributeOffset = sharedMesh.GetVertexAttributeOffset(VertexAttribute.TexCoord0);
				int vertexAttributeOffset2 = sharedMesh.GetVertexAttributeOffset(VertexAttribute.TexCoord1);
				int vertexAttributeOffset3 = sharedMesh.GetVertexAttributeOffset(VertexAttribute.Color);
				int stride2 = vertexBuffer.stride;
				int vertexAttributeOffset4 = sharedMesh.GetVertexAttributeOffset(VertexAttribute.Normal);
				int vertexAttributeOffset5 = sharedMesh.GetVertexAttributeOffset(VertexAttribute.Tangent);
				GraphicsBuffer indexBuffer = sharedMesh.GetIndexBuffer();
				if (indexBuffer == null)
				{
					vertexBuffer.Dispose();
					vertexBuffer2.Dispose();
					continue;
				}
				int count = indexBuffer.count;
				cmd.SetGlobalBuffer(DyanamicDataTag, vertexBuffer);
				cmd.SetGlobalBuffer(StaticDataTag, vertexBuffer2);
				cmd.SetGlobalVector(StaticStreamOffsetTag, new Vector4(stride, vertexAttributeOffset, vertexAttributeOffset2, vertexAttributeOffset3));
				cmd.SetGlobalVector(DynamicStreamOffsetTag, new Vector4(stride2, vertexAttributeOffset4, vertexAttributeOffset5, 0f));
				foreach (Material item3 in matList)
				{
					if (item3 != null)
					{
						cmd.DrawProcedural(indexBuffer, matrix, item3, 0, MeshTopology.Triangles, count);
					}
				}
				vertexBuffer.Dispose();
				vertexBuffer2.Dispose();
				indexBuffer.Dispose();
			}
		}
	}
}

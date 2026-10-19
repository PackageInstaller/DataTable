using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public static class RenderingUtils
{
	public static readonly int _BlitScaleBias = Shader.PropertyToID("_BlitScaleBias");

	internal static readonly bool UsesReversedZBuffer = SystemInfo.usesReversedZBuffer;

	private static List<ShaderTagId> m_LegacyShaderPassNames = new List<ShaderTagId>
	{
		new ShaderTagId("Always"),
		new ShaderTagId("ForwardBase"),
		new ShaderTagId("PrepassBase"),
		new ShaderTagId("Vertex"),
		new ShaderTagId("VertexLMRGBM"),
		new ShaderTagId("VertexLM")
	};

	private static AttachmentDescriptor s_EmptyAttachment = new AttachmentDescriptor(GraphicsFormat.None);

	private static Mesh s_FullscreenMesh = null;

	private static MaterialPropertyBlock s_PropertyBlock = new MaterialPropertyBlock();

	private static Material s_ErrorMaterial;

	private static Dictionary<RenderTextureFormat, bool> m_RenderTextureFormatSupport = new Dictionary<RenderTextureFormat, bool>();

	private static Dictionary<GraphicsFormat, Dictionary<FormatUsage, bool>> m_GraphicsFormatSupport = new Dictionary<GraphicsFormat, Dictionary<FormatUsage, bool>>();

	internal static AttachmentDescriptor emptyAttachment => s_EmptyAttachment;

	public static Mesh fullscreenMesh
	{
		get
		{
			if (s_FullscreenMesh != null)
			{
				return s_FullscreenMesh;
			}
			float y = 1f;
			float y2 = 0f;
			s_FullscreenMesh = new Mesh
			{
				name = "Fullscreen Quad"
			};
			s_FullscreenMesh.SetVertices(new List<Vector3>
			{
				new Vector3(-1f, -1f, 0f),
				new Vector3(-1f, 1f, 0f),
				new Vector3(1f, -1f, 0f),
				new Vector3(1f, 1f, 0f)
			});
			s_FullscreenMesh.SetUVs(0, new List<Vector2>
			{
				new Vector2(0f, y2),
				new Vector2(0f, y),
				new Vector2(1f, y2),
				new Vector2(1f, y)
			});
			s_FullscreenMesh.SetIndices(new int[6] { 0, 1, 2, 2, 1, 3 }, MeshTopology.Triangles, 0, calculateBounds: false);
			s_FullscreenMesh.UploadMeshData(markNoLongerReadable: true);
			return s_FullscreenMesh;
		}
	}

	private static Material errorMaterial
	{
		get
		{
			if (s_ErrorMaterial == null)
			{
				try
				{
					s_ErrorMaterial = new Material(Shader.Find("Hidden/Universal Render Pipeline/FallbackError"));
				}
				catch
				{
				}
			}
			return s_ErrorMaterial;
		}
	}

	public static void DrawProcedural(CommandBuffer cmd, Material material, int passIndex, Vector4 scaleBiasTex)
	{
		s_PropertyBlock.SetVector(_BlitScaleBias, scaleBiasTex);
		cmd.DrawProcedural(Matrix4x4.identity, material, passIndex, MeshTopology.Triangles, 3, 1, s_PropertyBlock);
	}

	internal static bool SupportsLightLayers(GraphicsDeviceType type)
	{
		return type != GraphicsDeviceType.OpenGLES2;
	}

	public static void SetViewAndProjectionMatrices(CommandBuffer cmd, Matrix4x4 viewMatrix, Matrix4x4 projectionMatrix, bool setInverseMatrices)
	{
		Matrix4x4 value = projectionMatrix * viewMatrix;
		cmd.SetGlobalMatrix(ShaderPropertyId.viewMatrix, viewMatrix);
		cmd.SetGlobalMatrix(ShaderPropertyId.projectionMatrix, projectionMatrix);
		cmd.SetGlobalMatrix(ShaderPropertyId.viewAndProjectionMatrix, value);
		if (setInverseMatrices)
		{
			Matrix4x4 matrix4x = Matrix4x4.Inverse(viewMatrix);
			Matrix4x4 matrix4x2 = Matrix4x4.Inverse(projectionMatrix);
			Matrix4x4 value2 = matrix4x * matrix4x2;
			cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewMatrix, matrix4x);
			cmd.SetGlobalMatrix(ShaderPropertyId.inverseProjectionMatrix, matrix4x2);
			cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewAndProjectionMatrix, value2);
		}
	}

	internal static void SetScaleBiasRt(CommandBuffer cmd, in RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		CameraData cameraData = renderingData.cameraData;
		float num = ((cameraData.cameraType != CameraType.Game || !(renderer.cameraColorTarget == BuiltinRenderTextureType.CameraTarget) || !(cameraData.camera.targetTexture == null)) ? (-1f) : 1f);
		Vector4 value = ((num < 0f) ? new Vector4(num, 1f, -1f, 1f) : new Vector4(num, 0f, 1f, 1f));
		cmd.SetGlobalVector(ShaderPropertyId.scaleBiasRt, value);
	}

	internal static void Blit(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination, Material material, int passIndex = 0, bool useDrawProcedural = false, RenderBufferLoadAction colorLoadAction = RenderBufferLoadAction.Load, RenderBufferStoreAction colorStoreAction = RenderBufferStoreAction.Store, RenderBufferLoadAction depthLoadAction = RenderBufferLoadAction.Load, RenderBufferStoreAction depthStoreAction = RenderBufferStoreAction.Store)
	{
		cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, source);
		if (useDrawProcedural)
		{
			Vector4 value = new Vector4(1f, 1f, 0f, 0f);
			Vector4 value2 = new Vector4(1f, 1f, 0f, 0f);
			cmd.SetGlobalVector(ShaderPropertyId.scaleBias, value);
			cmd.SetGlobalVector(ShaderPropertyId.scaleBiasRt, value2);
			cmd.SetRenderTarget(new RenderTargetIdentifier(destination, 0, CubemapFace.Unknown, -1), colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction);
			cmd.DrawProcedural(Matrix4x4.identity, material, passIndex, MeshTopology.Quads, 4, 1, null);
		}
		else
		{
			cmd.SetRenderTarget(destination, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction);
			cmd.Blit(source, BuiltinRenderTextureType.CurrentActive, material, passIndex);
		}
	}

	[Conditional("UNITY_EDITOR")]
	[Conditional("DEVELOPMENT_BUILD")]
	internal static void RenderObjectsWithError(ScriptableRenderContext context, ref CullingResults cullResults, Camera camera, FilteringSettings filterSettings, SortingCriteria sortFlags)
	{
		if (!(errorMaterial == null))
		{
			SortingSettings sortingSettings = new SortingSettings(camera);
			sortingSettings.criteria = sortFlags;
			SortingSettings sortingSettings2 = sortingSettings;
			DrawingSettings drawingSettings = new DrawingSettings(m_LegacyShaderPassNames[0], sortingSettings2);
			drawingSettings.perObjectData = PerObjectData.None;
			drawingSettings.overrideMaterial = errorMaterial;
			drawingSettings.overrideMaterialPassIndex = 0;
			DrawingSettings drawingSettings2 = drawingSettings;
			for (int i = 1; i < m_LegacyShaderPassNames.Count; i++)
			{
				drawingSettings2.SetShaderPassName(i, m_LegacyShaderPassNames[i]);
			}
			context.DrawRenderers(cullResults, ref drawingSettings2, ref filterSettings);
		}
	}

	internal static void ClearSystemInfoCache()
	{
		m_RenderTextureFormatSupport.Clear();
		m_GraphicsFormatSupport.Clear();
	}

	public static bool SupportsRenderTextureFormat(RenderTextureFormat format)
	{
		if (!m_RenderTextureFormatSupport.TryGetValue(format, out var value))
		{
			value = SystemInfo.SupportsRenderTextureFormat(format);
			m_RenderTextureFormatSupport.Add(format, value);
		}
		return value;
	}

	public static bool SupportsGraphicsFormat(GraphicsFormat format, FormatUsage usage)
	{
		bool value = false;
		if (!m_GraphicsFormatSupport.TryGetValue(format, out var value2))
		{
			value2 = new Dictionary<FormatUsage, bool>();
			value = SystemInfo.IsFormatSupported(format, usage);
			value2.Add(usage, value);
			m_GraphicsFormatSupport.Add(format, value2);
		}
		else if (!value2.TryGetValue(usage, out value))
		{
			value = SystemInfo.IsFormatSupported(format, usage);
			value2.Add(usage, value);
		}
		return value;
	}

	internal static int GetLastValidColorBufferIndex(RenderTargetIdentifier[] colorBuffers)
	{
		int num = colorBuffers.Length - 1;
		while (num >= 0 && !(colorBuffers[num] != 0))
		{
			num--;
		}
		return num;
	}

	internal static uint GetValidColorBufferCount(RenderTargetIdentifier[] colorBuffers)
	{
		uint num = 0u;
		if (colorBuffers != null)
		{
			for (int i = 0; i < colorBuffers.Length; i++)
			{
				if (colorBuffers[i] != 0)
				{
					num++;
				}
			}
		}
		return num;
	}

	internal static bool IsMRT(RenderTargetIdentifier[] colorBuffers)
	{
		return GetValidColorBufferCount(colorBuffers) > 1;
	}

	internal static bool Contains(RenderTargetIdentifier[] source, RenderTargetIdentifier value)
	{
		for (int i = 0; i < source.Length; i++)
		{
			if (source[i] == value)
			{
				return true;
			}
		}
		return false;
	}

	internal static int IndexOf(RenderTargetIdentifier[] source, RenderTargetIdentifier value)
	{
		for (int i = 0; i < source.Length; i++)
		{
			if (source[i] == value)
			{
				return i;
			}
		}
		return -1;
	}

	internal static uint CountDistinct(RenderTargetIdentifier[] source, RenderTargetIdentifier value)
	{
		uint num = 0u;
		for (int i = 0; i < source.Length; i++)
		{
			if (source[i] != value && source[i] != 0)
			{
				num++;
			}
		}
		return num;
	}

	internal static int LastValid(RenderTargetIdentifier[] source)
	{
		for (int num = source.Length - 1; num >= 0; num--)
		{
			if (source[num] != 0)
			{
				return num;
			}
		}
		return -1;
	}

	internal static bool Contains(ClearFlag a, ClearFlag b)
	{
		return (a & b) == b;
	}

	internal static bool SequenceEqual(RenderTargetIdentifier[] left, RenderTargetIdentifier[] right)
	{
		if (left.Length != right.Length)
		{
			return false;
		}
		for (int i = 0; i < left.Length; i++)
		{
			if (left[i] != right[i])
			{
				return false;
			}
		}
		return true;
	}
}

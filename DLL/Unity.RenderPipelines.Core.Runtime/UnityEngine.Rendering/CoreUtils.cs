using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Rendering;

public static class CoreUtils
{
	public static class Sections
	{
		public const int section1 = 10000;

		public const int section2 = 20000;

		public const int section3 = 30000;

		public const int section4 = 40000;

		public const int section5 = 50000;

		public const int section6 = 60000;

		public const int section7 = 70000;

		public const int section8 = 80000;
	}

	public static class Priorities
	{
		public const int assetsCreateShaderMenuPriority = 83;

		public const int assetsCreateRenderingMenuPriority = 308;

		public const int editMenuPriority = 320;

		public const int gameObjectMenuPriority = 10;

		public const int srpLensFlareMenuPriority = 303;
	}

	public static readonly Vector3[] lookAtList = new Vector3[6]
	{
		new Vector3(1f, 0f, 0f),
		new Vector3(-1f, 0f, 0f),
		new Vector3(0f, 1f, 0f),
		new Vector3(0f, -1f, 0f),
		new Vector3(0f, 0f, 1f),
		new Vector3(0f, 0f, -1f)
	};

	public static readonly Vector3[] upVectorList = new Vector3[6]
	{
		new Vector3(0f, 1f, 0f),
		new Vector3(0f, 1f, 0f),
		new Vector3(0f, 0f, -1f),
		new Vector3(0f, 0f, 1f),
		new Vector3(0f, 1f, 0f),
		new Vector3(0f, 1f, 0f)
	};

	private const string obsoletePriorityMessage = "Use CoreUtils.Priorities instead";

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int editMenuPriority1 = 320;

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int editMenuPriority2 = 331;

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int editMenuPriority3 = 342;

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int editMenuPriority4 = 353;

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int assetCreateMenuPriority1 = 230;

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int assetCreateMenuPriority2 = 241;

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int assetCreateMenuPriority3 = 300;

	[Obsolete("Use CoreUtils.Priorities instead", false)]
	public const int gameObjectMenuPriority = 10;

	private static Cubemap m_BlackCubeTexture;

	private static Cubemap m_MagentaCubeTexture;

	private static CubemapArray m_MagentaCubeTextureArray;

	private static Cubemap m_WhiteCubeTexture;

	private static RenderTexture m_EmptyUAV;

	private static Texture3D m_BlackVolumeTexture;

	private static IEnumerable<Type> m_AssemblyTypes;

	public static Cubemap blackCubeTexture
	{
		get
		{
			if (m_BlackCubeTexture == null)
			{
				m_BlackCubeTexture = new Cubemap(1, GraphicsFormat.R8G8B8A8_SRGB, TextureCreationFlags.None);
				for (int i = 0; i < 6; i++)
				{
					m_BlackCubeTexture.SetPixel((CubemapFace)i, 0, 0, Color.black);
				}
				m_BlackCubeTexture.Apply();
			}
			return m_BlackCubeTexture;
		}
	}

	public static Cubemap magentaCubeTexture
	{
		get
		{
			if (m_MagentaCubeTexture == null)
			{
				m_MagentaCubeTexture = new Cubemap(1, GraphicsFormat.R8G8B8A8_SRGB, TextureCreationFlags.None);
				for (int i = 0; i < 6; i++)
				{
					m_MagentaCubeTexture.SetPixel((CubemapFace)i, 0, 0, Color.magenta);
				}
				m_MagentaCubeTexture.Apply();
			}
			return m_MagentaCubeTexture;
		}
	}

	public static CubemapArray magentaCubeTextureArray
	{
		get
		{
			if (m_MagentaCubeTextureArray == null)
			{
				m_MagentaCubeTextureArray = new CubemapArray(1, 1, GraphicsFormat.R32G32B32A32_SFloat, TextureCreationFlags.None);
				for (int i = 0; i < 6; i++)
				{
					Color[] colors = new Color[1] { Color.magenta };
					m_MagentaCubeTextureArray.SetPixels(colors, (CubemapFace)i, 0);
				}
				m_MagentaCubeTextureArray.Apply();
			}
			return m_MagentaCubeTextureArray;
		}
	}

	public static Cubemap whiteCubeTexture
	{
		get
		{
			if (m_WhiteCubeTexture == null)
			{
				m_WhiteCubeTexture = new Cubemap(1, GraphicsFormat.R8G8B8A8_SRGB, TextureCreationFlags.None);
				for (int i = 0; i < 6; i++)
				{
					m_WhiteCubeTexture.SetPixel((CubemapFace)i, 0, 0, Color.white);
				}
				m_WhiteCubeTexture.Apply();
			}
			return m_WhiteCubeTexture;
		}
	}

	public static RenderTexture emptyUAV
	{
		get
		{
			if (m_EmptyUAV == null)
			{
				m_EmptyUAV = new RenderTexture(1, 1, 0);
				m_EmptyUAV.enableRandomWrite = true;
				m_EmptyUAV.Create();
			}
			return m_EmptyUAV;
		}
	}

	public static Texture3D blackVolumeTexture
	{
		get
		{
			if (m_BlackVolumeTexture == null)
			{
				Color[] colors = new Color[1] { Color.black };
				m_BlackVolumeTexture = new Texture3D(1, 1, 1, GraphicsFormat.R8G8B8A8_SRGB, TextureCreationFlags.None);
				m_BlackVolumeTexture.SetPixels(colors, 0);
				m_BlackVolumeTexture.Apply();
			}
			return m_BlackVolumeTexture;
		}
	}

	public static void ClearRenderTarget(CommandBuffer cmd, ClearFlag clearFlag, Color clearColor)
	{
		if (clearFlag != ClearFlag.None)
		{
			cmd.ClearRenderTarget((RTClearFlags)clearFlag, clearColor, 1f, 0u);
		}
	}

	private static int FixupDepthSlice(int depthSlice, RTHandle buffer)
	{
		if (depthSlice == -1)
		{
			RenderTexture rt = buffer.rt;
			if ((object)rt != null && rt.dimension == TextureDimension.Cube)
			{
				depthSlice = 0;
			}
		}
		return depthSlice;
	}

	private static int FixupDepthSlice(int depthSlice, CubemapFace cubemapFace)
	{
		if (depthSlice == -1 && cubemapFace != CubemapFace.Unknown)
		{
			depthSlice = 0;
		}
		return depthSlice;
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier buffer, ClearFlag clearFlag, Color clearColor, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		depthSlice = FixupDepthSlice(depthSlice, cubemapFace);
		cmd.SetRenderTarget(buffer, miplevel, cubemapFace, depthSlice);
		ClearRenderTarget(cmd, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier buffer, ClearFlag clearFlag = ClearFlag.None, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		SetRenderTarget(cmd, buffer, clearFlag, Color.clear, miplevel, cubemapFace, depthSlice);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorBuffer, RenderTargetIdentifier depthBuffer, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		SetRenderTarget(cmd, colorBuffer, depthBuffer, ClearFlag.None, Color.clear, miplevel, cubemapFace, depthSlice);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorBuffer, RenderTargetIdentifier depthBuffer, ClearFlag clearFlag, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		SetRenderTarget(cmd, colorBuffer, depthBuffer, clearFlag, Color.clear, miplevel, cubemapFace, depthSlice);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorBuffer, RenderTargetIdentifier depthBuffer, ClearFlag clearFlag, Color clearColor, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		depthSlice = FixupDepthSlice(depthSlice, cubemapFace);
		cmd.SetRenderTarget(colorBuffer, depthBuffer, miplevel, cubemapFace, depthSlice);
		ClearRenderTarget(cmd, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorBuffers, RenderTargetIdentifier depthBuffer)
	{
		SetRenderTarget(cmd, colorBuffers, depthBuffer, ClearFlag.None, Color.clear);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorBuffers, RenderTargetIdentifier depthBuffer, ClearFlag clearFlag = ClearFlag.None)
	{
		SetRenderTarget(cmd, colorBuffers, depthBuffer, clearFlag, Color.clear);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorBuffers, RenderTargetIdentifier depthBuffer, ClearFlag clearFlag, Color clearColor)
	{
		cmd.SetRenderTarget(colorBuffers, depthBuffer, 0, CubemapFace.Unknown, -1);
		ClearRenderTarget(cmd, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier buffer, RenderBufferLoadAction loadAction, RenderBufferStoreAction storeAction, ClearFlag clearFlag, Color clearColor)
	{
		cmd.SetRenderTarget(buffer, loadAction, storeAction);
		ClearRenderTarget(cmd, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier buffer, RenderBufferLoadAction loadAction, RenderBufferStoreAction storeAction, ClearFlag clearFlag)
	{
		SetRenderTarget(cmd, buffer, loadAction, storeAction, clearFlag, Color.clear);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorBuffer, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderTargetIdentifier depthBuffer, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, ClearFlag clearFlag, Color clearColor)
	{
		cmd.SetRenderTarget(colorBuffer, colorLoadAction, colorStoreAction, depthBuffer, depthLoadAction, depthStoreAction);
		ClearRenderTarget(cmd, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier buffer, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, ClearFlag clearFlag, Color clearColor)
	{
		cmd.SetRenderTarget(buffer, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction);
		ClearRenderTarget(cmd, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorBuffer, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderTargetIdentifier depthBuffer, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, ClearFlag clearFlag)
	{
		SetRenderTarget(cmd, colorBuffer, colorLoadAction, colorStoreAction, depthBuffer, depthLoadAction, depthStoreAction, clearFlag, Color.clear);
	}

	private static void SetViewportAndClear(CommandBuffer cmd, RTHandle buffer, ClearFlag clearFlag, Color clearColor)
	{
		SetViewport(cmd, buffer);
		ClearRenderTarget(cmd, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RTHandle buffer, ClearFlag clearFlag, Color clearColor, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		depthSlice = FixupDepthSlice(depthSlice, buffer);
		cmd.SetRenderTarget(buffer, miplevel, cubemapFace, depthSlice);
		SetViewportAndClear(cmd, buffer, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RTHandle buffer, ClearFlag clearFlag = ClearFlag.None, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		SetRenderTarget(cmd, buffer, clearFlag, Color.clear, miplevel, cubemapFace, depthSlice);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RTHandle colorBuffer, RTHandle depthBuffer, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		_ = colorBuffer.rt.width;
		_ = colorBuffer.rt.height;
		_ = depthBuffer.rt.width;
		_ = depthBuffer.rt.height;
		SetRenderTarget(cmd, colorBuffer, depthBuffer, ClearFlag.None, Color.clear, miplevel, cubemapFace, depthSlice);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RTHandle colorBuffer, RTHandle depthBuffer, ClearFlag clearFlag, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		_ = colorBuffer.rt.width;
		_ = colorBuffer.rt.height;
		_ = depthBuffer.rt.width;
		_ = depthBuffer.rt.height;
		SetRenderTarget(cmd, colorBuffer, depthBuffer, clearFlag, Color.clear, miplevel, cubemapFace, depthSlice);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RTHandle colorBuffer, RTHandle depthBuffer, ClearFlag clearFlag, Color clearColor, int miplevel = 0, CubemapFace cubemapFace = CubemapFace.Unknown, int depthSlice = -1)
	{
		_ = colorBuffer.rt.width;
		_ = colorBuffer.rt.height;
		_ = depthBuffer.rt.width;
		_ = depthBuffer.rt.height;
		SetRenderTarget(cmd, colorBuffer.rt, depthBuffer.rt, miplevel, cubemapFace, depthSlice);
		SetViewportAndClear(cmd, colorBuffer, clearFlag, clearColor);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorBuffers, RTHandle depthBuffer)
	{
		SetRenderTarget(cmd, colorBuffers, depthBuffer.rt, ClearFlag.None, Color.clear);
		SetViewport(cmd, depthBuffer);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorBuffers, RTHandle depthBuffer, ClearFlag clearFlag = ClearFlag.None)
	{
		SetRenderTarget(cmd, colorBuffers, depthBuffer.rt);
		SetViewportAndClear(cmd, depthBuffer, clearFlag, Color.clear);
	}

	public static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorBuffers, RTHandle depthBuffer, ClearFlag clearFlag, Color clearColor)
	{
		cmd.SetRenderTarget(colorBuffers, depthBuffer, 0, CubemapFace.Unknown, -1);
		SetViewportAndClear(cmd, depthBuffer, clearFlag, clearColor);
	}

	public static void SetViewport(CommandBuffer cmd, RTHandle target)
	{
		if (target.useScaling)
		{
			Vector2Int scaledSize = target.GetScaledSize(target.rtHandleProperties.currentViewportSize);
			cmd.SetViewport(new Rect(0f, 0f, scaledSize.x, scaledSize.y));
		}
	}

	public static string GetRenderTargetAutoName(int width, int height, int depth, RenderTextureFormat format, string name, bool mips = false, bool enableMSAA = false, MSAASamples msaaSamples = MSAASamples.None)
	{
		return GetRenderTargetAutoName(width, height, depth, format.ToString(), TextureDimension.None, name, mips, enableMSAA, msaaSamples, dynamicRes: false);
	}

	public static string GetRenderTargetAutoName(int width, int height, int depth, GraphicsFormat format, string name, bool mips = false, bool enableMSAA = false, MSAASamples msaaSamples = MSAASamples.None)
	{
		return GetRenderTargetAutoName(width, height, depth, format.ToString(), TextureDimension.None, name, mips, enableMSAA, msaaSamples, dynamicRes: false);
	}

	public static string GetRenderTargetAutoName(int width, int height, int depth, GraphicsFormat format, TextureDimension dim, string name, bool mips = false, bool enableMSAA = false, MSAASamples msaaSamples = MSAASamples.None, bool dynamicRes = false)
	{
		return GetRenderTargetAutoName(width, height, depth, format.ToString(), dim, name, mips, enableMSAA, msaaSamples, dynamicRes);
	}

	private static string GetRenderTargetAutoName(int width, int height, int depth, string format, TextureDimension dim, string name, bool mips, bool enableMSAA, MSAASamples msaaSamples, bool dynamicRes)
	{
		string arg = $"{name}_{width}x{height}";
		if (depth > 1)
		{
			arg = $"{arg}x{depth}";
		}
		if (mips)
		{
			arg = string.Format("{0}_{1}", arg, "Mips");
		}
		arg = $"{arg}_{format}";
		if (dim != TextureDimension.None)
		{
			arg = $"{arg}_{dim}";
		}
		if (enableMSAA)
		{
			arg = $"{arg}_{msaaSamples.ToString()}";
		}
		if (dynamicRes)
		{
			arg = string.Format("{0}_{1}", arg, "dynamic");
		}
		return arg;
	}

	public static string GetTextureAutoName(int width, int height, TextureFormat format, TextureDimension dim = TextureDimension.None, string name = "", bool mips = false, int depth = 0)
	{
		return GetTextureAutoName(width, height, format.ToString(), dim, name, mips, depth);
	}

	public static string GetTextureAutoName(int width, int height, GraphicsFormat format, TextureDimension dim = TextureDimension.None, string name = "", bool mips = false, int depth = 0)
	{
		return GetTextureAutoName(width, height, format.ToString(), dim, name, mips, depth);
	}

	private static string GetTextureAutoName(int width, int height, string format, TextureDimension dim = TextureDimension.None, string name = "", bool mips = false, int depth = 0)
	{
		return string.Format(arg2: (depth != 0) ? string.Format("{0}x{1}x{2}{3}_{4}", width, height, depth, mips ? "_Mips" : "", format) : string.Format("{0}x{1}{2}_{3}", width, height, mips ? "_Mips" : "", format), format: "{0}_{1}_{2}", arg0: (name == "") ? "Texture" : name, arg1: (dim == TextureDimension.None) ? "" : dim.ToString());
	}

	public static void ClearCubemap(CommandBuffer cmd, RenderTexture renderTexture, Color clearColor, bool clearMips = false)
	{
		int num = 1;
		if (renderTexture.useMipMap & clearMips)
		{
			num = (int)Mathf.Log(renderTexture.width, 2f) + 1;
		}
		for (int i = 0; i < 6; i++)
		{
			for (int j = 0; j < num; j++)
			{
				SetRenderTarget(cmd, new RenderTargetIdentifier(renderTexture), ClearFlag.Color, clearColor, j, (CubemapFace)i);
			}
		}
	}

	public static void DrawFullScreen(CommandBuffer commandBuffer, Material material, MaterialPropertyBlock properties = null, int shaderPassId = 0)
	{
		commandBuffer.DrawProcedural(Matrix4x4.identity, material, shaderPassId, MeshTopology.Triangles, 3, 1, properties);
	}

	public static void DrawFullScreen(CommandBuffer commandBuffer, Material material, RenderTargetIdentifier colorBuffer, MaterialPropertyBlock properties = null, int shaderPassId = 0)
	{
		commandBuffer.SetRenderTarget(colorBuffer, 0, CubemapFace.Unknown, -1);
		commandBuffer.DrawProcedural(Matrix4x4.identity, material, shaderPassId, MeshTopology.Triangles, 3, 1, properties);
	}

	public static void DrawFullScreen(CommandBuffer commandBuffer, Material material, RenderTargetIdentifier colorBuffer, RenderTargetIdentifier depthStencilBuffer, MaterialPropertyBlock properties = null, int shaderPassId = 0)
	{
		commandBuffer.SetRenderTarget(colorBuffer, depthStencilBuffer, 0, CubemapFace.Unknown, -1);
		commandBuffer.DrawProcedural(Matrix4x4.identity, material, shaderPassId, MeshTopology.Triangles, 3, 1, properties);
	}

	public static void DrawFullScreen(CommandBuffer commandBuffer, Material material, RenderTargetIdentifier[] colorBuffers, RenderTargetIdentifier depthStencilBuffer, MaterialPropertyBlock properties = null, int shaderPassId = 0)
	{
		commandBuffer.SetRenderTarget(colorBuffers, depthStencilBuffer, 0, CubemapFace.Unknown, -1);
		commandBuffer.DrawProcedural(Matrix4x4.identity, material, shaderPassId, MeshTopology.Triangles, 3, 1, properties);
	}

	public static void DrawFullScreen(CommandBuffer commandBuffer, Material material, RenderTargetIdentifier[] colorBuffers, MaterialPropertyBlock properties = null, int shaderPassId = 0)
	{
		DrawFullScreen(commandBuffer, material, colorBuffers, colorBuffers[0], properties, shaderPassId);
	}

	public static Color ConvertSRGBToActiveColorSpace(Color color)
	{
		if (QualitySettings.activeColorSpace != ColorSpace.Linear)
		{
			return color;
		}
		return color.linear;
	}

	public static Color ConvertLinearToActiveColorSpace(Color color)
	{
		if (QualitySettings.activeColorSpace != ColorSpace.Linear)
		{
			return color.gamma;
		}
		return color;
	}

	public static Material CreateEngineMaterial(string shaderPath)
	{
		Shader shader = Shader.Find(shaderPath);
		if (shader == null)
		{
			Debug.LogError("Cannot create required material because shader " + shaderPath + " could not be found");
			return null;
		}
		return new Material(shader)
		{
			hideFlags = HideFlags.HideAndDontSave
		};
	}

	public static Material CreateEngineMaterial(Shader shader)
	{
		if (shader == null)
		{
			Debug.LogError("Cannot create required material because shader is null");
			return null;
		}
		return new Material(shader)
		{
			hideFlags = HideFlags.HideAndDontSave
		};
	}

	public static bool HasFlag<T>(T mask, T flag) where T : IConvertible
	{
		return (mask.ToUInt32(null) & flag.ToUInt32(null)) != 0;
	}

	public static void Swap<T>(ref T a, ref T b)
	{
		T val = a;
		a = b;
		b = val;
	}

	public static void SetKeyword(CommandBuffer cmd, string keyword, bool state)
	{
		if (state)
		{
			cmd.EnableShaderKeyword(keyword);
		}
		else
		{
			cmd.DisableShaderKeyword(keyword);
		}
	}

	public static void SetKeyword(Material material, string keyword, bool state)
	{
		if (state)
		{
			material.EnableKeyword(keyword);
		}
		else
		{
			material.DisableKeyword(keyword);
		}
	}

	public static void SetKeyword(ComputeShader cs, string keyword, bool state)
	{
		if (state)
		{
			cs.EnableKeyword(keyword);
		}
		else
		{
			cs.DisableKeyword(keyword);
		}
	}

	public static void Destroy(Object obj)
	{
		if (obj != null)
		{
			Object.Destroy(obj);
		}
	}

	public static IEnumerable<Type> GetAllAssemblyTypes()
	{
		if (m_AssemblyTypes == null)
		{
			m_AssemblyTypes = AppDomain.CurrentDomain.GetAssemblies().SelectMany(delegate(Assembly t)
			{
				Type[] result = new Type[0];
				try
				{
					result = t.GetTypes();
				}
				catch
				{
				}
				return result;
			});
		}
		return m_AssemblyTypes;
	}

	public static IEnumerable<Type> GetAllTypesDerivedFrom<T>()
	{
		return from t in GetAllAssemblyTypes()
			where t.IsSubclassOf(typeof(T))
			select t;
	}

	public static void SafeRelease(ComputeBuffer buffer)
	{
		buffer?.Release();
	}

	public static Mesh CreateCubeMesh(Vector3 min, Vector3 max)
	{
		return new Mesh
		{
			vertices = new Vector3[8]
			{
				new Vector3(min.x, min.y, min.z),
				new Vector3(max.x, min.y, min.z),
				new Vector3(max.x, max.y, min.z),
				new Vector3(min.x, max.y, min.z),
				new Vector3(min.x, min.y, max.z),
				new Vector3(max.x, min.y, max.z),
				new Vector3(max.x, max.y, max.z),
				new Vector3(min.x, max.y, max.z)
			},
			triangles = new int[36]
			{
				0, 2, 1, 0, 3, 2, 1, 6, 5, 1,
				2, 6, 5, 7, 4, 5, 6, 7, 4, 3,
				0, 4, 7, 3, 3, 6, 2, 3, 7, 6,
				4, 1, 5, 4, 0, 1
			}
		};
	}

	public static bool ArePostProcessesEnabled(Camera camera)
	{
		return true;
	}

	public static bool AreAnimatedMaterialsEnabled(Camera camera)
	{
		return true;
	}

	public static bool IsSceneLightingDisabled(Camera camera)
	{
		return false;
	}

	public static bool IsLightOverlapDebugEnabled(Camera camera)
	{
		return false;
	}

	public static bool IsSceneViewFogEnabled(Camera camera)
	{
		return true;
	}

	public static bool IsSceneFilteringEnabled()
	{
		return false;
	}

	public static bool IsSceneViewPrefabStageContextHidden()
	{
		return false;
	}

	[Obsolete("Use the updated RendererList API in the UnityEngine.Rendering.RendererUtils namespace.")]
	public static void DrawRendererList(ScriptableRenderContext renderContext, CommandBuffer cmd, UnityEngine.Experimental.Rendering.RendererList rendererList)
	{
		if (!rendererList.isValid)
		{
			throw new ArgumentException("Invalid renderer list provided to DrawRendererList");
		}
		renderContext.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		if (!rendererList.stateBlock.HasValue)
		{
			renderContext.DrawRenderers(rendererList.cullingResult, ref rendererList.drawSettings, ref rendererList.filteringSettings);
			return;
		}
		RenderStateBlock stateBlock = rendererList.stateBlock.Value;
		renderContext.DrawRenderers(rendererList.cullingResult, ref rendererList.drawSettings, ref rendererList.filteringSettings, ref stateBlock);
	}

	public static void DrawRendererList(ScriptableRenderContext renderContext, CommandBuffer cmd, UnityEngine.Rendering.RendererUtils.RendererList rendererList)
	{
		if (!rendererList.isValid)
		{
			throw new ArgumentException("Invalid renderer list provided to DrawRendererList");
		}
		cmd.DrawRendererList(rendererList);
	}

	public static int GetTextureHash(Texture texture)
	{
		int hashCode = texture.GetHashCode();
		hashCode = 23 * hashCode + texture.GetInstanceID().GetHashCode();
		hashCode = 23 * hashCode + texture.graphicsFormat.GetHashCode();
		hashCode = 23 * hashCode + texture.wrapMode.GetHashCode();
		hashCode = 23 * hashCode + texture.width.GetHashCode();
		hashCode = 23 * hashCode + texture.height.GetHashCode();
		hashCode = 23 * hashCode + texture.filterMode.GetHashCode();
		hashCode = 23 * hashCode + texture.anisoLevel.GetHashCode();
		hashCode = 23 * hashCode + texture.mipmapCount.GetHashCode();
		return 23 * hashCode + texture.updateCount.GetHashCode();
	}

	public static int PreviousPowerOfTwo(int size)
	{
		if (size <= 0)
		{
			return 0;
		}
		size |= size >> 1;
		size |= size >> 2;
		size |= size >> 4;
		size |= size >> 8;
		size |= size >> 16;
		return size - (size >> 1);
	}

	public static T GetLastEnumValue<T>() where T : Enum
	{
		return typeof(T).GetEnumValues().Cast<T>().Last();
	}

	internal static string GetCorePath()
	{
		return "Packages/com.unity.render-pipelines.core/";
	}
}

using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

public class UnityEngine_SystemInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SystemInfo), typeof(object));
		L.RegFunction("SupportsRenderTextureFormat", SupportsRenderTextureFormat);
		L.RegFunction("SupportsBlendingOnRenderTextureFormat", SupportsBlendingOnRenderTextureFormat);
		L.RegFunction("SupportsRandomWriteOnRenderTextureFormat", SupportsRandomWriteOnRenderTextureFormat);
		L.RegFunction("SupportsTextureFormat", SupportsTextureFormat);
		L.RegFunction("SupportsVertexAttributeFormat", SupportsVertexAttributeFormat);
		L.RegFunction("IsFormatSupported", IsFormatSupported);
		L.RegFunction("GetCompatibleFormat", GetCompatibleFormat);
		L.RegFunction("GetGraphicsFormat", GetGraphicsFormat);
		L.RegFunction("GetRenderTextureSupportedMSAASampleCount", GetRenderTextureSupportedMSAASampleCount);
		L.RegFunction("New", _CreateUnityEngine_SystemInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("unsupportedIdentifier", get_unsupportedIdentifier, null);
		L.RegVar("batteryLevel", get_batteryLevel, null);
		L.RegVar("batteryStatus", get_batteryStatus, null);
		L.RegVar("operatingSystem", get_operatingSystem, null);
		L.RegVar("operatingSystemFamily", get_operatingSystemFamily, null);
		L.RegVar("processorType", get_processorType, null);
		L.RegVar("processorFrequency", get_processorFrequency, null);
		L.RegVar("processorCount", get_processorCount, null);
		L.RegVar("systemMemorySize", get_systemMemorySize, null);
		L.RegVar("deviceUniqueIdentifier", get_deviceUniqueIdentifier, null);
		L.RegVar("deviceName", get_deviceName, null);
		L.RegVar("deviceModel", get_deviceModel, null);
		L.RegVar("supportsAccelerometer", get_supportsAccelerometer, null);
		L.RegVar("supportsGyroscope", get_supportsGyroscope, null);
		L.RegVar("supportsLocationService", get_supportsLocationService, null);
		L.RegVar("supportsVibration", get_supportsVibration, null);
		L.RegVar("supportsAudio", get_supportsAudio, null);
		L.RegVar("deviceType", get_deviceType, null);
		L.RegVar("graphicsMemorySize", get_graphicsMemorySize, null);
		L.RegVar("graphicsDeviceName", get_graphicsDeviceName, null);
		L.RegVar("graphicsDeviceVendor", get_graphicsDeviceVendor, null);
		L.RegVar("graphicsDeviceID", get_graphicsDeviceID, null);
		L.RegVar("graphicsDeviceVendorID", get_graphicsDeviceVendorID, null);
		L.RegVar("graphicsDeviceType", get_graphicsDeviceType, null);
		L.RegVar("graphicsUVStartsAtTop", get_graphicsUVStartsAtTop, null);
		L.RegVar("graphicsDeviceVersion", get_graphicsDeviceVersion, null);
		L.RegVar("graphicsShaderLevel", get_graphicsShaderLevel, null);
		L.RegVar("graphicsMultiThreaded", get_graphicsMultiThreaded, null);
		L.RegVar("renderingThreadingMode", get_renderingThreadingMode, null);
		L.RegVar("hasHiddenSurfaceRemovalOnGPU", get_hasHiddenSurfaceRemovalOnGPU, null);
		L.RegVar("hasDynamicUniformArrayIndexingInFragmentShaders", get_hasDynamicUniformArrayIndexingInFragmentShaders, null);
		L.RegVar("supportsShadows", get_supportsShadows, null);
		L.RegVar("supportsRawShadowDepthSampling", get_supportsRawShadowDepthSampling, null);
		L.RegVar("supportsMotionVectors", get_supportsMotionVectors, null);
		L.RegVar("supports3DTextures", get_supports3DTextures, null);
		L.RegVar("supportsCompressed3DTextures", get_supportsCompressed3DTextures, null);
		L.RegVar("supports2DArrayTextures", get_supports2DArrayTextures, null);
		L.RegVar("supports3DRenderTextures", get_supports3DRenderTextures, null);
		L.RegVar("supportsCubemapArrayTextures", get_supportsCubemapArrayTextures, null);
		L.RegVar("copyTextureSupport", get_copyTextureSupport, null);
		L.RegVar("supportsComputeShaders", get_supportsComputeShaders, null);
		L.RegVar("supportsGeometryShaders", get_supportsGeometryShaders, null);
		L.RegVar("supportsTessellationShaders", get_supportsTessellationShaders, null);
		L.RegVar("supportsRenderTargetArrayIndexFromVertexShader", get_supportsRenderTargetArrayIndexFromVertexShader, null);
		L.RegVar("supportsInstancing", get_supportsInstancing, null);
		L.RegVar("supportsHardwareQuadTopology", get_supportsHardwareQuadTopology, null);
		L.RegVar("supports32bitsIndexBuffer", get_supports32bitsIndexBuffer, null);
		L.RegVar("supportsSparseTextures", get_supportsSparseTextures, null);
		L.RegVar("supportedRenderTargetCount", get_supportedRenderTargetCount, null);
		L.RegVar("supportsSeparatedRenderTargetsBlend", get_supportsSeparatedRenderTargetsBlend, null);
		L.RegVar("supportedRandomWriteTargetCount", get_supportedRandomWriteTargetCount, null);
		L.RegVar("supportsMultisampledTextures", get_supportsMultisampledTextures, null);
		L.RegVar("supportsMultisampled2DArrayTextures", get_supportsMultisampled2DArrayTextures, null);
		L.RegVar("supportsMultisampleAutoResolve", get_supportsMultisampleAutoResolve, null);
		L.RegVar("supportsTextureWrapMirrorOnce", get_supportsTextureWrapMirrorOnce, null);
		L.RegVar("usesReversedZBuffer", get_usesReversedZBuffer, null);
		L.RegVar("npotSupport", get_npotSupport, null);
		L.RegVar("maxTextureSize", get_maxTextureSize, null);
		L.RegVar("maxCubemapSize", get_maxCubemapSize, null);
		L.RegVar("maxComputeBufferInputsVertex", get_maxComputeBufferInputsVertex, null);
		L.RegVar("maxComputeBufferInputsFragment", get_maxComputeBufferInputsFragment, null);
		L.RegVar("maxComputeBufferInputsGeometry", get_maxComputeBufferInputsGeometry, null);
		L.RegVar("maxComputeBufferInputsDomain", get_maxComputeBufferInputsDomain, null);
		L.RegVar("maxComputeBufferInputsHull", get_maxComputeBufferInputsHull, null);
		L.RegVar("maxComputeBufferInputsCompute", get_maxComputeBufferInputsCompute, null);
		L.RegVar("maxComputeWorkGroupSize", get_maxComputeWorkGroupSize, null);
		L.RegVar("maxComputeWorkGroupSizeX", get_maxComputeWorkGroupSizeX, null);
		L.RegVar("maxComputeWorkGroupSizeY", get_maxComputeWorkGroupSizeY, null);
		L.RegVar("maxComputeWorkGroupSizeZ", get_maxComputeWorkGroupSizeZ, null);
		L.RegVar("supportsAsyncCompute", get_supportsAsyncCompute, null);
		L.RegVar("supportsGpuRecorder", get_supportsGpuRecorder, null);
		L.RegVar("supportsGraphicsFence", get_supportsGraphicsFence, null);
		L.RegVar("supportsAsyncGPUReadback", get_supportsAsyncGPUReadback, null);
		L.RegVar("supportsRayTracing", get_supportsRayTracing, null);
		L.RegVar("supportsSetConstantBuffer", get_supportsSetConstantBuffer, null);
		L.RegVar("constantBufferOffsetAlignment", get_constantBufferOffsetAlignment, null);
		L.RegVar("maxGraphicsBufferSize", get_maxGraphicsBufferSize, null);
		L.RegVar("hasMipMaxLevel", get_hasMipMaxLevel, null);
		L.RegVar("supportsMipStreaming", get_supportsMipStreaming, null);
		L.RegVar("usesLoadStoreActions", get_usesLoadStoreActions, null);
		L.RegVar("hdrDisplaySupportFlags", get_hdrDisplaySupportFlags, null);
		L.RegVar("supportsConservativeRaster", get_supportsConservativeRaster, null);
		L.RegVar("supportsMultiview", get_supportsMultiview, null);
		L.RegVar("supportsStoreAndResolveAction", get_supportsStoreAndResolveAction, null);
		L.RegVar("supportsMultisampleResolveDepth", get_supportsMultisampleResolveDepth, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_SystemInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SystemInfo o = new SystemInfo();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.SystemInfo.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupportsRenderTextureFormat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SystemInfo.SupportsRenderTextureFormat((RenderTextureFormat)ToLua.CheckObject(L, 1, typeof(RenderTextureFormat)));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupportsBlendingOnRenderTextureFormat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SystemInfo.SupportsBlendingOnRenderTextureFormat((RenderTextureFormat)ToLua.CheckObject(L, 1, typeof(RenderTextureFormat)));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupportsRandomWriteOnRenderTextureFormat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SystemInfo.SupportsRandomWriteOnRenderTextureFormat((RenderTextureFormat)ToLua.CheckObject(L, 1, typeof(RenderTextureFormat)));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupportsTextureFormat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SystemInfo.SupportsTextureFormat((TextureFormat)ToLua.CheckObject(L, 1, typeof(TextureFormat)));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupportsVertexAttributeFormat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VertexAttributeFormat format = (VertexAttributeFormat)ToLua.CheckObject(L, 1, typeof(VertexAttributeFormat));
			int dimension = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = SystemInfo.SupportsVertexAttributeFormat(format, dimension);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsFormatSupported(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GraphicsFormat format = (GraphicsFormat)ToLua.CheckObject(L, 1, typeof(GraphicsFormat));
			FormatUsage usage = (FormatUsage)ToLua.CheckObject(L, 2, typeof(FormatUsage));
			bool value = SystemInfo.IsFormatSupported(format, usage);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCompatibleFormat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GraphicsFormat format = (GraphicsFormat)ToLua.CheckObject(L, 1, typeof(GraphicsFormat));
			FormatUsage usage = (FormatUsage)ToLua.CheckObject(L, 2, typeof(FormatUsage));
			GraphicsFormat compatibleFormat = SystemInfo.GetCompatibleFormat(format, usage);
			ToLua.Push(L, compatibleFormat);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGraphicsFormat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GraphicsFormat graphicsFormat = SystemInfo.GetGraphicsFormat((DefaultFormat)ToLua.CheckObject(L, 1, typeof(DefaultFormat)));
			ToLua.Push(L, graphicsFormat);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRenderTextureSupportedMSAASampleCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int renderTextureSupportedMSAASampleCount = SystemInfo.GetRenderTextureSupportedMSAASampleCount(StackTraits<RenderTextureDescriptor>.Check(L, 1));
			LuaDLL.lua_pushinteger(L, renderTextureSupportedMSAASampleCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_unsupportedIdentifier(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "n/a");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_batteryLevel(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, SystemInfo.batteryLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_batteryStatus(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.batteryStatus);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_operatingSystem(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.operatingSystem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_operatingSystemFamily(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.operatingSystemFamily);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_processorType(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.processorType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_processorFrequency(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.processorFrequency);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_processorCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.processorCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_systemMemorySize(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.systemMemorySize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deviceUniqueIdentifier(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.deviceUniqueIdentifier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deviceName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.deviceName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deviceModel(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.deviceModel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsAccelerometer(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsAccelerometer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsGyroscope(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsGyroscope);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsLocationService(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsLocationService);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsVibration(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsVibration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsAudio(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsAudio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deviceType(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.deviceType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsMemorySize(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.graphicsMemorySize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsDeviceName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.graphicsDeviceName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsDeviceVendor(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.graphicsDeviceVendor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsDeviceID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.graphicsDeviceID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsDeviceVendorID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.graphicsDeviceVendorID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsDeviceType(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.graphicsDeviceType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsUVStartsAtTop(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.graphicsUVStartsAtTop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsDeviceVersion(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, SystemInfo.graphicsDeviceVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsShaderLevel(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.graphicsShaderLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphicsMultiThreaded(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.graphicsMultiThreaded);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderingThreadingMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.renderingThreadingMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasHiddenSurfaceRemovalOnGPU(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.hasHiddenSurfaceRemovalOnGPU);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasDynamicUniformArrayIndexingInFragmentShaders(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.hasDynamicUniformArrayIndexingInFragmentShaders);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsShadows(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsShadows);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsRawShadowDepthSampling(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsRawShadowDepthSampling);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsMotionVectors(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsMotionVectors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supports3DTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supports3DTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsCompressed3DTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsCompressed3DTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supports2DArrayTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supports2DArrayTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supports3DRenderTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supports3DRenderTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsCubemapArrayTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsCubemapArrayTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_copyTextureSupport(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.copyTextureSupport);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsComputeShaders(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsComputeShaders);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsGeometryShaders(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsGeometryShaders);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsTessellationShaders(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsTessellationShaders);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsRenderTargetArrayIndexFromVertexShader(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsRenderTargetArrayIndexFromVertexShader);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsInstancing(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsInstancing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsHardwareQuadTopology(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsHardwareQuadTopology);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supports32bitsIndexBuffer(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supports32bitsIndexBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsSparseTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsSparseTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportedRenderTargetCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.supportedRenderTargetCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsSeparatedRenderTargetsBlend(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsSeparatedRenderTargetsBlend);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportedRandomWriteTargetCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.supportedRandomWriteTargetCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsMultisampledTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.supportsMultisampledTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsMultisampled2DArrayTextures(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsMultisampled2DArrayTextures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsMultisampleAutoResolve(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsMultisampleAutoResolve);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsTextureWrapMirrorOnce(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.supportsTextureWrapMirrorOnce);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_usesReversedZBuffer(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.usesReversedZBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_npotSupport(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.npotSupport);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxTextureSize(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxTextureSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxCubemapSize(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxCubemapSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeBufferInputsVertex(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeBufferInputsVertex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeBufferInputsFragment(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeBufferInputsFragment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeBufferInputsGeometry(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeBufferInputsGeometry);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeBufferInputsDomain(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeBufferInputsDomain);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeBufferInputsHull(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeBufferInputsHull);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeBufferInputsCompute(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeBufferInputsCompute);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeWorkGroupSize(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeWorkGroupSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeWorkGroupSizeX(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeWorkGroupSizeX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeWorkGroupSizeY(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeWorkGroupSizeY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxComputeWorkGroupSizeZ(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.maxComputeWorkGroupSizeZ);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsAsyncCompute(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsAsyncCompute);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsGpuRecorder(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsGpuRecorder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsGraphicsFence(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsGraphicsFence);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsAsyncGPUReadback(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsAsyncGPUReadback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsRayTracing(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsRayTracing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsSetConstantBuffer(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsSetConstantBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_constantBufferOffsetAlignment(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SystemInfo.constantBufferOffsetAlignment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxGraphicsBufferSize(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushint64(L, SystemInfo.maxGraphicsBufferSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasMipMaxLevel(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.hasMipMaxLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsMipStreaming(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsMipStreaming);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_usesLoadStoreActions(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.usesLoadStoreActions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hdrDisplaySupportFlags(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SystemInfo.hdrDisplaySupportFlags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsConservativeRaster(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsConservativeRaster);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsMultiview(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsMultiview);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsStoreAndResolveAction(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsStoreAndResolveAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supportsMultisampleResolveDepth(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SystemInfo.supportsMultisampleResolveDepth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

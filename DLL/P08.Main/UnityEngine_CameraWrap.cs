using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

public class UnityEngine_CameraWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Camera), typeof(Behaviour));
		L.RegFunction("Reset", Reset);
		L.RegFunction("ResetTransparencySortSettings", ResetTransparencySortSettings);
		L.RegFunction("ResetAspect", ResetAspect);
		L.RegFunction("ResetCullingMatrix", ResetCullingMatrix);
		L.RegFunction("SetReplacementShader", SetReplacementShader);
		L.RegFunction("ResetReplacementShader", ResetReplacementShader);
		L.RegFunction("SetTargetBuffers", SetTargetBuffers);
		L.RegFunction("ResetWorldToCameraMatrix", ResetWorldToCameraMatrix);
		L.RegFunction("ResetProjectionMatrix", ResetProjectionMatrix);
		L.RegFunction("CalculateObliqueMatrix", CalculateObliqueMatrix);
		L.RegFunction("WorldToScreenPoint", WorldToScreenPoint);
		L.RegFunction("WorldToViewportPoint", WorldToViewportPoint);
		L.RegFunction("ViewportToWorldPoint", ViewportToWorldPoint);
		L.RegFunction("ScreenToWorldPoint", ScreenToWorldPoint);
		L.RegFunction("ScreenToViewportPoint", ScreenToViewportPoint);
		L.RegFunction("ViewportToScreenPoint", ViewportToScreenPoint);
		L.RegFunction("ViewportPointToRay", ViewportPointToRay);
		L.RegFunction("ScreenPointToRay", ScreenPointToRay);
		L.RegFunction("CalculateFrustumCorners", CalculateFrustumCorners);
		L.RegFunction("CalculateProjectionMatrixFromPhysicalProperties", CalculateProjectionMatrixFromPhysicalProperties);
		L.RegFunction("FocalLengthToFOV", FocalLengthToFOV);
		L.RegFunction("FOVToFocalLength", FOVToFocalLength);
		L.RegFunction("GetStereoNonJitteredProjectionMatrix", GetStereoNonJitteredProjectionMatrix);
		L.RegFunction("GetStereoViewMatrix", GetStereoViewMatrix);
		L.RegFunction("CopyStereoDeviceProjectionMatrixToNonJittered", CopyStereoDeviceProjectionMatrixToNonJittered);
		L.RegFunction("GetStereoProjectionMatrix", GetStereoProjectionMatrix);
		L.RegFunction("SetStereoProjectionMatrix", SetStereoProjectionMatrix);
		L.RegFunction("ResetStereoProjectionMatrices", ResetStereoProjectionMatrices);
		L.RegFunction("SetStereoViewMatrix", SetStereoViewMatrix);
		L.RegFunction("ResetStereoViewMatrices", ResetStereoViewMatrices);
		L.RegFunction("GetAllCameras", GetAllCameras);
		L.RegFunction("RenderToCubemap", RenderToCubemap);
		L.RegFunction("Render", Render);
		L.RegFunction("RenderWithShader", RenderWithShader);
		L.RegFunction("RenderDontRestore", RenderDontRestore);
		L.RegFunction("SetupCurrent", SetupCurrent);
		L.RegFunction("CopyFrom", CopyFrom);
		L.RegFunction("RemoveCommandBuffers", RemoveCommandBuffers);
		L.RegFunction("RemoveAllCommandBuffers", RemoveAllCommandBuffers);
		L.RegFunction("AddCommandBuffer", AddCommandBuffer);
		L.RegFunction("AddCommandBufferAsync", AddCommandBufferAsync);
		L.RegFunction("RemoveCommandBuffer", RemoveCommandBuffer);
		L.RegFunction("GetCommandBuffers", GetCommandBuffers);
		L.RegFunction("New", _CreateUnityEngine_Camera);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onPreCull", get_onPreCull, set_onPreCull);
		L.RegVar("onPreRender", get_onPreRender, set_onPreRender);
		L.RegVar("onPostRender", get_onPostRender, set_onPostRender);
		L.RegVar("nearClipPlane", get_nearClipPlane, set_nearClipPlane);
		L.RegVar("farClipPlane", get_farClipPlane, set_farClipPlane);
		L.RegVar("fieldOfView", get_fieldOfView, set_fieldOfView);
		L.RegVar("renderingPath", get_renderingPath, set_renderingPath);
		L.RegVar("actualRenderingPath", get_actualRenderingPath, null);
		L.RegVar("allowHDR", get_allowHDR, set_allowHDR);
		L.RegVar("allowMSAA", get_allowMSAA, set_allowMSAA);
		L.RegVar("allowDynamicResolution", get_allowDynamicResolution, set_allowDynamicResolution);
		L.RegVar("forceIntoRenderTexture", get_forceIntoRenderTexture, set_forceIntoRenderTexture);
		L.RegVar("orthographicSize", get_orthographicSize, set_orthographicSize);
		L.RegVar("orthographic", get_orthographic, set_orthographic);
		L.RegVar("opaqueSortMode", get_opaqueSortMode, set_opaqueSortMode);
		L.RegVar("transparencySortMode", get_transparencySortMode, set_transparencySortMode);
		L.RegVar("transparencySortAxis", get_transparencySortAxis, set_transparencySortAxis);
		L.RegVar("depth", get_depth, set_depth);
		L.RegVar("aspect", get_aspect, set_aspect);
		L.RegVar("velocity", get_velocity, null);
		L.RegVar("cullingMask", get_cullingMask, set_cullingMask);
		L.RegVar("eventMask", get_eventMask, set_eventMask);
		L.RegVar("layerCullSpherical", get_layerCullSpherical, set_layerCullSpherical);
		L.RegVar("cameraType", get_cameraType, set_cameraType);
		L.RegVar("layerCullDistances", get_layerCullDistances, set_layerCullDistances);
		L.RegVar("useOcclusionCulling", get_useOcclusionCulling, set_useOcclusionCulling);
		L.RegVar("cullingMatrix", get_cullingMatrix, set_cullingMatrix);
		L.RegVar("backgroundColor", get_backgroundColor, set_backgroundColor);
		L.RegVar("clearFlags", get_clearFlags, set_clearFlags);
		L.RegVar("depthTextureMode", get_depthTextureMode, set_depthTextureMode);
		L.RegVar("clearStencilAfterLightingPass", get_clearStencilAfterLightingPass, set_clearStencilAfterLightingPass);
		L.RegVar("usePhysicalProperties", get_usePhysicalProperties, set_usePhysicalProperties);
		L.RegVar("sensorSize", get_sensorSize, set_sensorSize);
		L.RegVar("lensShift", get_lensShift, set_lensShift);
		L.RegVar("focalLength", get_focalLength, set_focalLength);
		L.RegVar("gateFit", get_gateFit, set_gateFit);
		L.RegVar("rect", get_rect, set_rect);
		L.RegVar("pixelRect", get_pixelRect, set_pixelRect);
		L.RegVar("pixelWidth", get_pixelWidth, null);
		L.RegVar("pixelHeight", get_pixelHeight, null);
		L.RegVar("scaledPixelWidth", get_scaledPixelWidth, null);
		L.RegVar("scaledPixelHeight", get_scaledPixelHeight, null);
		L.RegVar("targetTexture", get_targetTexture, set_targetTexture);
		L.RegVar("activeTexture", get_activeTexture, null);
		L.RegVar("targetDisplay", get_targetDisplay, set_targetDisplay);
		L.RegVar("cameraToWorldMatrix", get_cameraToWorldMatrix, null);
		L.RegVar("worldToCameraMatrix", get_worldToCameraMatrix, set_worldToCameraMatrix);
		L.RegVar("projectionMatrix", get_projectionMatrix, set_projectionMatrix);
		L.RegVar("nonJitteredProjectionMatrix", get_nonJitteredProjectionMatrix, set_nonJitteredProjectionMatrix);
		L.RegVar("useJitteredProjectionMatrixForTransparentRendering", get_useJitteredProjectionMatrixForTransparentRendering, set_useJitteredProjectionMatrixForTransparentRendering);
		L.RegVar("previousViewProjectionMatrix", get_previousViewProjectionMatrix, null);
		L.RegVar("main", get_main, null);
		L.RegVar("current", get_current, null);
		L.RegVar("scene", get_scene, set_scene);
		L.RegVar("stereoEnabled", get_stereoEnabled, null);
		L.RegVar("stereoSeparation", get_stereoSeparation, set_stereoSeparation);
		L.RegVar("stereoConvergence", get_stereoConvergence, set_stereoConvergence);
		L.RegVar("areVRStereoViewMatricesWithinSingleCullTolerance", get_areVRStereoViewMatricesWithinSingleCullTolerance, null);
		L.RegVar("stereoTargetEye", get_stereoTargetEye, set_stereoTargetEye);
		L.RegVar("stereoActiveEye", get_stereoActiveEye, null);
		L.RegVar("allCamerasCount", get_allCamerasCount, null);
		L.RegVar("allCameras", get_allCameras, null);
		L.RegVar("commandBufferCount", get_commandBufferCount, null);
		L.RegFunction("CameraCallback", UnityEngine_Camera_CameraCallback);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Camera(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Camera o = new Camera();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Camera.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).Reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetTransparencySortSettings(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetTransparencySortSettings();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetAspect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetAspect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetCullingMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetCullingMatrix();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetReplacementShader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Shader shader = (Shader)ToLua.CheckObject(L, 2, typeof(Shader));
			string replacementTag = ToLua.CheckString(L, 3);
			obj.SetReplacementShader(shader, replacementTag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetReplacementShader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetReplacementShader();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTargetBuffers(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<RenderBuffer[], RenderBuffer>(L, 2))
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				RenderBuffer[] colorBuffer = ToLua.ToStructArray<RenderBuffer>(L, 2);
				RenderBuffer depthBuffer = StackTraits<RenderBuffer>.To(L, 3);
				obj.SetTargetBuffers(colorBuffer, depthBuffer);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<RenderBuffer, RenderBuffer>(L, 2))
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				RenderBuffer colorBuffer2 = StackTraits<RenderBuffer>.To(L, 2);
				RenderBuffer depthBuffer2 = StackTraits<RenderBuffer>.To(L, 3);
				obj2.SetTargetBuffers(colorBuffer2, depthBuffer2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.SetTargetBuffers");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetWorldToCameraMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetWorldToCameraMatrix();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetProjectionMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetProjectionMatrix();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateObliqueMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Vector4 clipPlane = ToLua.ToVector4(L, 2);
			Matrix4x4 v = obj.CalculateObliqueMatrix(clipPlane);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WorldToScreenPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position2 = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.WorldToScreenPoint(position2);
				ToLua.Push(L, v2);
				return 1;
			}
			case 3:
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position = ToLua.ToVector3(L, 2);
				Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 3, typeof(Camera.MonoOrStereoscopicEye));
				Vector3 v = obj.WorldToScreenPoint(position, eye);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.WorldToScreenPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WorldToViewportPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position2 = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.WorldToViewportPoint(position2);
				ToLua.Push(L, v2);
				return 1;
			}
			case 3:
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position = ToLua.ToVector3(L, 2);
				Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 3, typeof(Camera.MonoOrStereoscopicEye));
				Vector3 v = obj.WorldToViewportPoint(position, eye);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.WorldToViewportPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ViewportToWorldPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position2 = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.ViewportToWorldPoint(position2);
				ToLua.Push(L, v2);
				return 1;
			}
			case 3:
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position = ToLua.ToVector3(L, 2);
				Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 3, typeof(Camera.MonoOrStereoscopicEye));
				Vector3 v = obj.ViewportToWorldPoint(position, eye);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.ViewportToWorldPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenToWorldPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position2 = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.ScreenToWorldPoint(position2);
				ToLua.Push(L, v2);
				return 1;
			}
			case 3:
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 position = ToLua.ToVector3(L, 2);
				Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 3, typeof(Camera.MonoOrStereoscopicEye));
				Vector3 v = obj.ScreenToWorldPoint(position, eye);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.ScreenToWorldPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenToViewportPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 v = obj.ScreenToViewportPoint(position);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ViewportToScreenPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 v = obj.ViewportToScreenPoint(position);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ViewportPointToRay(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 pos2 = ToLua.ToVector3(L, 2);
				Ray ray2 = obj2.ViewportPointToRay(pos2);
				ToLua.Push(L, ray2);
				return 1;
			}
			case 3:
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 pos = ToLua.ToVector3(L, 2);
				Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 3, typeof(Camera.MonoOrStereoscopicEye));
				Ray ray = obj.ViewportPointToRay(pos, eye);
				ToLua.Push(L, ray);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.ViewportPointToRay");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenPointToRay(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 pos2 = ToLua.ToVector3(L, 2);
				Ray ray2 = obj2.ScreenPointToRay(pos2);
				ToLua.Push(L, ray2);
				return 1;
			}
			case 3:
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Vector3 pos = ToLua.ToVector3(L, 2);
				Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 3, typeof(Camera.MonoOrStereoscopicEye));
				Ray ray = obj.ScreenPointToRay(pos, eye);
				ToLua.Push(L, ray);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.ScreenPointToRay");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateFrustumCorners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Rect viewport = StackTraits<Rect>.Check(L, 2);
			float z = (float)LuaDLL.luaL_checknumber(L, 3);
			Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 4, typeof(Camera.MonoOrStereoscopicEye));
			Vector3[] outCorners = ToLua.CheckStructArray<Vector3>(L, 5);
			obj.CalculateFrustumCorners(viewport, z, eye, outCorners);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateProjectionMatrixFromPhysicalProperties(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 6:
			{
				float focalLength2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 sensorSize2 = ToLua.ToVector2(L, 3);
				Vector2 lensShift2 = ToLua.ToVector2(L, 4);
				float nearClip2 = (float)LuaDLL.luaL_checknumber(L, 5);
				float farClip2 = (float)LuaDLL.luaL_checknumber(L, 6);
				Camera.CalculateProjectionMatrixFromPhysicalProperties(out var output2, focalLength2, sensorSize2, lensShift2, nearClip2, farClip2);
				ToLua.PushValue(L, output2);
				return 1;
			}
			case 7:
			{
				float focalLength = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 sensorSize = ToLua.ToVector2(L, 3);
				Vector2 lensShift = ToLua.ToVector2(L, 4);
				float nearClip = (float)LuaDLL.luaL_checknumber(L, 5);
				float farClip = (float)LuaDLL.luaL_checknumber(L, 6);
				Camera.GateFitParameters gateFitParameters = StackTraits<Camera.GateFitParameters>.Check(L, 7);
				Camera.CalculateProjectionMatrixFromPhysicalProperties(out var output, focalLength, sensorSize, lensShift, nearClip, farClip, gateFitParameters);
				ToLua.PushValue(L, output);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.CalculateProjectionMatrixFromPhysicalProperties");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FocalLengthToFOV(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float focalLength = (float)LuaDLL.luaL_checknumber(L, 1);
			float sensorSize = (float)LuaDLL.luaL_checknumber(L, 2);
			float num = Camera.FocalLengthToFieldOfView(focalLength, sensorSize);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FOVToFocalLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float fieldOfView = (float)LuaDLL.luaL_checknumber(L, 1);
			float sensorSize = (float)LuaDLL.luaL_checknumber(L, 2);
			float num = Camera.FieldOfViewToFocalLength(fieldOfView, sensorSize);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStereoNonJitteredProjectionMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Camera.StereoscopicEye eye = (Camera.StereoscopicEye)ToLua.CheckObject(L, 2, typeof(Camera.StereoscopicEye));
			Matrix4x4 stereoNonJitteredProjectionMatrix = obj.GetStereoNonJitteredProjectionMatrix(eye);
			ToLua.PushValue(L, stereoNonJitteredProjectionMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStereoViewMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Camera.StereoscopicEye eye = (Camera.StereoscopicEye)ToLua.CheckObject(L, 2, typeof(Camera.StereoscopicEye));
			Matrix4x4 stereoViewMatrix = obj.GetStereoViewMatrix(eye);
			ToLua.PushValue(L, stereoViewMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyStereoDeviceProjectionMatrixToNonJittered(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Camera.StereoscopicEye eye = (Camera.StereoscopicEye)ToLua.CheckObject(L, 2, typeof(Camera.StereoscopicEye));
			obj.CopyStereoDeviceProjectionMatrixToNonJittered(eye);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStereoProjectionMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Camera.StereoscopicEye eye = (Camera.StereoscopicEye)ToLua.CheckObject(L, 2, typeof(Camera.StereoscopicEye));
			Matrix4x4 stereoProjectionMatrix = obj.GetStereoProjectionMatrix(eye);
			ToLua.PushValue(L, stereoProjectionMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStereoProjectionMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Camera.StereoscopicEye eye = (Camera.StereoscopicEye)ToLua.CheckObject(L, 2, typeof(Camera.StereoscopicEye));
			Matrix4x4 matrix = StackTraits<Matrix4x4>.Check(L, 3);
			obj.SetStereoProjectionMatrix(eye, matrix);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetStereoProjectionMatrices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetStereoProjectionMatrices();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStereoViewMatrix(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Camera.StereoscopicEye eye = (Camera.StereoscopicEye)ToLua.CheckObject(L, 2, typeof(Camera.StereoscopicEye));
			Matrix4x4 matrix = StackTraits<Matrix4x4>.Check(L, 3);
			obj.SetStereoViewMatrix(eye, matrix);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetStereoViewMatrices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).ResetStereoViewMatrices();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAllCameras(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int allCameras = Camera.GetAllCameras(ToLua.CheckObjectArray<Camera>(L, 1));
			LuaDLL.lua_pushinteger(L, allCameras);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RenderToCubemap(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Cubemap>(L, 2))
			{
				Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Cubemap cubemap = (Cubemap)ToLua.ToObject(L, 2);
				bool value = obj.RenderToCubemap(cubemap);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<RenderTexture>(L, 2))
			{
				Camera obj2 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				RenderTexture cubemap2 = (RenderTexture)ToLua.ToObject(L, 2);
				bool value2 = obj2.RenderToCubemap(cubemap2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RenderTexture, int>(L, 2))
			{
				Camera obj3 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				RenderTexture cubemap3 = (RenderTexture)ToLua.ToObject(L, 2);
				int faceMask = (int)LuaDLL.lua_tonumber(L, 3);
				bool value3 = obj3.RenderToCubemap(cubemap3, faceMask);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Cubemap, int>(L, 2))
			{
				Camera obj4 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				Cubemap cubemap4 = (Cubemap)ToLua.ToObject(L, 2);
				int faceMask2 = (int)LuaDLL.lua_tonumber(L, 3);
				bool value4 = obj4.RenderToCubemap(cubemap4, faceMask2);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			if (num == 4)
			{
				Camera obj5 = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
				RenderTexture cubemap5 = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
				int faceMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				Camera.MonoOrStereoscopicEye stereoEye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 4, typeof(Camera.MonoOrStereoscopicEye));
				bool value5 = obj5.RenderToCubemap(cubemap5, faceMask3, stereoEye);
				LuaDLL.lua_pushboolean(L, value5);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Camera.RenderToCubemap");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Render(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).Render();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RenderWithShader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Shader shader = (Shader)ToLua.CheckObject(L, 2, typeof(Shader));
			string replacementTag = ToLua.CheckString(L, 3);
			obj.RenderWithShader(shader, replacementTag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RenderDontRestore(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).RenderDontRestore();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetupCurrent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Camera.SetupCurrent((Camera)ToLua.CheckObject(L, 1, typeof(Camera)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyFrom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Camera other = (Camera)ToLua.CheckObject(L, 2, typeof(Camera));
			obj.CopyFrom(other);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveCommandBuffers(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			CameraEvent evt = (CameraEvent)ToLua.CheckObject(L, 2, typeof(CameraEvent));
			obj.RemoveCommandBuffers(evt);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAllCommandBuffers(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Camera)ToLua.CheckObject(L, 1, typeof(Camera))).RemoveAllCommandBuffers();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddCommandBuffer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			CameraEvent evt = (CameraEvent)ToLua.CheckObject(L, 2, typeof(CameraEvent));
			CommandBuffer buffer = (CommandBuffer)ToLua.CheckObject<CommandBuffer>(L, 3);
			obj.AddCommandBuffer(evt, buffer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddCommandBufferAsync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			CameraEvent evt = (CameraEvent)ToLua.CheckObject(L, 2, typeof(CameraEvent));
			CommandBuffer buffer = (CommandBuffer)ToLua.CheckObject<CommandBuffer>(L, 3);
			ComputeQueueType queueType = (ComputeQueueType)ToLua.CheckObject(L, 4, typeof(ComputeQueueType));
			obj.AddCommandBufferAsync(evt, buffer, queueType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveCommandBuffer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			CameraEvent evt = (CameraEvent)ToLua.CheckObject(L, 2, typeof(CameraEvent));
			CommandBuffer buffer = (CommandBuffer)ToLua.CheckObject<CommandBuffer>(L, 3);
			obj.RemoveCommandBuffer(evt, buffer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCommandBuffers(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera obj = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			CameraEvent evt = (CameraEvent)ToLua.CheckObject(L, 2, typeof(CameraEvent));
			CommandBuffer[] commandBuffers = obj.GetCommandBuffers(evt);
			ToLua.Push(L, commandBuffers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onPreCull(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Camera.onPreCull);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onPreRender(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Camera.onPreRender);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onPostRender(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Camera.onPostRender);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nearClipPlane(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float nearClipPlane = ((Camera)obj).nearClipPlane;
			LuaDLL.lua_pushnumber(L, nearClipPlane);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nearClipPlane on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_farClipPlane(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float farClipPlane = ((Camera)obj).farClipPlane;
			LuaDLL.lua_pushnumber(L, farClipPlane);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index farClipPlane on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fieldOfView(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fieldOfView = ((Camera)obj).fieldOfView;
			LuaDLL.lua_pushnumber(L, fieldOfView);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fieldOfView on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderingPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderingPath renderingPath = ((Camera)obj).renderingPath;
			ToLua.Push(L, renderingPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderingPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_actualRenderingPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderingPath actualRenderingPath = ((Camera)obj).actualRenderingPath;
			ToLua.Push(L, actualRenderingPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index actualRenderingPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowHDR(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowHDR = ((Camera)obj).allowHDR;
			LuaDLL.lua_pushboolean(L, allowHDR);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowHDR on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowMSAA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowMSAA = ((Camera)obj).allowMSAA;
			LuaDLL.lua_pushboolean(L, allowMSAA);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowMSAA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowDynamicResolution(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowDynamicResolution = ((Camera)obj).allowDynamicResolution;
			LuaDLL.lua_pushboolean(L, allowDynamicResolution);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowDynamicResolution on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_forceIntoRenderTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool forceIntoRenderTexture = ((Camera)obj).forceIntoRenderTexture;
			LuaDLL.lua_pushboolean(L, forceIntoRenderTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index forceIntoRenderTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_orthographicSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float orthographicSize = ((Camera)obj).orthographicSize;
			LuaDLL.lua_pushnumber(L, orthographicSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index orthographicSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_orthographic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool orthographic = ((Camera)obj).orthographic;
			LuaDLL.lua_pushboolean(L, orthographic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index orthographic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_opaqueSortMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			OpaqueSortMode opaqueSortMode = ((Camera)obj).opaqueSortMode;
			ToLua.Push(L, opaqueSortMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index opaqueSortMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_transparencySortMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TransparencySortMode transparencySortMode = ((Camera)obj).transparencySortMode;
			ToLua.Push(L, transparencySortMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transparencySortMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_transparencySortAxis(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 transparencySortAxis = ((Camera)obj).transparencySortAxis;
			ToLua.Push(L, transparencySortAxis);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transparencySortAxis on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_depth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float depth = ((Camera)obj).depth;
			LuaDLL.lua_pushnumber(L, depth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_aspect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float aspect = ((Camera)obj).aspect;
			LuaDLL.lua_pushnumber(L, aspect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aspect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 velocity = ((Camera)obj).velocity;
			ToLua.Push(L, velocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cullingMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cullingMask = ((Camera)obj).cullingMask;
			LuaDLL.lua_pushinteger(L, cullingMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eventMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int eventMask = ((Camera)obj).eventMask;
			LuaDLL.lua_pushinteger(L, eventMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layerCullSpherical(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool layerCullSpherical = ((Camera)obj).layerCullSpherical;
			LuaDLL.lua_pushboolean(L, layerCullSpherical);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layerCullSpherical on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameraType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraType cameraType = ((Camera)obj).cameraType;
			ToLua.Push(L, cameraType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layerCullDistances(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float[] layerCullDistances = ((Camera)obj).layerCullDistances;
			ToLua.Push(L, layerCullDistances);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layerCullDistances on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useOcclusionCulling(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useOcclusionCulling = ((Camera)obj).useOcclusionCulling;
			LuaDLL.lua_pushboolean(L, useOcclusionCulling);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useOcclusionCulling on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cullingMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 cullingMatrix = ((Camera)obj).cullingMatrix;
			ToLua.PushValue(L, cullingMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_backgroundColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color backgroundColor = ((Camera)obj).backgroundColor;
			ToLua.Push(L, backgroundColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index backgroundColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clearFlags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraClearFlags clearFlags = ((Camera)obj).clearFlags;
			ToLua.Push(L, clearFlags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clearFlags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_depthTextureMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DepthTextureMode depthTextureMode = ((Camera)obj).depthTextureMode;
			ToLua.Push(L, depthTextureMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depthTextureMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clearStencilAfterLightingPass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool clearStencilAfterLightingPass = ((Camera)obj).clearStencilAfterLightingPass;
			LuaDLL.lua_pushboolean(L, clearStencilAfterLightingPass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clearStencilAfterLightingPass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_usePhysicalProperties(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool usePhysicalProperties = ((Camera)obj).usePhysicalProperties;
			LuaDLL.lua_pushboolean(L, usePhysicalProperties);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usePhysicalProperties on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sensorSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 sensorSize = ((Camera)obj).sensorSize;
			ToLua.Push(L, sensorSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sensorSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lensShift(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 lensShift = ((Camera)obj).lensShift;
			ToLua.Push(L, lensShift);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lensShift on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_focalLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float focalLength = ((Camera)obj).focalLength;
			LuaDLL.lua_pushnumber(L, focalLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index focalLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gateFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera.GateFitMode gateFit = ((Camera)obj).gateFit;
			ToLua.Push(L, gateFit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gateFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = ((Camera)obj).rect;
			ToLua.PushValue(L, rect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect pixelRect = ((Camera)obj).pixelRect;
			ToLua.PushValue(L, pixelRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int pixelWidth = ((Camera)obj).pixelWidth;
			LuaDLL.lua_pushinteger(L, pixelWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int pixelHeight = ((Camera)obj).pixelHeight;
			LuaDLL.lua_pushinteger(L, pixelHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scaledPixelWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int scaledPixelWidth = ((Camera)obj).scaledPixelWidth;
			LuaDLL.lua_pushinteger(L, scaledPixelWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scaledPixelWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scaledPixelHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int scaledPixelHeight = ((Camera)obj).scaledPixelHeight;
			LuaDLL.lua_pushinteger(L, scaledPixelHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scaledPixelHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture targetTexture = ((Camera)obj).targetTexture;
			ToLua.Push(L, targetTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activeTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture activeTexture = ((Camera)obj).activeTexture;
			ToLua.Push(L, activeTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activeTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetDisplay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int targetDisplay = ((Camera)obj).targetDisplay;
			LuaDLL.lua_pushinteger(L, targetDisplay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetDisplay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameraToWorldMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 cameraToWorldMatrix = ((Camera)obj).cameraToWorldMatrix;
			ToLua.PushValue(L, cameraToWorldMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraToWorldMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_worldToCameraMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 worldToCameraMatrix = ((Camera)obj).worldToCameraMatrix;
			ToLua.PushValue(L, worldToCameraMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index worldToCameraMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_projectionMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 projectionMatrix = ((Camera)obj).projectionMatrix;
			ToLua.PushValue(L, projectionMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index projectionMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nonJitteredProjectionMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 nonJitteredProjectionMatrix = ((Camera)obj).nonJitteredProjectionMatrix;
			ToLua.PushValue(L, nonJitteredProjectionMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nonJitteredProjectionMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useJitteredProjectionMatrixForTransparentRendering(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useJitteredProjectionMatrixForTransparentRendering = ((Camera)obj).useJitteredProjectionMatrixForTransparentRendering;
			LuaDLL.lua_pushboolean(L, useJitteredProjectionMatrixForTransparentRendering);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useJitteredProjectionMatrixForTransparentRendering on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_previousViewProjectionMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 previousViewProjectionMatrix = ((Camera)obj).previousViewProjectionMatrix;
			ToLua.PushValue(L, previousViewProjectionMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index previousViewProjectionMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_main(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, Camera.main);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_current(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, Camera.current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scene(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Scene scene = ((Camera)obj).scene;
			ToLua.PushValue(L, scene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scene on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stereoEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool stereoEnabled = ((Camera)obj).stereoEnabled;
			LuaDLL.lua_pushboolean(L, stereoEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stereoSeparation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float stereoSeparation = ((Camera)obj).stereoSeparation;
			LuaDLL.lua_pushnumber(L, stereoSeparation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoSeparation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stereoConvergence(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float stereoConvergence = ((Camera)obj).stereoConvergence;
			LuaDLL.lua_pushnumber(L, stereoConvergence);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoConvergence on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_areVRStereoViewMatricesWithinSingleCullTolerance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool areVRStereoViewMatricesWithinSingleCullTolerance = ((Camera)obj).areVRStereoViewMatricesWithinSingleCullTolerance;
			LuaDLL.lua_pushboolean(L, areVRStereoViewMatricesWithinSingleCullTolerance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index areVRStereoViewMatricesWithinSingleCullTolerance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stereoTargetEye(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StereoTargetEyeMask stereoTargetEye = ((Camera)obj).stereoTargetEye;
			ToLua.Push(L, stereoTargetEye);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoTargetEye on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stereoActiveEye(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera.MonoOrStereoscopicEye stereoActiveEye = ((Camera)obj).stereoActiveEye;
			ToLua.Push(L, stereoActiveEye);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoActiveEye on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allCamerasCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Camera.allCamerasCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allCameras(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Camera.allCameras);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_commandBufferCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int commandBufferCount = ((Camera)obj).commandBufferCount;
			LuaDLL.lua_pushinteger(L, commandBufferCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index commandBufferCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPreCull(IntPtr L)
	{
		try
		{
			Camera.onPreCull = (Camera.CameraCallback)ToLua.CheckDelegate<Camera.CameraCallback>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPreRender(IntPtr L)
	{
		try
		{
			Camera.onPreRender = (Camera.CameraCallback)ToLua.CheckDelegate<Camera.CameraCallback>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPostRender(IntPtr L)
	{
		try
		{
			Camera.onPostRender = (Camera.CameraCallback)ToLua.CheckDelegate<Camera.CameraCallback>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nearClipPlane(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float nearClipPlane = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.nearClipPlane = nearClipPlane;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nearClipPlane on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_farClipPlane(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float farClipPlane = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.farClipPlane = farClipPlane;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index farClipPlane on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fieldOfView(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float fieldOfView = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fieldOfView = fieldOfView;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fieldOfView on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderingPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			RenderingPath renderingPath = (RenderingPath)ToLua.CheckObject(L, 2, typeof(RenderingPath));
			obj2.renderingPath = renderingPath;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderingPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowHDR(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool allowHDR = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowHDR = allowHDR;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowHDR on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowMSAA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool allowMSAA = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowMSAA = allowMSAA;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowMSAA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowDynamicResolution(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool allowDynamicResolution = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowDynamicResolution = allowDynamicResolution;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowDynamicResolution on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_forceIntoRenderTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool forceIntoRenderTexture = LuaDLL.luaL_checkboolean(L, 2);
			obj2.forceIntoRenderTexture = forceIntoRenderTexture;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index forceIntoRenderTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_orthographicSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float orthographicSize = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.orthographicSize = orthographicSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index orthographicSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_orthographic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool orthographic = LuaDLL.luaL_checkboolean(L, 2);
			obj2.orthographic = orthographic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index orthographic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_opaqueSortMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			OpaqueSortMode opaqueSortMode = (OpaqueSortMode)ToLua.CheckObject(L, 2, typeof(OpaqueSortMode));
			obj2.opaqueSortMode = opaqueSortMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index opaqueSortMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_transparencySortMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			TransparencySortMode transparencySortMode = (TransparencySortMode)ToLua.CheckObject(L, 2, typeof(TransparencySortMode));
			obj2.transparencySortMode = transparencySortMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transparencySortMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_transparencySortAxis(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Vector3 transparencySortAxis = ToLua.ToVector3(L, 2);
			obj2.transparencySortAxis = transparencySortAxis;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transparencySortAxis on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_depth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float depth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.depth = depth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_aspect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float aspect = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.aspect = aspect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aspect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cullingMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			int cullingMask = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cullingMask = cullingMask;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eventMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			int eventMask = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.eventMask = eventMask;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_layerCullSpherical(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool layerCullSpherical = LuaDLL.luaL_checkboolean(L, 2);
			obj2.layerCullSpherical = layerCullSpherical;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layerCullSpherical on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cameraType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			CameraType cameraType = (CameraType)ToLua.CheckObject(L, 2, typeof(CameraType));
			obj2.cameraType = cameraType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_layerCullDistances(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float[] layerCullDistances = ToLua.CheckNumberArray<float>(L, 2);
			obj2.layerCullDistances = layerCullDistances;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layerCullDistances on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useOcclusionCulling(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool useOcclusionCulling = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useOcclusionCulling = useOcclusionCulling;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useOcclusionCulling on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cullingMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Matrix4x4 cullingMatrix = StackTraits<Matrix4x4>.Check(L, 2);
			obj2.cullingMatrix = cullingMatrix;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_backgroundColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Color backgroundColor = ToLua.ToColor(L, 2);
			obj2.backgroundColor = backgroundColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index backgroundColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clearFlags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			CameraClearFlags clearFlags = (CameraClearFlags)ToLua.CheckObject(L, 2, typeof(CameraClearFlags));
			obj2.clearFlags = clearFlags;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clearFlags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_depthTextureMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			DepthTextureMode depthTextureMode = (DepthTextureMode)ToLua.CheckObject(L, 2, typeof(DepthTextureMode));
			obj2.depthTextureMode = depthTextureMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depthTextureMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clearStencilAfterLightingPass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool clearStencilAfterLightingPass = LuaDLL.luaL_checkboolean(L, 2);
			obj2.clearStencilAfterLightingPass = clearStencilAfterLightingPass;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clearStencilAfterLightingPass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_usePhysicalProperties(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool usePhysicalProperties = LuaDLL.luaL_checkboolean(L, 2);
			obj2.usePhysicalProperties = usePhysicalProperties;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usePhysicalProperties on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sensorSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Vector2 sensorSize = ToLua.ToVector2(L, 2);
			obj2.sensorSize = sensorSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sensorSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lensShift(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Vector2 lensShift = ToLua.ToVector2(L, 2);
			obj2.lensShift = lensShift;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lensShift on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_focalLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float focalLength = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.focalLength = focalLength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index focalLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gateFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Camera.GateFitMode gateFit = (Camera.GateFitMode)ToLua.CheckObject(L, 2, typeof(Camera.GateFitMode));
			obj2.gateFit = gateFit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gateFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Rect rect = StackTraits<Rect>.Check(L, 2);
			obj2.rect = rect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pixelRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Rect pixelRect = StackTraits<Rect>.Check(L, 2);
			obj2.pixelRect = pixelRect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			RenderTexture targetTexture = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
			obj2.targetTexture = targetTexture;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetDisplay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			int targetDisplay = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.targetDisplay = targetDisplay;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetDisplay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_worldToCameraMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Matrix4x4 worldToCameraMatrix = StackTraits<Matrix4x4>.Check(L, 2);
			obj2.worldToCameraMatrix = worldToCameraMatrix;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index worldToCameraMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_projectionMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Matrix4x4 projectionMatrix = StackTraits<Matrix4x4>.Check(L, 2);
			obj2.projectionMatrix = projectionMatrix;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index projectionMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nonJitteredProjectionMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Matrix4x4 nonJitteredProjectionMatrix = StackTraits<Matrix4x4>.Check(L, 2);
			obj2.nonJitteredProjectionMatrix = nonJitteredProjectionMatrix;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nonJitteredProjectionMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useJitteredProjectionMatrixForTransparentRendering(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			bool useJitteredProjectionMatrixForTransparentRendering = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useJitteredProjectionMatrixForTransparentRendering = useJitteredProjectionMatrixForTransparentRendering;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useJitteredProjectionMatrixForTransparentRendering on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scene(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			Scene scene = StackTraits<Scene>.Check(L, 2);
			obj2.scene = scene;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scene on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stereoSeparation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float stereoSeparation = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.stereoSeparation = stereoSeparation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoSeparation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stereoConvergence(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			float stereoConvergence = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.stereoConvergence = stereoConvergence;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoConvergence on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stereoTargetEye(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera obj2 = (Camera)obj;
			StereoTargetEyeMask stereoTargetEye = (StereoTargetEyeMask)ToLua.CheckObject(L, 2, typeof(StereoTargetEyeMask));
			obj2.stereoTargetEye = stereoTargetEye;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stereoTargetEye on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Camera_CameraCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Camera.CameraCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Camera.CameraCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

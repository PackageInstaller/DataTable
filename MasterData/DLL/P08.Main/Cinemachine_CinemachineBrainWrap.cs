using System;
using Cinemachine;
using LuaInterface;
using UnityEngine;

public class Cinemachine_CinemachineBrainWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CinemachineBrain), typeof(MonoBehaviour));
		L.RegFunction("GetSoloGUIColor", GetSoloGUIColor);
		L.RegFunction("ManualUpdate", ManualUpdate);
		L.RegFunction("IsLiveInBlend", IsLiveInBlend);
		L.RegFunction("SetCameraOverride", SetCameraOverride);
		L.RegFunction("ReleaseCameraOverride", ReleaseCameraOverride);
		L.RegFunction("ComputeCurrentBlend", ComputeCurrentBlend);
		L.RegFunction("IsLive", IsLive);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("m_ShowDebugText", get_m_ShowDebugText, set_m_ShowDebugText);
		L.RegVar("m_ShowCameraFrustum", get_m_ShowCameraFrustum, set_m_ShowCameraFrustum);
		L.RegVar("m_IgnoreTimeScale", get_m_IgnoreTimeScale, set_m_IgnoreTimeScale);
		L.RegVar("m_WorldUpOverride", get_m_WorldUpOverride, set_m_WorldUpOverride);
		L.RegVar("m_UpdateMethod", get_m_UpdateMethod, set_m_UpdateMethod);
		L.RegVar("m_BlendUpdateMethod", get_m_BlendUpdateMethod, set_m_BlendUpdateMethod);
		L.RegVar("m_DefaultBlend", get_m_DefaultBlend, set_m_DefaultBlend);
		L.RegVar("m_CustomBlends", get_m_CustomBlends, set_m_CustomBlends);
		L.RegVar("m_CameraCutEvent", get_m_CameraCutEvent, set_m_CameraCutEvent);
		L.RegVar("m_CameraActivatedEvent", get_m_CameraActivatedEvent, set_m_CameraActivatedEvent);
		L.RegVar("OutputCamera", get_OutputCamera, null);
		L.RegVar("SoloCamera", get_SoloCamera, set_SoloCamera);
		L.RegVar("DefaultWorldUp", get_DefaultWorldUp, null);
		L.RegVar("ActiveVirtualCamera", get_ActiveVirtualCamera, null);
		L.RegVar("IsBlending", get_IsBlending, null);
		L.RegVar("ActiveBlend", get_ActiveBlend, null);
		L.RegVar("CurrentCameraState", get_CurrentCameraState, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSoloGUIColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Color soloGUIColor = CinemachineBrain.GetSoloGUIColor();
			ToLua.Push(L, soloGUIColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ManualUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 1)).ManualUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsLiveInBlend(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineBrain obj = (CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 1);
			ICinemachineCamera vcam = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 2);
			bool value = obj.IsLiveInBlend(vcam);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCameraOverride(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			CinemachineBrain obj = (CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 1);
			int overrideId = (int)LuaDLL.luaL_checknumber(L, 2);
			ICinemachineCamera camA = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 3);
			ICinemachineCamera camB = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 4);
			float weightB = (float)LuaDLL.luaL_checknumber(L, 5);
			float deltaTime = (float)LuaDLL.luaL_checknumber(L, 6);
			int n = obj.SetCameraOverride(overrideId, camA, camB, weightB, deltaTime);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReleaseCameraOverride(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineBrain obj = (CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 1);
			int overrideId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ReleaseCameraOverride(overrideId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ComputeCurrentBlend(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CinemachineBrain obj = (CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 1);
			CinemachineBlend outputBlend = (CinemachineBlend)ToLua.CheckObject<CinemachineBlend>(L, 2);
			int numTopLayersToExclude = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ComputeCurrentBlend(ref outputBlend, numTopLayersToExclude);
			ToLua.PushObject(L, outputBlend);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsLive(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				CinemachineBrain obj2 = (CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 1);
				ICinemachineCamera vcam2 = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 2);
				bool value2 = obj2.IsLive(vcam2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
			{
				CinemachineBrain obj = (CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 1);
				ICinemachineCamera vcam = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 2);
				bool dominantChildOnly = LuaDLL.luaL_checkboolean(L, 3);
				bool value = obj.IsLive(vcam, dominantChildOnly);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Cinemachine.CinemachineBrain.IsLive");
			}
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
	private static int get_m_ShowDebugText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool showDebugText = ((CinemachineBrain)obj).m_ShowDebugText;
			LuaDLL.lua_pushboolean(L, showDebugText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ShowDebugText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_ShowCameraFrustum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool showCameraFrustum = ((CinemachineBrain)obj).m_ShowCameraFrustum;
			LuaDLL.lua_pushboolean(L, showCameraFrustum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ShowCameraFrustum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_IgnoreTimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreTimeScale = ((CinemachineBrain)obj).m_IgnoreTimeScale;
			LuaDLL.lua_pushboolean(L, ignoreTimeScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_IgnoreTimeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_WorldUpOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform worldUpOverride = ((CinemachineBrain)obj).m_WorldUpOverride;
			ToLua.Push(L, worldUpOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_WorldUpOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_UpdateMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain.UpdateMethod updateMethod = ((CinemachineBrain)obj).m_UpdateMethod;
			ToLua.Push(L, updateMethod);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_UpdateMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_BlendUpdateMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain.BrainUpdateMethod blendUpdateMethod = ((CinemachineBrain)obj).m_BlendUpdateMethod;
			ToLua.Push(L, blendUpdateMethod);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_BlendUpdateMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_DefaultBlend(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBlendDefinition defaultBlend = ((CinemachineBrain)obj).m_DefaultBlend;
			ToLua.PushValue(L, defaultBlend);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_DefaultBlend on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_CustomBlends(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBlenderSettings customBlends = ((CinemachineBrain)obj).m_CustomBlends;
			ToLua.PushSealed(L, customBlends);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_CustomBlends on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_CameraCutEvent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain.BrainEvent cameraCutEvent = ((CinemachineBrain)obj).m_CameraCutEvent;
			ToLua.PushObject(L, cameraCutEvent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_CameraCutEvent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_CameraActivatedEvent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain.VcamActivatedEvent cameraActivatedEvent = ((CinemachineBrain)obj).m_CameraActivatedEvent;
			ToLua.PushObject(L, cameraActivatedEvent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_CameraActivatedEvent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OutputCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera outputCamera = ((CinemachineBrain)obj).OutputCamera;
			ToLua.PushSealed(L, outputCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OutputCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SoloCamera(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, CinemachineBrain.SoloCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DefaultWorldUp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 defaultWorldUp = ((CinemachineBrain)obj).DefaultWorldUp;
			ToLua.Push(L, defaultWorldUp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DefaultWorldUp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ActiveVirtualCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ICinemachineCamera activeVirtualCamera = ((CinemachineBrain)obj).ActiveVirtualCamera;
			ToLua.PushObject(L, activeVirtualCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ActiveVirtualCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsBlending(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isBlending = ((CinemachineBrain)obj).IsBlending;
			LuaDLL.lua_pushboolean(L, isBlending);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsBlending on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ActiveBlend(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBlend activeBlend = ((CinemachineBrain)obj).ActiveBlend;
			ToLua.PushObject(L, activeBlend);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ActiveBlend on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CurrentCameraState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraState currentCameraState = ((CinemachineBrain)obj).CurrentCameraState;
			ToLua.PushValue(L, currentCameraState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CurrentCameraState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_ShowDebugText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			bool showDebugText = LuaDLL.luaL_checkboolean(L, 2);
			obj2.m_ShowDebugText = showDebugText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ShowDebugText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_ShowCameraFrustum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			bool showCameraFrustum = LuaDLL.luaL_checkboolean(L, 2);
			obj2.m_ShowCameraFrustum = showCameraFrustum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ShowCameraFrustum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_IgnoreTimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			bool ignoreTimeScale = LuaDLL.luaL_checkboolean(L, 2);
			obj2.m_IgnoreTimeScale = ignoreTimeScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_IgnoreTimeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_WorldUpOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			Transform worldUpOverride = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.m_WorldUpOverride = worldUpOverride;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_WorldUpOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_UpdateMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			CinemachineBrain.UpdateMethod updateMethod = (CinemachineBrain.UpdateMethod)ToLua.CheckObject(L, 2, typeof(CinemachineBrain.UpdateMethod));
			obj2.m_UpdateMethod = updateMethod;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_UpdateMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_BlendUpdateMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			CinemachineBrain.BrainUpdateMethod blendUpdateMethod = (CinemachineBrain.BrainUpdateMethod)ToLua.CheckObject(L, 2, typeof(CinemachineBrain.BrainUpdateMethod));
			obj2.m_BlendUpdateMethod = blendUpdateMethod;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_BlendUpdateMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_DefaultBlend(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			CinemachineBlendDefinition defaultBlend = StackTraits<CinemachineBlendDefinition>.Check(L, 2);
			obj2.m_DefaultBlend = defaultBlend;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_DefaultBlend on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_CustomBlends(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			CinemachineBlenderSettings customBlends = (CinemachineBlenderSettings)ToLua.CheckObject(L, 2, typeof(CinemachineBlenderSettings));
			obj2.m_CustomBlends = customBlends;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_CustomBlends on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_CameraCutEvent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			CinemachineBrain.BrainEvent cameraCutEvent = (CinemachineBrain.BrainEvent)ToLua.CheckObject<CinemachineBrain.BrainEvent>(L, 2);
			obj2.m_CameraCutEvent = cameraCutEvent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_CameraCutEvent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_CameraActivatedEvent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain obj2 = (CinemachineBrain)obj;
			CinemachineBrain.VcamActivatedEvent cameraActivatedEvent = (CinemachineBrain.VcamActivatedEvent)ToLua.CheckObject<CinemachineBrain.VcamActivatedEvent>(L, 2);
			obj2.m_CameraActivatedEvent = cameraActivatedEvent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_CameraActivatedEvent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_SoloCamera(IntPtr L)
	{
		try
		{
			CinemachineBrain.SoloCamera = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

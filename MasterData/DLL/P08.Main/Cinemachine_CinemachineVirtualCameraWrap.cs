using System;
using Cinemachine;
using LuaInterface;
using UnityEngine;

public class Cinemachine_CinemachineVirtualCameraWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CinemachineVirtualCamera), typeof(CinemachineVirtualCameraBase));
		L.RegFunction("GetMaxDampTime", GetMaxDampTime);
		L.RegFunction("InternalUpdateCameraState", InternalUpdateCameraState);
		L.RegFunction("InvalidateComponentPipeline", InvalidateComponentPipeline);
		L.RegFunction("GetComponentOwner", GetComponentOwner);
		L.RegFunction("GetComponentPipeline", GetComponentPipeline);
		L.RegFunction("GetCinemachineComponent", GetCinemachineComponent);
		L.RegFunction("OnTargetObjectWarped", OnTargetObjectWarped);
		L.RegFunction("ForceCameraPosition", ForceCameraPosition);
		L.RegFunction("OnTransitionFromCamera", OnTransitionFromCamera);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("m_LookAt", get_m_LookAt, set_m_LookAt);
		L.RegVar("m_Follow", get_m_Follow, set_m_Follow);
		L.RegVar("m_Lens", get_m_Lens, set_m_Lens);
		L.RegVar("m_Transitions", get_m_Transitions, set_m_Transitions);
		L.RegVar("PipelineName", get_PipelineName, null);
		L.RegVar("CreatePipelineOverride", get_CreatePipelineOverride, set_CreatePipelineOverride);
		L.RegVar("DestroyPipelineOverride", get_DestroyPipelineOverride, set_DestroyPipelineOverride);
		L.RegVar("State", get_State, null);
		L.RegVar("LookAt", get_LookAt, set_LookAt);
		L.RegVar("Follow", get_Follow, set_Follow);
		L.RegFunction("DestroyPipelineDelegate", Cinemachine_CinemachineVirtualCamera_DestroyPipelineDelegate);
		L.RegFunction("CreatePipelineDelegate", Cinemachine_CinemachineVirtualCamera_CreatePipelineDelegate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaxDampTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float maxDampTime = ((CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1)).GetMaxDampTime();
			LuaDLL.lua_pushnumber(L, maxDampTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InternalUpdateCameraState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CinemachineVirtualCamera obj = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
			Vector3 worldUp = ToLua.ToVector3(L, 2);
			float deltaTime = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.InternalUpdateCameraState(worldUp, deltaTime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InvalidateComponentPipeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1)).InvalidateComponentPipeline();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponentOwner(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform componentOwner = ((CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1)).GetComponentOwner();
			ToLua.Push(L, componentOwner);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponentPipeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CinemachineComponentBase[] componentPipeline = ((CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1)).GetComponentPipeline();
			ToLua.Push(L, componentPipeline);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCinemachineComponent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineVirtualCamera obj = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
			CinemachineCore.Stage stage = (CinemachineCore.Stage)ToLua.CheckObject(L, 2, typeof(CinemachineCore.Stage));
			CinemachineComponentBase cinemachineComponent = obj.GetCinemachineComponent(stage);
			ToLua.Push(L, cinemachineComponent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnTargetObjectWarped(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CinemachineVirtualCamera obj = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			Vector3 positionDelta = ToLua.ToVector3(L, 3);
			obj.OnTargetObjectWarped(target, positionDelta);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceCameraPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CinemachineVirtualCamera obj = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
			Vector3 pos = ToLua.ToVector3(L, 2);
			Quaternion rot = ToLua.ToQuaternion(L, 3);
			obj.ForceCameraPosition(pos, rot);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnTransitionFromCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			CinemachineVirtualCamera obj = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
			ICinemachineCamera fromCam = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 2);
			Vector3 worldUp = ToLua.ToVector3(L, 3);
			float deltaTime = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.OnTransitionFromCamera(fromCam, worldUp, deltaTime);
			return 0;
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
	private static int get_m_LookAt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform lookAt = ((CinemachineVirtualCamera)obj).m_LookAt;
			ToLua.Push(L, lookAt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_LookAt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_Follow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform follow = ((CinemachineVirtualCamera)obj).m_Follow;
			ToLua.Push(L, follow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Follow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_Lens(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LensSettings lens = ((CinemachineVirtualCamera)obj).m_Lens;
			ToLua.PushValue(L, lens);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Lens on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_Transitions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase.TransitionParams transitions = ((CinemachineVirtualCamera)obj).m_Transitions;
			ToLua.PushValue(L, transitions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Transitions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PipelineName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "cm");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CreatePipelineOverride(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CinemachineVirtualCamera.CreatePipelineOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DestroyPipelineOverride(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CinemachineVirtualCamera.DestroyPipelineOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_State(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraState state = ((CinemachineVirtualCamera)obj).State;
			ToLua.PushValue(L, state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index State on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LookAt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform lookAt = ((CinemachineVirtualCamera)obj).LookAt;
			ToLua.Push(L, lookAt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LookAt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Follow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform follow = ((CinemachineVirtualCamera)obj).Follow;
			ToLua.Push(L, follow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Follow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_LookAt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCamera obj2 = (CinemachineVirtualCamera)obj;
			Transform lookAt = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.m_LookAt = lookAt;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_LookAt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_Follow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCamera obj2 = (CinemachineVirtualCamera)obj;
			Transform follow = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.m_Follow = follow;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Follow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_Lens(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCamera obj2 = (CinemachineVirtualCamera)obj;
			LensSettings lens = StackTraits<LensSettings>.Check(L, 2);
			obj2.m_Lens = lens;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Lens on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_Transitions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCamera obj2 = (CinemachineVirtualCamera)obj;
			CinemachineVirtualCameraBase.TransitionParams transitions = StackTraits<CinemachineVirtualCameraBase.TransitionParams>.Check(L, 2);
			obj2.m_Transitions = transitions;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Transitions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CreatePipelineOverride(IntPtr L)
	{
		try
		{
			CinemachineVirtualCamera.CreatePipelineOverride = (CinemachineVirtualCamera.CreatePipelineDelegate)ToLua.CheckDelegate<CinemachineVirtualCamera.CreatePipelineDelegate>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_DestroyPipelineOverride(IntPtr L)
	{
		try
		{
			CinemachineVirtualCamera.DestroyPipelineOverride = (CinemachineVirtualCamera.DestroyPipelineDelegate)ToLua.CheckDelegate<CinemachineVirtualCamera.DestroyPipelineDelegate>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LookAt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCamera obj2 = (CinemachineVirtualCamera)obj;
			Transform lookAt = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.LookAt = lookAt;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LookAt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Follow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCamera obj2 = (CinemachineVirtualCamera)obj;
			Transform follow = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.Follow = follow;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Follow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cinemachine_CinemachineVirtualCamera_DestroyPipelineDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<CinemachineVirtualCamera.DestroyPipelineDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<CinemachineVirtualCamera.DestroyPipelineDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cinemachine_CinemachineVirtualCamera_CreatePipelineDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<CinemachineVirtualCamera.CreatePipelineDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<CinemachineVirtualCamera.CreatePipelineDelegate>.Create(func, self);
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

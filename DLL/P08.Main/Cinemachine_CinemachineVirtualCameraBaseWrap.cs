using System;
using Cinemachine;
using LuaInterface;
using UnityEngine;

public class Cinemachine_CinemachineVirtualCameraBaseWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CinemachineVirtualCameraBase), typeof(MonoBehaviour));
		L.RegFunction("GetMaxDampTime", GetMaxDampTime);
		L.RegFunction("DetachedFollowTargetDamp", DetachedFollowTargetDamp);
		L.RegFunction("DetachedLookAtTargetDamp", DetachedLookAtTargetDamp);
		L.RegFunction("AddExtension", AddExtension);
		L.RegFunction("RemoveExtension", RemoveExtension);
		L.RegFunction("IsLiveChild", IsLiveChild);
		L.RegFunction("UpdateCameraState", UpdateCameraState);
		L.RegFunction("InternalUpdateCameraState", InternalUpdateCameraState);
		L.RegFunction("OnTransitionFromCamera", OnTransitionFromCamera);
		L.RegFunction("GetInputAxisProvider", GetInputAxisProvider);
		L.RegFunction("ResolveLookAt", ResolveLookAt);
		L.RegFunction("ResolveFollow", ResolveFollow);
		L.RegFunction("MoveToTopOfPrioritySubqueue", MoveToTopOfPrioritySubqueue);
		L.RegFunction("OnTargetObjectWarped", OnTargetObjectWarped);
		L.RegFunction("ForceCameraPosition", ForceCameraPosition);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("m_ExcludedPropertiesInInspector", get_m_ExcludedPropertiesInInspector, set_m_ExcludedPropertiesInInspector);
		L.RegVar("m_LockStageInInspector", get_m_LockStageInInspector, set_m_LockStageInInspector);
		L.RegVar("m_Priority", get_m_Priority, set_m_Priority);
		L.RegVar("FollowTargetAttachment", get_FollowTargetAttachment, set_FollowTargetAttachment);
		L.RegVar("LookAtTargetAttachment", get_LookAtTargetAttachment, set_LookAtTargetAttachment);
		L.RegVar("m_StandbyUpdate", get_m_StandbyUpdate, set_m_StandbyUpdate);
		L.RegVar("ValidatingStreamVersion", get_ValidatingStreamVersion, null);
		L.RegVar("Name", get_Name, null);
		L.RegVar("Description", get_Description, null);
		L.RegVar("Priority", get_Priority, set_Priority);
		L.RegVar("VirtualCameraGameObject", get_VirtualCameraGameObject, null);
		L.RegVar("IsValid", get_IsValid, null);
		L.RegVar("State", get_State, null);
		L.RegVar("ParentCamera", get_ParentCamera, null);
		L.RegVar("LookAt", get_LookAt, set_LookAt);
		L.RegVar("Follow", get_Follow, set_Follow);
		L.RegVar("PreviousStateIsValid", get_PreviousStateIsValid, set_PreviousStateIsValid);
		L.RegVar("FollowTargetChanged", get_FollowTargetChanged, null);
		L.RegVar("LookAtTargetChanged", get_LookAtTargetChanged, null);
		L.RegVar("AbstractFollowTargetGroup", get_AbstractFollowTargetGroup, null);
		L.RegVar("FollowTargetAsVcam", get_FollowTargetAsVcam, null);
		L.RegVar("AbstractLookAtTargetGroup", get_AbstractLookAtTargetGroup, null);
		L.RegVar("LookAtTargetAsVcam", get_LookAtTargetAsVcam, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaxDampTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float maxDampTime = ((CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1)).GetMaxDampTime();
			LuaDLL.lua_pushnumber(L, maxDampTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DetachedFollowTargetDamp(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 4 && TypeChecker.CheckTypes<float, float, float>(L, 2))
			{
				CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				float initial = (float)LuaDLL.lua_tonumber(L, 2);
				float dampTime = (float)LuaDLL.lua_tonumber(L, 3);
				float deltaTime = (float)LuaDLL.lua_tonumber(L, 4);
				float num2 = obj.DetachedFollowTargetDamp(initial, dampTime, deltaTime);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, float>(L, 2))
			{
				CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				Vector3 initial2 = ToLua.ToVector3(L, 2);
				Vector3 dampTime2 = ToLua.ToVector3(L, 3);
				float deltaTime2 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 v = obj2.DetachedFollowTargetDamp(initial2, dampTime2, deltaTime2);
				ToLua.Push(L, v);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, float, float>(L, 2))
			{
				CinemachineVirtualCameraBase obj3 = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				Vector3 initial3 = ToLua.ToVector3(L, 2);
				float dampTime3 = (float)LuaDLL.lua_tonumber(L, 3);
				float deltaTime3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 v2 = obj3.DetachedFollowTargetDamp(initial3, dampTime3, deltaTime3);
				ToLua.Push(L, v2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Cinemachine.CinemachineVirtualCameraBase.DetachedFollowTargetDamp");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DetachedLookAtTargetDamp(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 4 && TypeChecker.CheckTypes<float, float, float>(L, 2))
			{
				CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				float initial = (float)LuaDLL.lua_tonumber(L, 2);
				float dampTime = (float)LuaDLL.lua_tonumber(L, 3);
				float deltaTime = (float)LuaDLL.lua_tonumber(L, 4);
				float num2 = obj.DetachedLookAtTargetDamp(initial, dampTime, deltaTime);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, float>(L, 2))
			{
				CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				Vector3 initial2 = ToLua.ToVector3(L, 2);
				Vector3 dampTime2 = ToLua.ToVector3(L, 3);
				float deltaTime2 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 v = obj2.DetachedLookAtTargetDamp(initial2, dampTime2, deltaTime2);
				ToLua.Push(L, v);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, float, float>(L, 2))
			{
				CinemachineVirtualCameraBase obj3 = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				Vector3 initial3 = ToLua.ToVector3(L, 2);
				float dampTime3 = (float)LuaDLL.lua_tonumber(L, 3);
				float deltaTime3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 v2 = obj3.DetachedLookAtTargetDamp(initial3, dampTime3, deltaTime3);
				ToLua.Push(L, v2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Cinemachine.CinemachineVirtualCameraBase.DetachedLookAtTargetDamp");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddExtension(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
			CinemachineExtension extension = (CinemachineExtension)ToLua.CheckObject<CinemachineExtension>(L, 2);
			obj.AddExtension(extension);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveExtension(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
			CinemachineExtension extension = (CinemachineExtension)ToLua.CheckObject<CinemachineExtension>(L, 2);
			obj.RemoveExtension(extension);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsLiveChild(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				ICinemachineCamera vcam2 = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 2);
				bool value2 = obj2.IsLiveChild(vcam2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
			{
				CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
				ICinemachineCamera vcam = (ICinemachineCamera)ToLua.CheckObject<ICinemachineCamera>(L, 2);
				bool dominantChildOnly = LuaDLL.luaL_checkboolean(L, 3);
				bool value = obj.IsLiveChild(vcam, dominantChildOnly);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Cinemachine.CinemachineVirtualCameraBase.IsLiveChild");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateCameraState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
			Vector3 worldUp = ToLua.ToVector3(L, 2);
			float deltaTime = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.UpdateCameraState(worldUp, deltaTime);
			return 0;
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
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
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
	private static int OnTransitionFromCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
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
	private static int GetInputAxisProvider(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AxisState.IInputAxisProvider inputAxisProvider = ((CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1)).GetInputAxisProvider();
			ToLua.PushObject(L, inputAxisProvider);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResolveLookAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
			Transform localLookAt = (Transform)ToLua.CheckObject<Transform>(L, 2);
			Transform obj2 = obj.ResolveLookAt(localLookAt);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResolveFollow(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
			Transform localFollow = (Transform)ToLua.CheckObject<Transform>(L, 2);
			Transform obj2 = obj.ResolveFollow(localFollow);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveToTopOfPrioritySubqueue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1)).MoveToTopOfPrioritySubqueue();
			return 0;
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
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
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
			CinemachineVirtualCameraBase obj = (CinemachineVirtualCameraBase)ToLua.CheckObject<CinemachineVirtualCameraBase>(L, 1);
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
	private static int get_m_ExcludedPropertiesInInspector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string[] excludedPropertiesInInspector = ((CinemachineVirtualCameraBase)obj).m_ExcludedPropertiesInInspector;
			ToLua.Push(L, excludedPropertiesInInspector);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ExcludedPropertiesInInspector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_LockStageInInspector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineCore.Stage[] lockStageInInspector = ((CinemachineVirtualCameraBase)obj).m_LockStageInInspector;
			ToLua.Push(L, lockStageInInspector);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_LockStageInInspector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_Priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int priority = ((CinemachineVirtualCameraBase)obj).m_Priority;
			LuaDLL.lua_pushinteger(L, priority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FollowTargetAttachment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float followTargetAttachment = ((CinemachineVirtualCameraBase)obj).FollowTargetAttachment;
			LuaDLL.lua_pushnumber(L, followTargetAttachment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FollowTargetAttachment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LookAtTargetAttachment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lookAtTargetAttachment = ((CinemachineVirtualCameraBase)obj).LookAtTargetAttachment;
			LuaDLL.lua_pushnumber(L, lookAtTargetAttachment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LookAtTargetAttachment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_StandbyUpdate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase.StandbyUpdateMode standbyUpdate = ((CinemachineVirtualCameraBase)obj).m_StandbyUpdate;
			ToLua.Push(L, standbyUpdate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_StandbyUpdate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ValidatingStreamVersion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int validatingStreamVersion = ((CinemachineVirtualCameraBase)obj).ValidatingStreamVersion;
			LuaDLL.lua_pushinteger(L, validatingStreamVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ValidatingStreamVersion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((CinemachineVirtualCameraBase)obj).Name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Description(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string description = ((CinemachineVirtualCameraBase)obj).Description;
			LuaDLL.lua_pushstring(L, description);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Description on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int priority = ((CinemachineVirtualCameraBase)obj).Priority;
			LuaDLL.lua_pushinteger(L, priority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VirtualCameraGameObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject virtualCameraGameObject = ((CinemachineVirtualCameraBase)obj).VirtualCameraGameObject;
			ToLua.PushSealed(L, virtualCameraGameObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VirtualCameraGameObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsValid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isValid = ((CinemachineVirtualCameraBase)obj).IsValid;
			LuaDLL.lua_pushboolean(L, isValid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsValid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_State(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraState state = ((CinemachineVirtualCameraBase)obj).State;
			ToLua.PushValue(L, state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index State on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ParentCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ICinemachineCamera parentCamera = ((CinemachineVirtualCameraBase)obj).ParentCamera;
			ToLua.PushObject(L, parentCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ParentCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LookAt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform lookAt = ((CinemachineVirtualCameraBase)obj).LookAt;
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
			Transform follow = ((CinemachineVirtualCameraBase)obj).Follow;
			ToLua.Push(L, follow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Follow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PreviousStateIsValid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool previousStateIsValid = ((CinemachineVirtualCameraBase)obj).PreviousStateIsValid;
			LuaDLL.lua_pushboolean(L, previousStateIsValid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PreviousStateIsValid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FollowTargetChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool followTargetChanged = ((CinemachineVirtualCameraBase)obj).FollowTargetChanged;
			LuaDLL.lua_pushboolean(L, followTargetChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FollowTargetChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LookAtTargetChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool lookAtTargetChanged = ((CinemachineVirtualCameraBase)obj).LookAtTargetChanged;
			LuaDLL.lua_pushboolean(L, lookAtTargetChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LookAtTargetChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AbstractFollowTargetGroup(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ICinemachineTargetGroup abstractFollowTargetGroup = ((CinemachineVirtualCameraBase)obj).AbstractFollowTargetGroup;
			ToLua.PushObject(L, abstractFollowTargetGroup);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AbstractFollowTargetGroup on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FollowTargetAsVcam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase followTargetAsVcam = ((CinemachineVirtualCameraBase)obj).FollowTargetAsVcam;
			ToLua.Push(L, followTargetAsVcam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FollowTargetAsVcam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AbstractLookAtTargetGroup(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ICinemachineTargetGroup abstractLookAtTargetGroup = ((CinemachineVirtualCameraBase)obj).AbstractLookAtTargetGroup;
			ToLua.PushObject(L, abstractLookAtTargetGroup);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AbstractLookAtTargetGroup on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LookAtTargetAsVcam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase lookAtTargetAsVcam = ((CinemachineVirtualCameraBase)obj).LookAtTargetAsVcam;
			ToLua.Push(L, lookAtTargetAsVcam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LookAtTargetAsVcam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_ExcludedPropertiesInInspector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			string[] excludedPropertiesInInspector = ToLua.CheckStringArray(L, 2);
			obj2.m_ExcludedPropertiesInInspector = excludedPropertiesInInspector;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ExcludedPropertiesInInspector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_LockStageInInspector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			CinemachineCore.Stage[] lockStageInInspector = ToLua.CheckStructArray<CinemachineCore.Stage>(L, 2);
			obj2.m_LockStageInInspector = lockStageInInspector;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_LockStageInInspector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_Priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			int priority = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.m_Priority = priority;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_Priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_FollowTargetAttachment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			float followTargetAttachment = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.FollowTargetAttachment = followTargetAttachment;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FollowTargetAttachment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LookAtTargetAttachment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			float lookAtTargetAttachment = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.LookAtTargetAttachment = lookAtTargetAttachment;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LookAtTargetAttachment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_StandbyUpdate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			CinemachineVirtualCameraBase.StandbyUpdateMode standbyUpdate = (CinemachineVirtualCameraBase.StandbyUpdateMode)ToLua.CheckObject(L, 2, typeof(CinemachineVirtualCameraBase.StandbyUpdateMode));
			obj2.m_StandbyUpdate = standbyUpdate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_StandbyUpdate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			int priority = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.Priority = priority;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LookAt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
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
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
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
	private static int set_PreviousStateIsValid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCameraBase obj2 = (CinemachineVirtualCameraBase)obj;
			bool previousStateIsValid = LuaDLL.luaL_checkboolean(L, 2);
			obj2.PreviousStateIsValid = previousStateIsValid;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PreviousStateIsValid on a nil value");
		}
	}
}

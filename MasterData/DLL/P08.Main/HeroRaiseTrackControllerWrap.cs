using System;
using System.Collections.Generic;
using Cinemachine;
using LuaInterface;
using UnityEngine;

public class HeroRaiseTrackControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HeroRaiseTrackController), typeof(MonoBehaviour));
		L.RegFunction("LoadTrackData", LoadTrackData);
		L.RegFunction("ChangePathPosition", ChangePathPosition);
		L.RegFunction("ChangeSubCamera", ChangeSubCamera);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("virtualCamera", get_virtualCamera, set_virtualCamera);
		L.RegVar("cameraData", get_cameraData, set_cameraData);
		L.RegVar("positionTime", get_positionTime, set_positionTime);
		L.RegVar("bodyTime", get_bodyTime, set_bodyTime);
		L.RegVar("Speed", get_Speed, set_Speed);
		L.RegVar("XDamping", get_XDamping, set_XDamping);
		L.RegVar("YDamping", get_YDamping, set_YDamping);
		L.RegVar("ZDamping", get_ZDamping, set_ZDamping);
		L.RegVar("heroRaiseSubLists", get_heroRaiseSubLists, set_heroRaiseSubLists);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadTrackData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HeroRaiseTrackController obj = (HeroRaiseTrackController)ToLua.CheckObject<HeroRaiseTrackController>(L, 1);
			string path = ToLua.CheckString(L, 2);
			bool value = obj.LoadTrackData(path);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangePathPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			HeroRaiseTrackController obj = (HeroRaiseTrackController)ToLua.CheckObject<HeroRaiseTrackController>(L, 1);
			int target = (int)LuaDLL.luaL_checknumber(L, 2);
			bool isForce = LuaDLL.luaL_checkboolean(L, 3);
			obj.ChangePathPosition(target, isForce);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeSubCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			HeroRaiseTrackController obj = (HeroRaiseTrackController)ToLua.CheckObject<HeroRaiseTrackController>(L, 1);
			int pageIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int target = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ChangeSubCamera(pageIndex, target);
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
	private static int get_virtualCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineVirtualCamera virtualCamera = ((HeroRaiseTrackController)obj).virtualCamera;
			ToLua.Push(L, virtualCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index virtualCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameraData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackData cameraData = ((HeroRaiseTrackController)obj).cameraData;
			ToLua.Push(L, cameraData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_positionTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float positionTime = ((HeroRaiseTrackController)obj).positionTime;
			LuaDLL.lua_pushnumber(L, positionTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index positionTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bodyTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float bodyTime = ((HeroRaiseTrackController)obj).bodyTime;
			LuaDLL.lua_pushnumber(L, bodyTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationCurve speed = ((HeroRaiseTrackController)obj).Speed;
			ToLua.PushObject(L, speed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_XDamping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationCurve xDamping = ((HeroRaiseTrackController)obj).XDamping;
			ToLua.PushObject(L, xDamping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index XDamping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_YDamping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationCurve yDamping = ((HeroRaiseTrackController)obj).YDamping;
			ToLua.PushObject(L, yDamping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index YDamping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ZDamping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationCurve zDamping = ((HeroRaiseTrackController)obj).ZDamping;
			ToLua.PushObject(L, zDamping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ZDamping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_heroRaiseSubLists(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<HeroRaiseSubNode> heroRaiseSubLists = ((HeroRaiseTrackController)obj).heroRaiseSubLists;
			ToLua.PushSealed(L, heroRaiseSubLists);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index heroRaiseSubLists on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_virtualCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			CinemachineVirtualCamera virtualCamera = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 2);
			obj2.virtualCamera = virtualCamera;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index virtualCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cameraData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			HeroRaiseTrackData cameraData = (HeroRaiseTrackData)ToLua.CheckObject<HeroRaiseTrackData>(L, 2);
			obj2.cameraData = cameraData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_positionTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			float positionTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.positionTime = positionTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index positionTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bodyTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			float bodyTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.bodyTime = bodyTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			AnimationCurve speed = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			obj2.Speed = speed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_XDamping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			AnimationCurve xDamping = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			obj2.XDamping = xDamping;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index XDamping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_YDamping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			AnimationCurve yDamping = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			obj2.YDamping = yDamping;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index YDamping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ZDamping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			AnimationCurve zDamping = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			obj2.ZDamping = zDamping;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ZDamping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_heroRaiseSubLists(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackController obj2 = (HeroRaiseTrackController)obj;
			List<HeroRaiseSubNode> heroRaiseSubLists = (List<HeroRaiseSubNode>)ToLua.CheckObject(L, 2, typeof(List<HeroRaiseSubNode>));
			obj2.heroRaiseSubLists = heroRaiseSubLists;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index heroRaiseSubLists on a nil value");
		}
	}
}

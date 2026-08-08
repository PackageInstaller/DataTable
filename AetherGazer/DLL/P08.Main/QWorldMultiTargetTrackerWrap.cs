using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class QWorldMultiTargetTrackerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldMultiTargetTracker), typeof(MonoBehaviour));
		L.RegFunction("UpdateTrack", UpdateTrack);
		L.RegFunction("SetTargetList", SetTargetList);
		L.RegFunction("ClearTargetList", ClearTargetList);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("canvas", get_canvas, set_canvas);
		L.RegVar("iconPrefab", get_iconPrefab, set_iconPrefab);
		L.RegVar("ellipseRadius", get_ellipseRadius, set_ellipseRadius);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateTrack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMultiTargetTracker obj = (QWorldMultiTargetTracker)ToLua.CheckObject<QWorldMultiTargetTracker>(L, 1);
			int[] trackEntityIds = ToLua.CheckNumberArray<int>(L, 2);
			obj.UpdateTrack(trackEntityIds);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTargetList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMultiTargetTracker obj = (QWorldMultiTargetTracker)ToLua.CheckObject<QWorldMultiTargetTracker>(L, 1);
			List<QWorldMapEntity> targetList = (List<QWorldMapEntity>)ToLua.CheckObject(L, 2, typeof(List<QWorldMapEntity>));
			obj.SetTargetList(targetList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearTargetList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWorldMultiTargetTracker)ToLua.CheckObject<QWorldMultiTargetTracker>(L, 1)).ClearTargetList();
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
	private static int get_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas canvas = ((QWorldMultiTargetTracker)obj).canvas;
			ToLua.PushSealed(L, canvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_iconPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject iconPrefab = ((QWorldMultiTargetTracker)obj).iconPrefab;
			ToLua.PushSealed(L, iconPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index iconPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ellipseRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 ellipseRadius = ((QWorldMultiTargetTracker)obj).ellipseRadius;
			ToLua.Push(L, ellipseRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ellipseRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMultiTargetTracker obj2 = (QWorldMultiTargetTracker)obj;
			Canvas canvas = (Canvas)ToLua.CheckObject(L, 2, typeof(Canvas));
			obj2.canvas = canvas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_iconPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMultiTargetTracker obj2 = (QWorldMultiTargetTracker)obj;
			GameObject iconPrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.iconPrefab = iconPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index iconPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ellipseRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMultiTargetTracker obj2 = (QWorldMultiTargetTracker)obj;
			Vector2 ellipseRadius = ToLua.ToVector2(L, 2);
			obj2.ellipseRadius = ellipseRadius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ellipseRadius on a nil value");
		}
	}
}

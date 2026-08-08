using System;
using LuaInterface;
using UnityEngine;

public class DebugMgrWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DebugMgr), typeof(MonoBehaviour));
		L.RegFunction("Active", Active);
		L.RegFunction("Deactive", Deactive);
		L.RegFunction("StartFileLogger", StartFileLogger);
		L.RegFunction("Log2File", Log2File);
		L.RegFunction("StopFileLogger", StopFileLogger);
		L.RegFunction("DrawCube", DrawCube);
		L.RegFunction("DrawCircle", DrawCircle);
		L.RegFunction("RemoveGeometry", RemoveGeometry);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Inst", get_Inst, null);
		L.RegVar("DebugPanel", get_DebugPanel, null);
		L.RegVar("AutoScroll", get_AutoScroll, set_AutoScroll);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Active(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1)).Active();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Deactive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1)).Deactive();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartFileLogger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DebugMgr obj = (DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1);
			string fileName = ToLua.CheckString(L, 2);
			int n = obj.StartFileLogger(fileName);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Log2File(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DebugMgr obj = (DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1);
			string content = ToLua.CheckString(L, 2);
			int n = obj.Log2File(content);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopFileLogger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = ((DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1)).StopFileLogger();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawCube(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			DebugMgr obj = (DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1);
			float centerX = (float)LuaDLL.luaL_checknumber(L, 2);
			float centerY = (float)LuaDLL.luaL_checknumber(L, 3);
			float width = (float)LuaDLL.luaL_checknumber(L, 4);
			float height = (float)LuaDLL.luaL_checknumber(L, 5);
			Color color = ToLua.ToColor(L, 6);
			obj.DrawCube(centerX, centerY, width, height, color);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawCircle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			DebugMgr obj = (DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1);
			float centerX = (float)LuaDLL.luaL_checknumber(L, 2);
			float centerY = (float)LuaDLL.luaL_checknumber(L, 3);
			float radius = (float)LuaDLL.luaL_checknumber(L, 4);
			Color color = ToLua.ToColor(L, 5);
			obj.DrawCircle(centerX, centerY, radius, color);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveGeometry(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DebugMgr)ToLua.CheckObject<DebugMgr>(L, 1)).RemoveGeometry();
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
	private static int get_Inst(IntPtr L)
	{
		try
		{
			ToLua.Push(L, DebugMgr.Inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DebugPanel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform debugPanel = ((DebugMgr)obj).DebugPanel;
			ToLua.Push(L, debugPanel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DebugPanel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AutoScroll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool autoScroll = ((DebugMgr)obj).AutoScroll;
			LuaDLL.lua_pushboolean(L, autoScroll);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AutoScroll on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AutoScroll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DebugMgr obj2 = (DebugMgr)obj;
			bool autoScroll = LuaDLL.luaL_checkboolean(L, 2);
			obj2.AutoScroll = autoScroll;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AutoScroll on a nil value");
		}
	}
}

using System;
using LuaInterface;
using UnityEngine;

public class QWorldHelperWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("QWorldHelper");
		L.RegFunction("Teleport", Teleport);
		L.RegFunction("TeleportToCachePos", TeleportToCachePos);
		L.RegFunction("GetPlayer", GetPlayer);
		L.RegFunction("GetStoryWordContent", GetStoryWordContent);
		L.RegFunction("GetRadiusFromThreePoint", GetRadiusFromThreePoint);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Teleport(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldHelper.Teleport((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TeleportToCachePos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 position = ToLua.ToVector3(L, 1);
			Quaternion rotation = ToLua.ToQuaternion(L, 2);
			QWorldHelper.TeleportToCachePos(position, rotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWCharacterAgent player = QWorldHelper.GetPlayer();
			ToLua.Push(L, player);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStoryWordContent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string storyWordContent = QWorldHelper.GetStoryWordContent((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushstring(L, storyWordContent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRadiusFromThreePoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Vector2 p = ToLua.ToVector2(L, 1);
			Vector2 p2 = ToLua.ToVector2(L, 2);
			Vector2 p3 = ToLua.ToVector2(L, 3);
			float radiusFromThreePoint = QWorldHelper.GetRadiusFromThreePoint(p, p2, p3);
			LuaDLL.lua_pushnumber(L, radiusFromThreePoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

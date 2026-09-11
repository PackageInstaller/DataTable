using System;
using LuaInterface;
using UnityEngine;

public class GuildActivitySPLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivitySPLuaBridge), typeof(MonoBehaviour));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("MoveCameraAimAtNode", MoveCameraAimAtNode);
		L.RegFunction("PlayNodeAnimation", PlayNodeAnimation);
		L.RegFunction("StartGuildActivity", StartGuildActivity);
		L.RegFunction("GetManager", GetManager);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GuildActivitySPDataForExchange musicSpDataForExchange = (GuildActivitySPDataForExchange)ToLua.CheckObject<GuildActivitySPDataForExchange>(L, 1);
			Action onStart = (Action)ToLua.CheckDelegate<Action>(L, 2);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 3);
			GuildActivitySPLuaBridge.Launcher(musicSpDataForExchange, onStart, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveCameraAimAtNode(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				GuildActivitySPLuaBridge.MoveCameraAimAtNode((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int nodeID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				float time3 = (float)LuaDLL.luaL_checknumber(L, 2);
				GuildActivitySPLuaBridge.MoveCameraAimAtNode(nodeID3, time3);
				return 0;
			}
			case 3:
			{
				int nodeID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				float time2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float offset2 = (float)LuaDLL.luaL_checknumber(L, 3);
				GuildActivitySPLuaBridge.MoveCameraAimAtNode(nodeID2, time2, offset2);
				return 0;
			}
			case 4:
			{
				int nodeID = (int)LuaDLL.luaL_checknumber(L, 1);
				float time = (float)LuaDLL.luaL_checknumber(L, 2);
				float offset = (float)LuaDLL.luaL_checknumber(L, 3);
				Action onComplete = (Action)ToLua.CheckDelegate<Action>(L, 4);
				GuildActivitySPLuaBridge.MoveCameraAimAtNode(nodeID, time, offset, onComplete);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: GuildActivitySPLuaBridge.MoveCameraAimAtNode");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayNodeAnimation(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				GuildActivitySPLuaBridge.PlayNodeAnimation((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int nodeID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int action3 = (int)LuaDLL.luaL_checknumber(L, 2);
				GuildActivitySPLuaBridge.PlayNodeAnimation(nodeID3, action3);
				return 0;
			}
			case 3:
			{
				int nodeID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int action2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action onComplete2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				GuildActivitySPLuaBridge.PlayNodeAnimation(nodeID2, action2, onComplete2);
				return 0;
			}
			case 4:
			{
				int nodeID = (int)LuaDLL.luaL_checknumber(L, 1);
				int action = (int)LuaDLL.luaL_checknumber(L, 2);
				Action onComplete = (Action)ToLua.CheckDelegate<Action>(L, 3);
				float time = (float)LuaDLL.luaL_checknumber(L, 4);
				GuildActivitySPLuaBridge.PlayNodeAnimation(nodeID, action, onComplete, time);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: GuildActivitySPLuaBridge.PlayNodeAnimation");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGuildActivity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GuildActivitySPLuaBridge.StartGuildActivity((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetManager(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GuildActivitySPManager manager = GuildActivitySPLuaBridge.GetManager();
			ToLua.Push(L, manager);
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
}

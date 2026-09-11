using System;
using LuaInterface;
using T0World;

public class T0World_T0SDKDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(T0SDKData), typeof(object));
		L.RegFunction("New", _CreateT0World_T0SDKData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sdkType", get_sdkType, set_sdkType);
		L.RegVar("sdkExtraType", get_sdkExtraType, set_sdkExtraType);
		L.RegVar("entityID", get_entityID, set_entityID);
		L.RegVar("treeID", get_treeID, set_treeID);
		L.RegVar("nodeID", get_nodeID, set_nodeID);
		L.RegVar("characterID", get_characterID, set_characterID);
		L.RegVar("select_list", get_select_list, set_select_list);
		L.RegVar("select_param", get_select_param, set_select_param);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateT0World_T0SDKData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				T0SDKData o = new T0SDKData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: T0World.T0SDKData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sdkType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sdkType = ((T0SDKData)obj).sdkType;
			LuaDLL.lua_pushinteger(L, sdkType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sdkType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sdkExtraType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sdkExtraType = ((T0SDKData)obj).sdkExtraType;
			LuaDLL.lua_pushinteger(L, sdkExtraType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sdkExtraType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_entityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int entityID = ((T0SDKData)obj).entityID;
			LuaDLL.lua_pushinteger(L, entityID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_treeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int treeID = ((T0SDKData)obj).treeID;
			LuaDLL.lua_pushinteger(L, treeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index treeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nodeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int nodeID = ((T0SDKData)obj).nodeID;
			LuaDLL.lua_pushinteger(L, nodeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nodeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_characterID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int characterID = ((T0SDKData)obj).characterID;
			LuaDLL.lua_pushinteger(L, characterID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_select_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string select_list = ((T0SDKData)obj).select_list;
			LuaDLL.lua_pushstring(L, select_list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index select_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_select_param(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string select_param = ((T0SDKData)obj).select_param;
			LuaDLL.lua_pushstring(L, select_param);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index select_param on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sdkType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			int sdkType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sdkType = sdkType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sdkType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sdkExtraType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			int sdkExtraType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sdkExtraType = sdkExtraType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sdkExtraType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_entityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.entityID = entityID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_treeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			int treeID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.treeID = treeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index treeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nodeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			int nodeID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.nodeID = nodeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nodeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_characterID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			int characterID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.characterID = characterID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_select_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			string select_list = ToLua.CheckString(L, 2);
			obj2.select_list = select_list;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index select_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_select_param(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0SDKData obj2 = (T0SDKData)obj;
			string select_param = ToLua.CheckString(L, 2);
			obj2.select_param = select_param;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index select_param on a nil value");
		}
	}
}

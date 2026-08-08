using System;
using LuaInterface;

public class DormDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DormDataForExchange), typeof(object));
		L.RegFunction("New", _CreateDormDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sceneName", get_sceneName, set_sceneName);
		L.RegVar("sceneType", get_sceneType, set_sceneType);
		L.RegVar("dormMapCfg", get_dormMapCfg, set_dormMapCfg);
		L.RegVar("furnitureConfigs", get_furnitureConfigs, set_furnitureConfigs);
		L.RegVar("mapFurnitureInfoS", get_mapFurnitureInfoS, set_mapFurnitureInfoS);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateDormDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				DormDataForExchange o = new DormDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: DormDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string sceneName = ((DormDataForExchange)obj).sceneName;
			LuaDLL.lua_pushstring(L, sceneName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sceneType = ((DormDataForExchange)obj).sceneType;
			LuaDLL.lua_pushinteger(L, sceneType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dormMapCfg(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormMapCfg[] dormMapCfg = ((DormDataForExchange)obj).dormMapCfg;
			ToLua.Push(L, dormMapCfg);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dormMapCfg on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_furnitureConfigs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FurnitureConfig[] furnitureConfigs = ((DormDataForExchange)obj).furnitureConfigs;
			ToLua.Push(L, furnitureConfigs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furnitureConfigs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapFurnitureInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoomInfo mapFurnitureInfoS = ((DormDataForExchange)obj).mapFurnitureInfoS;
			ToLua.PushObject(L, mapFurnitureInfoS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapFurnitureInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sceneName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormDataForExchange obj2 = (DormDataForExchange)obj;
			string sceneName = ToLua.CheckString(L, 2);
			obj2.sceneName = sceneName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sceneType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormDataForExchange obj2 = (DormDataForExchange)obj;
			int sceneType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sceneType = sceneType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dormMapCfg(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormDataForExchange obj2 = (DormDataForExchange)obj;
			DormMapCfg[] dormMapCfg = ToLua.CheckObjectArray<DormMapCfg>(L, 2);
			obj2.dormMapCfg = dormMapCfg;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dormMapCfg on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_furnitureConfigs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormDataForExchange obj2 = (DormDataForExchange)obj;
			FurnitureConfig[] furnitureConfigs = ToLua.CheckObjectArray<FurnitureConfig>(L, 2);
			obj2.furnitureConfigs = furnitureConfigs;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furnitureConfigs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapFurnitureInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormDataForExchange obj2 = (DormDataForExchange)obj;
			RoomInfo mapFurnitureInfoS = (RoomInfo)ToLua.CheckObject<RoomInfo>(L, 2);
			obj2.mapFurnitureInfoS = mapFurnitureInfoS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapFurnitureInfoS on a nil value");
		}
	}
}

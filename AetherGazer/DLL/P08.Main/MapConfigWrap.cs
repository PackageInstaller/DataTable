using System;
using LuaInterface;

public class MapConfigWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MapConfig), typeof(object));
		L.RegFunction("New", _CreateMapConfig);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mapId", get_mapId, set_mapId);
		L.RegVar("sceneId", get_sceneId, set_sceneId);
		L.RegVar("minFreeLookX", get_minFreeLookX, set_minFreeLookX);
		L.RegVar("maxFreeLookX", get_maxFreeLookX, set_maxFreeLookX);
		L.RegVar("minFreeLookZ", get_minFreeLookZ, set_minFreeLookZ);
		L.RegVar("maxFreeLookZ", get_maxFreeLookZ, set_maxFreeLookZ);
		L.RegVar("modelName", get_modelName, set_modelName);
		L.RegVar("modelScale", get_modelScale, set_modelScale);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateMapConfig(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MapConfig o = new MapConfig();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: MapConfig.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mapId = ((MapConfig)obj).mapId;
			LuaDLL.lua_pushinteger(L, mapId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string sceneId = ((MapConfig)obj).sceneId;
			LuaDLL.lua_pushstring(L, sceneId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minFreeLookX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minFreeLookX = ((MapConfig)obj).minFreeLookX;
			LuaDLL.lua_pushnumber(L, minFreeLookX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minFreeLookX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxFreeLookX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxFreeLookX = ((MapConfig)obj).maxFreeLookX;
			LuaDLL.lua_pushnumber(L, maxFreeLookX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFreeLookX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minFreeLookZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minFreeLookZ = ((MapConfig)obj).minFreeLookZ;
			LuaDLL.lua_pushnumber(L, minFreeLookZ);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minFreeLookZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxFreeLookZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxFreeLookZ = ((MapConfig)obj).maxFreeLookZ;
			LuaDLL.lua_pushnumber(L, maxFreeLookZ);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFreeLookZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_modelName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string modelName = ((MapConfig)obj).modelName;
			LuaDLL.lua_pushstring(L, modelName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index modelName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_modelScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float modelScale = ((MapConfig)obj).modelScale;
			LuaDLL.lua_pushnumber(L, modelScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index modelScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			int mapId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mapId = mapId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sceneId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			string sceneId = ToLua.CheckString(L, 2);
			obj2.sceneId = sceneId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minFreeLookX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			float minFreeLookX = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minFreeLookX = minFreeLookX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minFreeLookX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxFreeLookX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			float maxFreeLookX = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxFreeLookX = maxFreeLookX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFreeLookX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minFreeLookZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			float minFreeLookZ = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minFreeLookZ = minFreeLookZ;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minFreeLookZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxFreeLookZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			float maxFreeLookZ = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxFreeLookZ = maxFreeLookZ;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFreeLookZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_modelName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			string modelName = ToLua.CheckString(L, 2);
			obj2.modelName = modelName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index modelName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_modelScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig obj2 = (MapConfig)obj;
			float modelScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.modelScale = modelScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index modelScale on a nil value");
		}
	}
}

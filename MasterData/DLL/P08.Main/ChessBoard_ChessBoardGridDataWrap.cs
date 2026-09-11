using System;
using ChessBoard;
using LuaInterface;

public class ChessBoard_ChessBoardGridDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardGridData), typeof(object));
		L.RegFunction("New", _CreateChessBoard_ChessBoardGridData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("prefab", get_prefab, set_prefab);
		L.RegVar("rotationY", get_rotationY, set_rotationY);
		L.RegVar("typeID", get_typeID, set_typeID);
		L.RegVar("x", get_x, set_x);
		L.RegVar("z", get_z, set_z);
		L.RegVar("banDir", get_banDir, set_banDir);
		L.RegVar("banDirIsHide", get_banDirIsHide, set_banDirIsHide);
		L.RegVar("enterParam", get_enterParam, set_enterParam);
		L.RegVar("exitParam", get_exitParam, set_exitParam);
		L.RegVar("startMoveParam", get_startMoveParam, set_startMoveParam);
		L.RegVar("endMoveParam", get_endMoveParam, set_endMoveParam);
		L.RegVar("status", get_status, set_status);
		L.RegVar("thingPrefab", get_thingPrefab, set_thingPrefab);
		L.RegVar("thingRotationY", get_thingRotationY, set_thingRotationY);
		L.RegVar("thingTypeID", get_thingTypeID, set_thingTypeID);
		L.RegVar("thingEnterParam", get_thingEnterParam, set_thingEnterParam);
		L.RegVar("thingExitParam", get_thingExitParam, set_thingExitParam);
		L.RegVar("thingStartMoveParam", get_thingStartMoveParam, set_thingStartMoveParam);
		L.RegVar("thingEndMoveParam", get_thingEndMoveParam, set_thingEndMoveParam);
		L.RegVar("offsetY", get_offsetY, set_offsetY);
		L.RegVar("walkable", get_walkable, set_walkable);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoard_ChessBoardGridData(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				ChessBoardGridData o2 = new ChessBoardGridData();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
			{
				ChessBoardGridData o = new ChessBoardGridData((ChessBoardGridData)ToLua.CheckObject<ChessBoardGridData>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoard.ChessBoardGridData.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string prefab = ((ChessBoardGridData)obj).prefab;
			LuaDLL.lua_pushstring(L, prefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotationY = ((ChessBoardGridData)obj).rotationY;
			LuaDLL.lua_pushnumber(L, rotationY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_typeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int typeID = ((ChessBoardGridData)obj).typeID;
			LuaDLL.lua_pushinteger(L, typeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			short x = ((ChessBoardGridData)obj).x;
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index x on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_z(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			short z = ((ChessBoardGridData)obj).z;
			LuaDLL.lua_pushnumber(L, z);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_banDir(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool[] banDir = ((ChessBoardGridData)obj).banDir;
			ToLua.Push(L, banDir);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index banDir on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_banDirIsHide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool[] banDirIsHide = ((ChessBoardGridData)obj).banDirIsHide;
			ToLua.Push(L, banDirIsHide);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index banDirIsHide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enterParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int enterParam = ((ChessBoardGridData)obj).enterParam;
			LuaDLL.lua_pushinteger(L, enterParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enterParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_exitParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int exitParam = ((ChessBoardGridData)obj).exitParam;
			LuaDLL.lua_pushinteger(L, exitParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exitParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int startMoveParam = ((ChessBoardGridData)obj).startMoveParam;
			LuaDLL.lua_pushinteger(L, startMoveParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_endMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int endMoveParam = ((ChessBoardGridData)obj).endMoveParam;
			LuaDLL.lua_pushinteger(L, endMoveParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index endMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int status = ((ChessBoardGridData)obj).status;
			LuaDLL.lua_pushinteger(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string thingPrefab = ((ChessBoardGridData)obj).thingPrefab;
			LuaDLL.lua_pushstring(L, thingPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float thingRotationY = ((ChessBoardGridData)obj).thingRotationY;
			LuaDLL.lua_pushnumber(L, thingRotationY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingRotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingTypeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int thingTypeID = ((ChessBoardGridData)obj).thingTypeID;
			LuaDLL.lua_pushinteger(L, thingTypeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingTypeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingEnterParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int thingEnterParam = ((ChessBoardGridData)obj).thingEnterParam;
			LuaDLL.lua_pushinteger(L, thingEnterParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingEnterParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingExitParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int thingExitParam = ((ChessBoardGridData)obj).thingExitParam;
			LuaDLL.lua_pushinteger(L, thingExitParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingExitParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingStartMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int thingStartMoveParam = ((ChessBoardGridData)obj).thingStartMoveParam;
			LuaDLL.lua_pushinteger(L, thingStartMoveParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingStartMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingEndMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int thingEndMoveParam = ((ChessBoardGridData)obj).thingEndMoveParam;
			LuaDLL.lua_pushinteger(L, thingEndMoveParam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingEndMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_offsetY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float offsetY = ((ChessBoardGridData)obj).offsetY;
			LuaDLL.lua_pushnumber(L, offsetY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_walkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool walkable = ((ChessBoardGridData)obj).walkable;
			LuaDLL.lua_pushboolean(L, walkable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index walkable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			string prefab = ToLua.CheckString(L, 2);
			obj2.prefab = prefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			float rotationY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotationY = rotationY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_typeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int typeID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.typeID = typeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			short x = (short)LuaDLL.luaL_checknumber(L, 2);
			obj2.x = x;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index x on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_z(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			short z = (short)LuaDLL.luaL_checknumber(L, 2);
			obj2.z = z;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_banDir(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			bool[] banDir = ToLua.CheckBoolArray(L, 2);
			obj2.banDir = banDir;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index banDir on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_banDirIsHide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			bool[] banDirIsHide = ToLua.CheckBoolArray(L, 2);
			obj2.banDirIsHide = banDirIsHide;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index banDirIsHide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enterParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int enterParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.enterParam = enterParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enterParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_exitParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int exitParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.exitParam = exitParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exitParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int startMoveParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.startMoveParam = startMoveParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_endMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int endMoveParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.endMoveParam = endMoveParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index endMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int status = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.status = status;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			string thingPrefab = ToLua.CheckString(L, 2);
			obj2.thingPrefab = thingPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			float thingRotationY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingRotationY = thingRotationY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingRotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingTypeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int thingTypeID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingTypeID = thingTypeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingTypeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingEnterParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int thingEnterParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingEnterParam = thingEnterParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingEnterParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingExitParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int thingExitParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingExitParam = thingExitParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingExitParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingStartMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int thingStartMoveParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingStartMoveParam = thingStartMoveParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingStartMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingEndMoveParam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			int thingEndMoveParam = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingEndMoveParam = thingEndMoveParam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingEndMoveParam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_offsetY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			float offsetY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.offsetY = offsetY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_walkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridData obj2 = (ChessBoardGridData)obj;
			bool walkable = LuaDLL.luaL_checkboolean(L, 2);
			obj2.walkable = walkable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index walkable on a nil value");
		}
	}
}

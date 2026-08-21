using System;
using LuaInterface;
using NewChess;

public class NewChess_NewGridDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(NewGridData), typeof(object));
		L.RegFunction("New", _CreateNewChess_NewGridData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("prefab", get_prefab, set_prefab);
		L.RegVar("rotationY", get_rotationY, set_rotationY);
		L.RegVar("typeID", get_typeID, set_typeID);
		L.RegVar("x", get_x, set_x);
		L.RegVar("z", get_z, set_z);
		L.RegVar("enterParamList", get_enterParamList, set_enterParamList);
		L.RegVar("clickParamList", get_clickParamList, set_clickParamList);
		L.RegVar("exitParamList", get_exitParamList, set_exitParamList);
		L.RegVar("status", get_status, set_status);
		L.RegVar("objectPrefab", get_objectPrefab, set_objectPrefab);
		L.RegVar("objectRotationY", get_objectRotationY, set_objectRotationY);
		L.RegVar("objectTypeID", get_objectTypeID, set_objectTypeID);
		L.RegVar("objectEnterParamList", get_objectEnterParamList, set_objectEnterParamList);
		L.RegVar("objectClickParamList", get_objectClickParamList, set_objectClickParamList);
		L.RegVar("objectExitParamList", get_objectExitParamList, set_objectExitParamList);
		L.RegVar("objectFarClickParamList", get_objectFarClickParamList, set_objectFarClickParamList);
		L.RegVar("offsetY", get_offsetY, set_offsetY);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateNewChess_NewGridData(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				NewGridData o2 = new NewGridData();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
			{
				NewGridData o = new NewGridData((NewGridData)ToLua.CheckObject<NewGridData>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: NewChess.NewGridData.New");
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
			string prefab = ((NewGridData)obj).prefab;
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
			float rotationY = ((NewGridData)obj).rotationY;
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
			int typeID = ((NewGridData)obj).typeID;
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
			short x = ((NewGridData)obj).x;
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
			short z = ((NewGridData)obj).z;
			LuaDLL.lua_pushnumber(L, z);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enterParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] enterParamList = ((NewGridData)obj).enterParamList;
			ToLua.Push(L, enterParamList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enterParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clickParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] clickParamList = ((NewGridData)obj).clickParamList;
			ToLua.Push(L, clickParamList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_exitParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] exitParamList = ((NewGridData)obj).exitParamList;
			ToLua.Push(L, exitParamList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exitParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int status = ((NewGridData)obj).status;
			LuaDLL.lua_pushinteger(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string objectPrefab = ((NewGridData)obj).objectPrefab;
			LuaDLL.lua_pushstring(L, objectPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float objectRotationY = ((NewGridData)obj).objectRotationY;
			LuaDLL.lua_pushnumber(L, objectRotationY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectRotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectTypeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int objectTypeID = ((NewGridData)obj).objectTypeID;
			LuaDLL.lua_pushinteger(L, objectTypeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectTypeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectEnterParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] objectEnterParamList = ((NewGridData)obj).objectEnterParamList;
			ToLua.Push(L, objectEnterParamList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectEnterParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectClickParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] objectClickParamList = ((NewGridData)obj).objectClickParamList;
			ToLua.Push(L, objectClickParamList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectClickParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectExitParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] objectExitParamList = ((NewGridData)obj).objectExitParamList;
			ToLua.Push(L, objectExitParamList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectExitParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectFarClickParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] objectFarClickParamList = ((NewGridData)obj).objectFarClickParamList;
			ToLua.Push(L, objectFarClickParamList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectFarClickParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_offsetY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float offsetY = ((NewGridData)obj).offsetY;
			LuaDLL.lua_pushnumber(L, offsetY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
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
			NewGridData obj2 = (NewGridData)obj;
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
			NewGridData obj2 = (NewGridData)obj;
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
			NewGridData obj2 = (NewGridData)obj;
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
			NewGridData obj2 = (NewGridData)obj;
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
	private static int set_enterParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int[] enterParamList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.enterParamList = enterParamList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enterParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clickParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int[] clickParamList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.clickParamList = clickParamList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_exitParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int[] exitParamList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.exitParamList = exitParamList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exitParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
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
	private static int set_objectPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			string objectPrefab = ToLua.CheckString(L, 2);
			obj2.objectPrefab = objectPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objectRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			float objectRotationY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.objectRotationY = objectRotationY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectRotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objectTypeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int objectTypeID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.objectTypeID = objectTypeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectTypeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objectEnterParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int[] objectEnterParamList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.objectEnterParamList = objectEnterParamList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectEnterParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objectClickParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int[] objectClickParamList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.objectClickParamList = objectClickParamList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectClickParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objectExitParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int[] objectExitParamList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.objectExitParamList = objectExitParamList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectExitParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objectFarClickParamList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			int[] objectFarClickParamList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.objectFarClickParamList = objectFarClickParamList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectFarClickParamList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_offsetY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridData obj2 = (NewGridData)obj;
			float offsetY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.offsetY = offsetY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetY on a nil value");
		}
	}
}

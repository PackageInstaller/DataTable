using System;
using LuaInterface;

public class TetrisGameGuideInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TetrisGameGuideInfo), typeof(object));
		L.RegFunction("New", _CreateTetrisGameGuideInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isGuide", get_isGuide, set_isGuide);
		L.RegVar("putInX", get_putInX, set_putInX);
		L.RegVar("putInY", get_putInY, set_putInY);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTetrisGameGuideInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				TetrisGameGuideInfo o = new TetrisGameGuideInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: TetrisGameGuideInfo.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isGuide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isGuide = ((TetrisGameGuideInfo)obj).isGuide;
			LuaDLL.lua_pushboolean(L, isGuide);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isGuide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_putInX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int putInX = ((TetrisGameGuideInfo)obj).putInX;
			LuaDLL.lua_pushinteger(L, putInX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index putInX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_putInY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int putInY = ((TetrisGameGuideInfo)obj).putInY;
			LuaDLL.lua_pushinteger(L, putInY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index putInY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isGuide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameGuideInfo obj2 = (TetrisGameGuideInfo)obj;
			bool isGuide = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isGuide = isGuide;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isGuide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_putInX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameGuideInfo obj2 = (TetrisGameGuideInfo)obj;
			int putInX = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.putInX = putInX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index putInX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_putInY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameGuideInfo obj2 = (TetrisGameGuideInfo)obj;
			int putInY = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.putInY = putInY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index putInY on a nil value");
		}
	}
}

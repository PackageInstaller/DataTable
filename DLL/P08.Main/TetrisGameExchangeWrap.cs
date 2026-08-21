using System;
using LuaInterface;

public class TetrisGameExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TetrisGameExchange), typeof(object));
		L.RegFunction("New", _CreateTetrisGameExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("canRotate", get_canRotate, set_canRotate);
		L.RegVar("canCombom", get_canCombom, set_canCombom);
		L.RegVar("canCharge", get_canCharge, set_canCharge);
		L.RegVar("colorRemove", get_colorRemove, set_colorRemove);
		L.RegVar("skillSpecialChipID", get_skillSpecialChipID, set_skillSpecialChipID);
		L.RegVar("bubbleChipPosIndex", get_bubbleChipPosIndex, set_bubbleChipPosIndex);
		L.RegVar("bubbleColorIndex", get_bubbleColorIndex, set_bubbleColorIndex);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTetrisGameExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				TetrisGameExchange o = new TetrisGameExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: TetrisGameExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canRotate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canRotate = ((TetrisGameExchange)obj).canRotate;
			LuaDLL.lua_pushboolean(L, canRotate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canRotate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canCombom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canCombom = ((TetrisGameExchange)obj).canCombom;
			LuaDLL.lua_pushboolean(L, canCombom);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canCombom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canCharge(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canCharge = ((TetrisGameExchange)obj).canCharge;
			LuaDLL.lua_pushboolean(L, canCharge);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canCharge on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colorRemove(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool colorRemove = ((TetrisGameExchange)obj).colorRemove;
			LuaDLL.lua_pushboolean(L, colorRemove);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorRemove on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillSpecialChipID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int skillSpecialChipID = ((TetrisGameExchange)obj).skillSpecialChipID;
			LuaDLL.lua_pushinteger(L, skillSpecialChipID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillSpecialChipID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bubbleChipPosIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int bubbleChipPosIndex = ((TetrisGameExchange)obj).bubbleChipPosIndex;
			LuaDLL.lua_pushinteger(L, bubbleChipPosIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleChipPosIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bubbleColorIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int bubbleColorIndex = ((TetrisGameExchange)obj).bubbleColorIndex;
			LuaDLL.lua_pushinteger(L, bubbleColorIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleColorIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canRotate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameExchange obj2 = (TetrisGameExchange)obj;
			bool canRotate = LuaDLL.luaL_checkboolean(L, 2);
			obj2.canRotate = canRotate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canRotate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canCombom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameExchange obj2 = (TetrisGameExchange)obj;
			bool canCombom = LuaDLL.luaL_checkboolean(L, 2);
			obj2.canCombom = canCombom;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canCombom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canCharge(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameExchange obj2 = (TetrisGameExchange)obj;
			bool canCharge = LuaDLL.luaL_checkboolean(L, 2);
			obj2.canCharge = canCharge;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canCharge on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_colorRemove(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameExchange obj2 = (TetrisGameExchange)obj;
			bool colorRemove = LuaDLL.luaL_checkboolean(L, 2);
			obj2.colorRemove = colorRemove;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorRemove on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillSpecialChipID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameExchange obj2 = (TetrisGameExchange)obj;
			int skillSpecialChipID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.skillSpecialChipID = skillSpecialChipID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillSpecialChipID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bubbleChipPosIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameExchange obj2 = (TetrisGameExchange)obj;
			int bubbleChipPosIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.bubbleChipPosIndex = bubbleChipPosIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleChipPosIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bubbleColorIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TetrisGameExchange obj2 = (TetrisGameExchange)obj;
			int bubbleColorIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.bubbleColorIndex = bubbleColorIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleColorIndex on a nil value");
		}
	}
}

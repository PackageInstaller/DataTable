using System;
using System.Collections.Generic;
using LuaInterface;
using Sirenix.OdinInspector;
using UnityEngine;

public class ColorPuzzleWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ColorPuzzle), typeof(SerializedMonoBehaviour));
		L.RegFunction("SetPallete", SetPallete);
		L.RegFunction("Solve", Solve);
		L.RegFunction("AutoComplete", AutoComplete);
		L.RegFunction("CheckComplete", CheckComplete);
		L.RegFunction("ClearNodes", ClearNodes);
		L.RegFunction("SetOnNodeClickCallback", SetOnNodeClickCallback);
		L.RegFunction("SetOnCompleteCallback", SetOnCompleteCallback);
		L.RegFunction("SetBeforeApplyValueCallback", SetBeforeApplyValueCallback);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegConstant("NODE_EMPTY_VALUE", -1.0);
		L.RegVar("lines", get_lines, set_lines);
		L.RegVar("CurSelect", get_CurSelect, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPallete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ColorPuzzle obj = (ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1);
			Sprite[] pallete = ToLua.CheckObjectArray<Sprite>(L, 2);
			obj.SetPallete(pallete);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Solve(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1)).Solve();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AutoComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1)).AutoComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckComplete(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = ((ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1)).CheckComplete();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				ColorPuzzle obj = (ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1);
				bool showConflict = LuaDLL.luaL_checkboolean(L, 2);
				bool value = obj.CheckComplete(showConflict);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ColorPuzzle.CheckComplete");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearNodes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1)).ClearNodes();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnNodeClickCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ColorPuzzle obj = (ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1);
			Action<bool> onNodeClickCallback = (Action<bool>)ToLua.CheckDelegate<Action<bool>>(L, 2);
			obj.SetOnNodeClickCallback(onNodeClickCallback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnCompleteCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ColorPuzzle obj = (ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1);
			Action onCompleteCallback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.SetOnCompleteCallback(onCompleteCallback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBeforeApplyValueCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ColorPuzzle obj = (ColorPuzzle)ToLua.CheckObject<ColorPuzzle>(L, 1);
			Action<int, int> beforeApplyValueCallback = (Action<int, int>)ToLua.CheckDelegate<Action<int, int>>(L, 2);
			obj.SetBeforeApplyValueCallback(beforeApplyValueCallback);
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
	private static int get_lines(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ColorPuzzle.Line> lines = ((ColorPuzzle)obj).lines;
			ToLua.PushSealed(L, lines);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lines on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CurSelect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curSelect = ((ColorPuzzle)obj).CurSelect;
			LuaDLL.lua_pushinteger(L, curSelect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CurSelect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lines(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ColorPuzzle obj2 = (ColorPuzzle)obj;
			List<ColorPuzzle.Line> lines = (List<ColorPuzzle.Line>)ToLua.CheckObject(L, 2, typeof(List<ColorPuzzle.Line>));
			obj2.lines = lines;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lines on a nil value");
		}
	}
}

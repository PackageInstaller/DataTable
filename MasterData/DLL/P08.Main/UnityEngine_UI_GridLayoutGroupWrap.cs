using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_GridLayoutGroupWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GridLayoutGroup), typeof(LayoutGroup));
		L.RegFunction("CalculateLayoutInputHorizontal", CalculateLayoutInputHorizontal);
		L.RegFunction("CalculateLayoutInputVertical", CalculateLayoutInputVertical);
		L.RegFunction("SetLayoutHorizontal", SetLayoutHorizontal);
		L.RegFunction("SetLayoutVertical", SetLayoutVertical);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("startCorner", get_startCorner, set_startCorner);
		L.RegVar("startAxis", get_startAxis, set_startAxis);
		L.RegVar("cellSize", get_cellSize, set_cellSize);
		L.RegVar("spacing", get_spacing, set_spacing);
		L.RegVar("constraint", get_constraint, set_constraint);
		L.RegVar("constraintCount", get_constraintCount, set_constraintCount);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((GridLayoutGroup)ToLua.CheckObject<GridLayoutGroup>(L, 1)).CalculateLayoutInputHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((GridLayoutGroup)ToLua.CheckObject<GridLayoutGroup>(L, 1)).CalculateLayoutInputVertical();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((GridLayoutGroup)ToLua.CheckObject<GridLayoutGroup>(L, 1)).SetLayoutHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((GridLayoutGroup)ToLua.CheckObject<GridLayoutGroup>(L, 1)).SetLayoutVertical();
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
	private static int get_startCorner(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup.Corner startCorner = ((GridLayoutGroup)obj).startCorner;
			ToLua.Push(L, startCorner);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startCorner on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startAxis(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup.Axis startAxis = ((GridLayoutGroup)obj).startAxis;
			ToLua.Push(L, startAxis);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startAxis on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cellSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 cellSize = ((GridLayoutGroup)obj).cellSize;
			ToLua.Push(L, cellSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cellSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 spacing = ((GridLayoutGroup)obj).spacing;
			ToLua.Push(L, spacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_constraint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup.Constraint constraint = ((GridLayoutGroup)obj).constraint;
			ToLua.Push(L, constraint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constraint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_constraintCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int constraintCount = ((GridLayoutGroup)obj).constraintCount;
			LuaDLL.lua_pushinteger(L, constraintCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constraintCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startCorner(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup obj2 = (GridLayoutGroup)obj;
			GridLayoutGroup.Corner startCorner = (GridLayoutGroup.Corner)ToLua.CheckObject(L, 2, typeof(GridLayoutGroup.Corner));
			obj2.startCorner = startCorner;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startCorner on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startAxis(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup obj2 = (GridLayoutGroup)obj;
			GridLayoutGroup.Axis startAxis = (GridLayoutGroup.Axis)ToLua.CheckObject(L, 2, typeof(GridLayoutGroup.Axis));
			obj2.startAxis = startAxis;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startAxis on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cellSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup obj2 = (GridLayoutGroup)obj;
			Vector2 cellSize = ToLua.ToVector2(L, 2);
			obj2.cellSize = cellSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cellSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup obj2 = (GridLayoutGroup)obj;
			Vector2 spacing = ToLua.ToVector2(L, 2);
			obj2.spacing = spacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_constraint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup obj2 = (GridLayoutGroup)obj;
			GridLayoutGroup.Constraint constraint = (GridLayoutGroup.Constraint)ToLua.CheckObject(L, 2, typeof(GridLayoutGroup.Constraint));
			obj2.constraint = constraint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constraint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_constraintCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridLayoutGroup obj2 = (GridLayoutGroup)obj;
			int constraintCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.constraintCount = constraintCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constraintCount on a nil value");
		}
	}
}

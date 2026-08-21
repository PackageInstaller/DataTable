using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_GUIUtilityWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GUIUtility), typeof(object));
		L.RegFunction("GetControlID", GetControlID);
		L.RegFunction("AlignRectToDevice", AlignRectToDevice);
		L.RegFunction("GetStateObject", GetStateObject);
		L.RegFunction("QueryStateObject", QueryStateObject);
		L.RegFunction("ExitGUI", ExitGUI);
		L.RegFunction("GUIToScreenPoint", GUIToScreenPoint);
		L.RegFunction("ScreenToGUIPoint", ScreenToGUIPoint);
		L.RegFunction("ScreenToGUIRect", ScreenToGUIRect);
		L.RegFunction("RotateAroundPivot", RotateAroundPivot);
		L.RegFunction("ScaleAroundPivot", ScaleAroundPivot);
		L.RegFunction("New", _CreateUnityEngine_GUIUtility);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("hasModalWindow", get_hasModalWindow, null);
		L.RegVar("systemCopyBuffer", get_systemCopyBuffer, set_systemCopyBuffer);
		L.RegVar("hotControl", get_hotControl, set_hotControl);
		L.RegVar("keyboardControl", get_keyboardControl, set_keyboardControl);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_GUIUtility(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				GUIUtility o = new GUIUtility();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.GUIUtility.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetControlID(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
			{
				int controlID2 = GUIUtility.GetControlID((FocusType)ToLua.CheckObject(L, 1, typeof(FocusType)));
				LuaDLL.lua_pushinteger(L, controlID2);
				return 1;
			}
			case 2:
				if (TypeChecker.CheckTypes<FocusType, Rect>(L, 1))
				{
					FocusType focus = (FocusType)ToLua.ToObject(L, 1);
					Rect position = StackTraits<Rect>.To(L, 2);
					int controlID = GUIUtility.GetControlID(focus, position);
					LuaDLL.lua_pushinteger(L, controlID);
					return 1;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, FocusType>(L, 1))
			{
				int hint = (int)LuaDLL.lua_tonumber(L, 1);
				FocusType focus2 = (FocusType)ToLua.ToObject(L, 2);
				int controlID3 = GUIUtility.GetControlID(hint, focus2);
				LuaDLL.lua_pushinteger(L, controlID3);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<GUIContent, FocusType>(L, 1))
			{
				GUIContent contents = (GUIContent)ToLua.ToObject(L, 1);
				FocusType focus3 = (FocusType)ToLua.ToObject(L, 2);
				int controlID4 = GUIUtility.GetControlID(contents, focus3);
				LuaDLL.lua_pushinteger(L, controlID4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, FocusType, Rect>(L, 1))
			{
				int hint2 = (int)LuaDLL.lua_tonumber(L, 1);
				FocusType focusType = (FocusType)ToLua.ToObject(L, 2);
				Rect rect = StackTraits<Rect>.To(L, 3);
				int controlID5 = GUIUtility.GetControlID(hint2, focusType, rect);
				LuaDLL.lua_pushinteger(L, controlID5);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<GUIContent, FocusType, Rect>(L, 1))
			{
				GUIContent contents2 = (GUIContent)ToLua.ToObject(L, 1);
				FocusType focus4 = (FocusType)ToLua.ToObject(L, 2);
				Rect position2 = StackTraits<Rect>.To(L, 3);
				int controlID6 = GUIUtility.GetControlID(contents2, focus4, position2);
				LuaDLL.lua_pushinteger(L, controlID6);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GUIUtility.GetControlID");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AlignRectToDevice(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Rect v2 = GUIUtility.AlignRectToDevice(StackTraits<Rect>.Check(L, 1));
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 3:
			{
				Rect v = GUIUtility.AlignRectToDevice(StackTraits<Rect>.Check(L, 1), out var widthInPixels, out var heightInPixels);
				ToLua.PushValue(L, v);
				LuaDLL.lua_pushinteger(L, widthInPixels);
				LuaDLL.lua_pushinteger(L, heightInPixels);
				return 3;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GUIUtility.AlignRectToDevice");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStateObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type t = ToLua.CheckMonoType(L, 1);
			int controlID = (int)LuaDLL.luaL_checknumber(L, 2);
			object stateObject = GUIUtility.GetStateObject(t, controlID);
			ToLua.Push(L, stateObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryStateObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type t = ToLua.CheckMonoType(L, 1);
			int controlID = (int)LuaDLL.luaL_checknumber(L, 2);
			object obj = GUIUtility.QueryStateObject(t, controlID);
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitGUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GUIUtility.ExitGUI();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GUIToScreenPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector2 v = GUIUtility.GUIToScreenPoint(ToLua.ToVector2(L, 1));
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenToGUIPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector2 v = GUIUtility.ScreenToGUIPoint(ToLua.ToVector2(L, 1));
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenToGUIRect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Rect v = GUIUtility.ScreenToGUIRect(StackTraits<Rect>.Check(L, 1));
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateAroundPivot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float angle = (float)LuaDLL.luaL_checknumber(L, 1);
			Vector2 pivotPoint = ToLua.ToVector2(L, 2);
			GUIUtility.RotateAroundPivot(angle, pivotPoint);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScaleAroundPivot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector2 scale = ToLua.ToVector2(L, 1);
			Vector2 pivotPoint = ToLua.ToVector2(L, 2);
			GUIUtility.ScaleAroundPivot(scale, pivotPoint);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasModalWindow(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GUIUtility.hasModalWindow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_systemCopyBuffer(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, GUIUtility.systemCopyBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hotControl(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, GUIUtility.hotControl);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_keyboardControl(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, GUIUtility.keyboardControl);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_systemCopyBuffer(IntPtr L)
	{
		try
		{
			GUIUtility.systemCopyBuffer = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hotControl(IntPtr L)
	{
		try
		{
			GUIUtility.hotControl = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_keyboardControl(IntPtr L)
	{
		try
		{
			GUIUtility.keyboardControl = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

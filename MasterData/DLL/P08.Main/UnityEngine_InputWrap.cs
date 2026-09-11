using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_InputWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Input");
		L.RegFunction("GetAxis", GetAxis);
		L.RegFunction("GetAxisRaw", GetAxisRaw);
		L.RegFunction("GetButton", GetButton);
		L.RegFunction("GetButtonDown", GetButtonDown);
		L.RegFunction("GetButtonUp", GetButtonUp);
		L.RegFunction("GetMouseButton", GetMouseButton);
		L.RegFunction("GetMouseButtonDown", GetMouseButtonDown);
		L.RegFunction("GetMouseButtonUp", GetMouseButtonUp);
		L.RegFunction("ResetInputAxes", ResetInputAxes);
		L.RegFunction("GetJoystickNames", GetJoystickNames);
		L.RegFunction("GetTouch", GetTouch);
		L.RegFunction("GetAccelerationEvent", GetAccelerationEvent);
		L.RegFunction("GetKey", GetKey);
		L.RegFunction("GetKeyUp", GetKeyUp);
		L.RegFunction("GetKeyDown", GetKeyDown);
		L.RegVar("simulateMouseWithTouches", get_simulateMouseWithTouches, set_simulateMouseWithTouches);
		L.RegVar("anyKey", get_anyKey, null);
		L.RegVar("anyKeyDown", get_anyKeyDown, null);
		L.RegVar("inputString", get_inputString, null);
		L.RegVar("mousePosition", get_mousePosition, null);
		L.RegVar("mouseScrollDelta", get_mouseScrollDelta, null);
		L.RegVar("imeCompositionMode", get_imeCompositionMode, set_imeCompositionMode);
		L.RegVar("compositionString", get_compositionString, null);
		L.RegVar("imeIsSelected", get_imeIsSelected, null);
		L.RegVar("compositionCursorPos", get_compositionCursorPos, set_compositionCursorPos);
		L.RegVar("mousePresent", get_mousePresent, null);
		L.RegVar("touchCount", get_touchCount, null);
		L.RegVar("touchPressureSupported", get_touchPressureSupported, null);
		L.RegVar("stylusTouchSupported", get_stylusTouchSupported, null);
		L.RegVar("touchSupported", get_touchSupported, null);
		L.RegVar("multiTouchEnabled", get_multiTouchEnabled, set_multiTouchEnabled);
		L.RegVar("deviceOrientation", get_deviceOrientation, null);
		L.RegVar("acceleration", get_acceleration, null);
		L.RegVar("compensateSensors", get_compensateSensors, set_compensateSensors);
		L.RegVar("accelerationEventCount", get_accelerationEventCount, null);
		L.RegVar("backButtonLeavesApp", get_backButtonLeavesApp, set_backButtonLeavesApp);
		L.RegVar("compass", get_compass, null);
		L.RegVar("gyro", get_gyro, null);
		L.RegVar("touches", get_touches, null);
		L.RegVar("accelerationEvents", get_accelerationEvents, null);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAxis(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float axis = Input.GetAxis(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushnumber(L, axis);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAxisRaw(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float axisRaw = Input.GetAxisRaw(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushnumber(L, axisRaw);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetButton(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool button = Input.GetButton(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, button);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetButtonDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool buttonDown = Input.GetButtonDown(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, buttonDown);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetButtonUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool buttonUp = Input.GetButtonUp(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, buttonUp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMouseButton(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool mouseButton = Input.GetMouseButton((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, mouseButton);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMouseButtonDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool mouseButtonDown = Input.GetMouseButtonDown((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, mouseButtonDown);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMouseButtonUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool mouseButtonUp = Input.GetMouseButtonUp((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, mouseButtonUp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetInputAxes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Input.ResetInputAxes();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetJoystickNames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string[] joystickNames = Input.GetJoystickNames();
			ToLua.Push(L, joystickNames);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTouch(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Touch touch = Input.GetTouch((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, touch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAccelerationEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AccelerationEvent accelerationEvent = Input.GetAccelerationEvent((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushValue(L, accelerationEvent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetKey(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				bool key = Input.GetKey(ToLua.ToString(L, 1));
				LuaDLL.lua_pushboolean(L, key);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<KeyCode>(L, 1))
			{
				bool key2 = Input.GetKey((KeyCode)ToLua.ToObject(L, 1));
				LuaDLL.lua_pushboolean(L, key2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Input.GetKey");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetKeyUp(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				bool keyUp = Input.GetKeyUp(ToLua.ToString(L, 1));
				LuaDLL.lua_pushboolean(L, keyUp);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<KeyCode>(L, 1))
			{
				bool keyUp2 = Input.GetKeyUp((KeyCode)ToLua.ToObject(L, 1));
				LuaDLL.lua_pushboolean(L, keyUp2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Input.GetKeyUp");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetKeyDown(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				bool keyDown = Input.GetKeyDown(ToLua.ToString(L, 1));
				LuaDLL.lua_pushboolean(L, keyDown);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<KeyCode>(L, 1))
			{
				bool keyDown2 = Input.GetKeyDown((KeyCode)ToLua.ToObject(L, 1));
				LuaDLL.lua_pushboolean(L, keyDown2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Input.GetKeyDown");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_simulateMouseWithTouches(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.simulateMouseWithTouches);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anyKey(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.anyKey);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anyKeyDown(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.anyKeyDown);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inputString(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Input.inputString);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mousePosition(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.mousePosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mouseScrollDelta(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.mouseScrollDelta);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_imeCompositionMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.imeCompositionMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_compositionString(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Input.compositionString);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_imeIsSelected(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.imeIsSelected);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_compositionCursorPos(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.compositionCursorPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mousePresent(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.mousePresent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_touchCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Input.touchCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_touchPressureSupported(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.touchPressureSupported);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stylusTouchSupported(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.stylusTouchSupported);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_touchSupported(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.touchSupported);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_multiTouchEnabled(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.multiTouchEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deviceOrientation(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.deviceOrientation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_acceleration(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.acceleration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_compensateSensors(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.compensateSensors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_accelerationEventCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Input.accelerationEventCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_backButtonLeavesApp(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Input.backButtonLeavesApp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_compass(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, Input.compass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gyro(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, Input.gyro);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_touches(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.touches);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_accelerationEvents(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Input.accelerationEvents);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_simulateMouseWithTouches(IntPtr L)
	{
		try
		{
			Input.simulateMouseWithTouches = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_imeCompositionMode(IntPtr L)
	{
		try
		{
			Input.imeCompositionMode = (IMECompositionMode)ToLua.CheckObject(L, 2, typeof(IMECompositionMode));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_compositionCursorPos(IntPtr L)
	{
		try
		{
			Input.compositionCursorPos = ToLua.ToVector2(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_multiTouchEnabled(IntPtr L)
	{
		try
		{
			Input.multiTouchEnabled = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_compensateSensors(IntPtr L)
	{
		try
		{
			Input.compensateSensors = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_backButtonLeavesApp(IntPtr L)
	{
		try
		{
			Input.backButtonLeavesApp = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

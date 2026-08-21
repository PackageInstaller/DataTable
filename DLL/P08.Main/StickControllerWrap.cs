using System;
using LuaInterface;
using UnityEngine;

public class StickControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(StickController), typeof(MonoBehaviour));
		L.RegFunction("SetStickFunc", SetStickFunc);
		L.RegFunction("SetStickModule", SetStickModule);
		L.RegFunction("ClearStickFunc", ClearStickFunc);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("PressFinger", get_PressFinger, set_PressFinger);
		L.RegVar("keyBoard", get_keyBoard, set_keyBoard);
		L.RegVar("canvas", get_canvas, set_canvas);
		L.RegVar("thumbPosition", get_thumbPosition, set_thumbPosition);
		L.RegVar("areaRect", get_areaRect, set_areaRect);
		L.RegVar("lastVector", get_lastVector, set_lastVector);
		L.RegVar("PreMoveDirection", get_PreMoveDirection, set_PreMoveDirection);
		L.RegVar("ConfirmDirSndFrame", get_ConfirmDirSndFrame, set_ConfirmDirSndFrame);
		L.RegVar("FixtimeDirSndFrame", get_FixtimeDirSndFrame, set_FixtimeDirSndFrame);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStickFunc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			StickController obj = (StickController)ToLua.CheckObject<StickController>(L, 1);
			LuaFunction updateFunc = ToLua.CheckLuaFunction(L, 2);
			LuaFunction validPosFunc = ToLua.CheckLuaFunction(L, 3);
			obj.SetStickFunc(updateFunc, validPosFunc);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStickModule(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			StickController obj = (StickController)ToLua.CheckObject<StickController>(L, 1);
			Action<Vector3, int> updateFunc = (Action<Vector3, int>)ToLua.CheckDelegate<Action<Vector3, int>>(L, 2);
			Func<Vector3, bool> validPosFunc = (Func<Vector3, bool>)ToLua.CheckDelegate<Func<Vector3, bool>>(L, 3);
			obj.SetStickModule(updateFunc, validPosFunc);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearStickFunc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((StickController)ToLua.CheckObject<StickController>(L, 1)).ClearStickFunc();
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
	private static int get_PressFinger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int pressFinger = ((StickController)obj).PressFinger;
			LuaDLL.lua_pushinteger(L, pressFinger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PressFinger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_keyBoard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool keyBoard = ((StickController)obj).keyBoard;
			LuaDLL.lua_pushboolean(L, keyBoard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keyBoard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas canvas = ((StickController)obj).canvas;
			ToLua.PushSealed(L, canvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thumbPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform thumbPosition = ((StickController)obj).thumbPosition;
			ToLua.PushSealed(L, thumbPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thumbPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_areaRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform areaRect = ((StickController)obj).areaRect;
			ToLua.PushSealed(L, areaRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index areaRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastVector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 lastVector = ((StickController)obj).lastVector;
			ToLua.Push(L, lastVector);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastVector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PreMoveDirection(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int preMoveDirection = ((StickController)obj).PreMoveDirection;
			LuaDLL.lua_pushinteger(L, preMoveDirection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PreMoveDirection on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ConfirmDirSndFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int confirmDirSndFrame = ((StickController)obj).ConfirmDirSndFrame;
			LuaDLL.lua_pushinteger(L, confirmDirSndFrame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ConfirmDirSndFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FixtimeDirSndFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fixtimeDirSndFrame = ((StickController)obj).FixtimeDirSndFrame;
			LuaDLL.lua_pushinteger(L, fixtimeDirSndFrame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FixtimeDirSndFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PressFinger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			int pressFinger = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.PressFinger = pressFinger;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PressFinger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_keyBoard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			bool keyBoard = LuaDLL.luaL_checkboolean(L, 2);
			obj2.keyBoard = keyBoard;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keyBoard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			Canvas canvas = (Canvas)ToLua.CheckObject(L, 2, typeof(Canvas));
			obj2.canvas = canvas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thumbPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			RectTransform thumbPosition = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.thumbPosition = thumbPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thumbPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_areaRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			RectTransform areaRect = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.areaRect = areaRect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index areaRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastVector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			Vector3 lastVector = ToLua.ToVector3(L, 2);
			obj2.lastVector = lastVector;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastVector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PreMoveDirection(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			int preMoveDirection = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.PreMoveDirection = preMoveDirection;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PreMoveDirection on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ConfirmDirSndFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			int confirmDirSndFrame = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.ConfirmDirSndFrame = confirmDirSndFrame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ConfirmDirSndFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_FixtimeDirSndFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StickController obj2 = (StickController)obj;
			int fixtimeDirSndFrame = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.FixtimeDirSndFrame = fixtimeDirSndFrame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FixtimeDirSndFrame on a nil value");
		}
	}
}

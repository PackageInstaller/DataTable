using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AsyncOperationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AsyncOperation), typeof(object));
		L.RegFunction("New", _CreateUnityEngine_AsyncOperation);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isDone", get_isDone, null);
		L.RegVar("progress", get_progress, null);
		L.RegVar("priority", get_priority, set_priority);
		L.RegVar("allowSceneActivation", get_allowSceneActivation, set_allowSceneActivation);
		L.RegVar("completed", get_completed, set_completed);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_AsyncOperation(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				AsyncOperation o = new AsyncOperation();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.AsyncOperation.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isDone = ((AsyncOperation)obj).isDone;
			LuaDLL.lua_pushboolean(L, isDone);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_progress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float progress = ((AsyncOperation)obj).progress;
			LuaDLL.lua_pushnumber(L, progress);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index progress on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int priority = ((AsyncOperation)obj).priority;
			LuaDLL.lua_pushinteger(L, priority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowSceneActivation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowSceneActivation = ((AsyncOperation)obj).allowSceneActivation;
			LuaDLL.lua_pushboolean(L, allowSceneActivation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowSceneActivation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_completed(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<AsyncOperation>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AsyncOperation obj2 = (AsyncOperation)obj;
			int priority = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.priority = priority;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowSceneActivation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AsyncOperation obj2 = (AsyncOperation)obj;
			bool allowSceneActivation = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowSceneActivation = allowSceneActivation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowSceneActivation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_completed(IntPtr L)
	{
		try
		{
			AsyncOperation asyncOperation = (AsyncOperation)ToLua.CheckObject(L, 1, typeof(AsyncOperation));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Action<AsyncOperation> value = (Action<AsyncOperation>)eventObject.func;
					asyncOperation.completed += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Action<AsyncOperation> value2 = (Action<AsyncOperation>)eventObject.func;
					asyncOperation.completed -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.AsyncOperation.completed' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.AsyncOperation'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

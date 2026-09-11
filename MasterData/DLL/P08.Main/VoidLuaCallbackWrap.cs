using System;
using LuaInterface;

public class VoidLuaCallbackWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(VoidLuaCallback), typeof(object));
		L.RegFunction("Invoke", Invoke);
		L.RegFunction("New", _CreateVoidLuaCallback);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("callback", get_callback, set_callback);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateVoidLuaCallback(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				VoidLuaCallback o = new VoidLuaCallback();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: VoidLuaCallback.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Invoke(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((VoidLuaCallback)ToLua.CheckObject<VoidLuaCallback>(L, 1)).Invoke();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_callback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action callback = ((VoidLuaCallback)obj).callback;
			ToLua.Push(L, callback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index callback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_callback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VoidLuaCallback obj2 = (VoidLuaCallback)obj;
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.callback = callback;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index callback on a nil value");
		}
	}
}

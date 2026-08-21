using System;
using LuaInterface;

public class QWorldBranchCallbackWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldBranchCallback), typeof(object));
		L.RegFunction("Invoke", Invoke);
		L.RegFunction("New", _CreateQWorldBranchCallback);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("nextId", get_nextId, set_nextId);
		L.RegVar("clickAction", get_clickAction, set_clickAction);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateQWorldBranchCallback(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				QWorldBranchCallback o = new QWorldBranchCallback();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: QWorldBranchCallback.New");
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
			((QWorldBranchCallback)ToLua.CheckObject<QWorldBranchCallback>(L, 1)).Invoke();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string id = ((QWorldBranchCallback)obj).id;
			LuaDLL.lua_pushstring(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nextId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string nextId = ((QWorldBranchCallback)obj).nextId;
			LuaDLL.lua_pushstring(L, nextId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nextId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clickAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<string> clickAction = ((QWorldBranchCallback)obj).clickAction;
			ToLua.Push(L, clickAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldBranchCallback obj2 = (QWorldBranchCallback)obj;
			string id = ToLua.CheckString(L, 2);
			obj2.id = id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nextId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldBranchCallback obj2 = (QWorldBranchCallback)obj;
			string nextId = ToLua.CheckString(L, 2);
			obj2.nextId = nextId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nextId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clickAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldBranchCallback obj2 = (QWorldBranchCallback)obj;
			Action<string> clickAction = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
			obj2.clickAction = clickAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickAction on a nil value");
		}
	}
}

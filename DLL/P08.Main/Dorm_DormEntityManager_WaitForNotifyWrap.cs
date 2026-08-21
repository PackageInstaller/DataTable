using System;
using Dorm;
using LuaInterface;

public class Dorm_DormEntityManager_WaitForNotifyWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DormEntityManager.WaitForNotify), typeof(object));
		L.RegFunction("Notify", Notify);
		L.RegFunction("New", _CreateDorm_DormEntityManager_WaitForNotify);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("canceled", get_canceled, null);
		L.RegVar("keepWaiting", get_keepWaiting, null);
		L.RegVar("success", get_success, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateDorm_DormEntityManager_WaitForNotify(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				DormEntityManager.WaitForNotify o = new DormEntityManager.WaitForNotify();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Dorm.DormEntityManager.WaitForNotify.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Notify(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((DormEntityManager.WaitForNotify)ToLua.CheckObject<DormEntityManager.WaitForNotify>(L, 1)).Notify();
				return 0;
			case 2:
			{
				DormEntityManager.WaitForNotify obj = (DormEntityManager.WaitForNotify)ToLua.CheckObject<DormEntityManager.WaitForNotify>(L, 1);
				bool success = LuaDLL.luaL_checkboolean(L, 2);
				obj.Notify(success);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.WaitForNotify.Notify");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canceled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canceled = ((DormEntityManager.WaitForNotify)obj).canceled;
			LuaDLL.lua_pushboolean(L, canceled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canceled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_keepWaiting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool keepWaiting = ((DormEntityManager.WaitForNotify)obj).keepWaiting;
			LuaDLL.lua_pushboolean(L, keepWaiting);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keepWaiting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_success(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool success = ((DormEntityManager.WaitForNotify)obj).success;
			LuaDLL.lua_pushboolean(L, success);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index success on a nil value");
		}
	}
}

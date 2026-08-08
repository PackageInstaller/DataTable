using System;
using LuaInterface;

public class CriDisposableWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CriDisposable), typeof(object));
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("guid", get_guid, set_guid);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Dispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriDisposable)ToLua.CheckObject<CriDisposable>(L, 1)).Dispose();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_guid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Guid guid = ((CriDisposable)obj).guid;
			ToLua.PushValue(L, guid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_guid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriDisposable obj2 = (CriDisposable)obj;
			Guid guid = StackTraits<Guid>.Check(L, 2);
			obj2.guid = guid;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guid on a nil value");
		}
	}
}

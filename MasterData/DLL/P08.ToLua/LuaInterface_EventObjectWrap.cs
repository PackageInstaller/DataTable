using System;
using LuaInterface;

public class LuaInterface_EventObjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EventObject), typeof(object));
		L.RegFunction("__add", op_Addition);
		L.RegFunction("__sub", op_Subtraction);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Subtraction(IntPtr L)
	{
		try
		{
			EventObject eventObject = (EventObject)ToLua.CheckObject(L, 1, typeof(EventObject));
			eventObject.func = ToLua.CheckDelegate(eventObject.type, L, 2);
			eventObject.op = EventOp.Sub;
			ToLua.Push(L, eventObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Addition(IntPtr L)
	{
		try
		{
			EventObject eventObject = (EventObject)ToLua.CheckObject(L, 1, typeof(EventObject));
			eventObject.func = ToLua.CheckDelegate(eventObject.type, L, 2);
			eventObject.op = EventOp.Add;
			ToLua.Push(L, eventObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

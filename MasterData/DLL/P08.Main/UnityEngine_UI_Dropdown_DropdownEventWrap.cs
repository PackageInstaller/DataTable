using System;
using LuaInterface;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_Dropdown_DropdownEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Dropdown.DropdownEvent), typeof(UnityEvent<int>));
		L.RegFunction("New", _CreateUnityEngine_UI_Dropdown_DropdownEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_Dropdown_DropdownEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Dropdown.DropdownEvent o = new Dropdown.DropdownEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.Dropdown.DropdownEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

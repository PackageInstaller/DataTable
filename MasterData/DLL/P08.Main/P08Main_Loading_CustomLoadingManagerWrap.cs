using System;
using LuaInterface;
using P08Main.Loading;

public class P08Main_Loading_CustomLoadingManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CustomLoadingManager), typeof(object));
		L.RegFunction("ShowLoadUI", ShowLoadUI);
		L.RegFunction("CloseLoadUI", CloseLoadUI);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowLoadUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CustomLoadingManager obj = (CustomLoadingManager)ToLua.CheckObject<CustomLoadingManager>(L, 1);
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ShowLoadUI(type);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CloseLoadUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CustomLoadingManager obj = (CustomLoadingManager)ToLua.CheckObject<CustomLoadingManager>(L, 1);
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.CloseLoadUI(type);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inst(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, CustomLoadingManager.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

using System;
using LuaInterface;

public class DormTagConstWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("DormTagConst");
		L.RegVar("DORM_RESTAURANT_ITEM_NAMESPACE", get_DORM_RESTAURANT_ITEM_NAMESPACE, null);
		L.RegVar("DORM_RESTAURANT_STATIC_ITEM_NAMESPACE", get_DORM_RESTAURANT_STATIC_ITEM_NAMESPACE, null);
		L.RegVar("DORM_RESTAURANT_ITEM_TYPE_NAMESPACE", get_DORM_RESTAURANT_ITEM_TYPE_NAMESPACE, null);
		L.RegVar("DORM_RESTAURANT_ITEM_GROUP_NAMESPACE", get_DORM_RESTAURANT_ITEM_GROUP_NAMESPACE, null);
		L.RegVar("DORM_RESTAURANT_ITEM_INTERACT_POINTS_NAMESPACE", get_DORM_RESTAURANT_ITEM_INTERACT_POINTS_NAMESPACE, null);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DORM_RESTAURANT_ITEM_NAMESPACE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "restaurant.pos.item");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DORM_RESTAURANT_STATIC_ITEM_NAMESPACE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "restaurant.pos.static.item");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DORM_RESTAURANT_ITEM_TYPE_NAMESPACE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "restaurant.itemType");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DORM_RESTAURANT_ITEM_GROUP_NAMESPACE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "restaurant.itemGroup");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DORM_RESTAURANT_ITEM_INTERACT_POINTS_NAMESPACE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "restaurant.itemInteractPoints");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

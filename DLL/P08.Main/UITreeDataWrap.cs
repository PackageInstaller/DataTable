using System;
using System.Collections.Generic;
using LuaInterface;

public class UITreeDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UITreeData), typeof(object));
		L.RegFunction("New", _CreateUITreeData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("groupDatas", get_groupDatas, set_groupDatas);
		L.RegVar("defaultIndex", get_defaultIndex, set_defaultIndex);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUITreeData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				UITreeData o = new UITreeData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UITreeData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_groupDatas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<UITreeGroupData> groupDatas = ((UITreeData)obj).groupDatas;
			ToLua.PushSealed(L, groupDatas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupDatas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int defaultIndex = ((UITreeData)obj).defaultIndex;
			LuaDLL.lua_pushinteger(L, defaultIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_groupDatas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITreeData obj2 = (UITreeData)obj;
			List<UITreeGroupData> groupDatas = (List<UITreeGroupData>)ToLua.CheckObject(L, 2, typeof(List<UITreeGroupData>));
			obj2.groupDatas = groupDatas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupDatas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITreeData obj2 = (UITreeData)obj;
			int defaultIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.defaultIndex = defaultIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultIndex on a nil value");
		}
	}
}

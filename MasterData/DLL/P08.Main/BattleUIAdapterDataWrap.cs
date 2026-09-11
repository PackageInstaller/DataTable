using System;
using System.Collections.Generic;
using LuaInterface;

public class BattleUIAdapterDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BattleUIAdapterData), typeof(object));
		L.RegFunction("Serialize", Serialize);
		L.RegFunction("Deserialize", Deserialize);
		L.RegFunction("New", _CreateBattleUIAdapterData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("datas", get_datas, set_datas);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBattleUIAdapterData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				BattleUIAdapterData o = new BattleUIAdapterData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BattleUIAdapterData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Serialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((BattleUIAdapterData)ToLua.CheckObject<BattleUIAdapterData>(L, 1)).Serialize();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Deserialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BattleUIAdapterData obj = (BattleUIAdapterData)ToLua.CheckObject<BattleUIAdapterData>(L, 1);
			string s = ToLua.CheckString(L, 2);
			obj.Deserialize(s);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_datas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<BattleUIAdapterData.Data> datas = ((BattleUIAdapterData)obj).datas;
			ToLua.PushSealed(L, datas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index datas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_datas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleUIAdapterData obj2 = (BattleUIAdapterData)obj;
			List<BattleUIAdapterData.Data> datas = (List<BattleUIAdapterData.Data>)ToLua.CheckObject(L, 2, typeof(List<BattleUIAdapterData.Data>));
			obj2.datas = datas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index datas on a nil value");
		}
	}
}

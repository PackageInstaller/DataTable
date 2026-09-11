using System;
using LuaInterface;

public class MasterSkillDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MasterSkillDataForExchange), typeof(object));
		L.RegFunction("New", _CreateMasterSkillDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("ID", get_ID, set_ID);
		L.RegVar("attributeID", get_attributeID, set_attributeID);
		L.RegVar("attributeValue", get_attributeValue, set_attributeValue);
		L.RegVar("masterSkillRenderLevel", get_masterSkillRenderLevel, set_masterSkillRenderLevel);
		L.RegVar("masterSkinID", get_masterSkinID, set_masterSkinID);
		L.RegVar("roleSkinID", get_roleSkinID, set_roleSkinID);
		L.RegVar("isVow", get_isVow, set_isVow);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateMasterSkillDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MasterSkillDataForExchange o = new MasterSkillDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: MasterSkillDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int iD = ((MasterSkillDataForExchange)obj).ID;
			LuaDLL.lua_pushinteger(L, iD);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attributeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] attributeID = ((MasterSkillDataForExchange)obj).attributeID;
			ToLua.Push(L, attributeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attributeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attributeValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long[] attributeValue = ((MasterSkillDataForExchange)obj).attributeValue;
			ToLua.Push(L, attributeValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attributeValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_masterSkillRenderLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int masterSkillRenderLevel = ((MasterSkillDataForExchange)obj).masterSkillRenderLevel;
			LuaDLL.lua_pushinteger(L, masterSkillRenderLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index masterSkillRenderLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_masterSkinID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int masterSkinID = ((MasterSkillDataForExchange)obj).masterSkinID;
			LuaDLL.lua_pushinteger(L, masterSkinID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index masterSkinID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roleSkinID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int roleSkinID = ((MasterSkillDataForExchange)obj).roleSkinID;
			LuaDLL.lua_pushinteger(L, roleSkinID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roleSkinID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isVow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVow = ((MasterSkillDataForExchange)obj).isVow;
			LuaDLL.lua_pushboolean(L, isVow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange obj2 = (MasterSkillDataForExchange)obj;
			int iD = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.ID = iD;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attributeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange obj2 = (MasterSkillDataForExchange)obj;
			int[] attributeID = ToLua.CheckNumberArray<int>(L, 2);
			obj2.attributeID = attributeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attributeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attributeValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange obj2 = (MasterSkillDataForExchange)obj;
			long[] attributeValue = ToLua.CheckNumberArray<long>(L, 2);
			obj2.attributeValue = attributeValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attributeValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_masterSkillRenderLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange obj2 = (MasterSkillDataForExchange)obj;
			int masterSkillRenderLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.masterSkillRenderLevel = masterSkillRenderLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index masterSkillRenderLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_masterSkinID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange obj2 = (MasterSkillDataForExchange)obj;
			int masterSkinID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.masterSkinID = masterSkinID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index masterSkinID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roleSkinID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange obj2 = (MasterSkillDataForExchange)obj;
			int roleSkinID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.roleSkinID = roleSkinID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roleSkinID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isVow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange obj2 = (MasterSkillDataForExchange)obj;
			bool isVow = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isVow = isVow;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVow on a nil value");
		}
	}
}

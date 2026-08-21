using System;
using System.Collections.Generic;
using LuaInterface;
using RogueCard;

public class RogueCard_RogueCardSaveCardDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RogueCardSaveCardData), typeof(object));
		L.RegFunction("New", _CreateRogueCard_RogueCardSaveCardData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("suit", get_suit, set_suit);
		L.RegVar("rank", get_rank, set_rank);
		L.RegVar("enhance_id", get_enhance_id, set_enhance_id);
		L.RegVar("tag_id", get_tag_id, set_tag_id);
		L.RegVar("effect_disable", get_effect_disable, set_effect_disable);
		L.RegVar("other_data", get_other_data, set_other_data);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRogueCard_RogueCardSaveCardData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RogueCardSaveCardData o = new RogueCardSaveCardData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RogueCard.RogueCardSaveCardData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_suit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int suit = ((RogueCardSaveCardData)obj).suit;
			LuaDLL.lua_pushinteger(L, suit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rank(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rank = ((RogueCardSaveCardData)obj).rank;
			LuaDLL.lua_pushinteger(L, rank);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rank on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhance_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int enhance_id = ((RogueCardSaveCardData)obj).enhance_id;
			LuaDLL.lua_pushinteger(L, enhance_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhance_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tag_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int tag_id = ((RogueCardSaveCardData)obj).tag_id;
			LuaDLL.lua_pushinteger(L, tag_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effect_disable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool effect_disable = ((RogueCardSaveCardData)obj).effect_disable;
			LuaDLL.lua_pushboolean(L, effect_disable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effect_disable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_other_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> other_data = ((RogueCardSaveCardData)obj).other_data;
			ToLua.PushSealed(L, other_data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index other_data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_suit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveCardData obj2 = (RogueCardSaveCardData)obj;
			int suit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.suit = suit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rank(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveCardData obj2 = (RogueCardSaveCardData)obj;
			int rank = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.rank = rank;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rank on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhance_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveCardData obj2 = (RogueCardSaveCardData)obj;
			int enhance_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.enhance_id = enhance_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhance_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tag_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveCardData obj2 = (RogueCardSaveCardData)obj;
			int tag_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.tag_id = tag_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effect_disable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveCardData obj2 = (RogueCardSaveCardData)obj;
			bool effect_disable = LuaDLL.luaL_checkboolean(L, 2);
			obj2.effect_disable = effect_disable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effect_disable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_other_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveCardData obj2 = (RogueCardSaveCardData)obj;
			List<int> other_data = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.other_data = other_data;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index other_data on a nil value");
		}
	}
}

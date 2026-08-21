using System;
using LuaInterface;

public class PinballRoleSkillDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PinballRoleSkillData), typeof(object));
		L.RegFunction("New", _CreatePinballRoleSkillData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("sType", get_sType, set_sType);
		L.RegVar("sValue", get_sValue, set_sValue);
		L.RegVar("cooldown", get_cooldown, set_cooldown);
		L.RegVar("remainCD", get_remainCD, set_remainCD);
		L.RegVar("level", get_level, set_level);
		L.RegVar("weight", get_weight, set_weight);
		L.RegVar("icon", get_icon, set_icon);
		L.RegVar("name", get_name, set_name);
		L.RegVar("animName", get_animName, set_animName);
		L.RegVar("effectName", get_effectName, set_effectName);
		L.RegVar("desc", get_desc, set_desc);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePinballRoleSkillData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PinballRoleSkillData o = new PinballRoleSkillData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: PinballRoleSkillData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int id = ((PinballRoleSkillData)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sType = ((PinballRoleSkillData)obj).sType;
			LuaDLL.lua_pushinteger(L, sType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float[] sValue = ((PinballRoleSkillData)obj).sValue;
			ToLua.Push(L, sValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cooldown(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cooldown = ((PinballRoleSkillData)obj).cooldown;
			LuaDLL.lua_pushinteger(L, cooldown);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cooldown on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_remainCD(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int remainCD = ((PinballRoleSkillData)obj).remainCD;
			LuaDLL.lua_pushinteger(L, remainCD);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index remainCD on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int level = ((PinballRoleSkillData)obj).level;
			LuaDLL.lua_pushinteger(L, level);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float weight = ((PinballRoleSkillData)obj).weight;
			LuaDLL.lua_pushnumber(L, weight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_icon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string icon = ((PinballRoleSkillData)obj).icon;
			LuaDLL.lua_pushstring(L, icon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index icon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((PinballRoleSkillData)obj).name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string animName = ((PinballRoleSkillData)obj).animName;
			LuaDLL.lua_pushstring(L, animName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effectName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string effectName = ((PinballRoleSkillData)obj).effectName;
			LuaDLL.lua_pushstring(L, effectName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_desc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string desc = ((PinballRoleSkillData)obj).desc;
			LuaDLL.lua_pushstring(L, desc);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index desc on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.id = id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			int sType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sType = sType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			float[] sValue = ToLua.CheckNumberArray<float>(L, 2);
			obj2.sValue = sValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cooldown(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			int cooldown = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cooldown = cooldown;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cooldown on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_remainCD(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			int remainCD = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.remainCD = remainCD;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index remainCD on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.level = level;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_weight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			float weight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.weight = weight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_icon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			string icon = ToLua.CheckString(L, 2);
			obj2.icon = icon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index icon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			string name = ToLua.CheckString(L, 2);
			obj2.name = name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_animName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			string animName = ToLua.CheckString(L, 2);
			obj2.animName = animName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effectName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			string effectName = ToLua.CheckString(L, 2);
			obj2.effectName = effectName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_desc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData obj2 = (PinballRoleSkillData)obj;
			string desc = ToLua.CheckString(L, 2);
			obj2.desc = desc;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index desc on a nil value");
		}
	}
}

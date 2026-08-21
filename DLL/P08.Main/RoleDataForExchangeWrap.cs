using System;
using LuaInterface;

public class RoleDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RoleDataForExchange), typeof(object));
		L.RegFunction("New", _CreateRoleDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("UID", get_UID, set_UID);
		L.RegVar("playerLevel", get_playerLevel, set_playerLevel);
		L.RegVar("ID", get_ID, set_ID);
		L.RegVar("Level", get_Level, set_Level);
		L.RegVar("attributeID", get_attributeID, set_attributeID);
		L.RegVar("attributeValue", get_attributeValue, set_attributeValue);
		L.RegVar("skillLevel", get_skillLevel, set_skillLevel);
		L.RegVar("astrolabe", get_astrolabe, set_astrolabe);
		L.RegVar("equipment", get_equipment, set_equipment);
		L.RegVar("weaponEffectID", get_weaponEffectID, set_weaponEffectID);
		L.RegVar("weaponEffectLevel", get_weaponEffectLevel, set_weaponEffectLevel);
		L.RegVar("AIChip", get_AIChip, set_AIChip);
		L.RegVar("equipSkillID", get_equipSkillID, set_equipSkillID);
		L.RegVar("equipSkillLv", get_equipSkillLv, set_equipSkillLv);
		L.RegVar("mainDamageType", get_mainDamageType, set_mainDamageType);
		L.RegVar("isVow", get_isVow, set_isVow);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRoleDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RoleDataForExchange o = new RoleDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RoleDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long uID = ((RoleDataForExchange)obj).UID;
			LuaDLL.tolua_pushint64(L, uID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playerLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int playerLevel = ((RoleDataForExchange)obj).playerLevel;
			LuaDLL.lua_pushinteger(L, playerLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int iD = ((RoleDataForExchange)obj).ID;
			LuaDLL.lua_pushinteger(L, iD);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int level = ((RoleDataForExchange)obj).Level;
			LuaDLL.lua_pushinteger(L, level);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attributeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] attributeID = ((RoleDataForExchange)obj).attributeID;
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
			long[] attributeValue = ((RoleDataForExchange)obj).attributeValue;
			ToLua.Push(L, attributeValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attributeValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] skillLevel = ((RoleDataForExchange)obj).skillLevel;
			ToLua.Push(L, skillLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_astrolabe(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] astrolabe = ((RoleDataForExchange)obj).astrolabe;
			ToLua.Push(L, astrolabe);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index astrolabe on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_equipment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] equipment = ((RoleDataForExchange)obj).equipment;
			ToLua.Push(L, equipment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index equipment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weaponEffectID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int weaponEffectID = ((RoleDataForExchange)obj).weaponEffectID;
			LuaDLL.lua_pushinteger(L, weaponEffectID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weaponEffectID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weaponEffectLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int weaponEffectLevel = ((RoleDataForExchange)obj).weaponEffectLevel;
			LuaDLL.lua_pushinteger(L, weaponEffectLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weaponEffectLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AIChip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] aIChip = ((RoleDataForExchange)obj).AIChip;
			ToLua.Push(L, aIChip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AIChip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_equipSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] equipSkillID = ((RoleDataForExchange)obj).equipSkillID;
			ToLua.Push(L, equipSkillID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index equipSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_equipSkillLv(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] equipSkillLv = ((RoleDataForExchange)obj).equipSkillLv;
			ToLua.Push(L, equipSkillLv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index equipSkillLv on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainDamageType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mainDamageType = ((RoleDataForExchange)obj).mainDamageType;
			LuaDLL.lua_pushinteger(L, mainDamageType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainDamageType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isVow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVow = ((RoleDataForExchange)obj).isVow;
			LuaDLL.lua_pushboolean(L, isVow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			long uID = LuaDLL.tolua_checkint64(L, 2);
			obj2.UID = uID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playerLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int playerLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.playerLevel = playerLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
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
	private static int set_Level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.Level = level;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attributeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
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
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
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
	private static int set_skillLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int[] skillLevel = ToLua.CheckNumberArray<int>(L, 2);
			obj2.skillLevel = skillLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_astrolabe(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int[] astrolabe = ToLua.CheckNumberArray<int>(L, 2);
			obj2.astrolabe = astrolabe;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index astrolabe on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_equipment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int[] equipment = ToLua.CheckNumberArray<int>(L, 2);
			obj2.equipment = equipment;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index equipment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_weaponEffectID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int weaponEffectID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.weaponEffectID = weaponEffectID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weaponEffectID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_weaponEffectLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int weaponEffectLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.weaponEffectLevel = weaponEffectLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weaponEffectLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AIChip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int[] aIChip = ToLua.CheckNumberArray<int>(L, 2);
			obj2.AIChip = aIChip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AIChip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_equipSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int[] equipSkillID = ToLua.CheckNumberArray<int>(L, 2);
			obj2.equipSkillID = equipSkillID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index equipSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_equipSkillLv(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int[] equipSkillLv = ToLua.CheckNumberArray<int>(L, 2);
			obj2.equipSkillLv = equipSkillLv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index equipSkillLv on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainDamageType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
			int mainDamageType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mainDamageType = mainDamageType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainDamageType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isVow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange obj2 = (RoleDataForExchange)obj;
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

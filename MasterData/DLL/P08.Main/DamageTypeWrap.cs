using System;
using LuaInterface;

public class DamageTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(DamageType));
		L.RegVar("None", get_None, null);
		L.RegVar("Damage", get_Damage, null);
		L.RegVar("Crit", get_Crit, null);
		L.RegVar("Missing", get_Missing, null);
		L.RegVar("Skill", get_Skill, null);
		L.RegVar("Buff", get_Buff, null);
		L.RegVar("Defense", get_Defense, null);
		L.RegVar("CritRecover", get_CritRecover, null);
		L.RegVar("Recover", get_Recover, null);
		L.RegVar("Absorb", get_Absorb, null);
		L.RegVar("HighDamage", get_HighDamage, null);
		L.RegVar("HighDamageCrit", get_HighDamageCrit, null);
		L.RegVar("AffixDamage", get_AffixDamage, null);
		L.RegVar("Immune", get_Immune, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<DamageType>.Check = CheckType;
		StackTraits<DamageType>.Push = Push;
	}

	private static void Push(IntPtr L, DamageType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(DamageType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_None(IntPtr L)
	{
		ToLua.Push(L, DamageType.None);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Damage(IntPtr L)
	{
		ToLua.Push(L, DamageType.Damage);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Crit(IntPtr L)
	{
		ToLua.Push(L, DamageType.Crit);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Missing(IntPtr L)
	{
		ToLua.Push(L, DamageType.Missing);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Skill(IntPtr L)
	{
		ToLua.Push(L, DamageType.Skill);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Buff(IntPtr L)
	{
		ToLua.Push(L, DamageType.Buff);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Defense(IntPtr L)
	{
		ToLua.Push(L, DamageType.Defense);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CritRecover(IntPtr L)
	{
		ToLua.Push(L, DamageType.CritRecover);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Recover(IntPtr L)
	{
		ToLua.Push(L, DamageType.Recover);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Absorb(IntPtr L)
	{
		ToLua.Push(L, DamageType.Absorb);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HighDamage(IntPtr L)
	{
		ToLua.Push(L, DamageType.HighDamage);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HighDamageCrit(IntPtr L)
	{
		ToLua.Push(L, DamageType.HighDamageCrit);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AffixDamage(IntPtr L)
	{
		ToLua.Push(L, DamageType.AffixDamage);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Immune(IntPtr L)
	{
		ToLua.Push(L, DamageType.Immune);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		DamageType damageType = (DamageType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, damageType);
		return 1;
	}
}

using System;
using LuaInterface;

public class RepairAssetsToLuaWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RepairAssetsToLua), typeof(object));
		L.RegFunction("VerifyAssets", VerifyAssets);
		L.RegFunction("HasError", HasError);
		L.RegFunction("GetTotalVerifyCount", GetTotalVerifyCount);
		L.RegFunction("GetCurrentVerifyIndex", GetCurrentVerifyIndex);
		L.RegFunction("IsVerifying", IsVerifying);
		L.RegFunction("StopVerify", StopVerify);
		L.RegFunction("New", _CreateRepairAssetsToLua);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRepairAssetsToLua(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RepairAssetsToLua o = new RepairAssetsToLua();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RepairAssetsToLua.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int VerifyAssets(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			RepairAssetsToLua.VerifyAssets();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasError(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = RepairAssetsToLua.HasError();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTotalVerifyCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int totalVerifyCount = RepairAssetsToLua.GetTotalVerifyCount();
			LuaDLL.lua_pushinteger(L, totalVerifyCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentVerifyIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int currentVerifyIndex = RepairAssetsToLua.GetCurrentVerifyIndex();
			LuaDLL.lua_pushinteger(L, currentVerifyIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsVerifying(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = RepairAssetsToLua.IsVerifying();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopVerify(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			RepairAssetsToLua.StopVerify();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

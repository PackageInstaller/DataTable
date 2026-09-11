using System;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;

namespace LuaInterface;

public class LuaDLL
{
	public static string version = "1.0.7.386";

	public static int LUA_MULTRET = -1;

	public static string[] LuaTypeName = new string[10] { "none", "nil", "boolean", "lightuserdata", "number", "string", "table", "function", "userdata", "thread" };

	private const string LUADLL = "tolua";

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_pb(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_ffi(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_bit(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_struct(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_lpeg(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_socket_core(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_mime_core(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_cjson(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaopen_cjson_safe(IntPtr L);

	public static int lua_upvalueindex(int i)
	{
		return LuaIndexes.LUA_GLOBALSINDEX - i;
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_close(IntPtr luaState);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr lua_newthread(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr lua_atpanic(IntPtr luaState, IntPtr panic);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_gettop(IntPtr luaState);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_settop(IntPtr luaState, int top);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_pushvalue(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_remove(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_insert(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_replace(IntPtr luaState, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_checkstack(IntPtr luaState, int extra);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_xmove(IntPtr from, IntPtr to, int n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_isnumber(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_isstring(IntPtr luaState, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_iscfunction(IntPtr luaState, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_isuserdata(IntPtr luaState, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern LuaTypes lua_type(IntPtr luaState, int index);

	public static string lua_typename(IntPtr luaState, LuaTypes type)
	{
		return LuaTypeName[(int)(type + 1)];
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_equal(IntPtr luaState, int idx1, int idx2);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_rawequal(IntPtr luaState, int idx1, int idx2);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_lessthan(IntPtr luaState, int idx1, int idx2);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern double lua_tonumber(IntPtr luaState, int idx);

	public static int lua_tointeger(IntPtr luaState, int idx)
	{
		return tolua_tointeger(luaState, idx);
	}

	public static bool lua_toboolean(IntPtr luaState, int idx)
	{
		return tolua_toboolean(luaState, idx);
	}

	public static IntPtr lua_tolstring(IntPtr luaState, int index, out int strLen)
	{
		return tolua_tolstring(luaState, index, out strLen);
	}

	public static int lua_objlen(IntPtr luaState, int idx)
	{
		return tolua_objlen(luaState, idx);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr lua_tocfunction(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr lua_touserdata(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr lua_tothread(IntPtr L, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr lua_topointer(IntPtr L, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_pushnil(IntPtr luaState);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_pushnumber(IntPtr luaState, double number);

	public static void lua_pushinteger(IntPtr L, int n)
	{
		lua_pushnumber(L, n);
	}

	public static void lua_pushlstring(IntPtr luaState, byte[] str, int size)
	{
		if (size >= 2147483392)
		{
			throw new LuaException("string length overflow");
		}
		tolua_pushlstring(luaState, str, size);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_pushstring(IntPtr luaState, string str);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_pushcclosure(IntPtr luaState, IntPtr fn, int n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_pushboolean(IntPtr luaState, int value);

	public static void lua_pushboolean(IntPtr luaState, bool value)
	{
		lua_pushboolean(luaState, value ? 1 : 0);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_pushlightuserdata(IntPtr luaState, IntPtr udata);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_pushthread(IntPtr L);

	public static void lua_gettable(IntPtr L, int idx)
	{
		if (tolua_gettable(L, idx) != 0)
		{
			throw new LuaException(lua_tostring(L, -1));
		}
	}

	public static void lua_getfield(IntPtr L, int idx, string key)
	{
		if (tolua_getfield(L, idx, key) != 0)
		{
			throw new LuaException(lua_tostring(L, -1));
		}
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_rawget(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_rawgeti(IntPtr luaState, int idx, int n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_createtable(IntPtr luaState, int narr, int nrec);

	public static IntPtr lua_newuserdata(IntPtr luaState, int size)
	{
		return tolua_newuserdata(luaState, size);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_getmetatable(IntPtr luaState, int objIndex);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_getfenv(IntPtr luaState, int idx);

	public static void lua_settable(IntPtr L, int idx)
	{
		if (tolua_settable(L, idx) != 0)
		{
			throw new LuaException(lua_tostring(L, -1));
		}
	}

	public static void lua_setfield(IntPtr L, int idx, string key)
	{
		if (tolua_setfield(L, idx, key) != 0)
		{
			throw new LuaException(lua_tostring(L, -1));
		}
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_rawset(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_rawseti(IntPtr luaState, int tableIndex, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_setmetatable(IntPtr luaState, int objIndex);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_setfenv(IntPtr luaState, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_call(IntPtr luaState, int nArgs, int nResults);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_pcall(IntPtr luaState, int nArgs, int nResults, int errfunc);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_cpcall(IntPtr L, IntPtr func, IntPtr ud);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_yield(IntPtr L, int nresults);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_resume(IntPtr L, int narg);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_status(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_gc(IntPtr luaState, LuaGCOptions what, int data);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_next(IntPtr luaState, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void lua_concat(IntPtr luaState, int n);

	public static void lua_pop(IntPtr luaState, int amount)
	{
		lua_settop(luaState, -amount - 1);
	}

	public static void lua_newtable(IntPtr luaState)
	{
		lua_createtable(luaState, 0, 0);
	}

	public static void lua_register(IntPtr luaState, string name, LuaCSFunction func)
	{
		lua_pushcfunction(luaState, func);
		lua_setglobal(luaState, name);
	}

	public static void lua_pushcfunction(IntPtr luaState, LuaCSFunction func)
	{
		IntPtr functionPointerForDelegate = Marshal.GetFunctionPointerForDelegate(func);
		lua_pushcclosure(luaState, functionPointerForDelegate, 0);
	}

	public static bool lua_isfunction(IntPtr luaState, int n)
	{
		return lua_type(luaState, n) == LuaTypes.LUA_TFUNCTION;
	}

	public static bool lua_istable(IntPtr luaState, int n)
	{
		return lua_type(luaState, n) == LuaTypes.LUA_TTABLE;
	}

	public static bool lua_islightuserdata(IntPtr luaState, int n)
	{
		return lua_type(luaState, n) == LuaTypes.LUA_TLIGHTUSERDATA;
	}

	public static bool lua_isnil(IntPtr luaState, int n)
	{
		return lua_type(luaState, n) == LuaTypes.LUA_TNIL;
	}

	public static bool lua_isboolean(IntPtr luaState, int n)
	{
		LuaTypes luaTypes = lua_type(luaState, n);
		if (luaTypes != LuaTypes.LUA_TBOOLEAN)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public static bool lua_isthread(IntPtr luaState, int n)
	{
		return lua_type(luaState, n) == LuaTypes.LUA_TTHREAD;
	}

	public static bool lua_isnone(IntPtr luaState, int n)
	{
		return lua_type(luaState, n) == LuaTypes.LUA_TNONE;
	}

	public static bool lua_isnoneornil(IntPtr luaState, int n)
	{
		return lua_type(luaState, n) <= LuaTypes.LUA_TNIL;
	}

	public static void lua_setglobal(IntPtr luaState, string name)
	{
		lua_setfield(luaState, LuaIndexes.LUA_GLOBALSINDEX, name);
	}

	public static void lua_getglobal(IntPtr luaState, string name)
	{
		lua_getfield(luaState, LuaIndexes.LUA_GLOBALSINDEX, name);
	}

	public static string lua_ptrtostring(IntPtr str, int len)
	{
		string text = Marshal.PtrToStringAnsi(str, len);
		if (text == null)
		{
			byte[] array = new byte[len];
			Marshal.Copy(str, array, 0, len);
			return Encoding.UTF8.GetString(array);
		}
		return text;
	}

	public static string lua_tostring(IntPtr luaState, int index)
	{
		int strLen = 0;
		IntPtr intPtr = tolua_tolstring(luaState, index, out strLen);
		if (intPtr != IntPtr.Zero)
		{
			return lua_ptrtostring(intPtr, strLen);
		}
		return null;
	}

	public static IntPtr lua_open()
	{
		return luaL_newstate();
	}

	public static void lua_getregistry(IntPtr L)
	{
		lua_pushvalue(L, LuaIndexes.LUA_REGISTRYINDEX);
	}

	public static int lua_getgccount(IntPtr L)
	{
		return lua_gc(L, LuaGCOptions.LUA_GCCOUNT, 0);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_getstack(IntPtr L, int level, ref Lua_Debug ar);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_getinfo(IntPtr L, string what, ref Lua_Debug ar);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern string lua_getlocal(IntPtr L, ref Lua_Debug ar, int n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern string lua_setlocal(IntPtr L, ref Lua_Debug ar, int n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern string lua_getupvalue(IntPtr L, int funcindex, int n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern string lua_setupvalue(IntPtr L, int funcindex, int n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_sethook(IntPtr L, LuaHookFunc func, int mask, int count);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern LuaHookFunc lua_gethook(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_gethookmask(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int lua_gethookcount(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void luaL_openlibs(IntPtr luaState);

	public static int abs_index(IntPtr L, int i)
	{
		if (i <= 0 && i > LuaIndexes.LUA_REGISTRYINDEX)
		{
			return lua_gettop(L) + i + 1;
		}
		return i;
	}

	public static int luaL_getn(IntPtr luaState, int i)
	{
		return tolua_getn(luaState, i);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaL_getmetafield(IntPtr luaState, int stackPos, string field);

	public static int luaL_callmeta(IntPtr L, int stackPos, string field)
	{
		stackPos = abs_index(L, stackPos);
		if (luaL_getmetafield(L, stackPos, field) == 0)
		{
			return 0;
		}
		lua_pushvalue(L, stackPos);
		if (lua_pcall(L, 1, 1, 0) != 0)
		{
			string msg = lua_tostring(L, -1);
			lua_pop(L, 1);
			throw new LuaException(msg);
		}
		return 1;
	}

	public static int luaL_argerror(IntPtr L, int narg, string extramsg)
	{
		if (tolua_argerror(L, narg, extramsg) != 0)
		{
			string msg = lua_tostring(L, -1);
			lua_pop(L, 1);
			throw new LuaException(msg);
		}
		return 0;
	}

	public static int luaL_typerror(IntPtr L, int stackPos, string tname, string t2 = null)
	{
		if (t2 == null)
		{
			t2 = luaL_typename(L, stackPos);
		}
		string extramsg = $"{tname} expected, got {t2}";
		return luaL_argerror(L, stackPos, extramsg);
	}

	public static string luaL_checklstring(IntPtr L, int numArg, out int len)
	{
		IntPtr intPtr = tolua_tolstring(L, numArg, out len);
		if (intPtr == IntPtr.Zero)
		{
			luaL_typerror(L, numArg, "string");
			return null;
		}
		return lua_ptrtostring(intPtr, len);
	}

	public static string luaL_optlstring(IntPtr L, int narg, string def, out int len)
	{
		if (lua_isnoneornil(L, narg))
		{
			len = def?.Length ?? 0;
			return def;
		}
		return luaL_checklstring(L, narg, out len);
	}

	public static double luaL_checknumber(IntPtr L, int stackPos)
	{
		double num = lua_tonumber(L, stackPos);
		if (num == 0.0 && lua_isnumber(L, stackPos) == 0)
		{
			luaL_typerror(L, stackPos, "number");
			return 0.0;
		}
		return num;
	}

	public static double luaL_optnumber(IntPtr L, int idx, double def)
	{
		if (lua_isnoneornil(L, idx))
		{
			return def;
		}
		return luaL_checknumber(L, idx);
	}

	public static int luaL_checkinteger(IntPtr L, int stackPos)
	{
		int num = tolua_tointeger(L, stackPos);
		if (num == 0 && lua_isnumber(L, stackPos) == 0)
		{
			luaL_typerror(L, stackPos, "number");
			return 0;
		}
		return num;
	}

	public static int luaL_optinteger(IntPtr L, int idx, int def)
	{
		if (lua_isnoneornil(L, idx))
		{
			return def;
		}
		return luaL_checkinteger(L, idx);
	}

	public static bool luaL_checkboolean(IntPtr luaState, int index)
	{
		if (lua_isboolean(luaState, index))
		{
			return lua_toboolean(luaState, index);
		}
		luaL_typerror(luaState, index, "boolean");
		return false;
	}

	public static void luaL_checkstack(IntPtr L, int space, string mes)
	{
		if (lua_checkstack(L, space) == 0)
		{
			throw new LuaException($"stack overflow {mes}");
		}
	}

	public static void luaL_checktype(IntPtr L, int narg, LuaTypes t)
	{
		if (lua_type(L, narg) != t)
		{
			luaL_typerror(L, narg, lua_typename(L, t));
		}
	}

	public static void luaL_checkany(IntPtr L, int narg)
	{
		if (lua_type(L, narg) == LuaTypes.LUA_TNONE)
		{
			luaL_argerror(L, narg, "value expected");
		}
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaL_newmetatable(IntPtr luaState, string meta);

	public static IntPtr luaL_checkudata(IntPtr L, int ud, string tname)
	{
		IntPtr intPtr = lua_touserdata(L, ud);
		if (intPtr != IntPtr.Zero && lua_getmetatable(L, ud) != 0)
		{
			lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, tname);
			if (lua_rawequal(L, -1, -2) != 0)
			{
				lua_pop(L, 2);
				return intPtr;
			}
		}
		luaL_typerror(L, ud, tname);
		return IntPtr.Zero;
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void luaL_where(IntPtr luaState, int level);

	public static int luaL_throw(IntPtr L, string message)
	{
		tolua_pushtraceback(L);
		lua_pushstring(L, message);
		lua_pushnumber(L, 1.0);
		if (lua_pcall(L, 2, -1, 0) == 0)
		{
			message = lua_tostring(L, -1);
		}
		else
		{
			lua_pop(L, 1);
		}
		throw new LuaException(message, null, 2);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaL_ref(IntPtr luaState, int t);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void luaL_unref(IntPtr luaState, int registryIndex, int reference);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaL_loadfile(IntPtr luaState, string filename);

	public static int luaL_loadbuffer(IntPtr luaState, byte[] buff, int size, string name)
	{
		return tolua_loadbuffer(luaState, buff, size, name);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int luaL_loadstring(IntPtr luaState, string chunk);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr luaL_newstate();

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr luaL_gsub(IntPtr luaState, string str, string pattern, string replacement);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr luaL_findtable(IntPtr luaState, int idx, string fname, int szhint = 1);

	public static string luaL_typename(IntPtr luaState, int stackPos)
	{
		LuaTypes type = lua_type(luaState, stackPos);
		return lua_typename(luaState, type);
	}

	public static bool luaL_dofile(IntPtr luaState, string fileName)
	{
		if (luaL_loadfile(luaState, fileName) != 0)
		{
			return false;
		}
		return lua_pcall(luaState, 0, LUA_MULTRET, 0) == 0;
	}

	public static bool luaL_dostring(IntPtr luaState, string chunk)
	{
		if (luaL_loadstring(luaState, chunk) != 0)
		{
			return false;
		}
		return lua_pcall(luaState, 0, LUA_MULTRET, 0) == 0;
	}

	public static void luaL_getmetatable(IntPtr luaState, string meta)
	{
		lua_getfield(luaState, LuaIndexes.LUA_REGISTRYINDEX, meta);
	}

	public static int lua_ref(IntPtr luaState)
	{
		return luaL_ref(luaState, LuaIndexes.LUA_REGISTRYINDEX);
	}

	public static void lua_getref(IntPtr luaState, int reference)
	{
		lua_rawgeti(luaState, LuaIndexes.LUA_REGISTRYINDEX, reference);
	}

	public static void lua_unref(IntPtr luaState, int reference)
	{
		luaL_unref(luaState, LuaIndexes.LUA_REGISTRYINDEX, reference);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_openlibs(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_openint64(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_openlualibs(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr tolua_tag();

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_newudata(IntPtr luaState, int val);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_rawnetobj(IntPtr luaState, int obj);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_pushudata(IntPtr L, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_pushnewudata(IntPtr L, int metaRef, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_beginpcall(IntPtr L, int reference);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushtraceback(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_getvec2(IntPtr luaState, int stackPos, out float x, out float y);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_getvec3(IntPtr luaState, int stackPos, out float x, out float y, out float z);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_getvec4(IntPtr luaState, int stackPos, out float x, out float y, out float z, out float w);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_getclr(IntPtr luaState, int stackPos, out float r, out float g, out float b, out float a);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_getquat(IntPtr luaState, int stackPos, out float x, out float y, out float z, out float w);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_getlayermask(IntPtr luaState, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushvec2(IntPtr luaState, float x, float y);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushvec3(IntPtr luaState, float x, float y, float z);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushvec4(IntPtr luaState, float x, float y, float z, float w);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushquat(IntPtr luaState, float x, float y, float z, float w);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushclr(IntPtr luaState, float r, float g, float b, float a);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushlayermask(IntPtr luaState, int mask);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_isint64(IntPtr luaState, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern long tolua_toint64(IntPtr luaState, int stackPos);

	public static long tolua_checkint64(IntPtr L, int stackPos)
	{
		long num = tolua_toint64(L, stackPos);
		if (num == 0L && !tolua_isint64(L, stackPos))
		{
			luaL_typerror(L, stackPos, "long");
			return 0L;
		}
		return num;
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushint64(IntPtr luaState, long n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_isuint64(IntPtr luaState, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern ulong tolua_touint64(IntPtr luaState, int stackPos);

	public static ulong tolua_checkuint64(IntPtr L, int stackPos)
	{
		ulong num = tolua_touint64(L, stackPos);
		if (num == 0L && !tolua_isuint64(L, stackPos))
		{
			luaL_typerror(L, stackPos, "ulong");
			return 0uL;
		}
		return num;
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushuint64(IntPtr luaState, ulong n);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_setindex(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_setnewindex(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int toluaL_ref(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void toluaL_unref(IntPtr L, int reference);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr tolua_getmainstate(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_getvaluetype(IntPtr L, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_createtable(IntPtr L, string fullPath, int szhint = 0);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_pushluatable(IntPtr L, string fullPath);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_beginmodule(IntPtr L, string name);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_endmodule(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_beginpremodule(IntPtr L, string fullPath, int szhint = 0);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_endpremodule(IntPtr L, int reference);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_addpreload(IntPtr L, string path);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_beginclass(IntPtr L, string name, int baseMetaRef, int reference = -1);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_endclass(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_function(IntPtr L, string name, IntPtr fn);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr tolua_tocbuffer(string name, int sz);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_freebuffer(IntPtr buffer);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_variable(IntPtr L, string name, IntPtr get, IntPtr set);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_constant(IntPtr L, string name, double val);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_beginenum(IntPtr L, string name);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_endenum(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_beginstaticclass(IntPtr L, string name);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_endstaticclass(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_require(IntPtr L, string fileName);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_getmetatableref(IntPtr L, int pos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_setflag(int bit, bool flag);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_isvptrtable(IntPtr L, int index);

	public static int toluaL_exception(IntPtr L, Exception e)
	{
		LuaException.luaStack = new LuaException(e.Message, e, 2);
		Debug.LogException(e);
		return tolua_error(L, e.Message);
	}

	public static int toluaL_exception(IntPtr L, Exception e, object o, string msg)
	{
		if (o != null && !o.Equals(null))
		{
			msg = e.Message;
		}
		LuaException.luaStack = new LuaException(msg, e, 2);
		return tolua_error(L, msg);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_loadbuffer(IntPtr luaState, byte[] buff, int size, string name);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool tolua_toboolean(IntPtr luaState, int index);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_tointeger(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr tolua_tolstring(IntPtr luaState, int index, out int strLen);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushlstring(IntPtr luaState, byte[] str, int size);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_objlen(IntPtr luaState, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr tolua_newuserdata(IntPtr luaState, int size);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_argerror(IntPtr luaState, int narg, string extramsg);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_error(IntPtr L, string msg);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_getfield(IntPtr L, int idx, string key);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_setfield(IntPtr L, int idx, string key);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_gettable(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_settable(IntPtr luaState, int idx);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_getn(IntPtr luaState, int stackPos);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_strlen(IntPtr str);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushcfunction(IntPtr L, IntPtr fn);

	public static void tolua_pushcfunction(IntPtr luaState, LuaCSFunction func)
	{
		IntPtr functionPointerForDelegate = Marshal.GetFunctionPointerForDelegate(func);
		tolua_pushcfunction(luaState, functionPointerForDelegate);
	}

	public static string tolua_findtable(IntPtr L, int idx, string name, int size = 1)
	{
		int top = lua_gettop(L);
		IntPtr intPtr = luaL_findtable(L, idx, name, size);
		if (intPtr != IntPtr.Zero)
		{
			lua_settop(L, top);
			int len = tolua_strlen(intPtr);
			return lua_ptrtostring(intPtr, len);
		}
		return null;
	}

	public static IntPtr tolua_atpanic(IntPtr L, LuaCSFunction func)
	{
		IntPtr functionPointerForDelegate = Marshal.GetFunctionPointerForDelegate(func);
		return lua_atpanic(L, functionPointerForDelegate);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern IntPtr tolua_buffinit(IntPtr luaState);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_addlstring(IntPtr b, string str, int l);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_addstring(IntPtr b, string s);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_addchar(IntPtr b, byte s);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_pushresult(IntPtr b);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_update(IntPtr L, float deltaTime, float unscaledDelta);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_lateupdate(IntPtr L);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_fixedupdate(IntPtr L, float fixedTime);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern void tolua_regthis(IntPtr L, IntPtr get, IntPtr set);

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_where(IntPtr L, int level);

	public static void tolua_bindthis(IntPtr L, LuaCSFunction get, LuaCSFunction set)
	{
		IntPtr get2 = IntPtr.Zero;
		IntPtr set2 = IntPtr.Zero;
		if (get != null)
		{
			get2 = Marshal.GetFunctionPointerForDelegate(get);
		}
		if (set != null)
		{
			set2 = Marshal.GetFunctionPointerForDelegate(set);
		}
		tolua_regthis(L, get2, set2);
	}

	[DllImport("tolua", CallingConvention = CallingConvention.Cdecl)]
	public static extern int tolua_getclassref(IntPtr L, int pos);
}

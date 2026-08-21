using System;
using System.Collections.Generic;
using LuaInterface;

public class FileStreamMgrWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(FileStreamMgr), typeof(object));
		L.RegFunction("CreateFile", CreateFile);
		L.RegFunction("DeleteFile", DeleteFile);
		L.RegFunction("DeleteDirectory", DeleteDirectory);
		L.RegFunction("AppendLine", AppendLine);
		L.RegFunction("AppendLines", AppendLines);
		L.RegFunction("ReadlAllLine", ReadlAllLine);
		L.RegFunction("New", _CreateFileStreamMgr);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateFileStreamMgr(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				FileStreamMgr o = new FileStreamMgr();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: FileStreamMgr.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateFile(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FileStreamMgr obj = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
			string path = ToLua.CheckString(L, 2);
			obj.CreateFile(path);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteFile(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FileStreamMgr obj = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
			string path = ToLua.CheckString(L, 2);
			obj.DeleteFile(path);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteDirectory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FileStreamMgr obj = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
			string path = ToLua.CheckString(L, 2);
			obj.DeleteDirectory(path);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AppendLine(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				FileStreamMgr obj2 = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
				string path2 = ToLua.CheckString(L, 2);
				string content2 = ToLua.CheckString(L, 3);
				obj2.AppendLine(path2, content2);
				return 0;
			}
			case 4:
			{
				FileStreamMgr obj = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
				string path = ToLua.CheckString(L, 2);
				string content = ToLua.CheckString(L, 3);
				bool isAppend = LuaDLL.luaL_checkboolean(L, 4);
				obj.AppendLine(path, content, isAppend);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: FileStreamMgr.AppendLine");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AppendLines(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				FileStreamMgr obj2 = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
				string path2 = ToLua.CheckString(L, 2);
				LuaTable table2 = ToLua.CheckLuaTable(L, 3);
				obj2.AppendLines(path2, table2);
				return 0;
			}
			case 4:
			{
				FileStreamMgr obj = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
				string path = ToLua.CheckString(L, 2);
				LuaTable table = ToLua.CheckLuaTable(L, 3);
				bool isAppend = LuaDLL.luaL_checkboolean(L, 4);
				obj.AppendLines(path, table, isAppend);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: FileStreamMgr.AppendLines");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReadlAllLine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FileStreamMgr obj = (FileStreamMgr)ToLua.CheckObject<FileStreamMgr>(L, 1);
			string path = ToLua.CheckString(L, 2);
			List<string> o = obj.ReadlAllLine(path);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inst(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, FileStreamMgr.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;

public class BulletinBoardMgrWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BulletinBoardMgr), typeof(MonoBehaviour));
		L.RegFunction("ClearCache", ClearCache);
		L.RegFunction("GetSprite", GetSprite);
		L.RegFunction("GetFocalSpriteCustom", GetFocalSpriteCustom);
		L.RegFunction("StopLoader", StopLoader);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearCache(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BulletinBoardMgr obj = (BulletinBoardMgr)ToLua.CheckObject<BulletinBoardMgr>(L, 1);
			string[] folderNameList = ToLua.CheckStringArray(L, 2);
			obj.ClearCache(folderNameList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			BulletinBoardMgr obj = (BulletinBoardMgr)ToLua.CheckObject<BulletinBoardMgr>(L, 1);
			string folderName = ToLua.CheckString(L, 2);
			string url = ToLua.CheckString(L, 3);
			UnityAction<Sprite> callBack = (UnityAction<Sprite>)ToLua.CheckDelegate<UnityAction<Sprite>>(L, 4);
			obj.GetSprite(folderName, url, callBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFocalSpriteCustom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BulletinBoardMgr obj = (BulletinBoardMgr)ToLua.CheckObject<BulletinBoardMgr>(L, 1);
			string filePath = ToLua.CheckString(L, 2);
			UnityAction<Sprite> callBack = (UnityAction<Sprite>)ToLua.CheckDelegate<UnityAction<Sprite>>(L, 3);
			obj.GetFocalSpriteCustom(filePath, callBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopLoader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BulletinBoardMgr obj = (BulletinBoardMgr)ToLua.CheckObject<BulletinBoardMgr>(L, 1);
			string url = ToLua.CheckString(L, 2);
			obj.StopLoader(url);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
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
			ToLua.Push(L, BulletinBoardMgr.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

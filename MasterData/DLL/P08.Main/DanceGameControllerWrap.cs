using System;
using System.Collections.Generic;
using Cinemachine;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class DanceGameControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DanceGameController), typeof(MonoBehaviour));
		L.RegFunction("AddCue", AddCue);
		L.RegFunction("RemoveAddedCueSheets", RemoveAddedCueSheets);
		L.RegFunction("GetCueInfoLength", GetCueInfoLength);
		L.RegFunction("SetEntityAnimeSpeed", SetEntityAnimeSpeed);
		L.RegFunction("SetDummyFollowEntity", SetDummyFollowEntity);
		L.RegFunction("GetDummy", GetDummy);
		L.RegFunction("Load", Load);
		L.RegFunction("InitCinemachineBrain", InitCinemachineBrain);
		L.RegFunction("UpdateCharaGrabPos", UpdateCharaGrabPos);
		L.RegFunction("InitCampEntity", InitCampEntity);
		L.RegFunction("LoadSceneObjAsync", LoadSceneObjAsync);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("dummyList", get_dummyList, set_dummyList);
		L.RegVar("brain", get_brain, set_brain);
		L.RegVar("director", get_director, set_director);
		L.RegVar("cut", get_cut, null);
		L.RegVar("loadScene", get_loadScene, set_loadScene);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddCue(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				DanceGameController.AddCue(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string cueSheet2 = ToLua.CheckString(L, 1);
				string awbFile = ToLua.CheckString(L, 2);
				DanceGameController.AddCue(cueSheet2, awbFile);
				return 0;
			}
			case 3:
			{
				string cueSheet = ToLua.CheckString(L, 1);
				string cueName = ToLua.CheckString(L, 2);
				bool useAwbFile = LuaDLL.luaL_checkboolean(L, 3);
				DanceGameController.AddCue(cueSheet, cueName, useAwbFile);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DanceGameController.AddCue");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAddedCueSheets(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DanceGameController.RemoveAddedCueSheets();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCueInfoLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string cueSheetName = ToLua.CheckString(L, 1);
			string cueName = ToLua.CheckString(L, 2);
			string awbFile = ToLua.CheckString(L, 3);
			int cueInfoLength = DanceGameController.GetCueInfoLength(cueSheetName, cueName, awbFile);
			LuaDLL.lua_pushinteger(L, cueInfoLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEntityAnimeSpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			DanceGameController.SetEntityAnimeSpeed(entityID, speed);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDummyFollowEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DanceGameController obj = (DanceGameController)ToLua.CheckObject<DanceGameController>(L, 1);
			string dummyName = ToLua.CheckString(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SetDummyFollowEntity(dummyName, entityID);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDummy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DanceGameController obj = (DanceGameController)ToLua.CheckObject<DanceGameController>(L, 1);
			string dummyName = ToLua.CheckString(L, 2);
			Transform dummy = obj.GetDummy(dummyName);
			ToLua.Push(L, dummy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Load(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DanceGameController obj = DanceGameController.Load(ToLua.CheckString(L, 1));
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitCinemachineBrain(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CinemachineBrain obj = ((DanceGameController)ToLua.CheckObject<DanceGameController>(L, 1)).InitCinemachineBrain();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateCharaGrabPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Collider[] walls = ToLua.CheckObjectArray<Collider>(L, 1);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 3);
			DanceGameController.UpdateCharaGrabPos(walls, entityID, eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitCampEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DanceGameController.InitCampEntity((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadSceneObjAsync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string path = ToLua.CheckString(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			bool value = DanceGameController.LoadSceneObjAsync(path, callback);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
	private static int get_dummyList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<PositionAttachIsNotChild> dummyList = ((DanceGameController)obj).dummyList;
			ToLua.PushSealed(L, dummyList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dummyList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_brain(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineBrain brain = ((DanceGameController)obj).brain;
			ToLua.Push(L, brain);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brain on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_director(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector director = ((DanceGameController)obj).director;
			ToLua.Push(L, director);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index director on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cut(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, DanceGameController.cut);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadScene(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, DanceGameController.loadScene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dummyList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DanceGameController obj2 = (DanceGameController)obj;
			List<PositionAttachIsNotChild> dummyList = (List<PositionAttachIsNotChild>)ToLua.CheckObject(L, 2, typeof(List<PositionAttachIsNotChild>));
			obj2.dummyList = dummyList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dummyList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_brain(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DanceGameController obj2 = (DanceGameController)obj;
			CinemachineBrain brain = (CinemachineBrain)ToLua.CheckObject<CinemachineBrain>(L, 2);
			obj2.brain = brain;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brain on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_director(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DanceGameController obj2 = (DanceGameController)obj;
			PlayableDirector director = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			obj2.director = director;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index director on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loadScene(IntPtr L)
	{
		try
		{
			DanceGameController.loadScene = StackTraits<Scene>.Check(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

using System;
using System.Collections.Generic;
using Cinemachine;
using LuaInterface;
using UnityEngine;

public class CharacterCameraManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CharacterCameraManager), typeof(MonoBehaviour));
		L.RegFunction("SetActiveCamera", SetActiveCamera);
		L.RegFunction("RemoveActiveCamera", RemoveActiveCamera);
		L.RegFunction("SwitchCamearInputmode", SwitchCamearInputmode);
		L.RegFunction("TweenToDefaultCameraPos", TweenToDefaultCameraPos);
		L.RegFunction("TweenAllCamToCameraPosByCfgID", TweenAllCamToCameraPosByCfgID);
		L.RegFunction("RemoveTween", RemoveTween);
		L.RegFunction("SetCameraPosWithMoveX", SetCameraPosWithMoveX);
		L.RegFunction("AddCameraPosWithMoveX", AddCameraPosWithMoveX);
		L.RegFunction("TweenCamComposerXToCenter", TweenCamComposerXToCenter);
		L.RegFunction("TweenCamComposerX", TweenCamComposerX);
		L.RegFunction("TweenCamComposerToCenter", TweenCamComposerToCenter);
		L.RegFunction("SetCameraParams", SetCameraParams);
		L.RegFunction("ResetCameraDefaultCfg", ResetCameraDefaultCfg);
		L.RegFunction("RotateCamera", RotateCamera);
		L.RegFunction("SyncFreelookVCamMove", SyncFreelookVCamMove);
		L.RegFunction("UpdateElevation", UpdateElevation);
		L.RegFunction("LateUpdate", LateUpdate);
		L.RegFunction("IsOpenelevation", IsOpenelevation);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("cinemachineFreeLookList", get_cinemachineFreeLookList, set_cinemachineFreeLookList);
		L.RegVar("dummyTrsList", get_dummyTrsList, set_dummyTrsList);
		L.RegVar("moveSpeedAffectComposerFactor", get_moveSpeedAffectComposerFactor, set_moveSpeedAffectComposerFactor);
		L.RegVar("lastCameraIndex", get_lastCameraIndex, set_lastCameraIndex);
		L.RegVar("touchHelper", get_touchHelper, set_touchHelper);
		L.RegVar("isMove", get_isMove, set_isMove);
		L.RegVar("cameara_mode", get_cameara_mode, set_cameara_mode);
		L.RegVar("IsTweening", get_IsTweening, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetActiveCamera(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				CharacterCameraManager obj3 = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				int index3 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj3.SetActiveCamera(index3);
				return 0;
			}
			case 3:
			{
				CharacterCameraManager obj2 = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				int index2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool cut2 = LuaDLL.luaL_checkboolean(L, 3);
				obj2.SetActiveCamera(index2, cut2);
				return 0;
			}
			case 4:
			{
				CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				bool cut = LuaDLL.luaL_checkboolean(L, 3);
				bool restore = LuaDLL.luaL_checkboolean(L, 4);
				obj.SetActiveCamera(index, cut, restore);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CharacterCameraManager.SetActiveCamera");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveActiveCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1)).RemoveActiveCamera();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SwitchCamearInputmode(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1)).SwitchCamearInputmode();
				return 0;
			case 2:
			{
				CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				int mode = (int)LuaDLL.luaL_checknumber(L, 2);
				obj.SwitchCamearInputmode(mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CharacterCameraManager.SwitchCamearInputmode");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TweenToDefaultCameraPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1)).TweenToDefaultCameraPos();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TweenAllCamToCameraPosByCfgID(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<CharacterCameraManager, int>(L, 1))
			{
				CharacterCameraManager obj = (CharacterCameraManager)ToLua.ToObject(L, 1);
				int cfgID = (int)LuaDLL.lua_tonumber(L, 2);
				obj.TweenAllCamToCameraPosByCfgID(cfgID);
				return 0;
			}
			if (TypeChecker.CheckTypes<CharacterCameraManager, int>(L, 1) && TypeChecker.CheckParamsType<int>(L, 3, num - 2))
			{
				CharacterCameraManager obj2 = (CharacterCameraManager)ToLua.ToObject(L, 1);
				int cfgID2 = (int)LuaDLL.lua_tonumber(L, 2);
				int[] tweenCamIds = ToLua.ToParamsNumber<int>(L, 3, num - 2);
				obj2.TweenAllCamToCameraPosByCfgID(cfgID2, tweenCamIds);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: CharacterCameraManager.TweenAllCamToCameraPosByCfgID");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveTween(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1)).RemoveTween();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCameraPosWithMoveX(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				CharacterCameraManager obj2 = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				float moveValue2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callback2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				obj2.SetCameraPosWithMoveX(moveValue2, callback2);
				return 0;
			}
			case 4:
			{
				CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				float moveValue = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callback = (Action)ToLua.CheckDelegate<Action>(L, 3);
				LeanTweenType easeType = (LeanTweenType)ToLua.CheckObject(L, 4, typeof(LeanTweenType));
				obj.SetCameraPosWithMoveX(moveValue, callback, easeType);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CharacterCameraManager.SetCameraPosWithMoveX");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddCameraPosWithMoveX(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				CharacterCameraManager obj2 = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				float moveValue2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callback2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				obj2.AddCameraPosWithMoveX(moveValue2, callback2);
				return 0;
			}
			case 4:
			{
				CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				float moveValue = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callback = (Action)ToLua.CheckDelegate<Action>(L, 3);
				LeanTweenType easeType = (LeanTweenType)ToLua.CheckObject(L, 4, typeof(LeanTweenType));
				obj.AddCameraPosWithMoveX(moveValue, callback, easeType);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CharacterCameraManager.AddCameraPosWithMoveX");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TweenCamComposerXToCenter(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				CharacterCameraManager obj2 = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				Action callback2 = (Action)ToLua.CheckDelegate<Action>(L, 2);
				obj2.TweenCamComposerXToCenter(callback2);
				return 0;
			}
			case 3:
			{
				CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
				LeanTweenType easeType = (LeanTweenType)ToLua.CheckObject(L, 3, typeof(LeanTweenType));
				obj.TweenCamComposerXToCenter(callback, easeType);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CharacterCameraManager.TweenCamComposerXToCenter");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TweenCamComposerX(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				CharacterCameraManager obj2 = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				float xValue2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callback2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				obj2.TweenCamComposerX(xValue2, callback2);
				return 0;
			}
			case 4:
			{
				CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
				float xValue = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callback = (Action)ToLua.CheckDelegate<Action>(L, 3);
				LeanTweenType easeType = (LeanTweenType)ToLua.CheckObject(L, 4, typeof(LeanTweenType));
				obj.TweenCamComposerX(xValue, callback, easeType);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CharacterCameraManager.TweenCamComposerX");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TweenCamComposerToCenter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.TweenCamComposerToCenter(callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCameraParams(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
			int cameraParams = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetCameraParams(cameraParams);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetCameraDefaultCfg(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1)).ResetCameraDefaultCfg();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
			float speed_x = (float)LuaDLL.luaL_checknumber(L, 2);
			float speed_y = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.RotateCamera(speed_x, speed_y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SyncFreelookVCamMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
			int target = (int)LuaDLL.luaL_checknumber(L, 2);
			int source = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SyncFreelookVCamMove(target, source);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateElevation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
			float speed_y = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.UpdateElevation(speed_y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LateUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1)).LateUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsOpenelevation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CharacterCameraManager obj = (CharacterCameraManager)ToLua.CheckObject<CharacterCameraManager>(L, 1);
			bool flag = LuaDLL.luaL_checkboolean(L, 2);
			obj.IsOpenelevation(flag);
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
	private static int get_cinemachineFreeLookList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CinemachineFreeLook> cinemachineFreeLookList = ((CharacterCameraManager)obj).cinemachineFreeLookList;
			ToLua.PushSealed(L, cinemachineFreeLookList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cinemachineFreeLookList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dummyTrsList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Transform> dummyTrsList = ((CharacterCameraManager)obj).dummyTrsList;
			ToLua.PushSealed(L, dummyTrsList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dummyTrsList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_moveSpeedAffectComposerFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float moveSpeedAffectComposerFactor = ((CharacterCameraManager)obj).moveSpeedAffectComposerFactor;
			LuaDLL.lua_pushnumber(L, moveSpeedAffectComposerFactor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveSpeedAffectComposerFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastCameraIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lastCameraIndex = ((CharacterCameraManager)obj).lastCameraIndex;
			LuaDLL.lua_pushinteger(L, lastCameraIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastCameraIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_touchHelper(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper touchHelper = ((CharacterCameraManager)obj).touchHelper;
			ToLua.Push(L, touchHelper);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index touchHelper on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isMove(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isMove = ((CharacterCameraManager)obj).isMove;
			LuaDLL.lua_pushboolean(L, isMove);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMove on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameara_mode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraInputMode cameara_mode = ((CharacterCameraManager)obj).cameara_mode;
			ToLua.Push(L, cameara_mode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameara_mode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsTweening(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isTweening = ((CharacterCameraManager)obj).IsTweening;
			LuaDLL.lua_pushboolean(L, isTweening);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsTweening on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cinemachineFreeLookList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterCameraManager obj2 = (CharacterCameraManager)obj;
			List<CinemachineFreeLook> cinemachineFreeLookList = (List<CinemachineFreeLook>)ToLua.CheckObject(L, 2, typeof(List<CinemachineFreeLook>));
			obj2.cinemachineFreeLookList = cinemachineFreeLookList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cinemachineFreeLookList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dummyTrsList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterCameraManager obj2 = (CharacterCameraManager)obj;
			List<Transform> dummyTrsList = (List<Transform>)ToLua.CheckObject(L, 2, typeof(List<Transform>));
			obj2.dummyTrsList = dummyTrsList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dummyTrsList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_moveSpeedAffectComposerFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterCameraManager obj2 = (CharacterCameraManager)obj;
			float moveSpeedAffectComposerFactor = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.moveSpeedAffectComposerFactor = moveSpeedAffectComposerFactor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveSpeedAffectComposerFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastCameraIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterCameraManager obj2 = (CharacterCameraManager)obj;
			int lastCameraIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.lastCameraIndex = lastCameraIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastCameraIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_touchHelper(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterCameraManager obj2 = (CharacterCameraManager)obj;
			MutiTouchHelper touchHelper = (MutiTouchHelper)ToLua.CheckObject<MutiTouchHelper>(L, 2);
			obj2.touchHelper = touchHelper;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index touchHelper on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isMove(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterCameraManager obj2 = (CharacterCameraManager)obj;
			bool isMove = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isMove = isMove;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMove on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cameara_mode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterCameraManager obj2 = (CharacterCameraManager)obj;
			CameraInputMode cameara_mode = (CameraInputMode)ToLua.CheckObject(L, 2, typeof(CameraInputMode));
			obj2.cameara_mode = cameara_mode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameara_mode on a nil value");
		}
	}
}

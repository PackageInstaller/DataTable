using System;
using Cinemachine;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.U2D;
using UnityEngine.UI;

public class LuaForUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaForUtil), typeof(object));
		L.RegFunction("OnLoginSuccess", OnLoginSuccess);
		L.RegFunction("NotifyLuaEvent", NotifyLuaEvent);
		L.RegFunction("SetSceneSetting", SetSceneSetting);
		L.RegFunction("GetClientVersion", GetClientVersion);
		L.RegFunction("GetVersionName", GetVersionName);
		L.RegFunction("GetResourceVersion", GetResourceVersion);
		L.RegFunction("GetResourceVersionName", GetResourceVersionName);
		L.RegFunction("UpdateVersionInfo", UpdateVersionInfo);
		L.RegFunction("GetBattleVersion", GetBattleVersion);
		L.RegFunction("PreLoadAtlas", PreLoadAtlas);
		L.RegFunction("EnableTposeRenders", EnableTposeRenders);
		L.RegFunction("PlayEffect", PlayEffect);
		L.RegFunction("PlayAttachEffect", PlayAttachEffect);
		L.RegFunction("StopEffect", StopEffect);
		L.RegFunction("InitWebView", InitWebView);
		L.RegFunction("OpenWebView", OpenWebView);
		L.RegFunction("CallWebView", CallWebView);
		L.RegFunction("InitSavePhoto", InitSavePhoto);
		L.RegFunction("SavePhotoToAlbum", SavePhotoToAlbum);
		L.RegFunction("SetAppIcon", SetAppIcon);
		L.RegFunction("SaveScreenShot", SaveScreenShot);
		L.RegFunction("OpenScreenShotFolder", OpenScreenShotFolder);
		L.RegFunction("LinkThirdApp", LinkThirdApp);
		L.RegFunction("GetFreeDiskSpace", GetFreeDiskSpace);
		L.RegFunction("ShowWeapon", ShowWeapon);
		L.RegFunction("EnableEyeController", EnableEyeController);
		L.RegFunction("PlayVoiceWithCriLipsync", PlayVoiceWithCriLipsync);
		L.RegFunction("StopCriLipsync", StopCriLipsync);
		L.RegFunction("GetIsMaintainByGMSDK", GetIsMaintainByGMSDK);
		L.RegFunction("GetUnreadMsg", GetUnreadMsg);
		L.RegFunction("UpdateCameraSetting", UpdateCameraSetting);
		L.RegFunction("IsCheckLuaMemory", IsCheckLuaMemory);
		L.RegFunction("RefreshI18NText", RefreshI18NText);
		L.RegFunction("GetLastCharPosition", GetLastCharPosition);
		L.RegFunction("ClearLinePrefixSymbol", ClearLinePrefixSymbol);
		L.RegFunction("AddHoverEffect", AddHoverEffect);
		L.RegFunction("ActiveHoverEffect", ActiveHoverEffect);
		L.RegFunction("HasBattleWinPos", HasBattleWinPos);
		L.RegFunction("EnableAudioSessionRestoration_IOS", EnableAudioSessionRestoration_IOS);
		L.RegFunction("GetCinemachineVirtualCameraFOV", GetCinemachineVirtualCameraFOV);
		L.RegFunction("SetCinemachineVirtualCameraFOV", SetCinemachineVirtualCameraFOV);
		L.RegFunction("SetVCMNoise", SetVCMNoise);
		L.RegFunction("SetTimelineSpeed", SetTimelineSpeed);
		L.RegFunction("SetTrailRendererClear", SetTrailRendererClear);
		L.RegFunction("SetAutoChessExportData", SetAutoChessExportData);
		L.RegFunction("HasCueSheet", HasCueSheet);
		L.RegFunction("GetRoleAttachPoint", GetRoleAttachPoint);
		L.RegFunction("SetNoOperationTime", SetNoOperationTime);
		L.RegFunction("DebugDrawLine", DebugDrawLine);
		L.RegFunction("New", _CreateLuaForUtil);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("IsManualAnimatorBlend", get_IsManualAnimatorBlend, set_IsManualAnimatorBlend);
		L.RegVar("LuaEventTrigger", get_LuaEventTrigger, set_LuaEventTrigger);
		L.RegVar("atlasLoadAction", get_atlasLoadAction, set_atlasLoadAction);
		L.RegVar("NowMilliSec", get_NowMilliSec, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLuaForUtil(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LuaForUtil o = new LuaForUtil();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LuaForUtil.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnLoginSuccess(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int channelId2 = (int)LuaDLL.luaL_checknumber(L, 1);
				string platformAccount2 = ToLua.CheckString(L, 2);
				string roleId2 = ToLua.CheckString(L, 3);
				LuaForUtil.OnLoginSuccess(channelId2, platformAccount2, roleId2);
				return 0;
			}
			case 4:
			{
				int channelId = (int)LuaDLL.luaL_checknumber(L, 1);
				string platformAccount = ToLua.CheckString(L, 2);
				string roleId = ToLua.CheckString(L, 3);
				int worldId = (int)LuaDLL.luaL_checknumber(L, 4);
				LuaForUtil.OnLoginSuccess(channelId, platformAccount, roleId, worldId);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForUtil.OnLoginSuccess");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NotifyLuaEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string eventName = ToLua.CheckString(L, 1);
			string data = ToLua.CheckString(L, 2);
			LuaForUtil.NotifyLuaEvent(eventName, data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSceneSetting(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject go = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			bool isEnable = LuaDLL.luaL_checkboolean(L, 2);
			LuaForUtil.SetSceneSetting(go, isEnable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClientVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int clientVersion = LuaForUtil.GetClientVersion();
			LuaDLL.lua_pushinteger(L, clientVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVersionName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string versionName = LuaForUtil.GetVersionName();
			LuaDLL.lua_pushstring(L, versionName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetResourceVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int resourceVersion = LuaForUtil.GetResourceVersion();
			LuaDLL.lua_pushinteger(L, resourceVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetResourceVersionName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string resourceVersionName = LuaForUtil.GetResourceVersionName();
			LuaDLL.lua_pushstring(L, resourceVersionName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateVersionInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForUtil.UpdateVersionInfo();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBattleVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int battleVersion = LuaForUtil.GetBattleVersion();
			LuaDLL.lua_pushinteger(L, battleVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadAtlas(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.PreLoadAtlas(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableTposeRenders(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.EnableTposeRenders((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEffect(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 6:
			{
				Transform target5 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath5 = ToLua.CheckString(L, 2);
				Vector3 offset5 = ToLua.ToVector3(L, 3);
				Vector3 scale5 = ToLua.ToVector3(L, 4);
				Vector3 rotation5 = ToLua.ToVector3(L, 5);
				Vector3 forward5 = ToLua.ToVector3(L, 6);
				EffectController obj5 = LuaForUtil.PlayEffect(target5, effectPath5, offset5, scale5, rotation5, forward5);
				ToLua.Push(L, obj5);
				return 1;
			}
			case 7:
			{
				Transform target4 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath4 = ToLua.CheckString(L, 2);
				Vector3 offset4 = ToLua.ToVector3(L, 3);
				Vector3 scale4 = ToLua.ToVector3(L, 4);
				Vector3 rotation4 = ToLua.ToVector3(L, 5);
				Vector3 forward4 = ToLua.ToVector3(L, 6);
				bool isLoop4 = LuaDLL.luaL_checkboolean(L, 7);
				EffectController obj4 = LuaForUtil.PlayEffect(target4, effectPath4, offset4, scale4, rotation4, forward4, isLoop4);
				ToLua.Push(L, obj4);
				return 1;
			}
			case 8:
			{
				Transform target3 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath3 = ToLua.CheckString(L, 2);
				Vector3 offset3 = ToLua.ToVector3(L, 3);
				Vector3 scale3 = ToLua.ToVector3(L, 4);
				Vector3 rotation3 = ToLua.ToVector3(L, 5);
				Vector3 forward3 = ToLua.ToVector3(L, 6);
				bool isLoop3 = LuaDLL.luaL_checkboolean(L, 7);
				float timeScale3 = (float)LuaDLL.luaL_checknumber(L, 8);
				EffectController obj3 = LuaForUtil.PlayEffect(target3, effectPath3, offset3, scale3, rotation3, forward3, isLoop3, timeScale3);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 9:
			{
				Transform target2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath2 = ToLua.CheckString(L, 2);
				Vector3 offset2 = ToLua.ToVector3(L, 3);
				Vector3 scale2 = ToLua.ToVector3(L, 4);
				Vector3 rotation2 = ToLua.ToVector3(L, 5);
				Vector3 forward2 = ToLua.ToVector3(L, 6);
				bool isLoop2 = LuaDLL.luaL_checkboolean(L, 7);
				float timeScale2 = (float)LuaDLL.luaL_checknumber(L, 8);
				float normalize2 = (float)LuaDLL.luaL_checknumber(L, 9);
				EffectController obj2 = LuaForUtil.PlayEffect(target2, effectPath2, offset2, scale2, rotation2, forward2, isLoop2, timeScale2, normalize2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 10:
			{
				Transform target = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath = ToLua.CheckString(L, 2);
				Vector3 offset = ToLua.ToVector3(L, 3);
				Vector3 scale = ToLua.ToVector3(L, 4);
				Vector3 rotation = ToLua.ToVector3(L, 5);
				Vector3 forward = ToLua.ToVector3(L, 6);
				bool isLoop = LuaDLL.luaL_checkboolean(L, 7);
				float timeScale = (float)LuaDLL.luaL_checknumber(L, 8);
				float normalize = (float)LuaDLL.luaL_checknumber(L, 9);
				float effectKeepTime = (float)LuaDLL.luaL_checknumber(L, 10);
				EffectController obj = LuaForUtil.PlayEffect(target, effectPath, offset, scale, rotation, forward, isLoop, timeScale, normalize, effectKeepTime);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForUtil.PlayEffect");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAttachEffect(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 6:
			{
				Transform target5 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath5 = ToLua.CheckString(L, 2);
				Vector3 offset5 = ToLua.ToVector3(L, 3);
				Vector3 scale5 = ToLua.ToVector3(L, 4);
				Vector3 rotation5 = ToLua.ToVector3(L, 5);
				Vector3 forward5 = ToLua.ToVector3(L, 6);
				EffectController obj5 = LuaForUtil.PlayAttachEffect(target5, effectPath5, offset5, scale5, rotation5, forward5);
				ToLua.Push(L, obj5);
				return 1;
			}
			case 7:
			{
				Transform target4 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath4 = ToLua.CheckString(L, 2);
				Vector3 offset4 = ToLua.ToVector3(L, 3);
				Vector3 scale4 = ToLua.ToVector3(L, 4);
				Vector3 rotation4 = ToLua.ToVector3(L, 5);
				Vector3 forward4 = ToLua.ToVector3(L, 6);
				bool isLoop4 = LuaDLL.luaL_checkboolean(L, 7);
				EffectController obj4 = LuaForUtil.PlayAttachEffect(target4, effectPath4, offset4, scale4, rotation4, forward4, isLoop4);
				ToLua.Push(L, obj4);
				return 1;
			}
			case 8:
			{
				Transform target3 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath3 = ToLua.CheckString(L, 2);
				Vector3 offset3 = ToLua.ToVector3(L, 3);
				Vector3 scale3 = ToLua.ToVector3(L, 4);
				Vector3 rotation3 = ToLua.ToVector3(L, 5);
				Vector3 forward3 = ToLua.ToVector3(L, 6);
				bool isLoop3 = LuaDLL.luaL_checkboolean(L, 7);
				float timeScale3 = (float)LuaDLL.luaL_checknumber(L, 8);
				EffectController obj3 = LuaForUtil.PlayAttachEffect(target3, effectPath3, offset3, scale3, rotation3, forward3, isLoop3, timeScale3);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 9:
			{
				Transform target2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath2 = ToLua.CheckString(L, 2);
				Vector3 offset2 = ToLua.ToVector3(L, 3);
				Vector3 scale2 = ToLua.ToVector3(L, 4);
				Vector3 rotation2 = ToLua.ToVector3(L, 5);
				Vector3 forward2 = ToLua.ToVector3(L, 6);
				bool isLoop2 = LuaDLL.luaL_checkboolean(L, 7);
				float timeScale2 = (float)LuaDLL.luaL_checknumber(L, 8);
				float normalize2 = (float)LuaDLL.luaL_checknumber(L, 9);
				EffectController obj2 = LuaForUtil.PlayAttachEffect(target2, effectPath2, offset2, scale2, rotation2, forward2, isLoop2, timeScale2, normalize2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 10:
			{
				Transform target = (Transform)ToLua.CheckObject<Transform>(L, 1);
				string effectPath = ToLua.CheckString(L, 2);
				Vector3 offset = ToLua.ToVector3(L, 3);
				Vector3 scale = ToLua.ToVector3(L, 4);
				Vector3 rotation = ToLua.ToVector3(L, 5);
				Vector3 forward = ToLua.ToVector3(L, 6);
				bool isLoop = LuaDLL.luaL_checkboolean(L, 7);
				float timeScale = (float)LuaDLL.luaL_checknumber(L, 8);
				float normalize = (float)LuaDLL.luaL_checknumber(L, 9);
				float effectKeepTime = (float)LuaDLL.luaL_checknumber(L, 10);
				EffectController obj = LuaForUtil.PlayAttachEffect(target, effectPath, offset, scale, rotation, forward, isLoop, timeScale, normalize, effectKeepTime);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForUtil.PlayAttachEffect");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.StopEffect((EffectController)ToLua.CheckObject<EffectController>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitWebView(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForUtil.InitWebView();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenWebView(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				LuaForUtil.OpenWebView(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string url4 = ToLua.CheckString(L, 1);
				bool isNeedCloseBtn4 = LuaDLL.luaL_checkboolean(L, 2);
				LuaForUtil.OpenWebView(url4, isNeedCloseBtn4);
				return 0;
			}
			case 3:
			{
				string url3 = ToLua.CheckString(L, 1);
				bool isNeedCloseBtn3 = LuaDLL.luaL_checkboolean(L, 2);
				Action beforeAction3 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				LuaForUtil.OpenWebView(url3, isNeedCloseBtn3, beforeAction3);
				return 0;
			}
			case 4:
			{
				string url2 = ToLua.CheckString(L, 1);
				bool isNeedCloseBtn2 = LuaDLL.luaL_checkboolean(L, 2);
				Action beforeAction2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				Action closedAction2 = (Action)ToLua.CheckDelegate<Action>(L, 4);
				LuaForUtil.OpenWebView(url2, isNeedCloseBtn2, beforeAction2, closedAction2);
				return 0;
			}
			case 5:
			{
				string url = ToLua.CheckString(L, 1);
				bool isNeedCloseBtn = LuaDLL.luaL_checkboolean(L, 2);
				Action beforeAction = (Action)ToLua.CheckDelegate<Action>(L, 3);
				Action closedAction = (Action)ToLua.CheckDelegate<Action>(L, 4);
				int screenOrientation = (int)LuaDLL.luaL_checknumber(L, 5);
				LuaForUtil.OpenWebView(url, isNeedCloseBtn, beforeAction, closedAction, screenOrientation);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForUtil.OpenWebView");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallWebView(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string webviewFuncName2 = ToLua.CheckString(L, 1);
				string callbackTag2 = ToLua.CheckString(L, 2);
				LuaForUtil.CallWebView(webviewFuncName2, callbackTag2);
				return 0;
			}
			case 3:
			{
				string webviewFuncName = ToLua.CheckString(L, 1);
				string callbackTag = ToLua.CheckString(L, 2);
				string data = ToLua.CheckString(L, 3);
				LuaForUtil.CallWebView(webviewFuncName, callbackTag, data);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForUtil.CallWebView");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitSavePhoto(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForUtil.InitSavePhoto();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SavePhotoToAlbum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.SavePhotoToAlbum(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAppIcon(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.SetAppIcon(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveScreenShot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.SaveScreenShot(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenScreenShotFolder(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForUtil.OpenScreenShotFolder();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LinkThirdApp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = LuaForUtil.LinkThirdApp(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFreeDiskSpace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int freeDiskSpace = LuaForUtil.GetFreeDiskSpace();
			LuaDLL.lua_pushinteger(L, freeDiskSpace);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowWeapon(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform transform = (Transform)ToLua.CheckObject<Transform>(L, 1);
			bool enable = LuaDLL.luaL_checkboolean(L, 2);
			LuaForUtil.ShowWeapon(transform, enable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableEyeController(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform pTransform = (Transform)ToLua.CheckObject<Transform>(L, 1);
			bool pEnable = LuaDLL.luaL_checkboolean(L, 2);
			LuaForUtil.EnableEyeController(pTransform, pEnable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayVoiceWithCriLipsync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Transform pTransform = (Transform)ToLua.CheckObject<Transform>(L, 1);
			string pSheetName = ToLua.CheckString(L, 2);
			string pCueName = ToLua.CheckString(L, 3);
			string pAwbName = ToLua.CheckString(L, 4);
			CriAtomExPlayback v = LuaForUtil.PlayVoiceWithCriLipsync(pTransform, pSheetName, pCueName, pAwbName);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopCriLipsync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.StopCriLipsync((Transform)ToLua.CheckObject<Transform>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIsMaintainByGMSDK(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.GetIsMaintainByGMSDK((Action<bool, string>)ToLua.CheckDelegate<Action<bool, string>>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUnreadMsg(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			string baseUrl = ToLua.CheckString(L, 1);
			string uid = ToLua.CheckString(L, 2);
			int gameId = (int)LuaDLL.luaL_checknumber(L, 3);
			Action<int> callback = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 4);
			LuaForUtil.GetUnreadMsg(baseUrl, uid, gameId, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateCameraSetting(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForUtil.UpdateCameraSetting();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsCheckLuaMemory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = LuaForUtil.IsCheckLuaMemory();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshI18NText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.RefreshI18NText((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLastCharPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 lastCharPosition = LuaForUtil.GetLastCharPosition((Text)ToLua.CheckObject<Text>(L, 1));
			ToLua.Push(L, lastCharPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearLinePrefixSymbol(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.ClearLinePrefixSymbol((Text)ToLua.CheckObject<Text>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddHoverEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			bool isAdd = LuaDLL.luaL_checkboolean(L, 2);
			LuaForUtil.AddHoverEffect(obj, isAdd);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ActiveHoverEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			bool isActive = LuaDLL.luaL_checkboolean(L, 2);
			LuaForUtil.ActiveHoverEffect(obj, isActive);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasBattleWinPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = LuaForUtil.HasBattleWinPos();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableAudioSessionRestoration_IOS(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.EnableAudioSessionRestoration_IOS(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCinemachineVirtualCameraFOV(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float cinemachineVirtualCameraFOV = LuaForUtil.GetCinemachineVirtualCameraFOV((CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1));
			LuaDLL.lua_pushnumber(L, cinemachineVirtualCameraFOV);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCinemachineVirtualCameraFOV(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CinemachineVirtualCamera virtualCamera = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
			float fov = (float)LuaDLL.luaL_checknumber(L, 2);
			LuaForUtil.SetCinemachineVirtualCameraFOV(virtualCamera, fov);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVCMNoise(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				LuaForUtil.SetVCMNoise((CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1));
				return 0;
			case 2:
			{
				CinemachineVirtualCamera virtualCamera3 = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
				string noiseAssetPath3 = ToLua.CheckString(L, 2);
				LuaForUtil.SetVCMNoise(virtualCamera3, noiseAssetPath3);
				return 0;
			}
			case 3:
			{
				CinemachineVirtualCamera virtualCamera2 = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
				string noiseAssetPath2 = ToLua.CheckString(L, 2);
				float amplitudeGain2 = (float)LuaDLL.luaL_checknumber(L, 3);
				LuaForUtil.SetVCMNoise(virtualCamera2, noiseAssetPath2, amplitudeGain2);
				return 0;
			}
			case 4:
			{
				CinemachineVirtualCamera virtualCamera = (CinemachineVirtualCamera)ToLua.CheckObject<CinemachineVirtualCamera>(L, 1);
				string noiseAssetPath = ToLua.CheckString(L, 2);
				float amplitudeGain = (float)LuaDLL.luaL_checknumber(L, 3);
				float frequencyGain = (float)LuaDLL.luaL_checknumber(L, 4);
				LuaForUtil.SetVCMNoise(virtualCamera, noiseAssetPath, amplitudeGain, frequencyGain);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForUtil.SetVCMNoise");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTimelineSpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayableDirector director = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			LuaForUtil.SetTimelineSpeed(director, speed);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTrailRendererClear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForUtil.SetTrailRendererClear((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAutoChessExportData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForUtil.SetAutoChessExportData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasCueSheet(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = LuaForUtil.HasCueSheet(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRoleAttachPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform roleRootTrs = (Transform)ToLua.CheckObject<Transform>(L, 1);
			string name = ToLua.CheckString(L, 2);
			Transform roleAttachPoint = LuaForUtil.GetRoleAttachPoint(roleRootTrs, name);
			ToLua.Push(L, roleAttachPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNoOperationTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject go = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			LuaForUtil.SetNoOperationTime(go, time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DebugDrawLine(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector3 vector3 = ToLua.ToVector3(L, 1);
				Vector3 to3 = ToLua.ToVector3(L, 2);
				Color color3 = ToLua.ToColor(L, 3);
				LuaForUtil.DebugDrawLine(vector3, to3, color3);
				return 0;
			}
			case 4:
			{
				Vector3 vector2 = ToLua.ToVector3(L, 1);
				Vector3 to2 = ToLua.ToVector3(L, 2);
				Color color2 = ToLua.ToColor(L, 3);
				float duration2 = (float)LuaDLL.luaL_checknumber(L, 4);
				LuaForUtil.DebugDrawLine(vector2, to2, color2, duration2);
				return 0;
			}
			case 5:
			{
				Vector3 vector = ToLua.ToVector3(L, 1);
				Vector3 to = ToLua.ToVector3(L, 2);
				Color color = ToLua.ToColor(L, 3);
				float duration = (float)LuaDLL.luaL_checknumber(L, 4);
				bool depthTest = LuaDLL.luaL_checkboolean(L, 5);
				LuaForUtil.DebugDrawLine(vector, to, color, duration, depthTest);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForUtil.DebugDrawLine");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsManualAnimatorBlend(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, LuaForUtil.IsManualAnimatorBlend);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LuaEventTrigger(IntPtr L)
	{
		try
		{
			ToLua.Push(L, LuaForUtil.LuaEventTrigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_atlasLoadAction(IntPtr L)
	{
		try
		{
			ToLua.Push(L, LuaForUtil.atlasLoadAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NowMilliSec(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LuaForUtil.NowMilliSec);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_IsManualAnimatorBlend(IntPtr L)
	{
		try
		{
			LuaForUtil.IsManualAnimatorBlend = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LuaEventTrigger(IntPtr L)
	{
		try
		{
			LuaForUtil.LuaEventTrigger = (Action<string, string>)ToLua.CheckDelegate<Action<string, string>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_atlasLoadAction(IntPtr L)
	{
		try
		{
			LuaForUtil.atlasLoadAction = (Action<SpriteAtlas>)ToLua.CheckDelegate<Action<SpriteAtlas>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

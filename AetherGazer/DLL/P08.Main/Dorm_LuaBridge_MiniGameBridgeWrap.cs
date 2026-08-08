using System;
using Dorm.LuaBridge;
using LuaInterface;
using UnityEngine;

public class Dorm_LuaBridge_MiniGameBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("MiniGameBridge");
		L.RegFunction("MuteAudioTriggerOnEntityAnimator", MuteAudioTriggerOnEntityAnimator);
		L.RegFunction("SetupItemSprite", SetupItemSprite);
		L.RegFunction("SetupClickTriggerForEntity", SetupClickTriggerForEntity);
		L.RegFunction("MuteClickTriggerForEntity", MuteClickTriggerForEntity);
		L.RegFunction("Launch", Launch);
		L.RegFunction("ShowConnectLine", ShowConnectLine);
		L.RegFunction("CheckPosBlocked", CheckPosBlocked);
		L.RegFunction("BeamcastEntity", BeamcastEntity);
		L.RegFunction("BeamcastEntities", BeamcastEntities);
		L.RegFunction("SetEntityIgnoreBeamcast", SetEntityIgnoreBeamcast);
		L.RegFunction("InitDefaultEntityCollider", InitDefaultEntityCollider);
		L.RegFunction("InitMoveController", InitMoveController);
		L.RegFunction("SetMoveControllerInput", SetMoveControllerInput);
		L.RegFunction("SetMoveLookAtEntity", SetMoveLookAtEntity);
		L.RegFunction("SetMoveLookAtDir", SetMoveLookAtDir);
		L.RegFunction("PlayEffect", PlayEffect);
		L.RegFunction("PlayFullScreenEffect", PlayFullScreenEffect);
		L.RegFunction("ClearAllFullScreenEffect", ClearAllFullScreenEffect);
		L.RegFunction("PlayStory", PlayStory);
		L.RegFunction("StopStory", StopStory);
		L.RegFunction("SetupCameraEventTriggerAtMainCamFarClip", SetupCameraEventTriggerAtMainCamFarClip);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MuteAudioTriggerOnEntityAnimator(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MiniGameBridge.MuteAudioTriggerOnEntityAnimator((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetupItemSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string spritepath = ToLua.CheckString(L, 2);
			MiniGameBridge.SetupItemSprite(entityID, spritepath);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetupClickTriggerForEntity(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				MiniGameBridge.SetupClickTriggerForEntity((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				float size = (float)LuaDLL.luaL_checknumber(L, 2);
				MiniGameBridge.SetupClickTriggerForEntity(entityID, size);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.LuaBridge.MiniGameBridge.SetupClickTriggerForEntity");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MuteClickTriggerForEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MiniGameBridge.MuteClickTriggerForEntity((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launch(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MiniGameBridge.Launch(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowConnectLine(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				MiniGameBridge.ShowConnectLine(ToLua.CheckStructArray<Vector3>(L, 1));
				return 0;
			case 2:
			{
				Vector3[] points = ToLua.CheckStructArray<Vector3>(L, 1);
				float displayTime = (float)LuaDLL.luaL_checknumber(L, 2);
				MiniGameBridge.ShowConnectLine(points, displayTime);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.LuaBridge.MiniGameBridge.ShowConnectLine");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckPosBlocked(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = MiniGameBridge.CheckPosBlocked(ToLua.ToVector3(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
			{
				Vector3 pos = ToLua.ToVector3(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				float height = (float)LuaDLL.luaL_checknumber(L, 3);
				bool value = MiniGameBridge.CheckPosBlocked(pos, radius, height);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.LuaBridge.MiniGameBridge.CheckPosBlocked");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BeamcastEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Vector2 screenPos = ToLua.ToVector2(L, 1);
			float radius = (float)LuaDLL.luaL_checknumber(L, 2);
			string hitColliderName = null;
			int n = MiniGameBridge.BeamcastEntity(screenPos, radius, out var hitPos, out hitColliderName);
			LuaDLL.lua_pushinteger(L, n);
			ToLua.Push(L, hitPos);
			LuaDLL.lua_pushstring(L, hitColliderName);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BeamcastEntities(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector2 screenPos = ToLua.ToVector2(L, 1);
			float radius = (float)LuaDLL.luaL_checknumber(L, 2);
			int[] array = MiniGameBridge.BeamcastEntities(screenPos, radius);
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEntityIgnoreBeamcast(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool value = LuaDLL.luaL_checkboolean(L, 2);
			MiniGameBridge.SetEntityIgnoreBeamcast(entityID, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitDefaultEntityCollider(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MiniGameBridge.InitDefaultEntityCollider((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitMoveController(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MiniGameBridge.InitMoveController((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMoveControllerInput(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			Vector2 input = ToLua.ToVector2(L, 2);
			MiniGameBridge.SetMoveControllerInput(entityID, input);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMoveLookAtEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int lookAt = (int)LuaDLL.luaL_checknumber(L, 2);
			MiniGameBridge.SetMoveLookAtEntity(entityID, lookAt);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMoveLookAtDir(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			Vector3 dir = ToLua.ToVector3(L, 2);
			MiniGameBridge.SetMoveLookAtDir(entityID, dir);
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
			case 3:
			{
				Vector3 pos2 = ToLua.ToVector3(L, 1);
				string path2 = ToLua.CheckString(L, 2);
				float duration2 = (float)LuaDLL.luaL_checknumber(L, 3);
				MiniGameBridge.PlayEffect(pos2, path2, duration2);
				return 0;
			}
			case 5:
			{
				Vector3 pos = ToLua.ToVector3(L, 1);
				Quaternion rot = ToLua.ToQuaternion(L, 2);
				Vector3 scale = ToLua.ToVector3(L, 3);
				string path = ToLua.CheckString(L, 4);
				float duration = (float)LuaDLL.luaL_checknumber(L, 5);
				MiniGameBridge.PlayEffect(pos, rot, scale, path, duration);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.LuaBridge.MiniGameBridge.PlayEffect");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayFullScreenEffect(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string, float>(L, 1))
			{
				string path = ToLua.ToString(L, 1);
				float duration = (float)LuaDLL.lua_tonumber(L, 2);
				MiniGameBridge.PlayFullScreenEffect(path, duration);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<GameObject, float>(L, 1))
			{
				GameObject efxGo = (GameObject)ToLua.ToObject(L, 1);
				float duration2 = (float)LuaDLL.lua_tonumber(L, 2);
				MiniGameBridge.PlayFullScreenEffect(efxGo, duration2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAllFullScreenEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			MiniGameBridge.ClearAllFullScreenEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayStory(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				string timelineAssetPath2 = ToLua.CheckString(L, 1);
				int[] actors2 = ToLua.CheckNumberArray<int>(L, 2);
				MiniGameBridge.PlayStory(timelineAssetPath2, actors2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<bool>(L, 3))
				{
					string timelineAssetPath = ToLua.CheckString(L, 1);
					int[] actors = ToLua.CheckNumberArray<int>(L, 2);
					bool recordOriginalCamParam = LuaDLL.lua_toboolean(L, 3);
					MiniGameBridge.PlayStory(timelineAssetPath, actors, recordOriginalCamParam);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<string[]>(L, 3))
			{
				string timelineAssetPath3 = ToLua.CheckString(L, 1);
				int[] actors3 = ToLua.CheckNumberArray<int>(L, 2);
				string[] actorPaths = ToLua.ToStringArray(L, 3);
				MiniGameBridge.PlayStory(timelineAssetPath3, actors3, actorPaths);
				return 0;
			}
			if (num == 4)
			{
				string timelineAssetPath4 = ToLua.CheckString(L, 1);
				int[] actors4 = ToLua.CheckNumberArray<int>(L, 2);
				string[] actorPaths2 = ToLua.CheckStringArray(L, 3);
				bool recordOriginalCamParam2 = LuaDLL.luaL_checkboolean(L, 4);
				MiniGameBridge.PlayStory(timelineAssetPath4, actors4, actorPaths2, recordOriginalCamParam2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.LuaBridge.MiniGameBridge.PlayStory");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopStory(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				MiniGameBridge.StopStory();
				return 0;
			case 1:
				MiniGameBridge.StopStory(LuaDLL.luaL_checkboolean(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.LuaBridge.MiniGameBridge.StopStory");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetupCameraEventTriggerAtMainCamFarClip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			MiniGameBridge.SetupCameraEventTriggerAtMainCamFarClip();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

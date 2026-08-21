using System;
using System.Collections.Generic;
using LuaInterface;
using QWorld.Story.Runtime;
using UnityEngine;

public class QWorld_Story_Runtime_QWStoryGraphBlackboardWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWStoryGraphBlackboard), typeof(MonoBehaviour));
		L.RegFunction("Awake", Awake);
		L.RegFunction("EnableCameraByTag", EnableCameraByTag);
		L.RegFunction("EnableCameraCut", EnableCameraCut);
		L.RegFunction("StartCameraShake", StartCameraShake);
		L.RegFunction("StopCameraShake", StopCameraShake);
		L.RegFunction("CameraMove", CameraMove);
		L.RegFunction("GetPoint", GetPoint);
		L.RegFunction("LoadThing", LoadThing);
		L.RegFunction("UnloadThing", UnloadThing);
		L.RegFunction("GetThing", GetThing);
		L.RegFunction("LoadChar", LoadChar);
		L.RegFunction("UnloadChar", UnloadChar);
		L.RegFunction("PlayTalkSheet", PlayTalkSheet);
		L.RegFunction("Agent_CameraControl", Agent_CameraControl);
		L.RegFunction("Agent_PlayerPosControl", Agent_PlayerPosControl);
		L.RegFunction("PreStart", PreStart);
		L.RegFunction("PreStop", PreStop);
		L.RegFunction("ClearOnNext", ClearOnNext);
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("charPath", get_charPath, null);
		L.RegVar("thingPath", get_thingPath, null);
		L.RegConstant("DeActiveCameraPriority", 1.0);
		L.RegConstant("ActiveCameraPriority", 20.0);
		L.RegVar("GraphIdentify", get_GraphIdentify, set_GraphIdentify);
		L.RegVar("charContext", get_charContext, set_charContext);
		L.RegVar("cameraContext", get_cameraContext, set_cameraContext);
		L.RegVar("pointContext", get_pointContext, set_pointContext);
		L.RegVar("timelineContext", get_timelineContext, set_timelineContext);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Awake(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1)).Awake();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableCameraByTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			string tag = ToLua.CheckString(L, 2);
			int style = (int)LuaDLL.luaL_checknumber(L, 3);
			float time = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.EnableCameraByTag(tag, style, time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableCameraCut(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			bool cut = LuaDLL.luaL_checkboolean(L, 2);
			obj.EnableCameraCut(cut);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartCameraShake(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			string cfgPath = ToLua.CheckString(L, 2);
			float amplitude = (float)LuaDLL.luaL_checknumber(L, 3);
			float frequency = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.StartCameraShake(cfgPath, amplitude, frequency);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopCameraShake(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1)).StopCameraShake();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CameraMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			string tag = ToLua.CheckString(L, 2);
			int tweenType = (int)LuaDLL.luaL_checknumber(L, 3);
			int direction = (int)LuaDLL.luaL_checknumber(L, 4);
			float time = (float)LuaDLL.luaL_checknumber(L, 5);
			float distance = (float)LuaDLL.luaL_checknumber(L, 6);
			obj.CameraMove(tag, tweenType, direction, time, distance);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			string tag = ToLua.CheckString(L, 2);
			Transform point = obj.GetPoint(tag);
			ToLua.Push(L, point);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadThing(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				QWStoryGraphBlackboard obj3 = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int id2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string asset2 = ToLua.CheckString(L, 3);
				QWStoryItem obj4 = obj3.LoadThing(id2, asset2);
				ToLua.Push(L, obj4);
				return 1;
			}
			case 4:
			{
				QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int id = (int)LuaDLL.luaL_checknumber(L, 2);
				string asset = ToLua.CheckString(L, 3);
				bool needLoad = LuaDLL.luaL_checkboolean(L, 4);
				QWStoryItem obj2 = obj.LoadThing(id, asset, needLoad);
				ToLua.Push(L, obj2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphBlackboard.LoadThing");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadThing(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int id2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.UnloadThing(id2);
				return 0;
			}
			case 3:
			{
				QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int id = (int)LuaDLL.luaL_checknumber(L, 2);
				bool lateClear = LuaDLL.luaL_checkboolean(L, 3);
				obj.UnloadThing(id, lateClear);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphBlackboard.UnloadThing");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetThing(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			QWStoryItem thing = obj.GetThing(id);
			ToLua.Push(L, thing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadChar(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWStoryGraphBlackboard obj3 = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int charId2 = (int)LuaDLL.luaL_checknumber(L, 2);
				QWStoryGraphActor obj4 = obj3.LoadChar(charId2);
				ToLua.Push(L, obj4);
				return 1;
			}
			case 3:
			{
				QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int charId = (int)LuaDLL.luaL_checknumber(L, 2);
				bool needLoad = LuaDLL.luaL_checkboolean(L, 3);
				QWStoryGraphActor obj2 = obj.LoadChar(charId, needLoad);
				ToLua.Push(L, obj2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphBlackboard.LoadChar");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadChar(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int charId2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.UnloadChar(charId2);
				return 0;
			}
			case 3:
			{
				QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int charId = (int)LuaDLL.luaL_checknumber(L, 2);
				bool lateClear = LuaDLL.luaL_checkboolean(L, 3);
				obj.UnloadChar(charId, lateClear);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphBlackboard.UnloadChar");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayTalkSheet(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int actorId2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string cueSheet2 = ToLua.CheckString(L, 3);
				string cueName2 = ToLua.CheckString(L, 4);
				obj2.PlayTalkSheet(actorId2, cueSheet2, cueName2);
				return 0;
			}
			case 5:
			{
				QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				int actorId = (int)LuaDLL.luaL_checknumber(L, 2);
				string cueSheet = ToLua.CheckString(L, 3);
				string cueName = ToLua.CheckString(L, 4);
				bool useStream = LuaDLL.luaL_checkboolean(L, 5);
				obj.PlayTalkSheet(actorId, cueSheet, cueName, useStream);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphBlackboard.PlayTalkSheet");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Agent_CameraControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			string cameraTag = ToLua.CheckString(L, 2);
			obj.Agent_CameraControl(cameraTag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Agent_PlayerPosControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
			string pointTag = ToLua.CheckString(L, 2);
			obj.Agent_PlayerPosControl(pointTag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreStart(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWStoryGraphBlackboard obj3 = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				QWorldMapEntity target3 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
				obj3.PreStart(target3);
				return 0;
			}
			case 3:
			{
				QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				QWorldMapEntity target2 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
				int stroyType2 = (int)LuaDLL.luaL_checknumber(L, 3);
				obj2.PreStart(target2, stroyType2);
				return 0;
			}
			case 4:
			{
				QWStoryGraphBlackboard obj = (QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1);
				QWorldMapEntity target = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
				int stroyType = (int)LuaDLL.luaL_checknumber(L, 3);
				bool defaultLookAt = LuaDLL.luaL_checkboolean(L, 4);
				obj.PreStart(target, stroyType, defaultLookAt);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphBlackboard.PreStart");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreStop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1)).PreStop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearOnNext(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1)).ClearOnNext();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Dispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphBlackboard)ToLua.CheckObject<QWStoryGraphBlackboard>(L, 1)).Dispose();
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
	private static int get_charPath(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "QWWorld/Chars/StoryActor/{0}");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingPath(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "QWWorld/Item/{0}");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GraphIdentify(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string graphIdentify = ((QWStoryGraphBlackboard)obj).GraphIdentify;
			LuaDLL.lua_pushstring(L, graphIdentify);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GraphIdentify on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_charContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CharContext> charContext = ((QWStoryGraphBlackboard)obj).charContext;
			ToLua.PushSealed(L, charContext);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index charContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameraContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CameraContext> cameraContext = ((QWStoryGraphBlackboard)obj).cameraContext;
			ToLua.PushSealed(L, cameraContext);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pointContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<PointContext> pointContext = ((QWStoryGraphBlackboard)obj).pointContext;
			ToLua.PushSealed(L, pointContext);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timelineContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<TimelineContext> timelineContext = ((QWStoryGraphBlackboard)obj).timelineContext;
			ToLua.PushSealed(L, timelineContext);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timelineContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_GraphIdentify(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)obj;
			string graphIdentify = ToLua.CheckString(L, 2);
			obj2.GraphIdentify = graphIdentify;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GraphIdentify on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_charContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)obj;
			List<CharContext> charContext = (List<CharContext>)ToLua.CheckObject(L, 2, typeof(List<CharContext>));
			obj2.charContext = charContext;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index charContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cameraContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)obj;
			List<CameraContext> cameraContext = (List<CameraContext>)ToLua.CheckObject(L, 2, typeof(List<CameraContext>));
			obj2.cameraContext = cameraContext;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pointContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)obj;
			List<PointContext> pointContext = (List<PointContext>)ToLua.CheckObject(L, 2, typeof(List<PointContext>));
			obj2.pointContext = pointContext;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timelineContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphBlackboard obj2 = (QWStoryGraphBlackboard)obj;
			List<TimelineContext> timelineContext = (List<TimelineContext>)ToLua.CheckObject(L, 2, typeof(List<TimelineContext>));
			obj2.timelineContext = timelineContext;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timelineContext on a nil value");
		}
	}
}

using System;
using LuaInterface;
using QWorld.Story.Runtime;
using UnityEngine;

public class QWorld_Story_Runtime_QWStoryGraphActorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWStoryGraphActor), typeof(MonoBehaviour));
		L.RegFunction("InitActor", InitActor);
		L.RegFunction("PlayAnimaton", PlayAnimaton);
		L.RegFunction("PlayEmote", PlayEmote);
		L.RegFunction("PlayTalkSheet", PlayTalkSheet);
		L.RegFunction("EndEmote", EndEmote);
		L.RegFunction("OnClear", OnClear);
		L.RegFunction("ClearOnNext", ClearOnNext);
		L.RegFunction("SetTransform", SetTransform);
		L.RegFunction("EnableRootmotion", EnableRootmotion);
		L.RegFunction("EnableNoneEyeFace", EnableNoneEyeFace);
		L.RegFunction("EnableLookAt", EnableLookAt);
		L.RegFunction("SetLookAtParams", SetLookAtParams);
		L.RegFunction("OnAnimMove", OnAnimMove);
		L.RegFunction("StartSeeker", StartSeeker);
		L.RegFunction("GetAttachPoint", GetAttachPoint);
		L.RegFunction("GetHeadTrans", GetHeadTrans);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isInRush", get_isInRush, set_isInRush);
		L.RegVar("OnAnimatorEnd", get_OnAnimatorEnd, set_OnAnimatorEnd);
		L.RegVar("OnEmoteEnd", get_OnEmoteEnd, set_OnEmoteEnd);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitActor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1)).InitActor();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAnimaton(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				QWStoryGraphActor obj2 = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
				bool needWait2 = LuaDLL.luaL_checkboolean(L, 2);
				string animName2 = ToLua.CheckString(L, 3);
				float crossFadeTime2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj2.PlayAnimaton(needWait2, animName2, crossFadeTime2);
				return 0;
			}
			case 5:
			{
				QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
				bool needWait = LuaDLL.luaL_checkboolean(L, 2);
				string animName = ToLua.CheckString(L, 3);
				float crossFadeTime = (float)LuaDLL.luaL_checknumber(L, 4);
				float time = (float)LuaDLL.luaL_checknumber(L, 5);
				obj.PlayAnimaton(needWait, animName, crossFadeTime, time);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphActor.PlayAnimaton");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEmote(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				QWStoryGraphActor obj3 = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
				string animName3 = ToLua.CheckString(L, 2);
				float crossFadeTime3 = (float)LuaDLL.luaL_checknumber(L, 3);
				obj3.PlayEmote(animName3, crossFadeTime3);
				return 0;
			}
			case 4:
			{
				QWStoryGraphActor obj2 = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
				string animName2 = ToLua.CheckString(L, 2);
				float crossFadeTime2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float time2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj2.PlayEmote(animName2, crossFadeTime2, time2);
				return 0;
			}
			case 5:
			{
				QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
				string animName = ToLua.CheckString(L, 2);
				float crossFadeTime = (float)LuaDLL.luaL_checknumber(L, 3);
				float time = (float)LuaDLL.luaL_checknumber(L, 4);
				bool isLoop = LuaDLL.luaL_checkboolean(L, 5);
				obj.PlayEmote(animName, crossFadeTime, time, isLoop);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphActor.PlayEmote");
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
			case 3:
			{
				QWStoryGraphActor obj2 = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
				string cueSheet2 = ToLua.CheckString(L, 2);
				string cueName2 = ToLua.CheckString(L, 3);
				obj2.PlayTalkSheet(cueSheet2, cueName2);
				return 0;
			}
			case 4:
			{
				QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
				string cueSheet = ToLua.CheckString(L, 2);
				string cueName = ToLua.CheckString(L, 3);
				bool useStream = LuaDLL.luaL_checkboolean(L, 4);
				obj.PlayTalkSheet(cueSheet, cueName, useStream);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryGraphActor.PlayTalkSheet");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndEmote(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1)).EndEmote();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnClear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1)).OnClear();
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
			((QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1)).ClearOnNext();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
			Transform transform = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj.SetTransform(transform);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableRootmotion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
			bool enable = LuaDLL.luaL_checkboolean(L, 2);
			obj.EnableRootmotion(enable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableNoneEyeFace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
			bool enable = LuaDLL.luaL_checkboolean(L, 2);
			obj.EnableNoneEyeFace(enable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableLookAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
			bool enableLookAt = LuaDLL.luaL_checkboolean(L, 2);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 3);
			obj.EnableLookAt(enableLookAt, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLookAtParams(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
			float headWeight = (float)LuaDLL.luaL_checknumber(L, 2);
			float ikWeight = (float)LuaDLL.luaL_checknumber(L, 3);
			float lookDuration = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.SetLookAtParams(headWeight, ikWeight, lookDuration);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnAnimMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1)).OnAnimMove();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartSeeker(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
			Vector3 endForward = ToLua.ToVector3(L, 2);
			Vector3[] routes = ToLua.CheckStructArray<Vector3>(L, 3);
			float speed = (float)LuaDLL.luaL_checknumber(L, 4);
			Action stopCallback = (Action)ToLua.CheckDelegate<Action>(L, 5);
			obj.StartSeeker(endForward, routes, speed, stopCallback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAttachPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryGraphActor obj = (QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1);
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			Transform attachPoint = obj.GetAttachPoint(id);
			ToLua.Push(L, attachPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHeadTrans(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform headTrans = ((QWStoryGraphActor)ToLua.CheckObject<QWStoryGraphActor>(L, 1)).GetHeadTrans();
			ToLua.Push(L, headTrans);
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
	private static int get_isInRush(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isInRush = ((QWStoryGraphActor)obj).isInRush;
			LuaDLL.lua_pushboolean(L, isInRush);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isInRush on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnAnimatorEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onAnimatorEnd = ((QWStoryGraphActor)obj).OnAnimatorEnd;
			ToLua.Push(L, onAnimatorEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnAnimatorEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnEmoteEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onEmoteEnd = ((QWStoryGraphActor)obj).OnEmoteEnd;
			ToLua.Push(L, onEmoteEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnEmoteEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isInRush(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphActor obj2 = (QWStoryGraphActor)obj;
			bool isInRush = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isInRush = isInRush;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isInRush on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnAnimatorEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphActor obj2 = (QWStoryGraphActor)obj;
			Action onAnimatorEnd = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnAnimatorEnd = onAnimatorEnd;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnAnimatorEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnEmoteEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryGraphActor obj2 = (QWStoryGraphActor)obj;
			Action onEmoteEnd = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnEmoteEnd = onEmoteEnd;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnEmoteEnd on a nil value");
		}
	}
}

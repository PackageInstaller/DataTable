using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;

public class UnityEngine_Playables_PlayableDirectorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PlayableDirector), typeof(Behaviour));
		L.RegFunction("DeferredEvaluate", DeferredEvaluate);
		L.RegFunction("Play", Play);
		L.RegFunction("SetGenericBinding", SetGenericBinding);
		L.RegFunction("Evaluate", Evaluate);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Pause", Pause);
		L.RegFunction("Resume", Resume);
		L.RegFunction("RebuildGraph", RebuildGraph);
		L.RegFunction("ClearReferenceValue", ClearReferenceValue);
		L.RegFunction("SetReferenceValue", SetReferenceValue);
		L.RegFunction("GetReferenceValue", GetReferenceValue);
		L.RegFunction("GetGenericBinding", GetGenericBinding);
		L.RegFunction("ClearGenericBinding", ClearGenericBinding);
		L.RegFunction("RebindPlayableGraphOutputs", RebindPlayableGraphOutputs);
		L.RegFunction("New", _CreateUnityEngine_Playables_PlayableDirector);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("state", get_state, null);
		L.RegVar("extrapolationMode", get_extrapolationMode, set_extrapolationMode);
		L.RegVar("playableAsset", get_playableAsset, set_playableAsset);
		L.RegVar("playableGraph", get_playableGraph, null);
		L.RegVar("playOnAwake", get_playOnAwake, set_playOnAwake);
		L.RegVar("timeUpdateMode", get_timeUpdateMode, set_timeUpdateMode);
		L.RegVar("time", get_time, set_time);
		L.RegVar("initialTime", get_initialTime, set_initialTime);
		L.RegVar("duration", get_duration, null);
		L.RegVar("played", get_played, set_played);
		L.RegVar("paused", get_paused, set_paused);
		L.RegVar("stopped", get_stopped, set_stopped);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Playables_PlayableDirector(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PlayableDirector obj = new PlayableDirector();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Playables.PlayableDirector.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeferredEvaluate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).DeferredEvaluate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Play(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).Play();
				return 0;
			case 2:
			{
				PlayableDirector obj2 = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
				PlayableAsset asset2 = (PlayableAsset)ToLua.CheckObject<PlayableAsset>(L, 2);
				obj2.Play(asset2);
				return 0;
			}
			case 3:
			{
				PlayableDirector obj = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
				PlayableAsset asset = (PlayableAsset)ToLua.CheckObject<PlayableAsset>(L, 2);
				DirectorWrapMode mode = (DirectorWrapMode)ToLua.CheckObject(L, 3, typeof(DirectorWrapMode));
				obj.Play(asset, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Playables.PlayableDirector.Play");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGenericBinding(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PlayableDirector obj = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
			UnityEngine.Object key = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 2);
			UnityEngine.Object value = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 3);
			obj.SetGenericBinding(key, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Evaluate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).Evaluate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Stop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).Stop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Pause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).Pause();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Resume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).Resume();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RebuildGraph(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).RebuildGraph();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearReferenceValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayableDirector obj = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
			PropertyName id = StackTraits<PropertyName>.Check(L, 2);
			obj.ClearReferenceValue(id);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetReferenceValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PlayableDirector obj = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
			PropertyName id = StackTraits<PropertyName>.Check(L, 2);
			UnityEngine.Object value = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 3);
			obj.SetReferenceValue(id, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetReferenceValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PlayableDirector obj = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
			PropertyName id = StackTraits<PropertyName>.Check(L, 2);
			UnityEngine.Object referenceValue = obj.GetReferenceValue(id, out var idValid);
			ToLua.Push(L, referenceValue);
			LuaDLL.lua_pushboolean(L, idValid);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGenericBinding(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayableDirector obj = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
			UnityEngine.Object key = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 2);
			UnityEngine.Object genericBinding = obj.GetGenericBinding(key);
			ToLua.Push(L, genericBinding);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearGenericBinding(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayableDirector obj = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1);
			UnityEngine.Object key = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 2);
			obj.ClearGenericBinding(key);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RebindPlayableGraphOutputs(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 1)).RebindPlayableGraphOutputs();
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
	private static int get_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayState state = ((PlayableDirector)obj).state;
			ToLua.Push(L, state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_extrapolationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DirectorWrapMode extrapolationMode = ((PlayableDirector)obj).extrapolationMode;
			ToLua.Push(L, extrapolationMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index extrapolationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playableAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableAsset playableAsset = ((PlayableDirector)obj).playableAsset;
			ToLua.Push(L, playableAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playableAsset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playableGraph(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableGraph playableGraph = ((PlayableDirector)obj).playableGraph;
			ToLua.PushValue(L, playableGraph);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playableGraph on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playOnAwake = ((PlayableDirector)obj).playOnAwake;
			LuaDLL.lua_pushboolean(L, playOnAwake);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeUpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DirectorUpdateMode timeUpdateMode = ((PlayableDirector)obj).timeUpdateMode;
			ToLua.Push(L, timeUpdateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeUpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double time = ((PlayableDirector)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_initialTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double initialTime = ((PlayableDirector)obj).initialTime;
			LuaDLL.lua_pushnumber(L, initialTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double duration = ((PlayableDirector)obj).duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_played(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<PlayableDirector>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_paused(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<PlayableDirector>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stopped(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<PlayableDirector>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_extrapolationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector obj2 = (PlayableDirector)obj;
			DirectorWrapMode extrapolationMode = (DirectorWrapMode)ToLua.CheckObject(L, 2, typeof(DirectorWrapMode));
			obj2.extrapolationMode = extrapolationMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index extrapolationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playableAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector obj2 = (PlayableDirector)obj;
			PlayableAsset playableAsset = (PlayableAsset)ToLua.CheckObject<PlayableAsset>(L, 2);
			obj2.playableAsset = playableAsset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playableAsset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector obj2 = (PlayableDirector)obj;
			bool playOnAwake = LuaDLL.luaL_checkboolean(L, 2);
			obj2.playOnAwake = playOnAwake;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeUpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector obj2 = (PlayableDirector)obj;
			DirectorUpdateMode timeUpdateMode = (DirectorUpdateMode)ToLua.CheckObject(L, 2, typeof(DirectorUpdateMode));
			obj2.timeUpdateMode = timeUpdateMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeUpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector obj2 = (PlayableDirector)obj;
			double time = LuaDLL.luaL_checknumber(L, 2);
			obj2.time = time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_initialTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector obj2 = (PlayableDirector)obj;
			double initialTime = LuaDLL.luaL_checknumber(L, 2);
			obj2.initialTime = initialTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_played(IntPtr L)
	{
		try
		{
			PlayableDirector playableDirector = (PlayableDirector)ToLua.CheckObject(L, 1, typeof(PlayableDirector));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Action<PlayableDirector> value = (Action<PlayableDirector>)eventObject.func;
					playableDirector.played += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Action<PlayableDirector> value2 = (Action<PlayableDirector>)eventObject.func;
					playableDirector.played -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Playables.PlayableDirector.played' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Playables.PlayableDirector'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_paused(IntPtr L)
	{
		try
		{
			PlayableDirector playableDirector = (PlayableDirector)ToLua.CheckObject(L, 1, typeof(PlayableDirector));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Action<PlayableDirector> value = (Action<PlayableDirector>)eventObject.func;
					playableDirector.paused += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Action<PlayableDirector> value2 = (Action<PlayableDirector>)eventObject.func;
					playableDirector.paused -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Playables.PlayableDirector.paused' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Playables.PlayableDirector'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stopped(IntPtr L)
	{
		try
		{
			PlayableDirector playableDirector = (PlayableDirector)ToLua.CheckObject(L, 1, typeof(PlayableDirector));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Action<PlayableDirector> value = (Action<PlayableDirector>)eventObject.func;
					playableDirector.stopped += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Action<PlayableDirector> value2 = (Action<PlayableDirector>)eventObject.func;
					playableDirector.stopped -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Playables.PlayableDirector.stopped' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Playables.PlayableDirector'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

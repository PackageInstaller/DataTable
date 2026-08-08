using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;

public class DrawControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DrawController), typeof(MonoBehaviour));
		L.RegFunction("Init", Init);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("SetAnimationProcess", SetAnimationProcess);
		L.RegFunction("Reset", Reset);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("timeline", get_timeline, set_timeline);
		L.RegVar("moveCurve", get_moveCurve, set_moveCurve);
		L.RegVar("fadeCurve", get_fadeCurve, set_fadeCurve);
		L.RegVar("loop_time", get_loop_time, set_loop_time);
		L.RegVar("stop_time", get_stop_time, set_stop_time);
		L.RegVar("damping_time", get_damping_time, set_damping_time);
		L.RegVar("cueSheetName_interaction", get_cueSheetName_interaction, set_cueSheetName_interaction);
		L.RegVar("cueName_interaction", get_cueName_interaction, set_cueName_interaction);
		L.RegVar("cueSheetName_loop", get_cueSheetName_loop, set_cueSheetName_loop);
		L.RegVar("cueName_loop", get_cueName_loop, set_cueName_loop);
		L.RegVar("audioRatio", get_audioRatio, set_audioRatio);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DrawController obj = (DrawController)ToLua.CheckObject<DrawController>(L, 1);
			PlayableDirector timeline = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			Action action = (Action)ToLua.CheckDelegate<Action>(L, 3);
			obj.Init(timeline, action);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DrawController obj = (DrawController)ToLua.CheckObject<DrawController>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerDown(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DrawController obj = (DrawController)ToLua.CheckObject<DrawController>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnimationProcess(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DrawController obj = (DrawController)ToLua.CheckObject<DrawController>(L, 1);
			float animationProcess = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetAnimationProcess(animationProcess);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DrawController)ToLua.CheckObject<DrawController>(L, 1)).Reset();
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
	private static int get_timeline(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector timeline = ((DrawController)obj).timeline;
			ToLua.Push(L, timeline);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeline on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_moveCurve(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationCurve moveCurve = ((DrawController)obj).moveCurve;
			ToLua.PushObject(L, moveCurve);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveCurve on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fadeCurve(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationCurve fadeCurve = ((DrawController)obj).fadeCurve;
			ToLua.PushObject(L, fadeCurve);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fadeCurve on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loop_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float loop_time = ((DrawController)obj).loop_time;
			LuaDLL.lua_pushnumber(L, loop_time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stop_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float stop_time = ((DrawController)obj).stop_time;
			LuaDLL.lua_pushnumber(L, stop_time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stop_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_damping_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float damping_time = ((DrawController)obj).damping_time;
			LuaDLL.lua_pushnumber(L, damping_time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index damping_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueSheetName_interaction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueSheetName_interaction = ((DrawController)obj).cueSheetName_interaction;
			LuaDLL.lua_pushstring(L, cueSheetName_interaction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName_interaction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueName_interaction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueName_interaction = ((DrawController)obj).cueName_interaction;
			LuaDLL.lua_pushstring(L, cueName_interaction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName_interaction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueSheetName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueSheetName_loop = ((DrawController)obj).cueSheetName_loop;
			LuaDLL.lua_pushstring(L, cueSheetName_loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName_loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueName_loop = ((DrawController)obj).cueName_loop;
			LuaDLL.lua_pushstring(L, cueName_loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName_loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_audioRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float audioRatio = ((DrawController)obj).audioRatio;
			LuaDLL.lua_pushnumber(L, audioRatio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeline(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			PlayableDirector timeline = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			obj2.timeline = timeline;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeline on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_moveCurve(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			AnimationCurve moveCurve = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			obj2.moveCurve = moveCurve;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveCurve on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fadeCurve(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			AnimationCurve fadeCurve = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			obj2.fadeCurve = fadeCurve;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fadeCurve on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loop_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			float loop_time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.loop_time = loop_time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stop_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			float stop_time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.stop_time = stop_time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stop_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_damping_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			float damping_time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.damping_time = damping_time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index damping_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueSheetName_interaction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			string cueSheetName_interaction = ToLua.CheckString(L, 2);
			obj2.cueSheetName_interaction = cueSheetName_interaction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName_interaction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueName_interaction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			string cueName_interaction = ToLua.CheckString(L, 2);
			obj2.cueName_interaction = cueName_interaction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName_interaction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueSheetName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			string cueSheetName_loop = ToLua.CheckString(L, 2);
			obj2.cueSheetName_loop = cueSheetName_loop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName_loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			string cueName_loop = ToLua.CheckString(L, 2);
			obj2.cueName_loop = cueName_loop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName_loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_audioRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DrawController obj2 = (DrawController)obj;
			float audioRatio = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.audioRatio = audioRatio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioRatio on a nil value");
		}
	}
}

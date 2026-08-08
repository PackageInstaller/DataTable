using System;
using LuaInterface;
using Spine;

public class Spine_TrackEntryWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TrackEntry), typeof(object));
		L.RegFunction("Reset", Reset);
		L.RegFunction("ResetRotationDirections", ResetRotationDirections);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateSpine_TrackEntry);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("TrackIndex", get_TrackIndex, null);
		L.RegVar("Animation", get_Animation, null);
		L.RegVar("Loop", get_Loop, set_Loop);
		L.RegVar("Delay", get_Delay, set_Delay);
		L.RegVar("TrackTime", get_TrackTime, set_TrackTime);
		L.RegVar("TrackEnd", get_TrackEnd, set_TrackEnd);
		L.RegVar("AnimationStart", get_AnimationStart, set_AnimationStart);
		L.RegVar("AnimationEnd", get_AnimationEnd, set_AnimationEnd);
		L.RegVar("AnimationLast", get_AnimationLast, set_AnimationLast);
		L.RegVar("AnimationTime", get_AnimationTime, null);
		L.RegVar("TimeScale", get_TimeScale, set_TimeScale);
		L.RegVar("Alpha", get_Alpha, set_Alpha);
		L.RegVar("EventThreshold", get_EventThreshold, set_EventThreshold);
		L.RegVar("AttachmentThreshold", get_AttachmentThreshold, set_AttachmentThreshold);
		L.RegVar("DrawOrderThreshold", get_DrawOrderThreshold, set_DrawOrderThreshold);
		L.RegVar("Next", get_Next, null);
		L.RegVar("IsComplete", get_IsComplete, null);
		L.RegVar("MixTime", get_MixTime, set_MixTime);
		L.RegVar("MixDuration", get_MixDuration, set_MixDuration);
		L.RegVar("MixBlend", get_MixBlend, set_MixBlend);
		L.RegVar("MixingFrom", get_MixingFrom, null);
		L.RegVar("MixingTo", get_MixingTo, null);
		L.RegVar("HoldPrevious", get_HoldPrevious, set_HoldPrevious);
		L.RegVar("Start", get_Start, set_Start);
		L.RegVar("Interrupt", get_Interrupt, set_Interrupt);
		L.RegVar("End", get_End, set_End);
		L.RegVar("Dispose", get_Dispose, set_Dispose);
		L.RegVar("Complete", get_Complete, set_Complete);
		L.RegVar("Event", get_Event, set_Event);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSpine_TrackEntry(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				TrackEntry o = new TrackEntry();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Spine.TrackEntry.New");
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
			((TrackEntry)ToLua.CheckObject<TrackEntry>(L, 1)).Reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetRotationDirections(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((TrackEntry)ToLua.CheckObject<TrackEntry>(L, 1)).ResetRotationDirections();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((TrackEntry)ToLua.CheckObject<TrackEntry>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TrackIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int trackIndex = ((TrackEntry)obj).TrackIndex;
			LuaDLL.lua_pushinteger(L, trackIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TrackIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Animation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation animation = ((TrackEntry)obj).Animation;
			ToLua.PushObject(L, animation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Animation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loop = ((TrackEntry)obj).Loop;
			LuaDLL.lua_pushboolean(L, loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Delay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float delay = ((TrackEntry)obj).Delay;
			LuaDLL.lua_pushnumber(L, delay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Delay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TrackTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float trackTime = ((TrackEntry)obj).TrackTime;
			LuaDLL.lua_pushnumber(L, trackTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TrackTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TrackEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float trackEnd = ((TrackEntry)obj).TrackEnd;
			LuaDLL.lua_pushnumber(L, trackEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TrackEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AnimationStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float animationStart = ((TrackEntry)obj).AnimationStart;
			LuaDLL.lua_pushnumber(L, animationStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AnimationEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float animationEnd = ((TrackEntry)obj).AnimationEnd;
			LuaDLL.lua_pushnumber(L, animationEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AnimationLast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float animationLast = ((TrackEntry)obj).AnimationLast;
			LuaDLL.lua_pushnumber(L, animationLast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationLast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AnimationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float animationTime = ((TrackEntry)obj).AnimationTime;
			LuaDLL.lua_pushnumber(L, animationTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float timeScale = ((TrackEntry)obj).TimeScale;
			LuaDLL.lua_pushnumber(L, timeScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TimeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Alpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float alpha = ((TrackEntry)obj).Alpha;
			LuaDLL.lua_pushnumber(L, alpha);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Alpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EventThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float eventThreshold = ((TrackEntry)obj).EventThreshold;
			LuaDLL.lua_pushnumber(L, eventThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EventThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AttachmentThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float attachmentThreshold = ((TrackEntry)obj).AttachmentThreshold;
			LuaDLL.lua_pushnumber(L, attachmentThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AttachmentThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DrawOrderThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float drawOrderThreshold = ((TrackEntry)obj).DrawOrderThreshold;
			LuaDLL.lua_pushnumber(L, drawOrderThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DrawOrderThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Next(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry next = ((TrackEntry)obj).Next;
			ToLua.PushObject(L, next);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Next on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isComplete = ((TrackEntry)obj).IsComplete;
			LuaDLL.lua_pushboolean(L, isComplete);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsComplete on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MixTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mixTime = ((TrackEntry)obj).MixTime;
			LuaDLL.lua_pushnumber(L, mixTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MixDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mixDuration = ((TrackEntry)obj).MixDuration;
			LuaDLL.lua_pushnumber(L, mixDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MixBlend(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MixBlend mixBlend = ((TrackEntry)obj).MixBlend;
			ToLua.Push(L, mixBlend);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixBlend on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MixingFrom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry mixingFrom = ((TrackEntry)obj).MixingFrom;
			ToLua.PushObject(L, mixingFrom);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixingFrom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MixingTo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry mixingTo = ((TrackEntry)obj).MixingTo;
			ToLua.PushObject(L, mixingTo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixingTo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HoldPrevious(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool holdPrevious = ((TrackEntry)obj).HoldPrevious;
			LuaDLL.lua_pushboolean(L, holdPrevious);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index HoldPrevious on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Start(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(AnimationState.TrackEntryDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Interrupt(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(AnimationState.TrackEntryDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_End(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(AnimationState.TrackEntryDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Dispose(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(AnimationState.TrackEntryDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Complete(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(AnimationState.TrackEntryDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Event(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(AnimationState.TrackEntryEventDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			bool loop = LuaDLL.luaL_checkboolean(L, 2);
			obj2.Loop = loop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Delay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float delay = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.Delay = delay;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Delay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_TrackTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float trackTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.TrackTime = trackTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TrackTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_TrackEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float trackEnd = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.TrackEnd = trackEnd;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TrackEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AnimationStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float animationStart = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.AnimationStart = animationStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AnimationEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float animationEnd = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.AnimationEnd = animationEnd;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AnimationLast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float animationLast = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.AnimationLast = animationLast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationLast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_TimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float timeScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.TimeScale = timeScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TimeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Alpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float alpha = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.Alpha = alpha;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Alpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_EventThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float eventThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.EventThreshold = eventThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EventThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AttachmentThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float attachmentThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.AttachmentThreshold = attachmentThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AttachmentThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_DrawOrderThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float drawOrderThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.DrawOrderThreshold = drawOrderThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DrawOrderThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MixTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float mixTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.MixTime = mixTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MixDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			float mixDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.MixDuration = mixDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MixBlend(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			MixBlend mixBlend = (MixBlend)ToLua.CheckObject(L, 2, typeof(MixBlend));
			obj2.MixBlend = mixBlend;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MixBlend on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_HoldPrevious(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackEntry obj2 = (TrackEntry)obj;
			bool holdPrevious = LuaDLL.luaL_checkboolean(L, 2);
			obj2.HoldPrevious = holdPrevious;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index HoldPrevious on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Start(IntPtr L)
	{
		try
		{
			TrackEntry trackEntry = (TrackEntry)ToLua.CheckObject(L, 1, typeof(TrackEntry));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Start += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Start -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.TrackEntry.Start' can only appear on the left hand side of += or -= when used outside of the type 'Spine.TrackEntry'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Interrupt(IntPtr L)
	{
		try
		{
			TrackEntry trackEntry = (TrackEntry)ToLua.CheckObject(L, 1, typeof(TrackEntry));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Interrupt += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Interrupt -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.TrackEntry.Interrupt' can only appear on the left hand side of += or -= when used outside of the type 'Spine.TrackEntry'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_End(IntPtr L)
	{
		try
		{
			TrackEntry trackEntry = (TrackEntry)ToLua.CheckObject(L, 1, typeof(TrackEntry));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.End += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.End -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.TrackEntry.End' can only appear on the left hand side of += or -= when used outside of the type 'Spine.TrackEntry'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Dispose(IntPtr L)
	{
		try
		{
			TrackEntry trackEntry = (TrackEntry)ToLua.CheckObject(L, 1, typeof(TrackEntry));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Dispose += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Dispose -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.TrackEntry.Dispose' can only appear on the left hand side of += or -= when used outside of the type 'Spine.TrackEntry'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Complete(IntPtr L)
	{
		try
		{
			TrackEntry trackEntry = (TrackEntry)ToLua.CheckObject(L, 1, typeof(TrackEntry));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Complete += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					trackEntry.Complete -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.TrackEntry.Complete' can only appear on the left hand side of += or -= when used outside of the type 'Spine.TrackEntry'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Event(IntPtr L)
	{
		try
		{
			TrackEntry trackEntry = (TrackEntry)ToLua.CheckObject(L, 1, typeof(TrackEntry));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryEventDelegate value = (AnimationState.TrackEntryEventDelegate)eventObject.func;
					trackEntry.Event += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryEventDelegate value2 = (AnimationState.TrackEntryEventDelegate)eventObject.func;
					trackEntry.Event -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.TrackEntry.Event' can only appear on the left hand side of += or -= when used outside of the type 'Spine.TrackEntry'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

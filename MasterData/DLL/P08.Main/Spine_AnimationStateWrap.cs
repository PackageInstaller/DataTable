using System;
using LuaInterface;
using Spine;

public class Spine_AnimationStateWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AnimationState), typeof(object));
		L.RegFunction("AssignEventSubscribersFrom", AssignEventSubscribersFrom);
		L.RegFunction("AddEventSubscribersFrom", AddEventSubscribersFrom);
		L.RegFunction("Update", Update);
		L.RegFunction("Apply", Apply);
		L.RegFunction("ApplyEventTimelinesOnly", ApplyEventTimelinesOnly);
		L.RegFunction("ClearTracks", ClearTracks);
		L.RegFunction("ClearTrack", ClearTrack);
		L.RegFunction("SetAnimation", SetAnimation);
		L.RegFunction("AddAnimation", AddAnimation);
		L.RegFunction("SetEmptyAnimation", SetEmptyAnimation);
		L.RegFunction("AddEmptyAnimation", AddEmptyAnimation);
		L.RegFunction("SetEmptyAnimations", SetEmptyAnimations);
		L.RegFunction("GetCurrent", GetCurrent);
		L.RegFunction("ClearListenerNotifications", ClearListenerNotifications);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateSpine_AnimationState);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("TimeScale", get_TimeScale, set_TimeScale);
		L.RegVar("Data", get_Data, set_Data);
		L.RegVar("Tracks", get_Tracks, null);
		L.RegVar("Start", get_Start, set_Start);
		L.RegVar("Interrupt", get_Interrupt, set_Interrupt);
		L.RegVar("End", get_End, set_End);
		L.RegVar("Dispose", get_Dispose, set_Dispose);
		L.RegVar("Complete", get_Complete, set_Complete);
		L.RegVar("Event", get_Event, set_Event);
		L.RegFunction("TrackEntryEventDelegate", Spine_AnimationState_TrackEntryEventDelegate);
		L.RegFunction("TrackEntryDelegate", Spine_AnimationState_TrackEntryDelegate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSpine_AnimationState(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				AnimationState o = new AnimationState((AnimationStateData)ToLua.CheckObject<AnimationStateData>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Spine.AnimationState.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AssignEventSubscribersFrom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			AnimationState src = (AnimationState)ToLua.CheckObject<AnimationState>(L, 2);
			obj.AssignEventSubscribersFrom(src);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddEventSubscribersFrom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			AnimationState src = (AnimationState)ToLua.CheckObject<AnimationState>(L, 2);
			obj.AddEventSubscribersFrom(src);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Update(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			float delta = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.Update(delta);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Apply(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			Skeleton skeleton = (Skeleton)ToLua.CheckObject<Skeleton>(L, 2);
			bool value = obj.Apply(skeleton);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ApplyEventTimelinesOnly(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			Skeleton skeleton = (Skeleton)ToLua.CheckObject<Skeleton>(L, 2);
			bool value = obj.ApplyEventTimelinesOnly(skeleton);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearTracks(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AnimationState)ToLua.CheckObject<AnimationState>(L, 1)).ClearTracks();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearTrack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			int trackIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ClearTrack(trackIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnimation(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 4 && TypeChecker.CheckTypes<string, bool>(L, 3))
			{
				AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
				int trackIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				string animationName = ToLua.ToString(L, 3);
				bool loop = LuaDLL.lua_toboolean(L, 4);
				TrackEntry o = obj.SetAnimation(trackIndex, animationName, loop);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Animation, bool>(L, 3))
			{
				AnimationState obj2 = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
				int trackIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Animation animation = (Animation)ToLua.ToObject(L, 3);
				bool loop2 = LuaDLL.lua_toboolean(L, 4);
				TrackEntry o2 = obj2.SetAnimation(trackIndex2, animation, loop2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.AnimationState.SetAnimation");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddAnimation(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 5 && TypeChecker.CheckTypes<string, bool, float>(L, 3))
			{
				AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
				int trackIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				string animationName = ToLua.ToString(L, 3);
				bool loop = LuaDLL.lua_toboolean(L, 4);
				float delay = (float)LuaDLL.lua_tonumber(L, 5);
				TrackEntry o = obj.AddAnimation(trackIndex, animationName, loop, delay);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Animation, bool, float>(L, 3))
			{
				AnimationState obj2 = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
				int trackIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Animation animation = (Animation)ToLua.ToObject(L, 3);
				bool loop2 = LuaDLL.lua_toboolean(L, 4);
				float delay2 = (float)LuaDLL.lua_tonumber(L, 5);
				TrackEntry o2 = obj2.AddAnimation(trackIndex2, animation, loop2, delay2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.AnimationState.AddAnimation");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEmptyAnimation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			int trackIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			float mixDuration = (float)LuaDLL.luaL_checknumber(L, 3);
			TrackEntry o = obj.SetEmptyAnimation(trackIndex, mixDuration);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddEmptyAnimation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			int trackIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			float mixDuration = (float)LuaDLL.luaL_checknumber(L, 3);
			float delay = (float)LuaDLL.luaL_checknumber(L, 4);
			TrackEntry o = obj.AddEmptyAnimation(trackIndex, mixDuration, delay);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEmptyAnimations(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			float emptyAnimations = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetEmptyAnimations(emptyAnimations);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationState obj = (AnimationState)ToLua.CheckObject<AnimationState>(L, 1);
			int trackIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			TrackEntry current = obj.GetCurrent(trackIndex);
			ToLua.PushObject(L, current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearListenerNotifications(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AnimationState)ToLua.CheckObject<AnimationState>(L, 1)).ClearListenerNotifications();
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
			string str = ((AnimationState)ToLua.CheckObject<AnimationState>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float timeScale = ((AnimationState)obj).TimeScale;
			LuaDLL.lua_pushnumber(L, timeScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TimeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationStateData data = ((AnimationState)obj).Data;
			ToLua.PushObject(L, data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Tracks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ExposedList<TrackEntry> tracks = ((AnimationState)obj).Tracks;
			ToLua.PushObject(L, tracks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Tracks on a nil value");
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
	private static int set_TimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationState obj2 = (AnimationState)obj;
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
	private static int set_Data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationState obj2 = (AnimationState)obj;
			AnimationStateData data = (AnimationStateData)ToLua.CheckObject<AnimationStateData>(L, 2);
			obj2.Data = data;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Start(IntPtr L)
	{
		try
		{
			AnimationState animationState = (AnimationState)ToLua.CheckObject(L, 1, typeof(AnimationState));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Start += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Start -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.AnimationState.Start' can only appear on the left hand side of += or -= when used outside of the type 'Spine.AnimationState'");
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
			AnimationState animationState = (AnimationState)ToLua.CheckObject(L, 1, typeof(AnimationState));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Interrupt += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Interrupt -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.AnimationState.Interrupt' can only appear on the left hand side of += or -= when used outside of the type 'Spine.AnimationState'");
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
			AnimationState animationState = (AnimationState)ToLua.CheckObject(L, 1, typeof(AnimationState));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.End += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.End -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.AnimationState.End' can only appear on the left hand side of += or -= when used outside of the type 'Spine.AnimationState'");
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
			AnimationState animationState = (AnimationState)ToLua.CheckObject(L, 1, typeof(AnimationState));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Dispose += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Dispose -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.AnimationState.Dispose' can only appear on the left hand side of += or -= when used outside of the type 'Spine.AnimationState'");
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
			AnimationState animationState = (AnimationState)ToLua.CheckObject(L, 1, typeof(AnimationState));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryDelegate value = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Complete += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryDelegate value2 = (AnimationState.TrackEntryDelegate)eventObject.func;
					animationState.Complete -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.AnimationState.Complete' can only appear on the left hand side of += or -= when used outside of the type 'Spine.AnimationState'");
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
			AnimationState animationState = (AnimationState)ToLua.CheckObject(L, 1, typeof(AnimationState));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					AnimationState.TrackEntryEventDelegate value = (AnimationState.TrackEntryEventDelegate)eventObject.func;
					animationState.Event += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					AnimationState.TrackEntryEventDelegate value2 = (AnimationState.TrackEntryEventDelegate)eventObject.func;
					animationState.Event -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.AnimationState.Event' can only appear on the left hand side of += or -= when used outside of the type 'Spine.AnimationState'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_AnimationState_TrackEntryEventDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<AnimationState.TrackEntryEventDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<AnimationState.TrackEntryEventDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_AnimationState_TrackEntryDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<AnimationState.TrackEntryDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<AnimationState.TrackEntryDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

using System;
using LuaInterface;
using Spine;

public class Spine_AnimationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Animation), typeof(object));
		L.RegFunction("HasTimeline", HasTimeline);
		L.RegFunction("Apply", Apply);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateSpine_Animation);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Timelines", get_Timelines, set_Timelines);
		L.RegVar("Duration", get_Duration, set_Duration);
		L.RegVar("Name", get_Name, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSpine_Animation(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 3)
			{
				string name = ToLua.CheckString(L, 1);
				ExposedList<Timeline> timelines = (ExposedList<Timeline>)ToLua.CheckObject<ExposedList<Timeline>>(L, 2);
				float duration = (float)LuaDLL.luaL_checknumber(L, 3);
				Animation o = new Animation(name, timelines, duration);
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Spine.Animation.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation obj = (Animation)ToLua.CheckObject<Animation>(L, 1);
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.HasTimeline(id);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			ToLua.CheckArgsCount(L, 9);
			Animation obj = (Animation)ToLua.CheckObject<Animation>(L, 1);
			Skeleton skeleton = (Skeleton)ToLua.CheckObject<Skeleton>(L, 2);
			float lastTime = (float)LuaDLL.luaL_checknumber(L, 3);
			float time = (float)LuaDLL.luaL_checknumber(L, 4);
			bool loop = LuaDLL.luaL_checkboolean(L, 5);
			ExposedList<Event> events = (ExposedList<Event>)ToLua.CheckObject<ExposedList<Event>>(L, 6);
			float alpha = (float)LuaDLL.luaL_checknumber(L, 7);
			MixBlend blend = (MixBlend)ToLua.CheckObject(L, 8, typeof(MixBlend));
			MixDirection direction = (MixDirection)ToLua.CheckObject(L, 9, typeof(MixDirection));
			obj.Apply(skeleton, lastTime, time, loop, events, alpha, blend, direction);
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
			string str = ((Animation)ToLua.CheckObject<Animation>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Timelines(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ExposedList<Timeline> timelines = ((Animation)obj).Timelines;
			ToLua.PushObject(L, timelines);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Timelines on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float duration = ((Animation)obj).Duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((Animation)obj).Name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Timelines(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			ExposedList<Timeline> timelines = (ExposedList<Timeline>)ToLua.CheckObject<ExposedList<Timeline>>(L, 2);
			obj2.Timelines = timelines;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Timelines on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			float duration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.Duration = duration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Duration on a nil value");
		}
	}
}

using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AnimationEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AnimationEvent), typeof(object));
		L.RegFunction("New", _CreateUnityEngine_AnimationEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("stringParameter", get_stringParameter, set_stringParameter);
		L.RegVar("floatParameter", get_floatParameter, set_floatParameter);
		L.RegVar("intParameter", get_intParameter, set_intParameter);
		L.RegVar("objectReferenceParameter", get_objectReferenceParameter, set_objectReferenceParameter);
		L.RegVar("functionName", get_functionName, set_functionName);
		L.RegVar("time", get_time, set_time);
		L.RegVar("messageOptions", get_messageOptions, set_messageOptions);
		L.RegVar("isFiredByLegacy", get_isFiredByLegacy, null);
		L.RegVar("isFiredByAnimator", get_isFiredByAnimator, null);
		L.RegVar("animationState", get_animationState, null);
		L.RegVar("animatorStateInfo", get_animatorStateInfo, null);
		L.RegVar("animatorClipInfo", get_animatorClipInfo, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_AnimationEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				AnimationEvent o = new AnimationEvent();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.AnimationEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stringParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string stringParameter = ((AnimationEvent)obj).stringParameter;
			LuaDLL.lua_pushstring(L, stringParameter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stringParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_floatParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float floatParameter = ((AnimationEvent)obj).floatParameter;
			LuaDLL.lua_pushnumber(L, floatParameter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index floatParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_intParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int intParameter = ((AnimationEvent)obj).intParameter;
			LuaDLL.lua_pushinteger(L, intParameter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index intParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objectReferenceParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UnityEngine.Object objectReferenceParameter = ((AnimationEvent)obj).objectReferenceParameter;
			ToLua.Push(L, objectReferenceParameter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectReferenceParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_functionName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string functionName = ((AnimationEvent)obj).functionName;
			LuaDLL.lua_pushstring(L, functionName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index functionName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float time = ((AnimationEvent)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_messageOptions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SendMessageOptions messageOptions = ((AnimationEvent)obj).messageOptions;
			ToLua.Push(L, messageOptions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index messageOptions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isFiredByLegacy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isFiredByLegacy = ((AnimationEvent)obj).isFiredByLegacy;
			LuaDLL.lua_pushboolean(L, isFiredByLegacy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isFiredByLegacy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isFiredByAnimator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isFiredByAnimator = ((AnimationEvent)obj).isFiredByAnimator;
			LuaDLL.lua_pushboolean(L, isFiredByAnimator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isFiredByAnimator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animationState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationState animationState = ((AnimationEvent)obj).animationState;
			ToLua.PushSealed(L, animationState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animationState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animatorStateInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimatorStateInfo animatorStateInfo = ((AnimationEvent)obj).animatorStateInfo;
			ToLua.PushValue(L, animatorStateInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animatorStateInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animatorClipInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimatorClipInfo animatorClipInfo = ((AnimationEvent)obj).animatorClipInfo;
			ToLua.PushValue(L, animatorClipInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animatorClipInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stringParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent obj2 = (AnimationEvent)obj;
			string stringParameter = ToLua.CheckString(L, 2);
			obj2.stringParameter = stringParameter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stringParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_floatParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent obj2 = (AnimationEvent)obj;
			float floatParameter = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.floatParameter = floatParameter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index floatParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_intParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent obj2 = (AnimationEvent)obj;
			int intParameter = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.intParameter = intParameter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index intParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objectReferenceParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent obj2 = (AnimationEvent)obj;
			UnityEngine.Object objectReferenceParameter = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 2);
			obj2.objectReferenceParameter = objectReferenceParameter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objectReferenceParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_functionName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent obj2 = (AnimationEvent)obj;
			string functionName = ToLua.CheckString(L, 2);
			obj2.functionName = functionName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index functionName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent obj2 = (AnimationEvent)obj;
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.time = time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_messageOptions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent obj2 = (AnimationEvent)obj;
			SendMessageOptions messageOptions = (SendMessageOptions)ToLua.CheckObject(L, 2, typeof(SendMessageOptions));
			obj2.messageOptions = messageOptions;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index messageOptions on a nil value");
		}
	}
}

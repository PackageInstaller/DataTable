using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;

public class HeroUITimelineBrainWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HeroUITimelineBrain), typeof(MonoBehaviour));
		L.RegFunction("GetCharModelGo", GetCharModelGo);
		L.RegFunction("BindPlayableDirector", BindPlayableDirector);
		L.RegFunction("RebuildPlayableDirector", RebuildPlayableDirector);
		L.RegFunction("FindTarget", FindTarget);
		L.RegFunction("PlayEffect", PlayEffect);
		L.RegFunction("StopEffect", StopEffect);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isPoseLooping", get_isPoseLooping, set_isPoseLooping);
		L.RegVar("talking", get_talking, set_talking);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharModelGo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject charModelGo = ((HeroUITimelineBrain)ToLua.CheckObject<HeroUITimelineBrain>(L, 1)).GetCharModelGo();
			ToLua.PushSealed(L, charModelGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BindPlayableDirector(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HeroUITimelineBrain obj = (HeroUITimelineBrain)ToLua.CheckObject<HeroUITimelineBrain>(L, 1);
			PlayableDirector pd = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			obj.BindPlayableDirector(pd);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RebuildPlayableDirector(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HeroUITimelineBrain obj = (HeroUITimelineBrain)ToLua.CheckObject<HeroUITimelineBrain>(L, 1);
			PlayableDirector pd = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			obj.RebuildPlayableDirector(pd);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindTarget(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				HeroUITimelineBrain obj2 = (HeroUITimelineBrain)ToLua.CheckObject<HeroUITimelineBrain>(L, 1);
				string targetPath2 = ToLua.CheckString(L, 2);
				GameObject o2 = obj2.FindTarget(targetPath2);
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 3:
			{
				HeroUITimelineBrain obj = (HeroUITimelineBrain)ToLua.CheckObject<HeroUITimelineBrain>(L, 1);
				string targetPath = ToLua.CheckString(L, 2);
				Transform extraTrans = (Transform)ToLua.CheckObject<Transform>(L, 3);
				GameObject o = obj.FindTarget(targetPath, extraTrans);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: HeroUITimelineBrain.FindTarget");
			}
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
			ToLua.CheckArgsCount(L, 4);
			HeroUITimelineBrain obj = (HeroUITimelineBrain)ToLua.CheckObject<HeroUITimelineBrain>(L, 1);
			string efxPath = ToLua.CheckString(L, 2);
			string point = ToLua.CheckString(L, 3);
			float duration = (float)LuaDLL.luaL_checknumber(L, 4);
			GameObject o = obj.PlayEffect(efxPath, point, duration);
			ToLua.PushSealed(L, o);
			return 1;
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
			ToLua.CheckArgsCount(L, 2);
			HeroUITimelineBrain obj = (HeroUITimelineBrain)ToLua.CheckObject<HeroUITimelineBrain>(L, 1);
			GameObject efxGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj.StopEffect(efxGo);
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
	private static int get_isPoseLooping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPoseLooping = ((HeroUITimelineBrain)obj).isPoseLooping;
			LuaDLL.lua_pushboolean(L, isPoseLooping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPoseLooping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_talking(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string talking = ((HeroUITimelineBrain)obj).talking;
			LuaDLL.lua_pushstring(L, talking);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index talking on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isPoseLooping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroUITimelineBrain obj2 = (HeroUITimelineBrain)obj;
			bool isPoseLooping = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isPoseLooping = isPoseLooping;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPoseLooping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_talking(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroUITimelineBrain obj2 = (HeroUITimelineBrain)obj;
			string talking = ToLua.CheckString(L, 2);
			obj2.talking = talking;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index talking on a nil value");
		}
	}
}

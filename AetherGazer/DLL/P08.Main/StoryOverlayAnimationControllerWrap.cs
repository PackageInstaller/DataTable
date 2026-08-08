using System;
using LuaInterface;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Playables;

public class StoryOverlayAnimationControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(StoryOverlayAnimationController), typeof(SerializedMonoBehaviour));
		L.RegFunction("PlayOverlayAnimation", PlayOverlayAnimation);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayOverlayAnimation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 7);
			StoryOverlayAnimationController obj = (StoryOverlayAnimationController)ToLua.CheckObject<StoryOverlayAnimationController>(L, 1);
			PlayableDirector director = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			UnityEngine.Object config = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 3);
			string clipName = ToLua.CheckString(L, 4);
			string avatarMaskName = ToLua.CheckString(L, 5);
			float blendInTime = (float)LuaDLL.luaL_checknumber(L, 6);
			float blendOutTime = (float)LuaDLL.luaL_checknumber(L, 7);
			obj.PlayOverlayAnimation(director, config, clipName, avatarMaskName, blendInTime, blendOutTime);
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
}

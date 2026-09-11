using System;
using LuaInterface;
using UnityEngine;

public class CharPreviewSettingWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CharPreviewSetting), typeof(MonoBehaviour));
		L.RegFunction("GetCharacterList", GetCharacterList);
		L.RegFunction("GetCharacterModelList", GetCharacterModelList);
		L.RegFunction("RegisterValidataHandler", RegisterValidataHandler);
		L.RegFunction("Refresh", Refresh);
		L.RegFunction("GetCharacterAnimationList", GetCharacterAnimationList);
		L.RegFunction("GetCharacterAnimationClipList", GetCharacterAnimationClipList);
		L.RegFunction("GetCharacterTimelineList", GetCharacterTimelineList);
		L.RegFunction("GetCharacterTimelineWithAssetNameList", GetCharacterTimelineWithAssetNameList);
		L.RegFunction("EditorTryLoadAsset", EditorTryLoadAsset);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharacterList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int[] characterList = ((CharPreviewSetting)ToLua.CheckObject<CharPreviewSetting>(L, 1)).GetCharacterList();
			ToLua.Push(L, characterList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharacterModelList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject[] characterModelList = ((CharPreviewSetting)ToLua.CheckObject<CharPreviewSetting>(L, 1)).GetCharacterModelList();
			ToLua.Push(L, characterModelList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RegisterValidataHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CharPreviewSetting obj = (CharPreviewSetting)ToLua.CheckObject<CharPreviewSetting>(L, 1);
			Action handler = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.RegisterValidataHandler(handler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Refresh(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharPreviewSetting)ToLua.CheckObject<CharPreviewSetting>(L, 1)).Refresh();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharacterAnimationList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] characterAnimationList = CharPreviewSetting.GetCharacterAnimationList((Animator)ToLua.CheckObject<Animator>(L, 1));
			ToLua.Push(L, characterAnimationList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharacterAnimationClipList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] characterAnimationClipList = CharPreviewSetting.GetCharacterAnimationClipList((Animator)ToLua.CheckObject<Animator>(L, 1));
			ToLua.Push(L, characterAnimationClipList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharacterTimelineList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] characterTimelineList = CharPreviewSetting.GetCharacterTimelineList(ToLua.CheckString(L, 1));
			ToLua.Push(L, characterTimelineList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharacterTimelineWithAssetNameList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string tposeName = ToLua.CheckString(L, 1);
			string[] nameArray = null;
			string[] characterTimelineWithAssetNameList = CharPreviewSetting.GetCharacterTimelineWithAssetNameList(tposeName, out nameArray);
			ToLua.Push(L, characterTimelineWithAssetNameList);
			ToLua.Push(L, nameArray);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EditorTryLoadAsset(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				GameObject o2 = CharPreviewSetting.EditorTryLoadAsset(ToLua.CheckString(L, 1));
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 2:
			{
				string title = ToLua.CheckString(L, 1);
				string dir = ToLua.CheckString(L, 2);
				GameObject o = CharPreviewSetting.EditorTryLoadAsset(title, dir);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CharPreviewSetting.EditorTryLoadAsset");
			}
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

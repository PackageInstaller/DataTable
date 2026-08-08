using System;
using LuaInterface;
using UnityEngine;

public class CutPictureWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CutPicture), typeof(MonoBehaviour));
		L.RegFunction("StartCutPicture", StartCutPicture);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sp", get_sp, set_sp);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartCutPicture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CutPicture obj = (CutPicture)ToLua.CheckObject<CutPicture>(L, 1);
			Action func = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.StartCutPicture(func);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Destroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CutPicture)ToLua.CheckObject<CutPicture>(L, 1)).Destroy();
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
	private static int get_sp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite sp = ((CutPicture)obj).sp;
			ToLua.PushSealed(L, sp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CutPicture obj2 = (CutPicture)obj;
			Sprite sp = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
			obj2.sp = sp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sp on a nil value");
		}
	}
}

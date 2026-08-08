using System;
using LuaInterface;
using UnityEngine.UI;

public class UnityEngine_UI_Selectable_TransitionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(Selectable.Transition));
		L.RegVar("None", get_None, null);
		L.RegVar("ColorTint", get_ColorTint, null);
		L.RegVar("SpriteSwap", get_SpriteSwap, null);
		L.RegVar("Animation", get_Animation, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<Selectable.Transition>.Check = CheckType;
		StackTraits<Selectable.Transition>.Push = Push;
	}

	private static void Push(IntPtr L, Selectable.Transition arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(Selectable.Transition), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_None(IntPtr L)
	{
		ToLua.Push(L, Selectable.Transition.None);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ColorTint(IntPtr L)
	{
		ToLua.Push(L, Selectable.Transition.ColorTint);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SpriteSwap(IntPtr L)
	{
		ToLua.Push(L, Selectable.Transition.SpriteSwap);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Animation(IntPtr L)
	{
		ToLua.Push(L, Selectable.Transition.Animation);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		Selectable.Transition transition = (Selectable.Transition)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, transition);
		return 1;
	}
}

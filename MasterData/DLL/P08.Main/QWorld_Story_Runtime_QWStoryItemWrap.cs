using System;
using LuaInterface;
using QWorld.Story.Runtime;
using UnityEngine;

public class QWorld_Story_Runtime_QWStoryItemWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWStoryItem), typeof(MonoBehaviour));
		L.RegFunction("Init", Init);
		L.RegFunction("PlayAnimaton", PlayAnimaton);
		L.RegFunction("OnClear", OnClear);
		L.RegFunction("ClearOnNext", ClearOnNext);
		L.RegFunction("GetAttachPoint", GetAttachPoint);
		L.RegFunction("SetTransform", SetTransform);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("OnAnimatorEnd", get_OnAnimatorEnd, set_OnAnimatorEnd);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1)).Init();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAnimaton(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				QWStoryItem obj3 = (QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1);
				string animName3 = ToLua.CheckString(L, 2);
				float crossFadeTime3 = (float)LuaDLL.luaL_checknumber(L, 3);
				obj3.PlayAnimaton(animName3, crossFadeTime3);
				return 0;
			}
			case 4:
			{
				QWStoryItem obj2 = (QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1);
				string animName2 = ToLua.CheckString(L, 2);
				float crossFadeTime2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float time2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj2.PlayAnimaton(animName2, crossFadeTime2, time2);
				return 0;
			}
			case 5:
			{
				QWStoryItem obj = (QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1);
				string animName = ToLua.CheckString(L, 2);
				float crossFadeTime = (float)LuaDLL.luaL_checknumber(L, 3);
				float time = (float)LuaDLL.luaL_checknumber(L, 4);
				Action callback = (Action)ToLua.CheckDelegate<Action>(L, 5);
				obj.PlayAnimaton(animName, crossFadeTime, time, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryItem.PlayAnimaton");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnClear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1)).OnClear();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearOnNext(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1)).ClearOnNext();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAttachPoint(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				QWStoryItem obj = (QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				Transform attachPoint = obj.GetAttachPoint(id);
				ToLua.Push(L, attachPoint);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				QWStoryItem obj2 = (QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1);
				string pointName = ToLua.ToString(L, 2);
				Transform attachPoint2 = obj2.GetAttachPoint(pointName);
				ToLua.Push(L, attachPoint2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorld.Story.Runtime.QWStoryItem.GetAttachPoint");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWStoryItem obj = (QWStoryItem)ToLua.CheckObject<QWStoryItem>(L, 1);
			Transform transform = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj.SetTransform(transform);
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
	private static int get_OnAnimatorEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onAnimatorEnd = ((QWStoryItem)obj).OnAnimatorEnd;
			ToLua.Push(L, onAnimatorEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnAnimatorEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnAnimatorEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWStoryItem obj2 = (QWStoryItem)obj;
			Action onAnimatorEnd = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnAnimatorEnd = onAnimatorEnd;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnAnimatorEnd on a nil value");
		}
	}
}

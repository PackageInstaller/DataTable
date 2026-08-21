using System;
using System.Collections;
using LuaInterface;
using UnityEngine;

public class UnityEngine_MonoBehaviourWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MonoBehaviour), typeof(Behaviour));
		L.RegFunction("IsInvoking", IsInvoking);
		L.RegFunction("CancelInvoke", CancelInvoke);
		L.RegFunction("Invoke", Invoke);
		L.RegFunction("InvokeRepeating", InvokeRepeating);
		L.RegFunction("StartCoroutine", StartCoroutine);
		L.RegFunction("StopCoroutine", StopCoroutine);
		L.RegFunction("StopAllCoroutines", StopAllCoroutines);
		L.RegFunction("print", print);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("useGUILayout", get_useGUILayout, set_useGUILayout);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsInvoking(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = ((MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1)).IsInvoking();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				MonoBehaviour obj = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				string methodName = ToLua.CheckString(L, 2);
				bool value = obj.IsInvoking(methodName);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MonoBehaviour.IsInvoking");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CancelInvoke(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1)).CancelInvoke();
				return 0;
			case 2:
			{
				MonoBehaviour obj = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				string methodName = ToLua.CheckString(L, 2);
				obj.CancelInvoke(methodName);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MonoBehaviour.CancelInvoke");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Invoke(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			MonoBehaviour obj = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
			string methodName = ToLua.CheckString(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.Invoke(methodName, time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InvokeRepeating(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			MonoBehaviour obj = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
			string methodName = ToLua.CheckString(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			float repeatRate = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.InvokeRepeating(methodName, time, repeatRate);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartCoroutine(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MonoBehaviour obj = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				string methodName = ToLua.ToString(L, 2);
				Coroutine o = obj.StartCoroutine(methodName);
				ToLua.PushSealed(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<IEnumerator>(L, 2))
			{
				MonoBehaviour obj2 = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				IEnumerator routine = (IEnumerator)ToLua.ToObject(L, 2);
				Coroutine o2 = obj2.StartCoroutine(routine);
				ToLua.PushSealed(L, o2);
				return 1;
			}
			if (num == 3)
			{
				MonoBehaviour obj3 = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				string methodName2 = ToLua.CheckString(L, 2);
				object value = ToLua.ToVarObject(L, 3);
				Coroutine o3 = obj3.StartCoroutine(methodName2, value);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MonoBehaviour.StartCoroutine");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopCoroutine(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<IEnumerator>(L, 2))
			{
				MonoBehaviour obj = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				IEnumerator routine = (IEnumerator)ToLua.ToObject(L, 2);
				obj.StopCoroutine(routine);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Coroutine>(L, 2))
			{
				MonoBehaviour obj2 = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				Coroutine routine2 = (Coroutine)ToLua.ToObject(L, 2);
				obj2.StopCoroutine(routine2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MonoBehaviour obj3 = (MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1);
				string methodName = ToLua.ToString(L, 2);
				obj3.StopCoroutine(methodName);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MonoBehaviour.StopCoroutine");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopAllCoroutines(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((MonoBehaviour)ToLua.CheckObject<MonoBehaviour>(L, 1)).StopAllCoroutines();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int print(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MonoBehaviour.print(ToLua.ToVarObject(L, 1));
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
	private static int get_useGUILayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useGUILayout = ((MonoBehaviour)obj).useGUILayout;
			LuaDLL.lua_pushboolean(L, useGUILayout);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useGUILayout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useGUILayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonoBehaviour obj2 = (MonoBehaviour)obj;
			bool useGUILayout = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useGUILayout = useGUILayout;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useGUILayout on a nil value");
		}
	}
}

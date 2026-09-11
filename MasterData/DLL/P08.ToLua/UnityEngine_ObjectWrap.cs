using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ObjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEngine.Object), typeof(object));
		L.RegFunction("FindObjectsOfType", FindObjectsOfType);
		L.RegFunction("DontDestroyOnLoad", DontDestroyOnLoad);
		L.RegFunction("ToString", ToString);
		L.RegFunction("GetInstanceID", GetInstanceID);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("Equals", Equals);
		L.RegFunction("FindObjectOfType", FindObjectOfType);
		L.RegFunction("Instantiate", Instantiate);
		L.RegFunction("DestroyImmediate", DestroyImmediate);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("New", _CreateUnityEngine_Object);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("name", get_name, set_name);
		L.RegVar("hideFlags", get_hideFlags, set_hideFlags);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Object(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				UnityEngine.Object obj = new UnityEngine.Object();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Object.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindObjectsOfType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UnityEngine.Object[] array = UnityEngine.Object.FindObjectsOfType(ToLua.CheckMonoType(L, 1));
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DontDestroyOnLoad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UnityEngine.Object.DontDestroyOnLoad((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1));
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
			string str = ((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInstanceID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int instanceID = ((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1)).GetInstanceID();
			LuaDLL.lua_pushinteger(L, instanceID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int hashCode = ((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1)).GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			bool value = ((obj != null) ? obj.Equals(obj2) : (obj2 == null));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindObjectOfType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UnityEngine.Object obj = UnityEngine.Object.FindObjectOfType(ToLua.CheckMonoType(L, 1));
			ToLua.Push(L, obj);
			return 1;
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
	private static int Instantiate(IntPtr L)
	{
		IntPtr l = LuaException.L;
		try
		{
			LuaException.InstantiateCount++;
			LuaException.L = L;
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
			{
				UnityEngine.Object obj2 = UnityEngine.Object.Instantiate((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1));
				if (LuaDLL.lua_toboolean(L, LuaDLL.lua_upvalueindex(1)))
				{
					string msg2 = LuaDLL.lua_tostring(L, -1);
					LuaDLL.lua_pop(L, 1);
					throw new LuaException(msg2, LuaException.GetLastError());
				}
				ToLua.Push(L, obj2);
				LuaException.L = l;
				LuaException.InstantiateCount--;
				return 1;
			}
			case 2:
			{
				UnityEngine.Object original2 = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
				Transform parent = (Transform)ToLua.CheckObject<Transform>(L, 2);
				UnityEngine.Object obj3 = UnityEngine.Object.Instantiate(original2, parent);
				if (LuaDLL.lua_toboolean(L, LuaDLL.lua_upvalueindex(1)))
				{
					string msg3 = LuaDLL.lua_tostring(L, -1);
					LuaDLL.lua_pop(L, 1);
					throw new LuaException(msg3, LuaException.GetLastError());
				}
				ToLua.Push(L, obj3);
				LuaException.L = l;
				LuaException.InstantiateCount--;
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<Vector3, Quaternion>(L, 2))
				{
					UnityEngine.Object original = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
					Vector3 position = ToLua.ToVector3(L, 2);
					Quaternion rotation = ToLua.ToQuaternion(L, 3);
					UnityEngine.Object obj = UnityEngine.Object.Instantiate(original, position, rotation);
					if (LuaDLL.lua_toboolean(L, LuaDLL.lua_upvalueindex(1)))
					{
						string msg = LuaDLL.lua_tostring(L, -1);
						LuaDLL.lua_pop(L, 1);
						throw new LuaException(msg, LuaException.GetLastError());
					}
					ToLua.Push(L, obj);
					LuaException.L = l;
					LuaException.InstantiateCount--;
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<Transform, bool>(L, 2))
			{
				UnityEngine.Object original3 = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
				Transform parent2 = (Transform)ToLua.ToObject(L, 2);
				bool instantiateInWorldSpace = LuaDLL.lua_toboolean(L, 3);
				UnityEngine.Object obj4 = UnityEngine.Object.Instantiate(original3, parent2, instantiateInWorldSpace);
				if (LuaDLL.lua_toboolean(L, LuaDLL.lua_upvalueindex(1)))
				{
					string msg4 = LuaDLL.lua_tostring(L, -1);
					LuaDLL.lua_pop(L, 1);
					throw new LuaException(msg4, LuaException.GetLastError());
				}
				ToLua.Push(L, obj4);
				LuaException.L = l;
				LuaException.InstantiateCount--;
				return 1;
			}
			if (num == 4)
			{
				UnityEngine.Object original4 = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
				Vector3 position2 = ToLua.CheckVector3(L, 2);
				Quaternion rotation2 = ToLua.CheckQuaternion(L, 3);
				Transform parent3 = (Transform)ToLua.CheckObject<Transform>(L, 4);
				UnityEngine.Object obj5 = UnityEngine.Object.Instantiate(original4, position2, rotation2, parent3);
				if (LuaDLL.lua_toboolean(L, LuaDLL.lua_upvalueindex(1)))
				{
					string msg5 = LuaDLL.lua_tostring(L, -1);
					LuaDLL.lua_pop(L, 1);
					throw new LuaException(msg5, LuaException.GetLastError());
				}
				ToLua.Push(L, obj5);
				LuaException.L = l;
				LuaException.InstantiateCount--;
				return 1;
			}
			LuaException.L = l;
			LuaException.InstantiateCount--;
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Object.Instantiate");
		}
		catch (Exception e)
		{
			LuaException.L = l;
			LuaException.InstantiateCount--;
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DestroyImmediate(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
				ToLua.Destroy(L);
				UnityEngine.Object.DestroyImmediate(obj2);
				return 0;
			}
			case 2:
			{
				UnityEngine.Object obj = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
				bool allowDestroyingAssets = LuaDLL.luaL_checkboolean(L, 2);
				ToLua.Destroy(L);
				UnityEngine.Object.DestroyImmediate(obj, allowDestroyingAssets);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Object.DestroyImmediate");
			}
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				UnityEngine.Object obj = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
				ToLua.Destroy(L);
				UnityEngine.Object.Destroy(obj);
				return 0;
			}
			case 2:
			{
				float time = (float)LuaDLL.luaL_checknumber(L, 2);
				int id = LuaDLL.tolua_rawnetobj(L, 1);
				LuaState.GetTranslator(L).DelayDestroy(id, time);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Object.Destroy");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((UnityEngine.Object)obj).name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hideFlags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HideFlags hideFlags = ((UnityEngine.Object)obj).hideFlags;
			ToLua.Push(L, hideFlags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hideFlags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)obj;
			string name = ToLua.CheckString(L, 2);
			obj2.name = name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hideFlags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)obj;
			HideFlags hideFlags = (HideFlags)ToLua.CheckObject(L, 2, typeof(HideFlags));
			obj2.hideFlags = hideFlags;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hideFlags on a nil value");
		}
	}
}

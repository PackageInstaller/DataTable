using System;
using System.Reflection;
using System.Runtime.Serialization;
using LuaInterface;

public class System_DelegateWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Delegate), typeof(object));
		L.RegFunction("CreateDelegate", CreateDelegate);
		L.RegFunction("DynamicInvoke", DynamicInvoke);
		L.RegFunction("Clone", Clone);
		L.RegFunction("GetObjectData", GetObjectData);
		L.RegFunction("GetInvocationList", GetInvocationList);
		L.RegFunction("Combine", Combine);
		L.RegFunction("Remove", Remove);
		L.RegFunction("RemoveAll", RemoveAll);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("Equals", Equals);
		L.RegFunction("__add", op_Addition);
		L.RegFunction("__sub", op_Subtraction);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Method", get_Method, null);
		L.RegVar("Target", get_Target, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Type type2 = ToLua.CheckMonoType(L, 1);
				MethodInfo method2 = (MethodInfo)ToLua.CheckObject<MethodInfo>(L, 2);
				Delegate ev2 = Delegate.CreateDelegate(type2, method2);
				ToLua.Push(L, ev2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<MethodInfo, bool>(L, 2))
				{
					Type type = ToLua.CheckMonoType(L, 1);
					MethodInfo method = (MethodInfo)ToLua.ToObject(L, 2);
					bool throwOnBindFailure = LuaDLL.lua_toboolean(L, 3);
					Delegate ev = Delegate.CreateDelegate(type, method, throwOnBindFailure);
					ToLua.Push(L, ev);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string>(L, 2))
			{
				Type type3 = ToLua.CheckMonoType(L, 1);
				Type target = (Type)ToLua.ToObject(L, 2);
				string method3 = ToLua.ToString(L, 3);
				Delegate ev3 = Delegate.CreateDelegate(type3, target, method3);
				ToLua.Push(L, ev3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<object, string>(L, 2))
			{
				Type type4 = ToLua.CheckMonoType(L, 1);
				object target2 = ToLua.ToVarObject(L, 2);
				string method4 = ToLua.ToString(L, 3);
				Delegate ev4 = Delegate.CreateDelegate(type4, target2, method4);
				ToLua.Push(L, ev4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<object, MethodInfo>(L, 2))
			{
				Type type5 = ToLua.CheckMonoType(L, 1);
				object firstArgument = ToLua.ToVarObject(L, 2);
				MethodInfo method5 = (MethodInfo)ToLua.ToObject(L, 3);
				Delegate ev5 = Delegate.CreateDelegate(type5, firstArgument, method5);
				ToLua.Push(L, ev5);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Type, string, bool>(L, 2))
			{
				Type type6 = ToLua.CheckMonoType(L, 1);
				Type target3 = (Type)ToLua.ToObject(L, 2);
				string method6 = ToLua.ToString(L, 3);
				bool ignoreCase = LuaDLL.lua_toboolean(L, 4);
				Delegate ev6 = Delegate.CreateDelegate(type6, target3, method6, ignoreCase);
				ToLua.Push(L, ev6);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<object, string, bool>(L, 2))
			{
				Type type7 = ToLua.CheckMonoType(L, 1);
				object target4 = ToLua.ToVarObject(L, 2);
				string method7 = ToLua.ToString(L, 3);
				bool ignoreCase2 = LuaDLL.lua_toboolean(L, 4);
				Delegate ev7 = Delegate.CreateDelegate(type7, target4, method7, ignoreCase2);
				ToLua.Push(L, ev7);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<object, MethodInfo, bool>(L, 2))
			{
				Type type8 = ToLua.CheckMonoType(L, 1);
				object firstArgument2 = ToLua.ToVarObject(L, 2);
				MethodInfo method8 = (MethodInfo)ToLua.ToObject(L, 3);
				bool throwOnBindFailure2 = LuaDLL.lua_toboolean(L, 4);
				Delegate ev8 = Delegate.CreateDelegate(type8, firstArgument2, method8, throwOnBindFailure2);
				ToLua.Push(L, ev8);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Type, string, bool, bool>(L, 2))
			{
				Type type9 = ToLua.CheckMonoType(L, 1);
				Type target5 = (Type)ToLua.ToObject(L, 2);
				string method9 = ToLua.ToString(L, 3);
				bool ignoreCase3 = LuaDLL.lua_toboolean(L, 4);
				bool throwOnBindFailure3 = LuaDLL.lua_toboolean(L, 5);
				Delegate ev9 = Delegate.CreateDelegate(type9, target5, method9, ignoreCase3, throwOnBindFailure3);
				ToLua.Push(L, ev9);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<object, string, bool, bool>(L, 2))
			{
				Type type10 = ToLua.CheckMonoType(L, 1);
				object target6 = ToLua.ToVarObject(L, 2);
				string method10 = ToLua.ToString(L, 3);
				bool ignoreCase4 = LuaDLL.lua_toboolean(L, 4);
				bool throwOnBindFailure4 = LuaDLL.lua_toboolean(L, 5);
				Delegate ev10 = Delegate.CreateDelegate(type10, target6, method10, ignoreCase4, throwOnBindFailure4);
				ToLua.Push(L, ev10);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Delegate.CreateDelegate");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DynamicInvoke(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Delegate obj = (Delegate)ToLua.CheckObject<Delegate>(L, 1);
			object[] args = ToLua.ToParamsObject(L, 2, num - 1);
			object obj2 = obj.DynamicInvoke(args);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clone(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ((Delegate)ToLua.CheckObject<Delegate>(L, 1)).Clone();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetObjectData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Delegate obj = (Delegate)ToLua.CheckObject<Delegate>(L, 1);
			SerializationInfo info = (SerializationInfo)ToLua.CheckObject(L, 2, typeof(SerializationInfo));
			StreamingContext context = StackTraits<StreamingContext>.Check(L, 3);
			obj.GetObjectData(info, context);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInvocationList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Delegate[] invocationList = ((Delegate)ToLua.CheckObject<Delegate>(L, 1)).GetInvocationList();
			ToLua.Push(L, invocationList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Combine(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Delegate, Delegate>(L, 1))
			{
				Delegate a = (Delegate)ToLua.ToObject(L, 1);
				Delegate b = (Delegate)ToLua.ToObject(L, 2);
				Delegate ev = Delegate.Combine(a, b);
				ToLua.Push(L, ev);
				return 1;
			}
			if (TypeChecker.CheckParamsType<Delegate>(L, 1, num))
			{
				Delegate ev2 = Delegate.Combine(ToLua.ToParamsObject<Delegate>(L, 1, num));
				ToLua.Push(L, ev2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Delegate.Combine");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Remove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Delegate source = (Delegate)ToLua.CheckObject<Delegate>(L, 1);
			Delegate value = (Delegate)ToLua.CheckObject<Delegate>(L, 2);
			Delegate ev = Delegate.Remove(source, value);
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Delegate source = (Delegate)ToLua.CheckObject<Delegate>(L, 1);
			Delegate value = (Delegate)ToLua.CheckObject<Delegate>(L, 2);
			Delegate ev = Delegate.RemoveAll(source, value);
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Subtraction(IntPtr L)
	{
		try
		{
			Delegate obj = (Delegate)ToLua.CheckObject<Delegate>(L, 1);
			if (LuaDLL.lua_type(L, 2) == LuaTypes.LUA_TFUNCTION)
			{
				LuaState luaState = LuaState.Get(L);
				LuaFunction luaFunction = ToLua.ToLuaFunction(L, 2);
				Delegate[] invocationList = obj.GetInvocationList();
				for (int i = 0; i < invocationList.Length; i++)
				{
					LuaDelegate luaDelegate = invocationList[i].Target as LuaDelegate;
					if (luaDelegate != null && luaDelegate.func == luaFunction && luaDelegate.self == null)
					{
						obj = Delegate.Remove(obj, invocationList[i]);
						luaState.DelayDispose(luaDelegate.func);
						break;
					}
				}
				luaFunction.Dispose();
				ToLua.Push(L, obj);
				return 1;
			}
			Delegate dg = (Delegate)ToLua.CheckObject<Delegate>(L, 2);
			obj = DelegateFactory.RemoveDelegate(obj, dg);
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Addition(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_type(L, 1))
			{
			case LuaTypes.LUA_TFUNCTION:
			{
				Delegate obj2 = ToLua.ToObject(L, 2) as Delegate;
				Delegate b2 = DelegateFactory.CreateDelegate(func: ToLua.ToLuaFunction(L, 1), t: obj2.GetType());
				Delegate ev2 = Delegate.Combine(obj2, b2);
				ToLua.Push(L, ev2);
				return 1;
			}
			case LuaTypes.LUA_TNIL:
				LuaDLL.lua_pushvalue(L, 2);
				return 1;
			case LuaTypes.LUA_TUSERDATA:
			{
				Delegate obj = ToLua.ToObject(L, 1) as Delegate;
				Delegate b = ToLua.CheckDelegate(obj.GetType(), L, 2);
				Delegate ev = Delegate.Combine(obj, b);
				ToLua.Push(L, ev);
				return 1;
			}
			default:
				LuaDLL.luaL_typerror(L, 1, "Delegate");
				return 0;
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
			Delegate obj = (Delegate)ToLua.ToObject(L, 1);
			Delegate obj2 = (Delegate)ToLua.ToObject(L, 2);
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
	private static int Destroy(IntPtr L)
	{
		Delegate[] invocationList = ((Delegate)ToLua.CheckObject<Delegate>(L, 1)).GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			LuaDelegate luaDelegate = invocationList[i].Target as LuaDelegate;
			if (luaDelegate != null)
			{
				luaDelegate.Dispose();
			}
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int hashCode = ((Delegate)ToLua.CheckObject<Delegate>(L, 1)).GetHashCode();
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
			Delegate obj = (Delegate)ToLua.CheckObject<Delegate>(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			bool value = obj?.Equals(obj2) ?? (obj2 == null);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Method(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MethodInfo method = ((Delegate)obj).Method;
			ToLua.PushObject(L, method);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Method on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Target(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object target = ((Delegate)obj).Target;
			ToLua.Push(L, target);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Target on a nil value");
		}
	}
}

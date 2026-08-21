using System;

namespace LuaInterface;

public static class DelegateTraits<T>
{
	private static DelegateFactory.DelegateCreate _Create;

	public static void Init(DelegateFactory.DelegateCreate func)
	{
		_Create = func;
	}

	public static Delegate Create(LuaFunction func)
	{
		if (func != null)
		{
			LuaState luaState = func.GetLuaState();
			LuaDelegate luaDelegate = luaState.GetLuaDelegate(func);
			if (luaDelegate != null)
			{
				return Delegate.CreateDelegate(typeof(T), luaDelegate, luaDelegate.method);
			}
			Delegate obj = _Create(func, null, flag: false);
			luaDelegate = obj.Target as LuaDelegate;
			luaState.AddLuaDelegate(luaDelegate, func);
			return obj;
		}
		return _Create(null, null, flag: false);
	}

	public static Delegate Create(LuaFunction func, LuaTable self)
	{
		if (func != null)
		{
			LuaState luaState = func.GetLuaState();
			LuaDelegate luaDelegate = luaState.GetLuaDelegate(func, self);
			if (luaDelegate != null)
			{
				return Delegate.CreateDelegate(typeof(T), luaDelegate, luaDelegate.method);
			}
			Delegate obj = _Create(func, self, flag: true);
			luaDelegate = obj.Target as LuaDelegate;
			luaState.AddLuaDelegate(luaDelegate, func, self);
			return obj;
		}
		return _Create(null, null, flag: true);
	}
}

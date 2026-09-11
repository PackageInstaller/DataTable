using System.Reflection;
using System.Runtime.CompilerServices;

namespace LuaInterface;

public class LuaDelegate
{
	public LuaFunction func;

	public LuaTable self;

	public MethodInfo method;

	public LuaDelegate(LuaFunction func)
	{
		this.func = func;
	}

	public LuaDelegate(LuaFunction func, LuaTable self)
	{
		this.func = func;
		this.self = self;
	}

	public virtual void Dispose()
	{
		method = null;
		if (func != null)
		{
			func.Dispose(1);
			func = null;
		}
		if (self != null)
		{
			self.Dispose(1);
			self = null;
		}
	}

	public override bool Equals(object o)
	{
		if (o == null)
		{
			if (func == null)
			{
				return self == null;
			}
			return false;
		}
		LuaDelegate luaDelegate = o as LuaDelegate;
		if (luaDelegate == null || luaDelegate.func != func || luaDelegate.self != self)
		{
			return false;
		}
		return luaDelegate.func != null;
	}

	private static bool CompareLuaDelegate(LuaDelegate a, LuaDelegate b)
	{
		if ((object)a == b)
		{
			return true;
		}
		if ((object)a == null && (object)b != null)
		{
			if (b.func == null)
			{
				return b.self == null;
			}
			return false;
		}
		if ((object)a != null && (object)b == null)
		{
			if (a.func == null)
			{
				return a.self == null;
			}
			return false;
		}
		if (a.func != b.func || a.self != b.self)
		{
			return false;
		}
		return a.func != null;
	}

	public static bool operator ==(LuaDelegate a, LuaDelegate b)
	{
		return CompareLuaDelegate(a, b);
	}

	public static bool operator !=(LuaDelegate a, LuaDelegate b)
	{
		return !CompareLuaDelegate(a, b);
	}

	public override int GetHashCode()
	{
		return RuntimeHelpers.GetHashCode(this);
	}
}

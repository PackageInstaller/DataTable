using System;
using System.Runtime.CompilerServices;

namespace LuaInterface;

public abstract class LuaBaseRef : IDisposable
{
	public string name;

	protected int reference = -1;

	protected LuaState luaState;

	protected ObjectTranslator translator;

	protected volatile bool beDisposed;

	protected int count;

	public volatile bool IsAlive = true;

	public LuaBaseRef()
	{
		IsAlive = true;
		count = 1;
	}

	~LuaBaseRef()
	{
		IsAlive = false;
		Dispose(disposeManagedResources: false);
	}

	public virtual void Dispose()
	{
		count--;
		if (count <= 0)
		{
			IsAlive = false;
			Dispose(disposeManagedResources: true);
		}
	}

	public void AddRef()
	{
		count++;
	}

	public virtual void Dispose(bool disposeManagedResources)
	{
		if (!beDisposed)
		{
			beDisposed = true;
			if (reference > 0 && luaState != null)
			{
				luaState.CollectRef(reference, name, !disposeManagedResources);
			}
			reference = -1;
			luaState = null;
			count = 0;
		}
	}

	public void Dispose(int generation)
	{
		if (count <= generation)
		{
			Dispose(disposeManagedResources: true);
		}
	}

	public LuaState GetLuaState()
	{
		return luaState;
	}

	public void Push()
	{
		luaState.Push(this);
	}

	public override int GetHashCode()
	{
		return RuntimeHelpers.GetHashCode(this);
	}

	public virtual int GetReference()
	{
		return reference;
	}

	public override bool Equals(object o)
	{
		if (o == null)
		{
			return reference <= 0;
		}
		LuaBaseRef luaBaseRef = o as LuaBaseRef;
		if (luaBaseRef == null || luaBaseRef.reference != reference)
		{
			return false;
		}
		return reference > 0;
	}

	private static bool CompareRef(LuaBaseRef a, LuaBaseRef b)
	{
		if ((object)a == b)
		{
			return true;
		}
		if ((object)a == null && (object)b != null)
		{
			return b.reference <= 0;
		}
		if ((object)a != null && (object)b == null)
		{
			return a.reference <= 0;
		}
		if (a.reference != b.reference)
		{
			return false;
		}
		return a.reference > 0;
	}

	public static bool operator ==(LuaBaseRef a, LuaBaseRef b)
	{
		return CompareRef(a, b);
	}

	public static bool operator !=(LuaBaseRef a, LuaBaseRef b)
	{
		return !CompareRef(a, b);
	}
}

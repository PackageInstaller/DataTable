using System;

namespace LuaInterface;

public class LuaEvent : IDisposable
{
	protected LuaState luaState;

	protected bool beDisposed;

	private LuaTable self;

	private LuaFunction _add;

	private LuaFunction _remove;

	public LuaEvent(LuaTable table)
	{
		self = table;
		luaState = table.GetLuaState();
		self.AddRef();
		_add = self.GetLuaFunction("Add");
		_remove = self.GetLuaFunction("Remove");
	}

	public void Dispose()
	{
		self.Dispose();
		_add.Dispose();
		_remove.Dispose();
		Clear();
	}

	private void Clear()
	{
		_add = null;
		_remove = null;
		self = null;
		luaState = null;
	}

	public void Dispose(bool disposeManagedResources)
	{
		if (!beDisposed)
		{
			beDisposed = true;
			if (_add != null)
			{
				_add.Dispose(disposeManagedResources);
				_add = null;
			}
			if (_remove != null)
			{
				_remove.Dispose(disposeManagedResources);
				_remove = null;
			}
			if (self != null)
			{
				self.Dispose(disposeManagedResources);
			}
			Clear();
		}
	}

	public void Add(LuaFunction func, LuaTable obj)
	{
		if (!(func == null))
		{
			_add.BeginPCall();
			_add.Push(self);
			_add.Push(func);
			_add.Push(obj);
			_add.PCall();
			_add.EndPCall();
		}
	}

	public void Remove(LuaFunction func, LuaTable obj)
	{
		if (!(func == null))
		{
			_remove.BeginPCall();
			_remove.Push(self);
			_remove.Push(func);
			_remove.Push(obj);
			_remove.PCall();
			_remove.EndPCall();
		}
	}
}

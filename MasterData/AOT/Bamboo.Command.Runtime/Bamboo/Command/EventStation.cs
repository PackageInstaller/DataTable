using System;
using System.Collections.Generic;

namespace Bamboo.Command;

public class EventStation
{
	private readonly int _id;

	private readonly EventStation _parent;

	private readonly EventOffice _office;

	private readonly int _depth;

	private readonly int _index;

	private readonly Dictionary<int, EventStation> _childrenMap = new Dictionary<int, EventStation>();

	private bool _isActive;

	public int ID => _id;

	public EventStation Parent => _parent;

	public int Depth => _depth;

	public int Index => _index;

	public int ChildCount => _childrenMap.Count;

	public bool IsActive => _isActive;

	internal EventStation(int id, EventStation parent, EventOffice office, int depth, int index)
	{
		_id = id;
		_parent = parent;
		_office = office;
		_depth = depth;
		_index = index;
	}

	internal void AddChild(EventStation child)
	{
		_childrenMap[child.ID] = child;
	}

	public void Send(int id)
	{
		if (_isActive)
		{
			_office.Send(this, id);
		}
	}

	public void Send<T>(int id, T arg)
	{
		if (_isActive)
		{
			_office.Send(this, id, arg);
		}
	}

	public void Send<T1, T2>(int id, T1 arg1, T2 arg2)
	{
		if (_isActive)
		{
			_office.Send(this, id, arg1, arg2);
		}
	}

	public void Send<T1, T2, T3>(int id, T1 arg1, T2 arg2, T3 arg3)
	{
		if (_isActive)
		{
			_office.Send(this, id, arg1, arg2, arg3);
		}
	}

	public void AddPeek(int id, Func<bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: false);
	}

	public void AddPeek<T>(int id, Func<T, bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: false);
	}

	public void AddPeek<T1, T2>(int id, Func<T1, T2, bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: false);
	}

	public void AddPeek<T1, T2, T3>(int id, Func<T1, T2, T3, bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: false);
	}

	public void AddPeekOnce(int id, Func<bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: true);
	}

	public void AddPeekOnce<T>(int id, Func<T, bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: true);
	}

	public void AddPeekOnce<T1, T2>(int id, Func<T1, T2, bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: true);
	}

	public void AddPeekOnce<T1, T2, T3>(int id, Func<T1, T2, T3, bool> action, int order = 0)
	{
		_office.AddPeek(id, order, this, action, isOnce: true);
	}

	public void RemovePeek(int id, Func<bool> action)
	{
		_office.RemovePeek(id, this, action);
	}

	public void RemovePeek<T>(int id, Func<T, bool> action)
	{
		_office.RemovePeek(id, this, action);
	}

	public void RemovePeek<T1, T2>(int id, Func<T1, T2, bool> action)
	{
		_office.RemovePeek(id, this, action);
	}

	public void RemovePeek<T1, T2, T3>(int id, Func<T1, T2, T3, bool> action)
	{
		_office.RemovePeek(id, this, action);
	}

	public void RemoveAllPeek()
	{
		_office.RemovePeek(this);
	}

	public void Active()
	{
		_isActive = true;
	}

	public void Unactive()
	{
		if (_isActive)
		{
			RemoveAllPeek();
			_isActive = false;
		}
	}
}

using System;
using System.Collections.Generic;

namespace ACT.Battle;

internal class VisualChannel<T> where T : VisualEntryBase
{
	private readonly SortedDictionary<int, LinkedList<T>> _byPriority = new SortedDictionary<int, LinkedList<T>>(Comparer<int>.Create((int a, int b) => b.CompareTo(a)));

	private readonly Dictionary<Guid, (int priority, LinkedListNode<T> node)> _lookup = new Dictionary<Guid, (int, LinkedListNode<T>)>();

	private T _current;

	public Guid? CurrentId => _current?.Id;

	public int? CurrentPriority => _current?._priority;

	public Guid Add(T entry)
	{
		if (entry == null)
		{
			return default;
		}
		if (!_byPriority.TryGetValue(entry._priority, out var value))
		{
			value = new LinkedList<T>();
			_byPriority[entry._priority] = value;
		}
		LinkedListNode<T> item = value.AddLast(entry);
		_lookup[entry.Id] = (entry._priority, item);
		TryPromote(entry);
		return entry.Id;
	}

	public bool Remove(Guid id)
	{
		if (!_lookup.TryGetValue(id, out (int, LinkedListNode<T>) value))
		{
			return false;
		}
		(int, LinkedListNode<T>) tuple = value;
		int item = tuple.Item1;
		LinkedListNode<T> item2 = tuple.Item2;
		T value2 = item2.Value;
		int num;
		if (_current != null)
		{
			num = ((_current.Id == value2.Id) ? 1 : 0);
			if (num != 0)
			{
				_current.Hide();
				_current = null;
			}
		}
		else
		{
			num = 0;
		}
		LinkedList<T> linkedList = _byPriority[item];
		linkedList.Remove(item2);
		if (linkedList.Count == 0)
		{
			_byPriority.Remove(item);
		}
		_lookup.Remove(id);
		if (num != 0)
		{
			ShowBestCandidate();
		}
		return true;
	}

	private void TryPromote(T candidate)
	{
		if (_current == null)
		{
			_current = candidate;
			_current.Show();
		}
		else if (candidate._priority > _current._priority || candidate._priority == _current._priority)
		{
			_current.Hide();
			_current = candidate;
			_current.Show();
		}
		else
		{
			candidate.Hide();
		}
	}

	private void ShowBestCandidate()
	{
		foreach (KeyValuePair<int, LinkedList<T>> item in _byPriority)
		{
			LinkedList<T> value = item.Value;
			if (value.Count == 0)
			{
				continue;
			}
			for (LinkedListNode<T> linkedListNode = value.Last; linkedListNode != null; linkedListNode = linkedListNode.Previous)
			{
				T value2 = linkedListNode.Value;
				if (value2 != null)
				{
					_current = value2;
					_current.Show();
					return;
				}
			}
		}
		_current = null;
	}

	public void ClearAll()
	{
		_current?.Hide();
		_current = null;
		_byPriority.Clear();
		_lookup.Clear();
	}
}

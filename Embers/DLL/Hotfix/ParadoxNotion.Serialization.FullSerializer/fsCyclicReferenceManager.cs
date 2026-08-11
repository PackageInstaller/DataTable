using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace ParadoxNotion.Serialization.FullSerializer;

public class fsCyclicReferenceManager
{
	private class ObjectReferenceEqualityComparator : IEqualityComparer<object>
	{
		public static readonly IEqualityComparer<object> Instance = new ObjectReferenceEqualityComparator();

		bool IEqualityComparer<object>.Equals(object x, object y)
		{
			return x == y;
		}

		int IEqualityComparer<object>.GetHashCode(object obj)
		{
			return RuntimeHelpers.GetHashCode(obj);
		}
	}

	private Dictionary<object, int> _objectIds;

	private int _nextId;

	private Dictionary<int, object> _marked;

	private int _depth;

	public fsCyclicReferenceManager()
	{
		_objectIds = new Dictionary<object, int>(ObjectReferenceEqualityComparator.Instance);
		_marked = new Dictionary<int, object>();
	}

	public void Clear()
	{
		_depth = 0;
		_nextId = 0;
		_objectIds.Clear();
		_marked.Clear();
	}

	public bool Enter()
	{
		_depth++;
		return _depth == 1;
	}

	public bool Exit()
	{
		_depth--;
		if (_depth == 0)
		{
			_nextId = 0;
			_objectIds.Clear();
			_marked.Clear();
		}
		if (_depth < 0)
		{
			_depth = 0;
			throw new InvalidOperationException("Internal Error - Mismatched Enter/Exit");
		}
		return _depth == 0;
	}

	public object GetReferenceObject(int id)
	{
		object value = null;
		if (!_marked.TryGetValue(id, out value))
		{
			throw new InvalidOperationException("Internal Deserialization Error - Object definition has not been encountered for object with id=" + id + "; have you reordered or modified the serialized data? If this is an issue with an unmodified Full Json implementation and unmodified serialization data, please report an issue with an included test case.");
		}
		return value;
	}

	public void AddReferenceWithId(int id, object reference)
	{
		_marked[id] = reference;
	}

	public int GetReferenceId(object item)
	{
		if (!_objectIds.TryGetValue(item, out var value))
		{
			value = _nextId++;
			_objectIds[item] = value;
		}
		return value;
	}

	public bool IsReference(object item)
	{
		return _marked.ContainsKey(GetReferenceId(item));
	}

	public void MarkSerialized(object item)
	{
		int referenceId = GetReferenceId(item);
		if (_marked.ContainsKey(referenceId))
		{
			throw new InvalidOperationException("Internal Error - " + item?.ToString() + " has already been marked as serialized");
		}
		_marked[referenceId] = item;
	}
}

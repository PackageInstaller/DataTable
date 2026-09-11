using System.Collections;
using System.Collections.Generic;

namespace System.ComponentModel;

public class PropertyDescriptorCollection : ICollection, IEnumerable, IList, IDictionary
{
	private class PropertyDescriptorEnumerator : IDictionaryEnumerator, IEnumerator
	{
		private PropertyDescriptorCollection _owner;

		private int _index = -1;

		public object Current => Entry;

		public DictionaryEntry Entry
		{
			get
			{
				PropertyDescriptor propertyDescriptor = _owner[_index];
				return new DictionaryEntry(propertyDescriptor.Name, propertyDescriptor);
			}
		}

		public object Key => _owner[_index].Name;

		public object Value => _owner[_index].Name;

		public PropertyDescriptorEnumerator(PropertyDescriptorCollection owner)
		{
			_owner = owner;
		}

		public bool MoveNext()
		{
			if (_index < _owner.Count - 1)
			{
				_index++;
				return true;
			}
			return false;
		}

		public void Reset()
		{
			_index = -1;
		}
	}

	public static readonly PropertyDescriptorCollection Empty = new PropertyDescriptorCollection(null, readOnly: true);

	private IDictionary _cachedFoundProperties;

	private bool _cachedIgnoreCase;

	private PropertyDescriptor[] _properties;

	private readonly string[] _namedSort;

	private readonly IComparer _comparer;

	private bool _propsOwned;

	private bool _needSort;

	private bool _readOnly;

	private readonly object _internalSyncObject = new object();

	public int Count { get; private set; }

	public virtual PropertyDescriptor this[int index]
	{
		get
		{
			if (index >= Count)
			{
				throw new IndexOutOfRangeException();
			}
			EnsurePropsOwned();
			return _properties[index];
		}
	}

	public virtual PropertyDescriptor this[string name] => Find(name, ignoreCase: false);

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot => null;

	int ICollection.Count => Count;

	bool IDictionary.IsFixedSize => _readOnly;

	bool IDictionary.IsReadOnly => _readOnly;

	object IDictionary.this[object key]
	{
		get
		{
			if (key is string)
			{
				return this[(string)key];
			}
			return null;
		}
		set
		{
			if (_readOnly)
			{
				throw new NotSupportedException();
			}
			if (value != null && !(value is PropertyDescriptor))
			{
				throw new ArgumentException("value");
			}
			int num = -1;
			if (key is int)
			{
				num = (int)key;
				if (num < 0 || num >= Count)
				{
					throw new IndexOutOfRangeException();
				}
			}
			else
			{
				if (!(key is string))
				{
					throw new ArgumentException("key");
				}
				for (int i = 0; i < Count; i++)
				{
					if (_properties[i].Name.Equals((string)key))
					{
						num = i;
						break;
					}
				}
			}
			if (num == -1)
			{
				Add((PropertyDescriptor)value);
				return;
			}
			EnsurePropsOwned();
			_properties[num] = (PropertyDescriptor)value;
			if (_cachedFoundProperties != null && key is string)
			{
				_cachedFoundProperties[key] = value;
			}
		}
	}

	ICollection IDictionary.Keys
	{
		get
		{
			string[] array = new string[Count];
			for (int i = 0; i < Count; i++)
			{
				array[i] = _properties[i].Name;
			}
			return array;
		}
	}

	ICollection IDictionary.Values
	{
		get
		{
			if (_properties.Length != Count)
			{
				PropertyDescriptor[] array = new PropertyDescriptor[Count];
				Array.Copy(_properties, 0, array, 0, Count);
				return array;
			}
			return (ICollection)_properties.Clone();
		}
	}

	bool IList.IsReadOnly => _readOnly;

	bool IList.IsFixedSize => _readOnly;

	object IList.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			if (_readOnly)
			{
				throw new NotSupportedException();
			}
			if (index >= Count)
			{
				throw new IndexOutOfRangeException();
			}
			if (value != null && !(value is PropertyDescriptor))
			{
				throw new ArgumentException("value");
			}
			EnsurePropsOwned();
			_properties[index] = (PropertyDescriptor)value;
		}
	}

	public PropertyDescriptorCollection(PropertyDescriptor[] properties)
	{
		if (properties == null)
		{
			_properties = Array.Empty<PropertyDescriptor>();
			Count = 0;
		}
		else
		{
			_properties = properties;
			Count = properties.Length;
		}
		_propsOwned = true;
	}

	public PropertyDescriptorCollection(PropertyDescriptor[] properties, bool readOnly)
		: this(properties)
	{
		_readOnly = readOnly;
	}

	public int Add(PropertyDescriptor value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		EnsureSize(Count + 1);
		_properties[Count++] = value;
		return Count - 1;
	}

	public void Clear()
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		Count = 0;
		_cachedFoundProperties = null;
	}

	public bool Contains(PropertyDescriptor value)
	{
		return IndexOf(value) >= 0;
	}

	public void CopyTo(Array array, int index)
	{
		EnsurePropsOwned();
		Array.Copy(_properties, 0, array, index, Count);
	}

	private void EnsurePropsOwned()
	{
		if (!_propsOwned)
		{
			_propsOwned = true;
			if (_properties != null)
			{
				PropertyDescriptor[] array = new PropertyDescriptor[Count];
				Array.Copy(_properties, 0, array, 0, Count);
				_properties = array;
			}
		}
		if (_needSort)
		{
			_needSort = false;
			InternalSort(_namedSort);
		}
	}

	private void EnsureSize(int sizeNeeded)
	{
		if (sizeNeeded > _properties.Length)
		{
			if (_properties.Length == 0)
			{
				Count = 0;
				_properties = new PropertyDescriptor[sizeNeeded];
				return;
			}
			EnsurePropsOwned();
			PropertyDescriptor[] array = new PropertyDescriptor[Math.Max(sizeNeeded, _properties.Length * 2)];
			Array.Copy(_properties, 0, array, 0, Count);
			_properties = array;
		}
	}

	public virtual PropertyDescriptor Find(string name, bool ignoreCase)
	{
		lock (_internalSyncObject)
		{
			PropertyDescriptor result = null;
			if (_cachedFoundProperties == null || _cachedIgnoreCase != ignoreCase)
			{
				_cachedIgnoreCase = ignoreCase;
				if (ignoreCase)
				{
					_cachedFoundProperties = new Hashtable(StringComparer.OrdinalIgnoreCase);
				}
				else
				{
					_cachedFoundProperties = new Hashtable();
				}
			}
			object obj = _cachedFoundProperties[name];
			if (obj != null)
			{
				return (PropertyDescriptor)obj;
			}
			for (int i = 0; i < Count; i++)
			{
				if (ignoreCase)
				{
					if (string.Equals(_properties[i].Name, name, StringComparison.OrdinalIgnoreCase))
					{
						_cachedFoundProperties[name] = _properties[i];
						result = _properties[i];
						break;
					}
				}
				else if (_properties[i].Name.Equals(name))
				{
					_cachedFoundProperties[name] = _properties[i];
					result = _properties[i];
					break;
				}
			}
			return result;
		}
	}

	public int IndexOf(PropertyDescriptor value)
	{
		return Array.IndexOf(_properties, value, 0, Count);
	}

	public void Insert(int index, PropertyDescriptor value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		EnsureSize(Count + 1);
		if (index < Count)
		{
			Array.Copy(_properties, index, _properties, index + 1, Count - index);
		}
		_properties[index] = value;
		Count++;
	}

	public void Remove(PropertyDescriptor value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		int num = IndexOf(value);
		if (num != -1)
		{
			RemoveAt(num);
		}
	}

	public void RemoveAt(int index)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		if (index < Count - 1)
		{
			Array.Copy(_properties, index + 1, _properties, index, Count - index - 1);
		}
		_properties[Count - 1] = null;
		Count--;
	}

	protected void InternalSort(string[] names)
	{
		if (_properties.Length == 0)
		{
			return;
		}
		InternalSort(_comparer);
		if (names == null || names.Length == 0)
		{
			return;
		}
		List<PropertyDescriptor> list = new List<PropertyDescriptor>(_properties);
		int num = 0;
		int num2 = _properties.Length;
		for (int i = 0; i < names.Length; i++)
		{
			for (int j = 0; j < num2; j++)
			{
				PropertyDescriptor propertyDescriptor = list[j];
				if (propertyDescriptor != null && propertyDescriptor.Name.Equals(names[i]))
				{
					_properties[num++] = propertyDescriptor;
					list[j] = null;
					break;
				}
			}
		}
		for (int k = 0; k < num2; k++)
		{
			if (list[k] != null)
			{
				_properties[num++] = list[k];
			}
		}
	}

	protected void InternalSort(IComparer sorter)
	{
		if (sorter == null)
		{
			TypeDescriptor.SortDescriptorArray(this);
		}
		else
		{
			Array.Sort(_properties, sorter);
		}
	}

	public virtual IEnumerator GetEnumerator()
	{
		EnsurePropsOwned();
		if (_properties.Length != Count)
		{
			PropertyDescriptor[] array = new PropertyDescriptor[Count];
			Array.Copy(_properties, 0, array, 0, Count);
			return array.GetEnumerator();
		}
		return _properties.GetEnumerator();
	}

	void IList.Clear()
	{
		Clear();
	}

	void IDictionary.Clear()
	{
		Clear();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	void IList.RemoveAt(int index)
	{
		RemoveAt(index);
	}

	void IDictionary.Add(object key, object value)
	{
		if (!(value is PropertyDescriptor value2))
		{
			throw new ArgumentException("value");
		}
		Add(value2);
	}

	bool IDictionary.Contains(object key)
	{
		if (key is string)
		{
			return this[(string)key] != null;
		}
		return false;
	}

	IDictionaryEnumerator IDictionary.GetEnumerator()
	{
		return new PropertyDescriptorEnumerator(this);
	}

	void IDictionary.Remove(object key)
	{
		if (key is string)
		{
			PropertyDescriptor propertyDescriptor = this[(string)key];
			if (propertyDescriptor != null)
			{
				((IList)this).Remove((object)propertyDescriptor);
			}
		}
	}

	int IList.Add(object value)
	{
		return Add((PropertyDescriptor)value);
	}

	bool IList.Contains(object value)
	{
		return Contains((PropertyDescriptor)value);
	}

	int IList.IndexOf(object value)
	{
		return IndexOf((PropertyDescriptor)value);
	}

	void IList.Insert(int index, object value)
	{
		Insert(index, (PropertyDescriptor)value);
	}

	void IList.Remove(object value)
	{
		Remove((PropertyDescriptor)value);
	}
}

using System.Runtime.Serialization;
using System.Text;

namespace System.Collections.Specialized;

[Serializable]
public class NameValueCollection : NameObjectCollectionBase
{
	private string[] _all;

	private string[] _allKeys;

	public string this[string name]
	{
		get
		{
			return Get(name);
		}
		set
		{
			Set(name, value);
		}
	}

	public virtual string[] AllKeys
	{
		get
		{
			if (_allKeys == null)
			{
				_allKeys = BaseGetAllKeys();
			}
			return _allKeys;
		}
	}

	public NameValueCollection()
	{
	}

	public NameValueCollection(int capacity, IEqualityComparer equalityComparer)
		: base(capacity, equalityComparer)
	{
	}

	protected NameValueCollection(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	protected void InvalidateCachedArrays()
	{
		_all = null;
		_allKeys = null;
	}

	private static string GetAsOneString(ArrayList list)
	{
		int num = list?.Count ?? 0;
		if (num == 1)
		{
			return (string)list[0];
		}
		if (num > 1)
		{
			StringBuilder stringBuilder = new StringBuilder((string)list[0]);
			for (int i = 1; i < num; i++)
			{
				stringBuilder.Append(',');
				stringBuilder.Append((string)list[i]);
			}
			return stringBuilder.ToString();
		}
		return null;
	}

	private static string[] GetAsStringArray(ArrayList list)
	{
		int num = list?.Count ?? 0;
		if (num == 0)
		{
			return null;
		}
		string[] array = new string[num];
		list.CopyTo(0, array, 0, num);
		return array;
	}

	public virtual void Add(string name, string value)
	{
		if (base.IsReadOnly)
		{
			throw new NotSupportedException("Collection is read-only.");
		}
		InvalidateCachedArrays();
		ArrayList arrayList = (ArrayList)BaseGet(name);
		if (arrayList == null)
		{
			arrayList = new ArrayList(1);
			if (value != null)
			{
				arrayList.Add(value);
			}
			BaseAdd(name, arrayList);
		}
		else if (value != null)
		{
			arrayList.Add(value);
		}
	}

	public virtual string Get(string name)
	{
		return GetAsOneString((ArrayList)BaseGet(name));
	}

	public virtual string[] GetValues(string name)
	{
		return GetAsStringArray((ArrayList)BaseGet(name));
	}

	public virtual void Set(string name, string value)
	{
		if (base.IsReadOnly)
		{
			throw new NotSupportedException("Collection is read-only.");
		}
		InvalidateCachedArrays();
		ArrayList arrayList = new ArrayList(1);
		arrayList.Add(value);
		BaseSet(name, arrayList);
	}

	public virtual void Remove(string name)
	{
		InvalidateCachedArrays();
		BaseRemove(name);
	}

	public virtual string Get(int index)
	{
		return GetAsOneString((ArrayList)BaseGet(index));
	}

	public virtual string GetKey(int index)
	{
		return BaseGetKey(index);
	}

	internal NameValueCollection(DBNull dummy)
		: base(dummy)
	{
	}
}

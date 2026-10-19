using System.Collections.Generic;

namespace System.Collections.Specialized;

[Serializable]
public class StringDictionary : IEnumerable
{
	internal Hashtable contents = new Hashtable();

	public virtual int Count => contents.Count;

	public virtual string this[string key]
	{
		get
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			return (string)contents[key.ToLowerInvariant()];
		}
		set
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			contents[key.ToLowerInvariant()] = value;
		}
	}

	public virtual ICollection Keys => contents.Keys;

	public virtual ICollection Values => contents.Values;

	public virtual void Add(string key, string value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		contents.Add(key.ToLowerInvariant(), value);
	}

	public virtual void Clear()
	{
		contents.Clear();
	}

	public virtual bool ContainsKey(string key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		return contents.ContainsKey(key.ToLowerInvariant());
	}

	public virtual bool ContainsValue(string value)
	{
		return contents.ContainsValue(value);
	}

	public virtual IEnumerator GetEnumerator()
	{
		return contents.GetEnumerator();
	}

	public virtual void Remove(string key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		contents.Remove(key.ToLowerInvariant());
	}

	internal IDictionary<string, string> AsGenericDictionary()
	{
		return new GenericAdapter(this);
	}
}

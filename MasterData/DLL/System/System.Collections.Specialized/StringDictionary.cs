namespace System.Collections.Specialized;

[Serializable]
public class StringDictionary : IEnumerable
{
	internal Hashtable contents = new Hashtable();

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

	public virtual void Add(string key, string value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		contents.Add(key.ToLowerInvariant(), value);
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
}

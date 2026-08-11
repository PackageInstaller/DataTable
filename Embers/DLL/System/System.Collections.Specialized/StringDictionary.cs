using System.Reflection;

namespace System.Collections.Specialized;

[Serializable]
[DefaultMember("Item")]
public class StringDictionary : IEnumerable
{
	internal Hashtable contents = new Hashtable();

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
}

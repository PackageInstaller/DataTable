using System.Reflection;

namespace System.Collections.Specialized;

[DefaultMember("Item")]
internal class CaseSensitiveStringDictionary : StringDictionary
{
	public override void Add(string key, string value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		contents.Add(key, value);
	}
}

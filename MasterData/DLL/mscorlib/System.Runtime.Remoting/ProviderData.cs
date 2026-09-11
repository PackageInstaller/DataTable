using System.Collections;
using System.Runtime.Remoting.Channels;

namespace System.Runtime.Remoting;

internal class ProviderData
{
	internal string Ref;

	internal string Type;

	internal string Id;

	internal Hashtable CustomProperties = new Hashtable();

	internal IList CustomData;

	public void CopyFrom(ProviderData other)
	{
		if (Ref == null)
		{
			Ref = other.Ref;
		}
		if (Id == null)
		{
			Id = other.Id;
		}
		if (Type == null)
		{
			Type = other.Type;
		}
		foreach (DictionaryEntry customProperty in other.CustomProperties)
		{
			if (!CustomProperties.ContainsKey(customProperty.Key))
			{
				CustomProperties[customProperty.Key] = customProperty.Value;
			}
		}
		if (other.CustomData == null)
		{
			return;
		}
		if (CustomData == null)
		{
			CustomData = new ArrayList();
		}
		foreach (SinkProviderData customDatum in other.CustomData)
		{
			CustomData.Add(customDatum);
		}
	}
}

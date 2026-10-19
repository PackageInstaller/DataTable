using System;

namespace Sirenix.Serialization;

[Serializable]
public struct SerializationNode
{
	public string Name;

	public EntryType Entry;

	public string Data;
}

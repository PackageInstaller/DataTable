using System;

namespace Unity.VisualScripting.Community;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Code.InterfacePropertyItem")]
[Inspectable]
public sealed class InterfacePropertyItem
{
	[Inspectable]
	public string name;

	[Inspectable]
	public Type type = typeof(object);

	[Inspectable]
	public bool get = true;

	[Inspectable]
	public bool set = true;
}

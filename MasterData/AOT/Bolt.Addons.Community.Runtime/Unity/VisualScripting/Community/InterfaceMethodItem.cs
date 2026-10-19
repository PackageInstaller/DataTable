using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Utility;

namespace Unity.VisualScripting.Community;

[Serializable]
[Inspectable]
[RenamedFrom("Bolt.Addons.Community.Code.InterfaceMethodItem")]
public sealed class InterfaceMethodItem
{
	[Inspectable]
	public string name;

	[Inspectable]
	public Type returnType = typeof(object);

	[InspectorWide]
	[Inspectable]
	public List<TypeParam> parameters = new List<TypeParam>();
}

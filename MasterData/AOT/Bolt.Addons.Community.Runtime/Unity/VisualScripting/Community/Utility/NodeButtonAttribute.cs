using System;

namespace Unity.VisualScripting.Community.Utility;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
[RenamedFrom("Bolt.Community.Addons.Utility.UnitButtonAttribute")]
public class NodeButtonAttribute : Attribute
{
	public string action;

	public NodeButtonAttribute(string action)
	{
		this.action = action;
	}
}

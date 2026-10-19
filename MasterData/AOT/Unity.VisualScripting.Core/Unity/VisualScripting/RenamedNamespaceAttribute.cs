using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true)]
public sealed class RenamedNamespaceAttribute : Attribute
{
	public string previousName { get; }

	public string newName { get; }

	public RenamedNamespaceAttribute(string previousName, string newName)
	{
		this.previousName = previousName;
		this.newName = newName;
	}
}

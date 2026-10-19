using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true)]
public sealed class RenamedAssemblyAttribute : Attribute
{
	public string previousName { get; }

	public string newName { get; }

	public RenamedAssemblyAttribute(string previousName, string newName)
	{
		this.previousName = previousName;
		this.newName = newName;
	}
}

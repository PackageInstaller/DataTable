using System;

namespace Yarn.Unity;

[AttributeUsage(AttributeTargets.Method, Inherited = false)]
public class YarnActionAttribute : Attribute
{
	public string Name { get; set; }

	public YarnActionAttribute(string name = null)
	{
		Name = name;
	}
}

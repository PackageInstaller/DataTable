using System;

namespace Yarn.Unity;

[AttributeUsage(AttributeTargets.Parameter, Inherited = false)]
public class YarnParameterAttribute : Attribute
{
	public string Injector { get; set; }

	public YarnParameterAttribute(string injector)
	{
		Injector = injector;
	}
}

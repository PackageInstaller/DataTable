using System;

namespace Yarn.Unity;

[AttributeUsage(AttributeTargets.Class, Inherited = false)]
public class YarnStateInjectorAttribute : Attribute
{
	public string Injector { get; set; }

	public YarnStateInjectorAttribute(string injector)
	{
		Injector = injector;
	}
}

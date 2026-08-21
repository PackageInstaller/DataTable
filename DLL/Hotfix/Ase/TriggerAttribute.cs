using System;

namespace Ase;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = true)]
public class TriggerAttribute : Attribute
{
	public string TriggerName { get; private set; }

	public TriggerAttribute(string key)
	{
		TriggerName = key;
	}
}

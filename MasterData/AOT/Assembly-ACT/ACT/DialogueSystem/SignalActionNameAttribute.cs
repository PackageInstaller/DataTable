using System;

namespace ACT.DialogueSystem;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public class SignalActionNameAttribute : Attribute
{
	public string name;

	public string desc;

	public SignalActionNameAttribute(string name)
	{
		this.name = name;
	}
}

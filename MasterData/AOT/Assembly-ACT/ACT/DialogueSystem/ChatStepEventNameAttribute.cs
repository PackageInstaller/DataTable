using System;

namespace ACT.DialogueSystem;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public class ChatStepEventNameAttribute : Attribute
{
	public string name;

	public string desc;

	public ChatStepEventNameAttribute(string name)
	{
		this.name = name;
	}
}

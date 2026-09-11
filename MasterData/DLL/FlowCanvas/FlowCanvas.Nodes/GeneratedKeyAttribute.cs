using System;

namespace FlowCanvas.Nodes;

[AttributeUsage(AttributeTargets.Class)]
public class GeneratedKeyAttribute : Attribute
{
	private string memberString;

	public string MemberName => memberString;

	public GeneratedKeyAttribute(string memberName)
	{
		memberString = memberName;
	}
}

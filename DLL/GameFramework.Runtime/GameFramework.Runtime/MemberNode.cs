using System;
using System.Reflection;
using System.Text;

namespace GameFramework.Runtime;

[Serializable]
public class MemberNode : IPathNode
{
	private readonly MemberInfo memberInfo;

	private readonly string name;

	private readonly Type type;

	private readonly bool isStatic;

	public bool IsStatic => isStatic;

	public Type Type => type;

	public string Name => name;

	public MemberInfo MemberInfo => memberInfo;

	public MemberNode(string name)
		: this(null, name, isStatic: false)
	{
	}

	public MemberNode(Type type, string name, bool isStatic)
	{
		this.name = name;
		this.type = type;
		this.isStatic = isStatic;
	}

	public MemberNode(MemberInfo memberInfo)
	{
		this.memberInfo = memberInfo;
		name = memberInfo.Name;
		type = memberInfo.DeclaringType;
		isStatic = memberInfo.IsStatic();
	}

	public void AppendTo(StringBuilder output)
	{
		if (output.Length > 0)
		{
			output.Append(".");
		}
		if (IsStatic)
		{
			output.Append(type.FullName).Append(".");
		}
		output.Append(Name);
	}

	public override string ToString()
	{
		return "MemberNode:" + ((Name == null) ? "null" : Name);
	}
}

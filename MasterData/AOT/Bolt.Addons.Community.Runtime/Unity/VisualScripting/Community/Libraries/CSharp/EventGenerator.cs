using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.EventGenerator")]
public sealed class EventGenerator : MemberGenerator
{
	private EventGenerator()
	{
	}

	public static EventGenerator Event(AccessModifier scope, Type returnType, string name)
	{
		return new EventGenerator
		{
			scope = scope,
			returnType = returnType,
			name = name
		};
	}

	public override string Generate(int indent)
	{
		return CodeBuilder.Indent(indent) + scope.AsString() + " event " + returnType.Name + " " + name + ";";
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (!returnType.Is().PrimitiveStringOrVoid())
		{
			list.Add(returnType.Namespace);
		}
		return list;
	}
}

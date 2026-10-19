using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.ConstructorGenerator")]
public sealed class ConstructorGenerator : MemberBodyGenerator
{
	private ConstructorModifier modifier;

	private List<(bool hasBase, ParameterGenerator generator)> parameters = new List<(bool, ParameterGenerator)>();

	private List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	private string body;

	private ConstructorGenerator()
	{
	}

	public static ConstructorGenerator Constructor(AccessModifier scope, ConstructorModifier modifier, string name)
	{
		return new ConstructorGenerator
		{
			scope = scope,
			modifier = modifier,
			name = name
		};
	}

	protected sealed override string GenerateBefore(int indent)
	{
		string text = string.Empty;
		foreach (AttributeGenerator attribute in attributes)
		{
			text = text + attribute.Generate(indent) + "\n";
		}
		string text2 = ((modifier == ConstructorModifier.None) ? string.Empty : " ");
		string text3 = string.Empty;
		string text4 = string.Empty;
		for (int i = 0; i < parameters.Count; i++)
		{
			text3 += parameters[i].generator.Generate(0);
			if (i < parameters.Count - 1)
			{
				text3 += ", ";
			}
			if (parameters[i].hasBase)
			{
				text4 += parameters[i].generator.name;
				if (i < parameters.Count - 1)
				{
					text4 += ", ";
				}
			}
		}
		return text + CodeBuilder.Indent(indent) + scope.AsString().ToLower().ConstructHighlight() + " " + modifier.AsString().ConstructHighlight() + text2 + name.LegalMemberName().TypeHighlight() + "(" + text3 + ")" + (string.IsNullOrEmpty(text4) ? string.Empty : (" : base(" + text4 + ")"));
	}

	protected sealed override string GenerateBody(int indent)
	{
		if (!string.IsNullOrEmpty(body))
		{
			if (!body.Contains("\n"))
			{
				return CodeBuilder.Indent(indent) + body;
			}
			return body.Replace("\n", "\n" + CodeBuilder.Indent(indent)).Insert(0, CodeBuilder.Indent(indent));
		}
		return string.Empty;
	}

	protected sealed override string GenerateAfter(int indent)
	{
		return string.Empty;
	}

	public ConstructorGenerator Body(string body)
	{
		this.body = body;
		return this;
	}

	public ConstructorGenerator AddParameter(bool hasBase, ParameterGenerator parameter)
	{
		parameters.Add((hasBase, parameter));
		return this;
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (returnType != typeof(void) && !returnType.IsPrimitive)
		{
			list.Add(returnType.Namespace);
		}
		for (int i = 0; i < parameters.Count; i++)
		{
			if (!list.Contains(parameters[i].generator.type.Namespace) && !parameters[i].generator.type.Is().PrimitiveStringOrVoid())
			{
				list.Add(parameters[i].generator.type.Namespace);
			}
		}
		return list;
	}
}

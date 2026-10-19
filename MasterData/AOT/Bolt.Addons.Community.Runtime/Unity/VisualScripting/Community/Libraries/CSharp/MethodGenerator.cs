using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.MethodGenerator")]
public sealed class MethodGenerator : BodyGenerator
{
	public AccessModifier scope;

	public MethodModifier modifier;

	public string name;

	public Type returnType;

	public List<ParameterGenerator> parameters = new List<ParameterGenerator>();

	public List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	public string body;

	private MethodGenerator()
	{
	}

	public static MethodGenerator Method(AccessModifier scope, MethodModifier modifier, Type returnType, string name)
	{
		return new MethodGenerator
		{
			scope = scope,
			modifier = modifier,
			name = name,
			returnType = returnType
		};
	}

	protected sealed override string GenerateBefore(int indent)
	{
		string text = string.Empty;
		foreach (AttributeGenerator attribute in attributes)
		{
			text = text + attribute.Generate(indent) + "\n";
		}
		string text2 = ((modifier == MethodModifier.None) ? string.Empty : " ");
		return text + CodeBuilder.Indent(indent) + scope.AsString().ToLower().ConstructHighlight() + " " + modifier.AsString().ConstructHighlight() + text2 + returnType.As().CSharpName() + " " + name.LegalMemberName() + parameters.Parameters();
	}

	protected sealed override string GenerateBody(int indent)
	{
		if (string.IsNullOrEmpty(name))
		{
			return string.Empty;
		}
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

	public MethodGenerator AddAttribute(AttributeGenerator generator)
	{
		attributes.Add(generator);
		return this;
	}

	public MethodGenerator Body(string body)
	{
		this.body = body;
		return this;
	}

	public MethodGenerator AddParameter(ParameterGenerator parameter)
	{
		parameters.Add(parameter);
		return this;
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (!list.Contains(returnType.Namespace) && !returnType.Is().PrimitiveStringOrVoid())
		{
			list.Add(returnType.Namespace);
		}
		for (int i = 0; i < attributes.Count; i++)
		{
			list.MergeUnique(attributes[i].Usings());
		}
		for (int j = 0; j < parameters.Count; j++)
		{
			if (!parameters[j].useAssemblyQualifiedType && !list.Contains(parameters[j].Using()) && !parameters[j].type.Is().PrimitiveStringOrVoid())
			{
				list.Add(parameters[j].Using());
			}
		}
		return list;
	}
}

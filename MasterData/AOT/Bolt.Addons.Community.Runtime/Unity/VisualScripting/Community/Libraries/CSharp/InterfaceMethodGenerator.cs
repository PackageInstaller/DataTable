using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.InterfaceMethodGenerator")]
public sealed class InterfaceMethodGenerator : ConstructGenerator
{
	public string name;

	public Type returnType;

	public List<ParameterGenerator> parameters = new List<ParameterGenerator>();

	public override string Generate(int indent)
	{
		if (string.IsNullOrEmpty(name))
		{
			return string.Empty;
		}
		string text = returnType.As().CSharpName() + " " + name.LegalMemberName() + "(";
		for (int i = 0; i < parameters.Count; i++)
		{
			text += parameters[i].Generate(indent);
		}
		return text + ");";
	}

	internal InterfaceMethodGenerator()
	{
	}

	public static InterfaceMethodGenerator Method(string name, Type returnType)
	{
		return new InterfaceMethodGenerator
		{
			name = name,
			returnType = returnType
		};
	}

	public InterfaceMethodGenerator AddParameter(ParameterGenerator generator)
	{
		parameters.Add(generator);
		return this;
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (returnType != null && returnType != typeof(void) && !returnType.IsPrimitive)
		{
			list.Add(returnType.Namespace);
		}
		for (int i = 0; i < parameters.Count; i++)
		{
			list.MergeUnique(parameters[i].Usings());
		}
		return list;
	}
}

using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.ParameterGenerator")]
public sealed class ParameterGenerator : ConstructGenerator
{
	public string name;

	public Type type;

	public string assemblyQualifiedType;

	public bool useAssemblyQualifiedType;

	public bool isParameters;

	public bool isLiteral;

	public ParameterModifier modifier;

	public override string Generate(int indent)
	{
		if (!useAssemblyQualifiedType && type == null)
		{
			return "/* Parameter type is null */".WarningHighlight();
		}
		string text = (isParameters ? "params ".ConstructHighlight() : string.Empty);
		if (!useAssemblyQualifiedType)
		{
			return text + type.As().CSharpName() + " " + name.LegalMemberName().VariableHighlight();
		}
		return text + assemblyQualifiedType + " " + name.VariableHighlight();
	}

	private ParameterGenerator()
	{
	}

	public static ParameterGenerator Parameter(string name, Type type, ParameterModifier modifier, bool isLiteral = false, bool isParameters = false)
	{
		return new ParameterGenerator
		{
			name = name,
			type = type,
			modifier = modifier,
			isLiteral = isLiteral,
			isParameters = isParameters,
			useAssemblyQualifiedType = false
		};
	}

	public static ParameterGenerator Parameter(string name, string assemblyQualifiedType, ParameterModifier modifier, bool isLiteral = false, bool isParameters = false)
	{
		return new ParameterGenerator
		{
			name = name,
			assemblyQualifiedType = assemblyQualifiedType,
			useAssemblyQualifiedType = true,
			modifier = modifier,
			isLiteral = isLiteral,
			isParameters = isParameters
		};
	}

	public string Using()
	{
		if (useAssemblyQualifiedType || type == null)
		{
			return string.Empty;
		}
		if (!(type == typeof(void)) && !(type == typeof(Void)) && !type.IsPrimitive)
		{
			return type.Namespace;
		}
		return string.Empty;
	}

	public override List<string> Usings()
	{
		return new List<string>();
	}
}

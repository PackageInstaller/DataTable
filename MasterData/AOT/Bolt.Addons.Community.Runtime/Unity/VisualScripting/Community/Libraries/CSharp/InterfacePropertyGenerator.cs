using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.InterfacePropertyGenerator")]
public sealed class InterfacePropertyGenerator : ConstructGenerator
{
	public string name;

	public Type type = typeof(object);

	public bool withNamespace;

	public string stringNamespace;

	public string stringType;

	public bool isStringType;

	public HUMType_Children.HighlightType highlightType;

	public string get;

	public string set;

	public List<string> definedUsings = new List<string>();

	public override string Generate(int indent)
	{
		return ((!isStringType) ? type.As().CSharpName() : (withNamespace ? (stringNamespace.SlashesToPeriods().OnNotNullOrEmpty(string.Empty) + stringType.WithHighlight(highlightType)) : stringType.WithHighlight(highlightType))) + " " + name.LegalMemberName() + " { " + get + set + "}";
	}

	private InterfacePropertyGenerator()
	{
	}

	public static InterfacePropertyGenerator Property(string name, Type type, bool get, bool set, HUMType_Children.HighlightType highlightType = HUMType_Children.HighlightType.Type)
	{
		return new InterfacePropertyGenerator
		{
			name = name,
			type = type,
			isStringType = false,
			highlightType = highlightType,
			get = (get ? ("get".ConstructHighlight() + "; ") : string.Empty),
			set = (set ? ("set".ConstructHighlight() + "; ") : string.Empty)
		};
	}

	public static InterfacePropertyGenerator Property(string name, string stringNamespace, string type, bool get, bool set, bool withNamespace = true, HUMType_Children.HighlightType highlightType = HUMType_Children.HighlightType.Type)
	{
		return new InterfacePropertyGenerator
		{
			name = name,
			withNamespace = withNamespace,
			stringNamespace = stringNamespace,
			stringType = type,
			isStringType = true,
			highlightType = highlightType,
			get = (get ? ("get".ConstructHighlight() + "; ") : string.Empty),
			set = (set ? ("set".ConstructHighlight() + "; ") : string.Empty)
		};
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (type != null)
		{
			if (!type.Is().PrimitiveStringOrVoid())
			{
				list.Add(type.Namespace);
			}
		}
		else if (!string.IsNullOrEmpty(stringNamespace))
		{
			list.Add(stringNamespace);
		}
		return list;
	}
}

using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.FieldGenerator")]
public sealed class FieldGenerator : ConstructGenerator
{
	public AccessModifier scope;

	public FieldModifier modifier;

	public string name;

	public object defaultValue;

	public string stringType;

	public string stringTypeNamespace;

	public bool typeIsString;

	public bool isString;

	public string stringDefault;

	public HUMType_Children.HighlightType highlightType;

	public Type type;

	public List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	private FieldGenerator()
	{
	}

	public static FieldGenerator Field(AccessModifier scope, FieldModifier modifier, Type type, string name, object defaultValue)
	{
		return new FieldGenerator
		{
			scope = scope,
			modifier = modifier,
			type = type,
			name = name.LegalMemberName(),
			defaultValue = defaultValue
		};
	}

	public static FieldGenerator Field(AccessModifier scope, FieldModifier modifier, Type type, string name)
	{
		return new FieldGenerator
		{
			scope = scope,
			modifier = modifier,
			type = type,
			name = name.LegalMemberName(),
			defaultValue = type.Default()
		};
	}

	public static FieldGenerator Field(AccessModifier scope, FieldModifier modifier, string typeName, string typeNamespace, string name, string defaultValue = null, HUMType_Children.HighlightType highlightType = HUMType_Children.HighlightType.None)
	{
		return new FieldGenerator
		{
			scope = scope,
			modifier = modifier,
			typeIsString = true,
			stringTypeNamespace = typeNamespace.SlashesToPeriods(),
			stringType = typeName,
			name = name.LegalMemberName(),
			highlightType = highlightType
		};
	}

	public FieldGenerator Default(object value)
	{
		defaultValue = value;
		isString = false;
		return this;
	}

	public FieldGenerator CustomDefault(string value)
	{
		isString = true;
		stringDefault = value;
		return this;
	}

	public FieldGenerator AddAttribute(AttributeGenerator attributeGenerator)
	{
		attributes.Add(attributeGenerator);
		return this;
	}

	public override string Generate(int indent)
	{
		if (string.IsNullOrEmpty(name))
		{
			return string.Empty;
		}
		string text = string.Empty;
		int num = 0;
		foreach (AttributeGenerator attribute in attributes)
		{
			text = text + attribute.Generate(indent) + ((num < attributes.Count - 1) ? "\n" : string.Empty);
			num++;
		}
		if (attributes.Count > 0)
		{
			text += "\n";
		}
		string text2 = ((modifier == FieldModifier.None) ? string.Empty : " ");
		string text3 = CodeBuilder.Indent(indent) + scope.AsString().ConstructHighlight() + " " + modifier.AsString().ConstructHighlight() + text2 + (typeIsString ? stringType.WithHighlight(highlightType) : type.As().CSharpName()) + " " + name.LegalMemberName();
		string text4 = ((!isString && (defaultValue == null || defaultValue.Equals(HUMValue.Create().New(type)))) ? ";" : (" = " + (isString ? stringDefault : (defaultValue.As().Code(isNew: true, isLiteral: true) + ";"))));
		return text + text3 + text4;
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (typeIsString)
		{
			if (!string.IsNullOrEmpty(stringTypeNamespace))
			{
				list.Add(stringTypeNamespace);
			}
		}
		else if (!type.Is().PrimitiveStringOrVoid() && !string.IsNullOrEmpty(type.Namespace))
		{
			list.Add(type.Namespace);
		}
		for (int i = 0; i < attributes.Count; i++)
		{
			list.MergeUnique(attributes[i].Usings());
		}
		return list;
	}
}

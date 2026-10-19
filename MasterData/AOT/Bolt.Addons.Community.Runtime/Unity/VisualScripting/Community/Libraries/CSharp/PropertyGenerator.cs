using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.PropertyGenerator")]
public sealed class PropertyGenerator : MemberGenerator
{
	public PropertyModifier modifier;

	public AccessModifier getterScope;

	public AccessModifier setterScope;

	public bool hasGetter;

	public bool hasSetter;

	private string getterBody;

	private string setterBody;

	private bool multiStatementGetter;

	private bool multiStatementSetter;

	public object defaultValue;

	private bool hasDefault;

	private string assemblyQualifiedReturnType;

	private bool useAssemblyQualifiedReturnType;

	private bool assemblyQualifiedIsValueType;

	private bool assemblyQualifiedIsPrimitive;

	private bool hasBackingField;

	private bool hasIndexer;

	private string indexerBody;

	public List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	private PropertyGenerator()
	{
	}

	public static PropertyGenerator Property(AccessModifier scope, PropertyModifier modifier, Type returnType, string name, bool hasDefault)
	{
		return new PropertyGenerator
		{
			scope = scope,
			modifier = modifier,
			name = name,
			returnType = returnType
		};
	}

	public static PropertyGenerator Property(AccessModifier scope, PropertyModifier modifier, string assemblyQualifiedReturnType, string name, bool hasDefault, bool isPrimitive, bool isValueType)
	{
		return new PropertyGenerator
		{
			scope = scope,
			modifier = modifier,
			name = name,
			assemblyQualifiedReturnType = assemblyQualifiedReturnType,
			useAssemblyQualifiedReturnType = true,
			assemblyQualifiedIsPrimitive = isPrimitive,
			assemblyQualifiedIsValueType = isValueType
		};
	}

	public PropertyGenerator Default(object value)
	{
		defaultValue = value;
		return this;
	}

	public PropertyGenerator SingleStatementGetter(AccessModifier scope, string body)
	{
		getterScope = scope;
		multiStatementGetter = false;
		getterBody = body;
		hasGetter = true;
		return this;
	}

	public PropertyGenerator MultiStatementGetter(AccessModifier scope, string body)
	{
		getterScope = scope;
		multiStatementGetter = true;
		getterBody = body;
		hasGetter = true;
		return this;
	}

	public PropertyGenerator SingleStatementSetter(AccessModifier scope, string body)
	{
		setterScope = scope;
		multiStatementGetter = false;
		setterBody = body;
		hasSetter = true;
		return this;
	}

	public PropertyGenerator MultiStatementSetter(AccessModifier scope, string body)
	{
		setterScope = scope;
		multiStatementSetter = true;
		setterBody = body;
		hasSetter = true;
		return this;
	}

	public PropertyGenerator AddAttribute(AttributeGenerator attributeGenerator)
	{
		attributes.Add(attributeGenerator);
		return this;
	}

	public PropertyGenerator AddTypeIndexer(string contents)
	{
		hasIndexer = true;
		indexerBody = contents;
		return this;
	}

	public override string Generate(int indent)
	{
		if (useAssemblyQualifiedReturnType)
		{
			string text = string.Empty;
			foreach (AttributeGenerator attribute in attributes)
			{
				text = text + attribute.Generate(indent) + "\n";
			}
			string text2 = ((modifier == PropertyModifier.None) ? string.Empty : " ");
			string text3 = CodeBuilder.Indent(indent) + scope.AsString().ConstructHighlight() + " " + modifier.AsString().ConstructHighlight() + text2 + assemblyQualifiedReturnType + (hasIndexer ? ("[" + indexerBody + "]") : string.Empty) + " " + name.LegalMemberName() + " " + GetterSetter();
			string text4;
			if (defaultValue != null || !returnType.IsValueType || !returnType.IsPrimitive)
			{
				text4 = (hasDefault ? (" = " + defaultValue.As().Code(isNew: true) + ";") : string.Empty);
			}
			else if (hasGetter || hasSetter)
			{
				text4 = string.Empty;
			}
			else
			{
				text4 = ((!hasDefault) ? ";" : string.Empty);
			}
			return text + text3 + text4;
		}
		string text5 = string.Empty;
		foreach (AttributeGenerator attribute2 in attributes)
		{
			text5 = text5 + attribute2.Generate(indent) + "\n";
		}
		string text6 = ((modifier == PropertyModifier.None) ? string.Empty : " ");
		string text7 = CodeBuilder.Indent(indent) + scope.AsString().ConstructHighlight() + " " + modifier.AsString().ConstructHighlight() + text6 + returnType.As().CSharpName().TypeHighlight() + (hasIndexer ? ("[" + indexerBody + "]") : string.Empty) + " " + name + " " + GetterSetter();
		string text8;
		if (defaultValue != null || !assemblyQualifiedIsValueType || !assemblyQualifiedIsPrimitive)
		{
			text8 = (hasDefault ? (" = " + defaultValue.As().Code(isNew: true) + ";") : string.Empty);
		}
		else if (hasGetter || hasSetter)
		{
			text8 = string.Empty;
		}
		else
		{
			text8 = ((!hasDefault) ? ";" : string.Empty);
		}
		return text5 + text7 + text8;
		string Getter()
		{
			if (multiStatementGetter)
			{
				return CodeBuilder.Indent(indent) + CodeBuilder.Indent(indent) + "get \n".ConstructHighlight() + CodeBuilder.Indent(indent + 1) + "{\n" + CodeBuilder.Indent(indent + 2) + getterBody.Replace("\n", "\n" + CodeBuilder.Indent(indent + 2)) + "\n" + CodeBuilder.Indent(indent + 1) + "}";
			}
			return "get".ConstructHighlight() + " => " + getterBody.Replace("\n", "\n" + CodeBuilder.Indent(indent + 1)) + ";";
		}
		string GetterSetter()
		{
			_ = string.Empty;
			if (multiStatementGetter || multiStatementSetter)
			{
				return (string.IsNullOrEmpty(getterBody) ? ("\n" + CodeBuilder.Indent(indent) + "{") : ("\n" + CodeBuilder.Indent(indent) + "{\n" + Getter())) + (string.IsNullOrEmpty(setterBody) ? "\n" : ((multiStatementGetter ? "\n" : string.Empty) + "\n" + Setter() + "\n")) + CodeBuilder.Indent(indent) + "}";
			}
			return CodeBuilder.Indent(indent) + "{ " + (string.IsNullOrEmpty(getterBody) ? string.Empty : (Getter() + " ")) + (string.IsNullOrEmpty(setterBody) ? string.Empty : ((string.IsNullOrEmpty(getterBody) ? " " : string.Empty) + Setter() + " ")) + "}";
		}
		string Setter()
		{
			if (multiStatementSetter)
			{
				return CodeBuilder.Indent(indent) + CodeBuilder.Indent(indent) + "set \n".ConstructHighlight() + CodeBuilder.Indent(indent + 1) + "{\n" + CodeBuilder.Indent(indent + 2) + setterBody.Replace("\n", "\n" + CodeBuilder.Indent(indent + 2)) + "\n" + CodeBuilder.Indent(indent + 1) + "}";
			}
			return "set".ConstructHighlight() + " => " + setterBody.Replace("\n", "\n" + CodeBuilder.Indent(indent + 1)) + ";";
		}
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		List<string> list2 = list;
		string item;
		if (useAssemblyQualifiedReturnType)
		{
			item = (Type.GetType(assemblyQualifiedReturnType).IsPrimitive ? Type.GetType(assemblyQualifiedReturnType).Namespace : string.Empty);
		}
		else
		{
			item = (returnType.IsPrimitive ? string.Empty : returnType.Namespace);
		}
		list2.Add(item);
		for (int i = 0; i < attributes.Count; i++)
		{
			list.MergeUnique(attributes[i].Usings());
		}
		return list;
	}
}

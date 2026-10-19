using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.InterfaceGenerator")]
public sealed class InterfaceGenerator : TypeGenerator
{
	public RootAccessModifier scope;

	public Type[] interfaces;

	public string typeName;

	public List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	public List<InterfacePropertyGenerator> properties = new List<InterfacePropertyGenerator>();

	public List<InterfaceMethodGenerator> methods = new List<InterfaceMethodGenerator>();

	public bool generateUsings;

	protected override string GenerateBefore(int indent)
	{
		string text = string.Empty;
		if (generateUsings)
		{
			List<string> list = Usings();
			for (int i = 0; i < list.Count; i++)
			{
				text = text + "using".ConstructHighlight() + " " + list[i] + ";" + ((i < list.Count - 1) ? "\n" : string.Empty);
			}
		}
		for (int j = 0; j < attributes.Count; j++)
		{
			text += attributes[j].Generate(indent);
			if (j < attributes.Count - 1)
			{
				text += "\n";
			}
		}
		bool flag = interfaces.Length != 0;
		text = text + CodeBuilder.Indent(indent) + scope.AsString().ConstructHighlight() + " interface ".ConstructHighlight() + typeName.LegalMemberName().InterfaceHighlight() + (flag ? " : " : string.Empty);
		for (int k = 0; k < interfaces.Length; k++)
		{
			text += interfaces[k].Name.LegalMemberName().InterfaceHighlight();
			if (k < interfaces.Length - 1)
			{
				text += ", ";
			}
		}
		return text;
	}

	protected override string GenerateBody(int indent)
	{
		string text = string.Empty;
		for (int i = 0; i < properties.Count; i++)
		{
			text = text + CodeBuilder.Indent(indent) + properties[i].Generate(indent);
			if (i < properties.Count - 1)
			{
				text += "\n";
			}
		}
		if (methods.Count > 0 && properties.Count > 0)
		{
			text += "\n";
		}
		for (int j = 0; j < methods.Count; j++)
		{
			text = text + CodeBuilder.Indent(indent) + methods[j].Generate(indent);
			if (j < methods.Count - 1)
			{
				text += "\n";
			}
		}
		return text;
	}

	protected override string GenerateAfter(int indent)
	{
		return string.Empty;
	}

	private InterfaceGenerator(string name, params Type[] interfaces)
	{
		typeName = name;
		this.interfaces = interfaces;
	}

	public static InterfaceGenerator Interface(string name, params Type[] interfaces)
	{
		return new InterfaceGenerator(name, interfaces);
	}

	public InterfaceGenerator AddMethod(InterfaceMethodGenerator generator)
	{
		methods.Add(generator);
		return this;
	}

	public InterfaceGenerator AddProperty(InterfacePropertyGenerator generator)
	{
		properties.Add(generator);
		return this;
	}

	public InterfaceGenerator AddAttribute(AttributeGenerator generator)
	{
		attributes.Add(generator);
		return this;
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		for (int i = 0; i < attributes?.Count; i++)
		{
			list.MergeUnique(attributes[i].Usings());
		}
		for (int j = 0; j < interfaces?.Length; j++)
		{
			if (!list.Contains(interfaces[j].Namespace) && !interfaces[j].IsPrimitive)
			{
				list.Add(interfaces[j].Namespace);
			}
		}
		for (int k = 0; k < properties?.Count; k++)
		{
			string item = properties[k].type.Namespace;
			if (!list.Contains(item) && !properties[k].type.Is().PrimitiveStringOrVoid())
			{
				list.Add(item);
			}
		}
		for (int l = 0; l < methods?.Count; l++)
		{
			string item2 = methods[l].returnType.Namespace;
			if (!list.Contains(item2) && !methods[l].returnType.Is().PrimitiveStringOrVoid())
			{
				list.Add(item2);
			}
		}
		return list;
	}
}

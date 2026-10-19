using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.EnumGenerator")]
public sealed class EnumGenerator : TypeGenerator
{
	private RootAccessModifier scope;

	private string typeName;

	private List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	private List<EnumValueGenerator> items = new List<EnumValueGenerator>();

	public bool indexing;

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
			text += "\n\n";
		}
		for (int j = 0; j < attributes.Count; j++)
		{
			text = text + attributes[j].Generate(indent) + "\n";
		}
		return text + CodeBuilder.Indent(indent) + scope.AsString().ConstructHighlight() + " enum ".ConstructHighlight() + typeName.LegalMemberName().EnumHighlight();
	}

	protected override string GenerateBody(int indent)
	{
		string text = string.Empty;
		for (int i = 0; i < items.Count; i++)
		{
			if (!string.IsNullOrEmpty(items[i].name))
			{
				text = text + CodeBuilder.Indent(indent) + items[i].name.LegalMemberName() + (indexing ? (" = " + items[i].index.ToString().NumericHighlight()) : string.Empty);
				if (i < items.Count - 1)
				{
					text += ",";
					text += "\n";
				}
			}
		}
		return text;
	}

	protected override string GenerateAfter(int indent)
	{
		return string.Empty;
	}

	private EnumGenerator(string name)
	{
		typeName = name;
	}

	public static EnumGenerator Enum(string name)
	{
		return new EnumGenerator(name);
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		for (int i = 0; i < attributes.Count; i++)
		{
			list.MergeUnique(attributes[i].Usings());
		}
		return list;
	}

	public EnumGenerator AddItem(string itemName, int index)
	{
		EnumValueGenerator enumValueGenerator = new EnumValueGenerator();
		enumValueGenerator.name = itemName;
		enumValueGenerator.index = index;
		items.Add(enumValueGenerator);
		return this;
	}

	public EnumGenerator AddAttribute(AttributeGenerator generator)
	{
		attributes.Add(generator);
		return this;
	}
}

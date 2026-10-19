using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.StructGenerator")]
public sealed class StructGenerator : TypeGenerator
{
	private RootAccessModifier scope;

	private bool isNested;

	private AccessModifier nestedScope;

	private StructModifier modifier;

	private string name;

	private List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	private List<FieldGenerator> fields = new List<FieldGenerator>();

	private List<PropertyGenerator> properties = new List<PropertyGenerator>();

	private List<ConstructorGenerator> constructors = new List<ConstructorGenerator>();

	private List<MethodGenerator> methods = new List<MethodGenerator>();

	private List<ClassGenerator> classes = new List<ClassGenerator>();

	private List<StructGenerator> structs = new List<StructGenerator>();

	private List<EnumGenerator> enums = new List<EnumGenerator>();

	private List<InterfaceGenerator> subInterfaces = new List<InterfaceGenerator>();

	private List<Type> interfaces = new List<Type>();

	public bool generateUsings;

	private StructGenerator()
	{
	}

	public static StructGenerator Struct(RootAccessModifier scope, StructModifier modifier, string name)
	{
		return new StructGenerator
		{
			scope = scope,
			modifier = modifier,
			name = name.LegalMemberName(),
			isNested = false
		};
	}

	public static StructGenerator Struct(AccessModifier nestedScope, StructModifier modifier, string name)
	{
		return new StructGenerator
		{
			nestedScope = nestedScope,
			modifier = modifier,
			name = name.LegalMemberName(),
			isNested = true
		};
	}

	protected override string GenerateBefore(int indent)
	{
		string text = string.Empty;
		if (generateUsings)
		{
			List<string> list = Usings();
			bool flag = false;
			for (int i = 0; i < list.Count; i++)
			{
				if (!string.IsNullOrEmpty(list[i]))
				{
					text = text + "using".ConstructHighlight() + " " + list[i] + ";" + ((i < list.Count - 1) ? "\n" : string.Empty);
					flag = true;
				}
			}
			if (flag)
			{
				text += "\n\n";
			}
		}
		for (int j = 0; j < attributes.Count; j++)
		{
			text = text + attributes[j].Generate(indent) + "\n";
		}
		text = text + CodeBuilder.Indent(indent) + scope.AsString().ConstructHighlight() + modifier.AsString().ConstructHighlight() + " struct ".ConstructHighlight() + name.LegalMemberName().TypeHighlight();
		text += ((interfaces.Count == 0) ? string.Empty : " : ");
		for (int k = 0; k < interfaces.Count; k++)
		{
			text += interfaces[k].As().CSharpName();
			text += ((k < interfaces.Count - 1) ? ", " : string.Empty);
		}
		return text;
	}

	protected override string GenerateBody(int indent)
	{
		string text = string.Empty;
		for (int i = 0; i < fields.Count; i++)
		{
			if (!string.IsNullOrEmpty(fields[i].name))
			{
				text = text + fields[i].Generate(indent) + ((i < fields.Count - 1) ? "\n" : string.Empty);
			}
		}
		text += ((fields.Count > 0 && (properties.Count > 0 || constructors.Count > 0 || methods.Count > 0 || classes.Count > 0 || structs.Count > 0 || enums.Count > 0)) ? "\n\n" : string.Empty);
		for (int j = 0; j < properties.Count; j++)
		{
			if (!string.IsNullOrEmpty(properties[j].name))
			{
				text = text + properties[j].Generate(indent) + ((j < properties.Count - 1) ? "\n\n" : string.Empty);
			}
		}
		text += ((properties.Count > 0 && (constructors.Count > 0 || methods.Count > 0 || classes.Count > 0 || structs.Count > 0 || enums.Count > 0)) ? "\n\n" : string.Empty);
		for (int k = 0; k < constructors.Count; k++)
		{
			text = text + constructors[k].Generate(indent) + ((k < constructors.Count - 1) ? "\n\n" : string.Empty);
		}
		text += ((constructors.Count > 0 && (methods.Count > 0 || classes.Count > 0 || structs.Count > 0 || enums.Count > 0)) ? "\n\n" : string.Empty);
		for (int l = 0; l < methods.Count; l++)
		{
			if (!string.IsNullOrEmpty(methods[l].name))
			{
				text = text + methods[l].Generate(indent) + ((l < methods.Count - 1) ? "\n\n" : string.Empty);
			}
		}
		text += ((methods.Count > 0 && (classes.Count > 0 || structs.Count > 0 || enums.Count > 0)) ? "\n\n" : string.Empty);
		for (int m = 0; m < classes.Count; m++)
		{
			text += classes[m].Generate(indent);
			text += ((m < classes.Count - 1) ? "\n\n" : string.Empty);
		}
		text += ((classes.Count > 0 && (structs.Count > 0 || enums.Count > 0)) ? "\n\n" : string.Empty);
		for (int n = 0; n < structs.Count; n++)
		{
			text += structs[n].Generate(indent);
			text += ((n < structs.Count - 1) ? "\n\n" : string.Empty);
		}
		text += ((structs.Count > 0 && enums.Count > 0) ? "\n\n" : string.Empty);
		for (int num = 0; num < enums.Count; num++)
		{
			text += enums[num].Generate(indent);
			text += ((num < enums.Count - 1) ? "\n\n" : string.Empty);
		}
		for (int num2 = 0; num2 < subInterfaces.Count; num2++)
		{
			text += subInterfaces[num2].Generate(indent);
			text += ((num2 < subInterfaces.Count - 1) ? "\n\n" : string.Empty);
		}
		return text;
	}

	protected override string GenerateAfter(int indent)
	{
		return string.Empty;
	}

	public StructGenerator ImplementInterface(Type type)
	{
		interfaces.Add(type);
		return this;
	}

	public StructGenerator AddAttribute(AttributeGenerator generator)
	{
		attributes.Add(generator);
		return this;
	}

	public StructGenerator AddMethod(MethodGenerator generator)
	{
		methods.Add(generator);
		return this;
	}

	public StructGenerator AddField(FieldGenerator generator)
	{
		fields.Add(generator);
		return this;
	}

	public StructGenerator AddProperty(PropertyGenerator generator)
	{
		properties.Add(generator);
		return this;
	}

	public StructGenerator AddConstructor(ConstructorGenerator generator)
	{
		constructors.Add(generator);
		return this;
	}

	public StructGenerator AddClass(ClassGenerator generator)
	{
		classes.Add(generator);
		return this;
	}

	public StructGenerator AddStruct(StructGenerator generator)
	{
		structs.Add(generator);
		return this;
	}

	public StructGenerator AddEnum(EnumGenerator generator)
	{
		enums.Add(generator);
		return this;
	}

	public StructGenerator AddInterface(InterfaceGenerator generator)
	{
		subInterfaces.Add(generator);
		return this;
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		for (int i = 0; i < attributes.Count; i++)
		{
			list.MergeUnique(attributes[i].Usings());
		}
		List<string> list2 = new List<string>();
		for (int j = 0; j < interfaces.Count; j++)
		{
			if (!string.IsNullOrEmpty(interfaces[j].Namespace) && !list2.Contains(interfaces[j].Namespace))
			{
				list2.Add(interfaces[j].Namespace);
			}
		}
		list.MergeUnique(list2);
		for (int k = 0; k < fields.Count; k++)
		{
			list.MergeUnique(fields[k].Usings());
		}
		for (int l = 0; l < properties.Count; l++)
		{
			list.MergeUnique(properties[l].Usings());
		}
		for (int m = 0; m < methods.Count; m++)
		{
			list.MergeUnique(methods[m].Usings());
		}
		return list;
	}
}

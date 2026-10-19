using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.ClassGenerator")]
public sealed class ClassGenerator : TypeGenerator
{
	public RootAccessModifier scope;

	public AccessModifier nestedScope;

	public ClassModifier modifier;

	public bool isNested;

	public string name;

	public List<AttributeGenerator> attributes = new List<AttributeGenerator>();

	public List<FieldGenerator> fields = new List<FieldGenerator>();

	public List<PropertyGenerator> properties = new List<PropertyGenerator>();

	public List<MethodGenerator> methods = new List<MethodGenerator>();

	public List<ConstructorGenerator> constructors = new List<ConstructorGenerator>();

	public List<ClassGenerator> classes = new List<ClassGenerator>();

	public List<StructGenerator> structs = new List<StructGenerator>();

	public List<EnumGenerator> enums = new List<EnumGenerator>();

	public List<InterfaceGenerator> subInterfaces = new List<InterfaceGenerator>();

	public List<Type> interfaces = new List<Type>();

	public Type inherits;

	public bool generateUsings;

	private bool useAssemblyQualifiedNameForInheritance;

	public string assemblyQualifiedInheritanceNamespace;

	public string assemblyQualifiedInheritanceType;

	private ClassGenerator()
	{
	}

	public static ClassGenerator Class(RootAccessModifier scope, ClassModifier modifier, string name, Type inherits)
	{
		return new ClassGenerator
		{
			scope = scope,
			modifier = modifier,
			name = name,
			inherits = ((inherits == null) ? typeof(object) : inherits),
			isNested = false
		};
	}

	public static ClassGenerator Class(RootAccessModifier scope, ClassModifier modifier, string name, string inherits, string inheritsNamespace, List<string> usings = null)
	{
		return new ClassGenerator
		{
			scope = scope,
			modifier = modifier,
			name = name,
			assemblyQualifiedInheritanceNamespace = inheritsNamespace,
			assemblyQualifiedInheritanceType = inherits,
			isNested = false,
			usings = usings,
			useAssemblyQualifiedNameForInheritance = true
		};
	}

	public static ClassGenerator Class(AccessModifier nestedScope, ClassModifier modifier, string name, Type inherits)
	{
		return new ClassGenerator
		{
			nestedScope = nestedScope,
			modifier = modifier,
			name = name,
			inherits = ((inherits == null) ? typeof(object) : inherits),
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
		bool flag2 = (!(inherits == null) || !string.IsNullOrEmpty(assemblyQualifiedInheritanceType)) && (!(inherits == typeof(object)) || !(inherits.BaseType == null));
		text = text + CodeBuilder.Indent(indent) + scope.AsString().ConstructHighlight() + ((modifier == ClassModifier.None) ? string.Empty : (" " + modifier.AsString().ConstructHighlight())) + " class ".ConstructHighlight() + name.LegalMemberName().TypeHighlight();
		text += ((!flag2 && interfaces.Count == 0) ? string.Empty : " : ");
		text += (flag2 ? (((inherits == null) ? assemblyQualifiedInheritanceType : inherits.As().CSharpName()) + ((interfaces.Count > 0) ? ", " : string.Empty)) : string.Empty);
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
		return "\n";
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (usings != null)
		{
			list.MergeUnique(usings);
		}
		if (useAssemblyQualifiedNameForInheritance)
		{
			if (!string.IsNullOrEmpty(assemblyQualifiedInheritanceNamespace) && assemblyQualifiedInheritanceNamespace + "." + assemblyQualifiedInheritanceType != "System.Void")
			{
				list.Add(assemblyQualifiedInheritanceNamespace);
			}
		}
		else if (!inherits.Is().PrimitiveStringOrVoid())
		{
			list.Add(inherits.Namespace);
		}
		List<string> list2 = new List<string>();
		for (int i = 0; i < interfaces.Count; i++)
		{
			if (!string.IsNullOrEmpty(interfaces[i].Namespace) && !list2.Contains(interfaces[i].Namespace))
			{
				list2.Add(interfaces[i].Namespace);
			}
		}
		list.MergeUnique(list2);
		for (int j = 0; j < attributes.Count; j++)
		{
			list.MergeUnique(attributes[j].Usings());
		}
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

	public ClassGenerator ImplementInterface(Type type)
	{
		interfaces.Add(type);
		return this;
	}

	public ClassGenerator AddConstructor(ConstructorGenerator constructor)
	{
		constructors.Add(constructor);
		return this;
	}

	public ClassGenerator AddAttribute(AttributeGenerator generator)
	{
		attributes.Add(generator);
		return this;
	}

	public ClassGenerator AddMethod(MethodGenerator generator)
	{
		methods.Add(generator);
		return this;
	}

	public ClassGenerator AddField(FieldGenerator generator)
	{
		fields.Add(generator);
		return this;
	}

	public ClassGenerator AddProperty(PropertyGenerator generator)
	{
		properties.Add(generator);
		return this;
	}

	public ClassGenerator AddClass(ClassGenerator generator)
	{
		classes.Add(generator);
		return this;
	}

	public ClassGenerator AddStruct(StructGenerator generator)
	{
		structs.Add(generator);
		return this;
	}

	public ClassGenerator AddEnum(EnumGenerator generator)
	{
		enums.Add(generator);
		return this;
	}

	public ClassGenerator AddInterface(InterfaceGenerator generator)
	{
		subInterfaces.Add(generator);
		return this;
	}
}

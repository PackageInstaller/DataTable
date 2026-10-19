using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.NamespaceGenerator")]
public class NamespaceGenerator : TypeGenerator
{
	public string @namespace;

	public List<ClassGenerator> classes = new List<ClassGenerator>();

	public List<StructGenerator> structs = new List<StructGenerator>();

	public List<EnumGenerator> enums = new List<EnumGenerator>();

	public List<InterfaceGenerator> interfaces = new List<InterfaceGenerator>();

	private NamespaceGenerator()
	{
	}

	public static NamespaceGenerator Namespace(string @namespace)
	{
		NamespaceGenerator namespaceGenerator = new NamespaceGenerator();
		namespaceGenerator.@namespace = @namespace?.Replace("/", ".").RemoveAllButLettersorDigitsExcept(new string[2] { "_", "." }).RemoveIllegalFirstLetters();
		if (string.IsNullOrEmpty(namespaceGenerator.@namespace))
		{
			namespaceGenerator.hideBrackets = true;
		}
		return namespaceGenerator;
	}

	public void AddUsing(string @namespace)
	{
		usings.AddNonContainedTypes(new List<string> { @namespace });
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		for (int i = 0; i < classes.Count; i++)
		{
			list.MergeUnique(classes[i].Usings());
		}
		for (int j = 0; j < structs.Count; j++)
		{
			list.MergeUnique(structs[j].Usings());
		}
		for (int k = 0; k < enums.Count; k++)
		{
			list.MergeUnique(enums[k].Usings());
		}
		for (int l = 0; l < interfaces.Count; l++)
		{
			list.MergeUnique(interfaces[l].Usings());
		}
		if (list.Contains(@namespace))
		{
			list.Remove(@namespace);
		}
		list.MergeUnique(usings);
		return list;
	}

	public override string Generate(int indent)
	{
		if (string.IsNullOrEmpty(@namespace))
		{
			return GenerateBefore(indent) + "\n" + GenerateBody(indent) + "\n" + GenerateAfter(indent);
		}
		return base.Generate(indent);
	}

	protected override string GenerateAfter(int indent)
	{
		return string.Empty;
	}

	protected override string GenerateBefore(int indent)
	{
		string text = string.Empty;
		List<string> other = Usings();
		usings.MergeUnique(other);
		for (int i = 0; i < usings.Count; i++)
		{
			if (!string.IsNullOrEmpty(usings[i]))
			{
				text = text + "using".ConstructHighlight() + " " + usings[i] + ";" + ((i < usings.Count - 1) ? "\n" : string.Empty);
			}
		}
		if (text.Contains("using"))
		{
			text += (string.IsNullOrEmpty(@namespace) ? "\n" : "\n\n");
		}
		if (string.IsNullOrEmpty(@namespace))
		{
			return text;
		}
		return text + "namespace ".ConstructHighlight() + @namespace;
	}

	protected override string GenerateBody(int indent)
	{
		string text = string.Empty;
		for (int i = 0; i < classes.Count; i++)
		{
			text = text + classes[i].Generate(indent) + ((i < classes.Count - 1) ? "\n" : string.Empty);
		}
		text += ((structs.Count > 0 && classes.Count > 0) ? "\n" : string.Empty);
		for (int j = 0; j < structs.Count; j++)
		{
			text = text + structs[j].Generate(indent) + ((j < structs.Count - 1) ? "\n" : string.Empty);
		}
		text += ((interfaces.Count > 0 && structs.Count > 0) ? "\n" : string.Empty);
		for (int k = 0; k < interfaces.Count; k++)
		{
			text = text + interfaces[k].Generate(indent) + ((k < interfaces.Count - 1) ? "\n" : string.Empty);
		}
		text += ((enums.Count > 0 && interfaces.Count > 0) ? "\n" : string.Empty);
		for (int l = 0; l < enums.Count; l++)
		{
			text = text + enums[l].Generate(indent) + ((l < enums.Count - 1) ? "\n" : string.Empty);
		}
		return text;
	}

	public NamespaceGenerator AddClass(ClassGenerator @class)
	{
		classes.Add(@class);
		return this;
	}

	public NamespaceGenerator AddStruct(StructGenerator @struct)
	{
		structs.Add(@struct);
		return this;
	}

	public NamespaceGenerator AddEnum(EnumGenerator @enum)
	{
		enums.Add(@enum);
		return this;
	}

	public NamespaceGenerator AddInterface(InterfaceGenerator @interface)
	{
		interfaces.Add(@interface);
		return this;
	}
}

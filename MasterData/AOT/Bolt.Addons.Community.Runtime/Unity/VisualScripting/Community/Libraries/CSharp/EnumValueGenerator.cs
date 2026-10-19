using System.Collections.Generic;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.EnumValueGenerator")]
public sealed class EnumValueGenerator : ConstructGenerator
{
	public string name = string.Empty;

	public int index;

	public override string Generate(int indent)
	{
		return CodeBuilder.Indent(indent) + name + " = " + index;
	}

	public override List<string> Usings()
	{
		return new List<string>();
	}
}

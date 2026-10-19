using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.InvokeParametersGenerator")]
public sealed class InvokeParametersGenerator : ConstructGenerator
{
	private List<ParameterGenerator> parameters = new List<ParameterGenerator>();

	public int Count => parameters.Count;

	public override string Generate(int indent)
	{
		string text = string.Empty;
		for (int i = 0; i < parameters.Count; i++)
		{
			text += parameters[i].As().Code(isNew: true);
			if (i < Count - 1)
			{
				text += ", ";
			}
		}
		return "(" + text + ")";
	}

	private InvokeParametersGenerator()
	{
	}

	public static InvokeParametersGenerator InvokeParameters()
	{
		return new InvokeParametersGenerator();
	}

	public InvokeParametersGenerator Parameter(ParameterGenerator parameter)
	{
		parameters.Add(parameter);
		return this;
	}

	public InvokeParametersGenerator Set(params ParameterGenerator[] parameters)
	{
		for (int i = 0; i < parameters.Length; i++)
		{
			this.parameters.Add(parameters[i]);
		}
		return this;
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		for (int i = 0; i < parameters.Count; i++)
		{
			string text = parameters[i]?.GetType().Namespace;
			if (!string.IsNullOrEmpty(text) && !list.Contains(text))
			{
				list.Add(text);
			}
		}
		return list;
	}
}

using System.Collections.Generic;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.LambdaGenerator")]
public sealed class LambdaGenerator : ConstructGenerator
{
	private bool multiLine;

	private List<string> parameterNames;

	private string body;

	private LambdaGenerator()
	{
	}

	public static LambdaGenerator SingleLine(List<string> parameterNames, string body)
	{
		return new LambdaGenerator
		{
			parameterNames = parameterNames,
			body = body,
			multiLine = false
		};
	}

	public static LambdaGenerator MultiLine(List<string> parameterNames, string body)
	{
		return new LambdaGenerator
		{
			parameterNames = parameterNames,
			body = body,
			multiLine = true
		};
	}

	public override string Generate(int indent)
	{
		string text = string.Empty;
		if (multiLine)
		{
			for (int i = 0; i < parameterNames.Count; i++)
			{
				text += parameterNames[i];
				if (i < parameterNames.Count - 1)
				{
					text += ", ";
				}
			}
			return "(" + text + ") =>\n" + CodeBuilder.Indent(indent) + "{\n" + body.Replace("\n", "\n" + CodeBuilder.Indent(indent + 1)) + "\n}";
		}
		for (int j = 0; j < parameterNames.Count; j++)
		{
			text += parameterNames[j];
			if (j < parameterNames.Count - 1)
			{
				text += ", ";
			}
		}
		return "(" + text + ") => { " + body + (string.IsNullOrEmpty(body) ? string.Empty : " ") + "}";
	}

	public override List<string> Usings()
	{
		return new List<string>();
	}
}

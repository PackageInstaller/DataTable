using System;
using Unity.VisualScripting.Community.Libraries.CSharp;
using Unity.VisualScripting.Community.Libraries.Humility;

public class CodeLine
{
	private Type castType;

	private string code;

	private int indent;

	private bool shouldIndent;

	public bool isCasted
	{
		get
		{
			return castType != null;
		}
		private set
		{
			isCasted = value;
		}
	}

	public CodeLine(string code)
	{
		this.code = code;
		shouldIndent = false;
	}

	public CodeLine(string code, int indent)
	{
		this.code = code;
		this.indent = indent;
		shouldIndent = true;
	}

	public CodeLine(string code, int indent, Type castType)
	{
		this.code = code;
		this.indent = indent;
		this.castType = castType;
		shouldIndent = true;
	}

	public string GetCode(bool newLine = true)
	{
		string text = (isCasted ? ("(" + castType.As().CSharpName(hideSystemObject: false, fullName: true) + ")") : string.Empty);
		return (shouldIndent ? CodeBuilder.Indent(indent) : string.Empty) + text + code + ";" + (newLine ? "\n" : "");
	}

	public static implicit operator string(CodeLine codeLine)
	{
		return codeLine.GetCode();
	}

	public static string operator -(CodeLine codeLine, string str)
	{
		return codeLine.GetCode(newLine: false).Replace(str, "");
	}
}

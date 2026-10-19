using System;
using System.Collections.Generic;
using System.Reflection;
using Unity.VisualScripting.Community.Libraries.Humility;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

public static class CodeBuilder
{
	public static string EnumColor = "FFFFBB";

	public static string ConstructColor = "4488FF";

	public static string WarningColor = "CC3333";

	public static string InterfaceColor = "DDFFBB";

	public static string TypeColor = "33EEAA";

	public static string StringColor = "CC8833";

	public static string NumericColor = "DDFFBB";

	public static string CommentColor = "009900";

	public static string SummaryColor = "00CC00";

	public static string VariableColor = "00FFFF";

	public static string RecommendationColor = "FFD700";

	public static string OpenBody(int indent)
	{
		return string.Empty + Indent(indent) + "{";
	}

	public static string OpenBody(int indent, int spaces)
	{
		string empty = string.Empty;
		empty = empty + Indent(indent) + "{";
		for (int i = 0; i < spaces; i++)
		{
			empty += "\n";
		}
		return empty;
	}

	public static string CloseBody(int indent)
	{
		return string.Empty + Indent(indent) + "}";
	}

	public static string CloseBody(int indent, int spaces)
	{
		string empty = string.Empty;
		empty = empty + Indent(indent) + "}";
		for (int i = 0; i < spaces; i++)
		{
			empty += "\n";
		}
		return empty;
	}

	public static string Indent(int amount)
	{
		string text = string.Empty;
		for (int i = 0; i < amount; i++)
		{
			text += "    ";
		}
		return text;
	}

	public static string Indent(int amount, int spacing)
	{
		string text = string.Empty;
		string text2 = string.Empty;
		for (int i = 0; i < spacing; i++)
		{
			text2 += " ";
		}
		for (int j = 0; j < amount; j++)
		{
			text += text2;
		}
		return text;
	}

	public static string Using(string[] namespaces)
	{
		string text = string.Empty;
		for (int i = 0; i < namespaces.Length; i++)
		{
			text = text + "using ".ConstructHighlight() + namespaces[i] + ";" + ((i < namespaces.Length - 1) ? "\n" : string.Empty);
		}
		return text;
	}

	public static string Using(List<string> namespaces)
	{
		_ = string.Empty;
		return Using(namespaces.ToArray());
	}

	public static string Using(this ClassGenerator generator)
	{
		List<string> list = new List<string>();
		for (int i = 0; i < generator.fields.Count; i++)
		{
			string item = generator.fields[i].type.Namespace;
			if (!list.Contains(item))
			{
				list.Add(item);
			}
		}
		for (int j = 0; j < generator.properties.Count; j++)
		{
			string item2 = generator.properties[j].returnType.Namespace;
			if (!list.Contains(item2))
			{
				list.Add(item2);
			}
		}
		for (int k = 0; k < generator.methods.Count; k++)
		{
			string item3 = generator.methods[k].returnType.Namespace;
			if (!list.Contains(item3))
			{
				list.Add(item3);
			}
		}
		string text = string.Empty;
		for (int l = 0; l < list.Count; l++)
		{
			text = text + "using ".ConstructHighlight() + list[l] + ";" + ((l < list.Count - 1) ? "\n" : string.Empty);
		}
		return text;
	}

	public static List<string> Usings(this ClassGenerator generator)
	{
		List<string> list = new List<string>();
		for (int i = 0; i < generator.attributes.Count; i++)
		{
			list.MergeUnique(generator.attributes[i].Usings());
		}
		for (int j = 0; j < generator.fields.Count; j++)
		{
			list.MergeUnique(generator.fields[j].Usings());
		}
		for (int k = 0; k < generator.properties.Count; k++)
		{
			list.MergeUnique(generator.properties[k].Usings());
		}
		for (int l = 0; l < generator.methods.Count; l++)
		{
			list.MergeUnique(generator.methods[l].Usings());
		}
		return list;
	}

	public static AccessModifier GetScope(this MethodInfo method)
	{
		if (method.IsPublic)
		{
			return AccessModifier.Public;
		}
		if (method.IsPrivate)
		{
			return AccessModifier.Private;
		}
		if (method.IsPrivate && method.IsFamily)
		{
			return AccessModifier.PrivateProtected;
		}
		if (method.IsFamilyAndAssembly)
		{
			return AccessModifier.ProtectedInternal;
		}
		if (method.IsFamily)
		{
			return AccessModifier.Protected;
		}
		if (method.IsAssembly)
		{
			return AccessModifier.Internal;
		}
		return AccessModifier.Public;
	}

	public static MethodModifier GetModifier(this MethodInfo method)
	{
		if (method.IsStatic)
		{
			return MethodModifier.Static;
		}
		if (method.IsVirtual)
		{
			return MethodModifier.Virtual;
		}
		if (method.IsAbstract)
		{
			return MethodModifier.Abstract;
		}
		if (method.IsFinal)
		{
			return MethodModifier.Sealed;
		}
		return MethodModifier.None;
	}

	public static string Parameters(this List<ParameterGenerator> parameters)
	{
		string text = "(";
		for (int i = 0; i < parameters.Count; i++)
		{
			text += parameters[i].Generate(0);
			if (i < parameters.Count - 1)
			{
				text += ", ";
			}
		}
		return text + ")";
	}

	public static string InitializeVariable(string name, Type type)
	{
		if (type.Is().NullOrVoid())
		{
			return string.Empty;
		}
		return type.As().CSharpName() + " " + Assign(name, HUMValue.Create().New(type).As()
			.Code(isNew: false)) + "\n";
	}

	public static string Qoute()
	{
		return "\"";
	}

	public static string Comma()
	{
		return ", ";
	}

	public static bool Null(string str)
	{
		return string.IsNullOrEmpty(str);
	}

	public static string NullOrNot(object obj, string @null, string not)
	{
		if (obj != null)
		{
			return not;
		}
		return @null;
	}

	public static string NullVoidOrNot(Type type, string nullOrVoid, string not)
	{
		if (!type.Is().NullOrVoid())
		{
			return not;
		}
		return nullOrVoid;
	}

	public static string NullAsEmptyOr(string str, string or)
	{
		if (!Null(str))
		{
			return or;
		}
		return string.Empty;
	}

	public static string End()
	{
		return ");";
	}

	public static string SingleLineLambda(string parameters, string body)
	{
		return "(" + parameters + ")=>{ " + body + " }";
	}

	public static string MultiLineLambda(string parameters, string body, int Indent)
	{
		return "(" + parameters + ") =>\n{\n" + CodeBuilder.Indent(Indent) + body + "\n}";
	}

	public static string Assign(string member, string value, Type castedType)
	{
		return member + " = (" + castedType.As().CSharpName() + ")" + value + ";";
	}

	public static string Assign(string member, string value)
	{
		return member + " = " + value + ";";
	}

	public static string Return(string value)
	{
		return "return ".ControlHighlight() + value + ";";
	}

	public static string CastAs(this string value, Type type)
	{
		return "(" + type.As().CSharpName() + ")" + value;
	}

	public static string LegalMemberName(this string memberName)
	{
		if (string.IsNullOrEmpty(memberName))
		{
			return string.Empty;
		}
		string text = memberName;
		text = text.Replace(" ", string.Empty);
		string text2 = text;
		for (int i = 0; i < text2.Length; i++)
		{
			if (!char.IsLetter(text2[i]) && !char.IsNumber(text2[i]) && text2[i] != "_".ToCharArray()[0])
			{
				text = text.Replace(text2[i].ToString(), string.Empty);
			}
		}
		if (!string.IsNullOrEmpty(text) && char.IsNumber(text[0]))
		{
			text = "_" + text;
		}
		return text;
	}

	public static string Highlight(string code, Color color)
	{
		return string.Concat(string.Concat(string.Empty + "[BeginUAPreviewHighlight]<color=#" + ColorUtility.ToHtmlStringRGB(color) + ">[EndUAPreviewHighlight]", code), "[BeginUAPreviewHighlight]</color>[EndUAPreviewHighlight]");
	}

	public static string Highlight(string code, string hex)
	{
		return string.Concat(string.Concat(string.Empty + "[BeginUAPreviewHighlight]<color=#" + hex + ">[EndUAPreviewHighlight]", code), "[BeginUAPreviewHighlight]</color>[EndUAPreviewHighlight]");
	}

	public static string MakeRecommendation(string Message)
	{
		return ("/*(Recommendation) " + Message + "*/").RecommendationHighlight();
	}

	public static string WarningHighlight(this string code)
	{
		return Highlight(code, WarningColor);
	}

	public static string ConstructHighlight(this string code)
	{
		return Highlight(code, ConstructColor);
	}

	public static string InterfaceHighlight(this string code)
	{
		return Highlight(code, InterfaceColor);
	}

	public static string EnumHighlight(this string code)
	{
		return Highlight(code, EnumColor);
	}

	public static string TypeHighlight(this string code)
	{
		return Highlight(code, TypeColor);
	}

	public static string StringHighlight(this string code)
	{
		return Highlight(code, StringColor);
	}

	public static string NumericHighlight(this string code)
	{
		return Highlight(code, NumericColor);
	}

	public static string CommentHighlight(this string code)
	{
		return Highlight(code, CommentColor);
	}

	public static string SummaryHighlight(this string code)
	{
		return Highlight(code, SummaryColor);
	}

	public static string VariableHighlight(this string code)
	{
		return Highlight(code, VariableColor);
	}

	public static string ControlHighlight(this string code)
	{
		return Highlight(code, "FF6BE8");
	}

	public static string RecommendationHighlight(this string code)
	{
		return Highlight(code, RecommendationColor);
	}

	public static string RemoveHighlights(this string code)
	{
		return code.RemoveBetween("[BeginUAPreviewHighlight]", "[EndUAPreviewHighlight]");
	}

	public static string RemoveMarkdown(this string code)
	{
		return code.Replace("[BeginUAPreviewHighlight]", string.Empty).Replace("[EndUAPreviewHighlight]", string.Empty);
	}
}

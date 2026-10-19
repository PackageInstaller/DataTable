using System;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting.FullSerializer.Internal;

public static class fsTypeExtensions
{
	public static string CSharpName(this Type type)
	{
		return type.CSharpName(includeNamespace: false);
	}

	public static string CSharpName(this Type type, bool includeNamespace, bool ensureSafeDeclarationName)
	{
		string text = type.CSharpName(includeNamespace);
		if (ensureSafeDeclarationName)
		{
			text = text.Replace('>', '_').Replace('<', '_').Replace('.', '_');
		}
		return text;
	}

	public static string CSharpName(this Type type, bool includeNamespace)
	{
		if (type == typeof(void))
		{
			return "void";
		}
		if (type == typeof(int))
		{
			return "int";
		}
		if (type == typeof(float))
		{
			return "float";
		}
		if (type == typeof(bool))
		{
			return "bool";
		}
		if (type == typeof(double))
		{
			return "double";
		}
		if (type == typeof(string))
		{
			return "string";
		}
		if (type.IsGenericParameter)
		{
			return type.ToString();
		}
		string text = "";
		IEnumerable<Type> source = type.GetGenericArguments();
		if (type.IsNested)
		{
			text = text + type.DeclaringType.CSharpName() + ".";
			if (type.DeclaringType.GetGenericArguments().Length != 0)
			{
				source = source.Skip(type.DeclaringType.GetGenericArguments().Length);
			}
		}
		if (!source.Any())
		{
			text += type.Name;
		}
		else
		{
			int num = type.Name.IndexOf('`');
			if (num > 0)
			{
				text += type.Name.Substring(0, num);
			}
			text = text + "<" + string.Join(",", source.Select((Type t) => t.CSharpName(includeNamespace)).ToArray()) + ">";
		}
		if (includeNamespace && type.Namespace != null)
		{
			text = type.Namespace + "." + text;
		}
		return text;
	}
}

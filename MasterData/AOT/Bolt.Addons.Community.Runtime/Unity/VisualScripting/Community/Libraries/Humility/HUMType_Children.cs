using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Unity.VisualScripting.Community.Libraries.CSharp;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMType_Children
{
	public enum HighlightType
	{
		None,
		Enum,
		Interface,
		Type,
		Construct,
		Comment,
		Variable
	}

	public static HUMType.Data.With With(this HUMType.Data.Types types)
	{
		return new HUMType.Data.With(types);
	}

	public static T New<T>(this HUMType.Data.As @as)
	{
		return (T)@as.type.New();
	}

	public static string CSharpName(this HUMType.Data.As @as, bool hideSystemObject = false, bool fullName = false, bool highlight = true)
	{
		if (highlight)
		{
			return @as.HighlightCSharpName(hideSystemObject, fullName);
		}
		if (@as.type == null)
		{
			return "null";
		}
		if (@as.type == typeof(Unity.VisualScripting.Community.Libraries.CSharp.Void))
		{
			return "void";
		}
		if (@as.type.IsConstructedGenericType || @as.type.IsGenericType)
		{
			return GenericDeclaration(@as.type);
		}
		if (@as.type == typeof(int))
		{
			return "int";
		}
		if (@as.type == typeof(string))
		{
			return "string";
		}
		if (@as.type == typeof(float))
		{
			return "float";
		}
		if (@as.type == typeof(void))
		{
			return "void";
		}
		if (@as.type == typeof(double))
		{
			return "double";
		}
		if (@as.type == typeof(bool))
		{
			return "bool";
		}
		if (@as.type == typeof(byte))
		{
			return "byte";
		}
		if (@as.type == typeof(void))
		{
			return "void";
		}
		if (@as.type == typeof(object) && @as.type.BaseType == null)
		{
			if (!hideSystemObject)
			{
				return "object";
			}
			return string.Empty;
		}
		if (@as.type == typeof(object[]))
		{
			return "object[]";
		}
		if (!fullName)
		{
			return @as.type.Name;
		}
		return @as.type.FullName;
	}

	private static string HighlightCSharpName(this HUMType.Data.As @as, bool hideSystemObject = false, bool fullName = false)
	{
		if (@as.type == null)
		{
			return "null".ConstructHighlight();
		}
		if (@as.type == typeof(Unity.VisualScripting.Community.Libraries.CSharp.Void))
		{
			return "void".ConstructHighlight();
		}
		if (@as.type.IsConstructedGenericType || @as.type.IsGenericType)
		{
			return GenericDeclaration(@as.type);
		}
		if (@as.type == typeof(int))
		{
			return "int".ConstructHighlight();
		}
		if (@as.type == typeof(string))
		{
			return "string".ConstructHighlight();
		}
		if (@as.type == typeof(float))
		{
			return "float".ConstructHighlight();
		}
		if (@as.type == typeof(void))
		{
			return "void".ConstructHighlight();
		}
		if (@as.type == typeof(double))
		{
			return "double".ConstructHighlight();
		}
		if (@as.type == typeof(bool))
		{
			return "bool".ConstructHighlight();
		}
		if (@as.type == typeof(byte))
		{
			return "byte".ConstructHighlight();
		}
		if (@as.type == typeof(void))
		{
			return "void".ConstructHighlight();
		}
		if (@as.type.IsEnum)
		{
			return @as.type.Name.EnumHighlight();
		}
		if (@as.type.IsInterface)
		{
			return @as.type.Name.InterfaceHighlight();
		}
		if (@as.type == typeof(object) && @as.type.BaseType == null)
		{
			if (!hideSystemObject)
			{
				return "object".ConstructHighlight();
			}
			return string.Empty;
		}
		if (@as.type == typeof(object[]))
		{
			return "object".ConstructHighlight() + "[]";
		}
		if (!fullName)
		{
			return @as.type.Name.TypeHighlight();
		}
		return @as.type.FullName.Replace(@as.type.Name, @as.type.Name.TypeHighlight());
	}

	public static string CSharpName(this HUMString.Data.As asData, bool hideSystemObject = false, HighlightType highlightType = HighlightType.None)
	{
		if (string.IsNullOrEmpty(asData.text) || string.IsNullOrWhiteSpace(asData.text))
		{
			return "null";
		}
		if (asData.text == "Int32")
		{
			return "int";
		}
		if (asData.text == "String")
		{
			return "string";
		}
		if (asData.text == "Float")
		{
			return "float";
		}
		if (asData.text == "Void")
		{
			return "void";
		}
		if (asData.text == "Double")
		{
			return "double";
		}
		if (asData.text == "Bool" || asData.text == "Boolean")
		{
			return "bool";
		}
		if (asData.text == "Byte")
		{
			return "byte";
		}
		if (asData.text == "Object")
		{
			if (!hideSystemObject)
			{
				return "object";
			}
			return string.Empty;
		}
		return asData.text.WithHighlight(highlightType);
	}

	public static string WithHighlight(this string text, HighlightType type)
	{
		return type switch
		{
			HighlightType.None => text, 
			HighlightType.Comment => text.CommentHighlight(), 
			HighlightType.Construct => text.ConstructHighlight(), 
			HighlightType.Interface => text.InterfaceHighlight(), 
			HighlightType.Enum => text.EnumHighlight(), 
			HighlightType.Type => text.TypeHighlight(), 
			HighlightType.Variable => text.VariableHighlight(), 
			_ => text, 
		};
	}

	public static bool Type<T>(this HUMType.Data.Is isData)
	{
		return isData.type == typeof(T);
	}

	public static bool Type(this HUMType.Data.Is isData, Type type)
	{
		return isData.type == type;
	}

	public static bool Void(this HUMType.Data.Is isData)
	{
		return isData.type == typeof(void);
	}

	public static bool NullOrVoid(this HUMType.Data.Is isData)
	{
		if (!(isData.type == typeof(void)))
		{
			return isData.type == null;
		}
		return true;
	}

	public static bool Enumerator(this HUMType.Data.Is isData)
	{
		if (isData.type == typeof(IEnumerator) || isData.type == typeof(IEnumerable) || isData.type == typeof(IEnumerator<>) || isData.type == typeof(IEnumerable<>))
		{
			return true;
		}
		return false;
	}

	public static bool Enumerator(this HUMType.Data.Has hasData, bool fields = true, bool methods = true)
	{
		return hasData.type.HasFieldOrMethodOfType<IEnumerator>(fields, methods);
	}

	public static bool Enumerator(this HUMType.Data.Generic genericData)
	{
		Type[] interfaces = genericData.isData.type.GetInterfaces();
		for (int i = 0; i < interfaces.Length; i++)
		{
			if (interfaces[i].IsGenericType && interfaces[i].GetGenericTypeDefinition() == typeof(IEnumerator<>))
			{
				return true;
			}
		}
		return false;
	}

	public static bool Enumerable(this HUMType.Data.Generic genericData)
	{
		Type[] interfaces = genericData.isData.type.GetInterfaces();
		for (int i = 0; i < interfaces.Length; i++)
		{
			if (interfaces[i].IsGenericType && interfaces[i].GetGenericTypeDefinition() == typeof(IEnumerable<>))
			{
				return true;
			}
		}
		return false;
	}

	public static bool Enumerable(this HUMType.Data.Is isData)
	{
		if (!isData.type.Inherits(typeof(IEnumerator)) && !isData.type.Inherits(typeof(IEnumerable)) && !isData.type.Is().Generic().Enumerator())
		{
			return isData.Enumerator();
		}
		return true;
	}

	public static bool Enumerable(this HUMType.Data.Has has, bool fields = true, bool methods = true)
	{
		return has.type.HasFieldOrMethodOfType<IEnumerable>(fields, methods);
	}

	public static bool Coroutine(this HUMType.Data.Is isData)
	{
		if (isData.type == typeof(IEnumerator) && isData.type != typeof(IEnumerable) && isData.type != typeof(IEnumerator<>) && isData.type != typeof(IEnumerable<>))
		{
			return true;
		}
		if (!(isData.type == typeof(Coroutine)) && !(isData.type == typeof(YieldInstruction)))
		{
			return isData.type == typeof(CustomYieldInstruction);
		}
		return true;
	}

	public static Type[] Attribute<TAttribute>(this HUMType.Data.With with) where TAttribute : Attribute
	{
		List<Type> result = new List<Type>();
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		for (int i = 0; i < assemblies.Length; i++)
		{
			Type[] types = assemblies[i].GetTypes();
			int type;
			for (type = 0; type < types.Length; type++)
			{
				if (!with.types.get.type.IsAssignableFrom(types[type]) || types[type].IsAbstract)
				{
					continue;
				}
				object[] customAttributes = types[type].GetCustomAttributes(typeof(TAttribute), inherit: false);
				if (customAttributes != null && customAttributes.Length != 0)
				{
					(customAttributes[0] as TAttribute).Is().NotNull(() =>
					{
						result.Add(types[type]);
					});
				}
			}
		}
		return result.ToArray();
	}

	public static HUMType.Data.Generic Generic(this HUMType.Data.Is isData)
	{
		return new HUMType.Data.Generic(isData);
	}

	public static Type[] Derived(this HUMType.Data.Get derived, bool includeSelf = false)
	{
		List<Type> list = new List<Type>();
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		for (int i = 0; i < assemblies.Length; i++)
		{
			Type[] types = assemblies[i].GetTypes();
			for (int j = 0; j < types.Length; j++)
			{
				if (!types[j].IsAbstract && !types[j].IsInterface && derived.type.IsAssignableFrom(types[j]))
				{
					list.Add(types[j]);
				}
			}
		}
		if (includeSelf)
		{
			list.Add(derived.type);
		}
		return list.ToArray();
	}

	public static Type[] All(this HUMType.Data.Get derived, bool includeSelf = false)
	{
		List<Type> list = new List<Type>();
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		for (int i = 0; i < assemblies.Length; i++)
		{
			Type[] types = assemblies[i].GetTypes();
			for (int j = 0; j < types.Length; j++)
			{
				if (derived.type.IsAssignableFrom(types[j]))
				{
					list.Add(types[j]);
				}
			}
		}
		if (includeSelf)
		{
			list.Add(derived.type);
		}
		return list.ToArray();
	}

	public static bool PrimitiveOrString(this HUMType.Data.Is @is)
	{
		if (!@is.type.IsPrimitive)
		{
			return @is.type == typeof(string);
		}
		return true;
	}

	public static bool PrimitiveStringOrVoid(this HUMType.Data.Is @is)
	{
		if (@is.type == null)
		{
			return false;
		}
		if (!@is.type.IsPrimitive && !(@is.type == typeof(string)) && !(@is.type == typeof(void)))
		{
			if (@is.type.BaseType == null)
			{
				return @is.type == typeof(object);
			}
			return false;
		}
		return true;
	}

	public static HUMType.Data.Types Types(this HUMType.Data.Get get)
	{
		return new HUMType.Data.Types(get);
	}

	public static string Code(this HUMValue.Data.As @as, bool isNew, bool isLiteral = false, bool highlight = true, string parameters = "", bool newLineLiteral = false)
	{
		if (highlight)
		{
			return @as.HighlightedCode(isNew, isLiteral, parameters, newLineLiteral);
		}
		Type type = @as.value?.GetType();
		if (@as.value is Type)
		{
			return "typeof(" + ((Type)@as.value).As().CSharpName() + ")";
		}
		if (type == null)
		{
			return "null";
		}
		if (type == typeof(void))
		{
			return "void";
		}
		if (type == typeof(bool))
		{
			return @as.value.ToString().ToLower();
		}
		if (type == typeof(float))
		{
			return @as.value.ToString().Replace(",", ".") + "f";
		}
		if (type == typeof(string))
		{
			return "\"" + @as.value.ToString() + "\"";
		}
		if (type == typeof(GameObject))
		{
			return "null";
		}
		if (type == typeof(int) || type == typeof(uint) || type == typeof(byte) || type == typeof(long) || type == typeof(short) || type == typeof(double))
		{
			return @as.value.ToString();
		}
		if (type.IsEnum)
		{
			return type.Name + "." + @as.value.ToString();
		}
		if (isNew)
		{
			if (type.IsClass || (!type.IsClass && !type.IsInterface && !type.IsEnum))
			{
				if (type.IsGenericType)
				{
					if (!isLiteral)
					{
						return "new ".ConstructHighlight() + GenericDeclaration(type) + "()";
					}
					return Literal(@as.value, newLineLiteral);
				}
				if (type.IsConstructedGenericType)
				{
					if (!isLiteral)
					{
						return "new " + GenericDeclaration(type) + "(" + parameters + ")";
					}
					return Literal(@as.value, newLineLiteral);
				}
				if (!isLiteral)
				{
					return "new " + type.Name + "(" + parameters + ")";
				}
				return Literal(@as.value, newLineLiteral);
			}
			if (type.IsValueType && !type.IsEnum && !type.IsPrimitive)
			{
				if (!isLiteral)
				{
					return "new " + type.Name + "(" + parameters + ")";
				}
				return Literal(@as.value, newLineLiteral);
			}
		}
		return @as.value.ToString();
	}

	private static string HighlightedCode(this HUMValue.Data.As @as, bool isNew, bool isLiteral = false, string parameters = "", bool newLineLiteral = false)
	{
		Type type = @as.value?.GetType();
		if (@as.value is Type)
		{
			return "typeof".ConstructHighlight() + "(" + ((Type)@as.value).As().CSharpName().TypeHighlight() + ")";
		}
		if (type == null)
		{
			return "null".ConstructHighlight();
		}
		if (type == typeof(void))
		{
			return "void".ConstructHighlight();
		}
		if (type == typeof(bool))
		{
			return @as.value.ToString().ToLower().ConstructHighlight();
		}
		if (type == typeof(float))
		{
			return (@as.value.ToString().Replace(",", ".") + "f").NumericHighlight();
		}
		if (type == typeof(string))
		{
			return ("\"" + @as.value.ToString() + "\"").StringHighlight();
		}
		if (type == typeof(GameObject))
		{
			return "null".ConstructHighlight();
		}
		if (type == typeof(int) || type == typeof(uint) || type == typeof(byte) || type == typeof(long) || type == typeof(short) || type == typeof(double))
		{
			return @as.value.ToString().NumericHighlight();
		}
		if (type.IsEnum)
		{
			return type.Name.EnumHighlight() + "." + @as.value.ToString();
		}
		if (isNew)
		{
			if (type.IsClass || (!type.IsClass && !type.IsInterface && !type.IsEnum))
			{
				if (type.IsGenericType)
				{
					if (!isLiteral)
					{
						return "new ".ConstructHighlight() + GenericDeclaration(type) + "()";
					}
					return Literal(@as.value, newLineLiteral);
				}
				if (type.IsConstructedGenericType)
				{
					if (!isLiteral)
					{
						return "new ".ConstructHighlight() + GenericDeclaration(type) + "(" + parameters + ")";
					}
					return Literal(@as.value, newLineLiteral);
				}
				if (!isLiteral)
				{
					return "new ".ConstructHighlight() + type.Name.TypeHighlight() + "(" + parameters + ")";
				}
				return Literal(@as.value, newLineLiteral);
			}
			if (type.IsValueType && !type.IsEnum && !type.IsPrimitive)
			{
				if (!isLiteral)
				{
					return "new ".ConstructHighlight() + type.Name.TypeHighlight() + "(" + parameters + ")";
				}
				return Literal(@as.value, newLineLiteral);
			}
		}
		return @as.value.ToString();
	}

	private static string Literal(object value, bool newLine = false)
	{
		FieldInfo[] array = value?.GetType().GetFields();
		string empty = string.Empty;
		List<FieldInfo> list = new List<FieldInfo>();
		bool flag = array.Length > 2;
		if (value is IDictionary { Count: >0 })
		{
			flag = true;
		}
		empty = empty + (newLine ? "\n" : string.Empty) + "new ".ConstructHighlight() + ((!value.GetType().IsGenericType) ? value.GetType().Name.TypeHighlight() : GenericDeclaration(value.GetType())) + "()" + (flag ? "\n{\n" : " { ");
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].IsPublic && !array[i].IsStatic && !array[i].IsInitOnly)
			{
				list.Add(array[i]);
			}
		}
		if (value.GetType().IsGenericType)
		{
			if (value is IList list2)
			{
				int num = 0;
				foreach (object item in list2)
				{
					empty += item.As().Code(isNew: true, isLiteral: true);
					if (++num != list2.Count)
					{
						empty += ", ";
					}
				}
			}
			else if (value is IDictionary dictionary2)
			{
				int num2 = 0;
				foreach (DictionaryEntry item2 in dictionary2)
				{
					empty = empty + CodeBuilder.Indent(1) + "{ ";
					empty += item2.Key.As().Code(isNew: true, isLiteral: true);
					empty += ", ";
					empty += item2.Value.As().Code(isNew: true, isLiteral: true);
					empty += "}";
					if (++num2 != dictionary2.Count)
					{
						empty += ", \n";
					}
				}
			}
		}
		else if (value is AotList || value is AotDictionary)
		{
			if (value is AotList aotList)
			{
				int num3 = 0;
				foreach (object item3 in aotList)
				{
					empty += item3.As().Code(isNew: true, isLiteral: true);
					if (++num3 != aotList.Count)
					{
						empty += ", ";
					}
				}
			}
			else if (value is AotDictionary aotDictionary)
			{
				int num4 = 0;
				foreach (DictionaryEntry item4 in aotDictionary)
				{
					empty = empty + CodeBuilder.Indent(1) + "{ ";
					empty += item4.Key.As().Code(isNew: true, isLiteral: true);
					empty += ", ";
					empty += item4.Value.As().Code(isNew: true, isLiteral: true);
					empty += "}";
					if (++num4 != aotDictionary.Count)
					{
						empty += ", \n";
					}
				}
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			empty = empty + (flag ? CodeBuilder.Indent(1) : string.Empty) + list[j].Name + " = " + list[j].GetValue(value).As().Code(isNew: true);
			empty += ((j < list.Count - 1) ? (", " + (flag ? "\n" : string.Empty)) : string.Empty);
		}
		return empty + (flag ? "\n}" : " } ");
	}

	public static string GenericDeclaration(Type type)
	{
		string empty = string.Empty;
		if (!type.IsConstructedGenericType && !type.IsGenericType)
		{
			throw new Exception("Type is not a generic type but you are trying to declare a generic.");
		}
		empty += (type.Name.Contains("`") ? type.Name.Remove(type.Name.IndexOf("`"), type.Name.Length - type.Name.IndexOf("`")).TypeHighlight() : type.Name.TypeHighlight());
		empty += "<";
		Type[] genericArguments = type.GetGenericArguments();
		for (int i = 0; i < genericArguments.Length; i++)
		{
			empty += genericArguments[i].As().CSharpName();
			if (i < genericArguments.Length - 1)
			{
				empty += ", ";
			}
		}
		return empty + ">";
	}

	public static string GenericDeclaration(Type type, List<Type> parameters)
	{
		string empty = string.Empty;
		if (!type.IsConstructedGenericType && !type.IsGenericType)
		{
			return type.As().CSharpName();
		}
		empty += (type.Name.Contains("`") ? type.Name.Remove(type.Name.IndexOf("`"), type.Name.Length - type.Name.IndexOf("`")).TypeHighlight() : type.Name.TypeHighlight());
		if (parameters.Count > 0)
		{
			empty += "<";
			for (int i = 0; i < parameters.Count; i++)
			{
				empty += parameters[i].As().CSharpName();
				if (i < parameters.Count - 1)
				{
					empty += ", ";
				}
			}
			return empty + ">";
		}
		empty += "<";
		Type[] genericArguments = type.GetGenericArguments();
		for (int j = 0; j < genericArguments.Length; j++)
		{
			empty += genericArguments[j].As().CSharpName();
			if (j < genericArguments.Length - 1)
			{
				empty += ", ";
			}
		}
		return empty + ">";
	}

	public static string GenericDeclaration(Type type, params Type[] parameters)
	{
		string empty = string.Empty;
		if (!type.IsConstructedGenericType && !type.IsGenericType)
		{
			return type.As().CSharpName();
		}
		empty += (type.Name.Contains("`") ? type.Name.Remove(type.Name.IndexOf("`"), type.Name.Length - type.Name.IndexOf("`")).TypeHighlight() : type.Name.TypeHighlight());
		if (parameters.Length != 0)
		{
			empty += "<";
			for (int i = 0; i < parameters.Length; i++)
			{
				empty += parameters[i].As().CSharpName();
				if (i < parameters.Length - 1)
				{
					empty += ", ";
				}
			}
			return empty + ">";
		}
		empty += "<";
		Type[] genericArguments = type.GetGenericArguments();
		for (int j = 0; j < genericArguments.Length; j++)
		{
			empty += genericArguments[j].As().CSharpName();
			if (j < genericArguments.Length - 1)
			{
				empty += ", ";
			}
		}
		return empty + ">";
	}
}

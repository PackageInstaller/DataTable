using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Text;
using System.Threading;

namespace System;

internal class TypeSpec
{
	[Flags]
	internal enum DisplayNameFormat
	{
		Default = 0,
		WANT_ASSEMBLY = 1,
		NO_MODIFIERS = 2
	}

	private TypeIdentifier name;

	private string assembly_name;

	private List<TypeIdentifier> nested;

	private List<TypeSpec> generic_params;

	private List<ModifierSpec> modifier_spec;

	private bool is_byref;

	private string display_fullname;

	internal bool HasModifiers => modifier_spec != null;

	internal string DisplayFullName
	{
		get
		{
			if (display_fullname == null)
			{
				display_fullname = GetDisplayFullName(DisplayNameFormat.Default);
			}
			return display_fullname;
		}
	}

	private string GetDisplayFullName(DisplayNameFormat flags)
	{
		bool flag = (flags & DisplayNameFormat.WANT_ASSEMBLY) != 0;
		bool flag2 = (flags & DisplayNameFormat.NO_MODIFIERS) == 0;
		StringBuilder stringBuilder = new StringBuilder(name.DisplayName);
		if (nested != null)
		{
			foreach (TypeIdentifier item in nested)
			{
				stringBuilder.Append('+').Append(item.DisplayName);
			}
		}
		if (generic_params != null)
		{
			stringBuilder.Append('[');
			for (int i = 0; i < generic_params.Count; i++)
			{
				if (i > 0)
				{
					stringBuilder.Append(", ");
				}
				if (generic_params[i].assembly_name != null)
				{
					stringBuilder.Append('[').Append(generic_params[i].DisplayFullName).Append(']');
				}
				else
				{
					stringBuilder.Append(generic_params[i].DisplayFullName);
				}
			}
			stringBuilder.Append(']');
		}
		if (flag2)
		{
			GetModifierString(stringBuilder);
		}
		if ((assembly_name != null) & flag)
		{
			stringBuilder.Append(", ").Append(assembly_name);
		}
		return stringBuilder.ToString();
	}

	private StringBuilder GetModifierString(StringBuilder sb)
	{
		if (modifier_spec != null)
		{
			foreach (ModifierSpec item in modifier_spec)
			{
				item.Append(sb);
			}
		}
		if (is_byref)
		{
			sb.Append('&');
		}
		return sb;
	}

	internal static TypeSpec Parse(string typeName)
	{
		int p = 0;
		if (typeName == null)
		{
			throw new ArgumentNullException("typeName");
		}
		TypeSpec result = Parse(typeName, ref p, is_recurse: false, allow_aqn: true);
		if (p < typeName.Length)
		{
			throw new ArgumentException("Count not parse the whole type name", "typeName");
		}
		return result;
	}

	internal static string UnescapeInternalName(string displayName)
	{
		StringBuilder stringBuilder = new StringBuilder(displayName.Length);
		for (int i = 0; i < displayName.Length; i++)
		{
			char c = displayName[i];
			if (c == '\\' && ++i < displayName.Length)
			{
				c = displayName[i];
			}
			stringBuilder.Append(c);
		}
		return stringBuilder.ToString();
	}

	internal Type Resolve(Func<AssemblyName, Assembly> assemblyResolver, Func<Assembly, string, bool, Type> typeResolver, bool throwOnError, bool ignoreCase, ref StackCrawlMark stackMark)
	{
		Assembly assembly = null;
		if (assemblyResolver == null && typeResolver == null)
		{
			return RuntimeType.GetType(DisplayFullName, throwOnError, ignoreCase, reflectionOnly: false, ref stackMark);
		}
		if (assembly_name != null)
		{
			assembly = ((assemblyResolver == null) ? Assembly.Load(assembly_name) : assemblyResolver(new AssemblyName(assembly_name)));
			if (assembly == null)
			{
				if (throwOnError)
				{
					throw new FileNotFoundException("Could not resolve assembly '" + assembly_name + "'");
				}
				return null;
			}
		}
		Type type = null;
		type = ((typeResolver == null) ? assembly.GetType(name.DisplayName, throwOnError: false, ignoreCase) : typeResolver(assembly, name.DisplayName, ignoreCase));
		if (type == null)
		{
			if (throwOnError)
			{
				throw new TypeLoadException("Could not resolve type '" + name?.ToString() + "'");
			}
			return null;
		}
		if (nested != null)
		{
			foreach (TypeIdentifier item in nested)
			{
				Type nestedType = type.GetNestedType(item.DisplayName, BindingFlags.Public | BindingFlags.NonPublic);
				if (nestedType == null)
				{
					if (throwOnError)
					{
						throw new TypeLoadException("Could not resolve type '" + item?.ToString() + "'");
					}
					return null;
				}
				type = nestedType;
			}
		}
		if (generic_params != null)
		{
			Type[] array = new Type[generic_params.Count];
			for (int i = 0; i < array.Length; i++)
			{
				Type type2 = generic_params[i].Resolve(assemblyResolver, typeResolver, throwOnError, ignoreCase, ref stackMark);
				if (type2 == null)
				{
					if (throwOnError)
					{
						throw new TypeLoadException("Could not resolve type '" + generic_params[i].name?.ToString() + "'");
					}
					return null;
				}
				array[i] = type2;
			}
			type = type.MakeGenericType(array);
		}
		if (modifier_spec != null)
		{
			foreach (ModifierSpec item2 in modifier_spec)
			{
				type = item2.Resolve(type);
			}
		}
		if (is_byref)
		{
			type = type.MakeByRefType();
		}
		return type;
	}

	private void AddName(string type_name)
	{
		if (name == null)
		{
			name = ParsedTypeIdentifier(type_name);
			return;
		}
		if (nested == null)
		{
			nested = new List<TypeIdentifier>();
		}
		nested.Add(ParsedTypeIdentifier(type_name));
	}

	private void AddModifier(ModifierSpec md)
	{
		if (modifier_spec == null)
		{
			modifier_spec = new List<ModifierSpec>();
		}
		modifier_spec.Add(md);
	}

	private static void SkipSpace(string name, ref int pos)
	{
		int i;
		for (i = pos; i < name.Length && char.IsWhiteSpace(name[i]); i++)
		{
		}
		pos = i;
	}

	private static void BoundCheck(int idx, string s)
	{
		if (idx >= s.Length)
		{
			throw new ArgumentException("Invalid generic arguments spec", "typeName");
		}
	}

	private static TypeIdentifier ParsedTypeIdentifier(string displayName)
	{
		return TypeIdentifiers.FromDisplay(displayName);
	}

	private static TypeSpec Parse(string name, ref int p, bool is_recurse, bool allow_aqn)
	{
		int i = p;
		bool flag = false;
		TypeSpec typeSpec = new TypeSpec();
		SkipSpace(name, ref i);
		int num = i;
		for (; i < name.Length; i++)
		{
			switch (name[i])
			{
			case '+':
				typeSpec.AddName(name.Substring(num, i - num));
				num = i + 1;
				break;
			case ',':
			case ']':
				typeSpec.AddName(name.Substring(num, i - num));
				num = i + 1;
				flag = true;
				if (is_recurse && !allow_aqn)
				{
					p = i;
					return typeSpec;
				}
				break;
			case '&':
			case '*':
			case '[':
				if ((name[i] != '[') & is_recurse)
				{
					throw new ArgumentException("Generic argument can't be byref or pointer type", "typeName");
				}
				typeSpec.AddName(name.Substring(num, i - num));
				num = i + 1;
				flag = true;
				break;
			case '\\':
				i++;
				break;
			}
			if (flag)
			{
				break;
			}
		}
		if (num < i)
		{
			typeSpec.AddName(name.Substring(num, i - num));
		}
		else if (num == i)
		{
			typeSpec.AddName(string.Empty);
		}
		if (flag)
		{
			for (; i < name.Length; i++)
			{
				switch (name[i])
				{
				case '&':
					if (typeSpec.is_byref)
					{
						throw new ArgumentException("Can't have a byref of a byref", "typeName");
					}
					typeSpec.is_byref = true;
					break;
				case '*':
				{
					if (typeSpec.is_byref)
					{
						throw new ArgumentException("Can't have a pointer to a byref type", "typeName");
					}
					int num2 = 1;
					while (i + 1 < name.Length && name[i + 1] == '*')
					{
						i++;
						num2++;
					}
					typeSpec.AddModifier(new PointerSpec(num2));
					break;
				}
				case ',':
					if (is_recurse & allow_aqn)
					{
						int j;
						for (j = i; j < name.Length && name[j] != ']'; j++)
						{
						}
						if (j >= name.Length)
						{
							throw new ArgumentException("Unmatched ']' while parsing generic argument assembly name");
						}
						typeSpec.assembly_name = name.Substring(i + 1, j - i - 1).Trim();
						p = j;
						return typeSpec;
					}
					if (is_recurse)
					{
						p = i;
						return typeSpec;
					}
					if (allow_aqn)
					{
						typeSpec.assembly_name = name.Substring(i + 1).Trim();
						i = name.Length;
					}
					break;
				case '[':
				{
					if (typeSpec.is_byref)
					{
						throw new ArgumentException("Byref qualifier must be the last one of a type", "typeName");
					}
					i++;
					if (i >= name.Length)
					{
						throw new ArgumentException("Invalid array/generic spec", "typeName");
					}
					SkipSpace(name, ref i);
					if (name[i] != ',' && name[i] != '*' && name[i] != ']')
					{
						List<TypeSpec> list = new List<TypeSpec>();
						if (typeSpec.HasModifiers)
						{
							throw new ArgumentException("generic args after array spec or pointer type", "typeName");
						}
						for (; i < name.Length; i++)
						{
							SkipSpace(name, ref i);
							bool flag2 = name[i] == '[';
							if (flag2)
							{
								i++;
							}
							list.Add(Parse(name, ref i, is_recurse: true, flag2));
							BoundCheck(i, name);
							if (flag2)
							{
								if (name[i] != ']')
								{
									throw new ArgumentException("Unclosed assembly-qualified type name at " + name[i], "typeName");
								}
								i++;
								BoundCheck(i, name);
							}
							if (name[i] == ']')
							{
								break;
							}
							if (name[i] != ',')
							{
								throw new ArgumentException("Invalid generic arguments separator " + name[i], "typeName");
							}
						}
						if (i >= name.Length || name[i] != ']')
						{
							throw new ArgumentException("Error parsing generic params spec", "typeName");
						}
						typeSpec.generic_params = list;
						break;
					}
					int num3 = 1;
					bool flag3 = false;
					while (i < name.Length && name[i] != ']')
					{
						if (name[i] == '*')
						{
							if (flag3)
							{
								throw new ArgumentException("Array spec cannot have 2 bound dimensions", "typeName");
							}
							flag3 = true;
						}
						else
						{
							if (name[i] != ',')
							{
								throw new ArgumentException("Invalid character in array spec " + name[i], "typeName");
							}
							num3++;
						}
						i++;
						SkipSpace(name, ref i);
					}
					if (i >= name.Length || name[i] != ']')
					{
						throw new ArgumentException("Error parsing array spec", "typeName");
					}
					if ((num3 > 1) & flag3)
					{
						throw new ArgumentException("Invalid array spec, multi-dimensional array cannot be bound", "typeName");
					}
					typeSpec.AddModifier(new ArraySpec(num3, flag3));
					break;
				}
				case ']':
					if (is_recurse)
					{
						p = i;
						return typeSpec;
					}
					throw new ArgumentException("Unmatched ']'", "typeName");
				default:
					throw new ArgumentException("Bad type def, can't handle '" + name[i] + "' at " + i, "typeName");
				}
			}
		}
		p = i;
		return typeSpec;
	}
}

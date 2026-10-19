using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Unity.VisualScripting;

public class TypeName
{
	private enum ParseState
	{
		Name,
		Array,
		Generics,
		Assembly
	}

	private readonly List<string> names = new List<string>();

	private readonly List<int> genericarities = new List<int>();

	public string AssemblyDescription { get; private set; }

	public string AssemblyName { get; private set; }

	public string AssemblyVersion { get; private set; }

	public string AssemblyCulture { get; private set; }

	public string AssemblyPublicKeyToken { get; private set; }

	public List<TypeName> GenericParameters { get; } = new List<TypeName>();

	public string Name { get; private set; }

	public bool IsArray => Name.EndsWith("[]");

	public string LastName => names[names.Count - 1];

	public static TypeName Parse(string s)
	{
		int index = 0;
		return new TypeName(s, ref index);
	}

	private TypeName(string s, ref int index)
	{
		try
		{
			int num = index;
			int num2 = num;
			int? num3 = null;
			int? num4 = null;
			int? num5 = null;
			bool flag = false;
			ParseState parseState = ParseState.Name;
			for (; index < s.Length; index++)
			{
				char c = s[index];
				char? c2 = ((index + 1 < s.Length) ? new char?(s[index + 1]) : ((char?)null));
				switch (parseState)
				{
				case ParseState.Name:
					switch (c)
					{
					case '[':
						if (index == num)
						{
							flag = true;
							num2++;
						}
						else if (c2 == ']' || c2 == ',')
						{
							parseState = ParseState.Array;
						}
						else
						{
							num3 = index;
							parseState = ParseState.Generics;
						}
						continue;
					case ']':
						break;
					case ',':
						parseState = ParseState.Assembly;
						num4 = index + 1;
						if (!num3.HasValue)
						{
							num3 = index;
						}
						continue;
					default:
						continue;
					}
					if (!flag)
					{
						continue;
					}
					break;
				case ParseState.Array:
					if (c == ']')
					{
						parseState = ParseState.Name;
					}
					continue;
				case ParseState.Generics:
					switch (c)
					{
					case ']':
						parseState = ParseState.Name;
						break;
					default:
						GenericParameters.Add(new TypeName(s, ref index));
						break;
					case ' ':
					case ',':
						break;
					}
					continue;
				case ParseState.Assembly:
					if (c != ']' || !flag)
					{
						continue;
					}
					num5 = index;
					break;
				default:
					continue;
				}
				break;
			}
			if (!num3.HasValue)
			{
				num3 = s.Length;
			}
			if (!num5.HasValue)
			{
				num5 = s.Length;
			}
			Name = s.Substring(num2, num3.Value - num2);
			if (Name.Contains('+'))
			{
				string[] array = Name.Split('+');
				for (int i = 0; i < array.Length; i++)
				{
					array[i].PartsAround('`', out var before, out var after);
					names.Add(before);
					if (after != null)
					{
						genericarities.Add(int.Parse(after));
					}
					else
					{
						genericarities.Add(0);
					}
				}
			}
			else
			{
				Name.PartsAround('`', out var before2, out var after2);
				names.Add(before2);
				if (after2 != null)
				{
					genericarities.Add(int.Parse(after2));
				}
				else
				{
					genericarities.Add(0);
				}
			}
			if (num4.HasValue)
			{
				AssemblyDescription = s.Substring(num4.Value, num5.Value - num4.Value);
				List<string> list = (from x in AssemblyDescription.Split(',')
					select x.Trim()).ToList();
				AssemblyVersion = LookForPairThenRemove(list, "Version");
				AssemblyCulture = LookForPairThenRemove(list, "Culture");
				AssemblyPublicKeyToken = LookForPairThenRemove(list, "PublicKeyToken");
				if (list.Count > 0)
				{
					AssemblyName = list[0];
				}
			}
		}
		catch (Exception innerException)
		{
			throw new FormatException("Failed to parse type name: " + s, innerException);
		}
	}

	private static string LookForPairThenRemove(List<string> strings, string Name)
	{
		for (int i = 0; i < strings.Count; i++)
		{
			string text = strings[i];
			if (text.IndexOf(Name) == 0)
			{
				int num = text.IndexOf('=');
				if (num > 0)
				{
					string result = text.Substring(num + 1);
					strings.RemoveAt(i);
					return result;
				}
			}
		}
		return null;
	}

	public void ReplaceNamespace(string oldNamespace, string newNamespace)
	{
		if (names[0].StartsWith(oldNamespace + "."))
		{
			names[0] = newNamespace + "." + names[0].TrimStart(oldNamespace + ".");
		}
		foreach (TypeName genericParameter in GenericParameters)
		{
			genericParameter.ReplaceNamespace(oldNamespace, newNamespace);
		}
		UpdateName();
	}

	public void ReplaceAssembly(string oldAssembly, string newAssembly)
	{
		if (AssemblyName != null && AssemblyName.StartsWith(oldAssembly))
		{
			AssemblyName = newAssembly + AssemblyName.TrimStart(oldAssembly);
		}
		foreach (TypeName genericParameter in GenericParameters)
		{
			genericParameter.ReplaceAssembly(oldAssembly, newAssembly);
		}
	}

	public void ReplaceName(string oldTypeName, Type newType)
	{
		ReplaceName(oldTypeName, newType.FullName, newType.Assembly?.GetName());
	}

	public void ReplaceName(string oldTypeName, string newTypeName, AssemblyName newAssemblyName = null)
	{
		for (int i = 0; i < names.Count; i++)
		{
			if (ToElementTypeName(names[i]) == oldTypeName)
			{
				names[i] = ToArrayOrType(names[i], newTypeName);
				if (newAssemblyName != null)
				{
					SetAssemblyName(newAssemblyName);
				}
			}
		}
		foreach (TypeName genericParameter in GenericParameters)
		{
			genericParameter.ReplaceName(oldTypeName, newTypeName, newAssemblyName);
		}
		UpdateName();
	}

	private static string ToElementTypeName(string s)
	{
		if (!s.EndsWith("[]"))
		{
			return s;
		}
		return s.Replace("[]", string.Empty);
	}

	private static string ToArrayOrType(string oldType, string newType)
	{
		if (oldType.EndsWith("[]"))
		{
			newType += "[]";
		}
		return newType;
	}

	public void SetAssemblyName(AssemblyName newAssemblyName)
	{
		AssemblyDescription = newAssemblyName.ToString();
		AssemblyName = newAssemblyName.Name;
		AssemblyCulture = newAssemblyName.CultureName;
		AssemblyVersion = newAssemblyName.Version.ToString();
		AssemblyPublicKeyToken = newAssemblyName.GetPublicKeyToken()?.ToHexString() ?? "null";
	}

	private void UpdateName()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < names.Count; i++)
		{
			if (i != 0)
			{
				stringBuilder.Append('+');
			}
			stringBuilder.Append(names[i]);
			if (genericarities[i] > 0)
			{
				stringBuilder.Append('`');
				stringBuilder.Append(genericarities[i]);
			}
		}
		Name = stringBuilder.ToString();
	}

	public string ToString(TypeNameDetail specification, TypeNameDetail genericsSpecification)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(Name);
		if (GenericParameters.Count > 0)
		{
			stringBuilder.Append("[");
			bool flag = true;
			foreach (TypeName genericParameter in GenericParameters)
			{
				if (!flag)
				{
					stringBuilder.Append(",");
				}
				if (genericsSpecification != TypeNameDetail.Name)
				{
					stringBuilder.Append("[");
				}
				stringBuilder.Append(genericParameter.ToString(genericsSpecification, genericsSpecification));
				if (genericsSpecification != TypeNameDetail.Name)
				{
					stringBuilder.Append("]");
				}
				flag = false;
			}
			stringBuilder.Append("]");
		}
		switch (specification)
		{
		case TypeNameDetail.Full:
			if (!string.IsNullOrEmpty(AssemblyDescription))
			{
				stringBuilder.Append(", ");
				stringBuilder.Append(AssemblyDescription);
			}
			break;
		case TypeNameDetail.NameAndAssembly:
			if (!string.IsNullOrEmpty(AssemblyName))
			{
				stringBuilder.Append(", ");
				stringBuilder.Append(AssemblyName);
			}
			break;
		}
		return stringBuilder.ToString();
	}

	public override string ToString()
	{
		return ToString(TypeNameDetail.Name, TypeNameDetail.Full);
	}

	public string ToLooseString()
	{
		return ToString(TypeNameDetail.NameAndAssembly, TypeNameDetail.NameAndAssembly);
	}

	public static string Simplify(string typeName)
	{
		return Parse(typeName).ToLooseString();
	}

	public static string SimplifyFast(string typeName)
	{
		while (true)
		{
			int num = typeName.IndexOf(", Version=", StringComparison.Ordinal);
			if (num < 0)
			{
				break;
			}
			int num2 = typeName.IndexOf(']', num);
			if (num2 >= 0)
			{
				typeName = typeName.Remove(num, num2 - num);
				continue;
			}
			typeName = typeName.Substring(0, num);
			break;
		}
		return typeName;
	}
}

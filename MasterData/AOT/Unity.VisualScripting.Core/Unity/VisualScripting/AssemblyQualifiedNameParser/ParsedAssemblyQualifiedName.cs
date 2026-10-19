using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Unity.VisualScripting.AssemblyQualifiedNameParser;

public class ParsedAssemblyQualifiedName
{
	private class Block
	{
		internal int startIndex;

		internal int endIndex;

		internal int level;

		internal Block parentBlock;

		internal readonly List<Block> innerBlocks = new List<Block>();

		internal ParsedAssemblyQualifiedName parsedAssemblyQualifiedName;
	}

	public string AssemblyDescriptionString { get; }

	public string TypeName { get; private set; }

	public string ShortAssemblyName { get; }

	public string Version { get; }

	public string Culture { get; }

	public string PublicKeyToken { get; }

	public List<ParsedAssemblyQualifiedName> GenericParameters { get; } = new List<ParsedAssemblyQualifiedName>();

	public int GenericParameterCount { get; }

	public ParsedAssemblyQualifiedName(string AssemblyQualifiedName)
	{
		int num = AssemblyQualifiedName.Length;
		bool flag = false;
		Block block = new Block();
		int num2 = 0;
		Block block2 = block;
		for (int i = 0; i < AssemblyQualifiedName.Length; i++)
		{
			char c = AssemblyQualifiedName[i];
			switch (c)
			{
			case '[':
			{
				if (AssemblyQualifiedName[i + 1] == ']')
				{
					i++;
					continue;
				}
				if (num2 == 0)
				{
					num = i;
				}
				num2++;
				Block block3 = new Block
				{
					startIndex = i + 1,
					level = num2,
					parentBlock = block2
				};
				block2.innerBlocks.Add(block3);
				block2 = block3;
				continue;
			}
			case ']':
				block2.endIndex = i - 1;
				if (AssemblyQualifiedName[block2.startIndex] != '[')
				{
					block2.parsedAssemblyQualifiedName = new ParsedAssemblyQualifiedName(AssemblyQualifiedName.Substring(block2.startIndex, i - block2.startIndex));
					if (num2 == 2)
					{
						GenericParameters.Add(block2.parsedAssemblyQualifiedName);
					}
				}
				block2 = block2.parentBlock;
				num2--;
				continue;
			default:
				if (num2 != 0 || c != ',')
				{
					continue;
				}
				break;
			}
			num = i;
			flag = true;
			break;
		}
		TypeName = AssemblyQualifiedName.Substring(0, num);
		int num3 = TypeName.IndexOf('`');
		if (num3 >= 0)
		{
			TypeName = TypeName.Substring(0, num3);
			GenericParameterCount = GenericParameters.Count;
		}
		if (flag)
		{
			AssemblyDescriptionString = AssemblyQualifiedName.Substring(num + 2);
			List<string> list = (from x in AssemblyDescriptionString.Split(',')
				select x.Trim()).ToList();
			Version = LookForPairThenRemove(list, "Version");
			Culture = LookForPairThenRemove(list, "Culture");
			PublicKeyToken = LookForPairThenRemove(list, "PublicKeyToken");
			if (list.Count > 0)
			{
				ShortAssemblyName = list[0];
			}
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

	public void Replace(string oldTypeName, string newTypeName)
	{
		if (TypeName == oldTypeName)
		{
			TypeName = newTypeName;
		}
		foreach (ParsedAssemblyQualifiedName genericParameter in GenericParameters)
		{
			genericParameter.Replace(oldTypeName, newTypeName);
		}
	}

	private string ToString(bool includeAssemblyDescription)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(TypeName);
		if (GenericParameters.Count > 0)
		{
			stringBuilder.Append("`");
			stringBuilder.Append(GenericParameterCount);
			stringBuilder.Append("[[");
			foreach (ParsedAssemblyQualifiedName genericParameter in GenericParameters)
			{
				stringBuilder.Append(genericParameter.ToString(includeAssemblyDescription: true));
			}
			stringBuilder.Append("]]");
		}
		if (includeAssemblyDescription)
		{
			stringBuilder.Append(", ");
			stringBuilder.Append(AssemblyDescriptionString);
		}
		return stringBuilder.ToString();
	}

	public override string ToString()
	{
		return ToString(includeAssemblyDescription: false);
	}
}

using System.Collections;
using System.Runtime.CompilerServices;

namespace System.Net;

internal class CaseInsensitiveAscii : IEqualityComparer, IComparer
{
	internal static readonly CaseInsensitiveAscii StaticInstance;

	internal static readonly byte[] AsciiToLower;

	public int GetHashCode(object myObject)
	{
		string text = myObject as string;
		if (myObject == null)
		{
			return 0;
		}
		int length = text.Length;
		if (length == 0)
		{
			return 0;
		}
		return length ^ ((AsciiToLower[(byte)text[0]] << 24) ^ (AsciiToLower[(byte)text[length - 1]] << 16));
	}

	public int Compare(object firstObject, object secondObject)
	{
		string text = firstObject as string;
		string text2 = secondObject as string;
		if (text == null)
		{
			if (text2 != null)
			{
				return -1;
			}
			return 0;
		}
		if (text2 == null)
		{
			return 1;
		}
		int num = text.Length - text2.Length;
		int num2 = ((num > 0) ? text2.Length : text.Length);
		for (int i = 0; i < num2; i++)
		{
			int num3 = AsciiToLower[(uint)text[i]] - AsciiToLower[(uint)text2[i]];
			if (num3 != 0)
			{
				num = num3;
				break;
			}
		}
		return num;
	}

	private int FastGetHashCode(string myString)
	{
		int num = myString.Length;
		if (num != 0)
		{
			num ^= (AsciiToLower[(byte)myString[0]] << 24) ^ (AsciiToLower[(byte)myString[num - 1]] << 16);
		}
		return num;
	}

	public new bool Equals(object firstObject, object secondObject)
	{
		string text = firstObject as string;
		string text2 = secondObject as string;
		if (text == null)
		{
			return text2 == null;
		}
		if (text2 != null)
		{
			int num = text.Length;
			if (num == text2.Length && FastGetHashCode(text) == FastGetHashCode(text2))
			{
				_ = text.Length;
				while (num > 0)
				{
					num--;
					if (AsciiToLower[(uint)text[num]] != AsciiToLower[(uint)text2[num]])
					{
						return false;
					}
				}
				return true;
			}
		}
		return false;
	}

	static CaseInsensitiveAscii()
	{
		//IL_001a: Field data (rva=0x490) could not be found in any section!
		//IL_001a: Field data (rva=0x490) could not be found in any section!
		StaticInstance = new CaseInsensitiveAscii();
		byte[] array = new byte[256];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		AsciiToLower = array;
	}
}

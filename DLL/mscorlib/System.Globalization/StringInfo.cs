using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public class StringInfo
{
	[OptionalField(VersionAdded = 2)]
	private string m_str;

	[NonSerialized]
	private int[] m_indexes;

	private int[] Indexes
	{
		get
		{
			if (m_indexes == null && 0 < String.Length)
			{
				m_indexes = ParseCombiningCharacters(String);
			}
			return m_indexes;
		}
	}

	public string String
	{
		get
		{
			return m_str;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("String", Environment.GetResourceString("String reference not set to an instance of a String."));
			}
			m_str = value;
			m_indexes = null;
		}
	}

	public int LengthInTextElements
	{
		get
		{
			if (Indexes == null)
			{
				return 0;
			}
			return Indexes.Length;
		}
	}

	public StringInfo()
		: this("")
	{
	}

	public StringInfo(string value)
	{
		String = value;
	}

	[OnDeserializing]
	private void OnDeserializing(StreamingContext ctx)
	{
		m_str = string.Empty;
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext ctx)
	{
		if (m_str.Length == 0)
		{
			m_indexes = null;
		}
	}

	[ComVisible(false)]
	public override bool Equals(object value)
	{
		if (value is StringInfo stringInfo)
		{
			return m_str.Equals(stringInfo.m_str);
		}
		return false;
	}

	[ComVisible(false)]
	public override int GetHashCode()
	{
		return m_str.GetHashCode();
	}

	internal static int GetCurrentTextElementLen(string str, int index, int len, ref UnicodeCategory ucCurrent, ref int currentCharCount)
	{
		if (index + currentCharCount == len)
		{
			return currentCharCount;
		}
		UnicodeCategory unicodeCategory = CharUnicodeInfo.InternalGetUnicodeCategory(str, index + currentCharCount, out var charLength);
		if (CharUnicodeInfo.IsCombiningCategory(unicodeCategory) && !CharUnicodeInfo.IsCombiningCategory(ucCurrent) && ucCurrent != UnicodeCategory.Format && ucCurrent != UnicodeCategory.Control && ucCurrent != UnicodeCategory.OtherNotAssigned && ucCurrent != UnicodeCategory.Surrogate)
		{
			int num = index;
			for (index += currentCharCount + charLength; index < len; index += charLength)
			{
				unicodeCategory = CharUnicodeInfo.InternalGetUnicodeCategory(str, index, out charLength);
				if (!CharUnicodeInfo.IsCombiningCategory(unicodeCategory))
				{
					ucCurrent = unicodeCategory;
					currentCharCount = charLength;
					break;
				}
			}
			return index - num;
		}
		int result = currentCharCount;
		ucCurrent = unicodeCategory;
		currentCharCount = charLength;
		return result;
	}

	public static int[] ParseCombiningCharacters(string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		int length = str.Length;
		int[] array = new int[length];
		if (length == 0)
		{
			return array;
		}
		int num = 0;
		int i = 0;
		int charLength;
		for (UnicodeCategory ucCurrent = CharUnicodeInfo.InternalGetUnicodeCategory(str, 0, out charLength); i < length; i += GetCurrentTextElementLen(str, i, length, ref ucCurrent, ref charLength))
		{
			array[num++] = i;
		}
		if (num < length)
		{
			int[] array2 = new int[num];
			Array.Copy(array, array2, num);
			return array2;
		}
		return array;
	}
}

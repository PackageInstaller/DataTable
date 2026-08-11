using System.Buffers;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Threading;
using Mono.Globalization.Unicode;
using Unity;

namespace System.Globalization;

[Serializable]
public class CompareInfo : IDeserializationCallback
{
	private const CompareOptions ValidIndexMaskOffFlags = ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth);

	private const CompareOptions ValidCompareMaskOffFlags = ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort);

	private const CompareOptions ValidHashCodeOfStringMaskOffFlags = ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth);

	private const CompareOptions ValidSortkeyCtorMaskOffFlags = ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort);

	internal static readonly CompareInfo Invariant = CultureInfo.InvariantCulture.CompareInfo;

	[OptionalField(VersionAdded = 2)]
	private string m_name;

	[NonSerialized]
	private string _sortName;

	[OptionalField(VersionAdded = 3)]
	private SortVersion m_SortVersion;

	private int culture;

	[NonSerialized]
	private ISimpleCollator collator;

	private static Dictionary<string, ISimpleCollator> collators;

	private static bool managedCollation;

	private static bool managedCollationChecked;

	public virtual string Name
	{
		get
		{
			if (m_name == "zh-CHT" || m_name == "zh-CHS")
			{
				return m_name;
			}
			return _sortName;
		}
	}

	private static bool UseManagedCollation
	{
		get
		{
			if (!managedCollationChecked)
			{
				managedCollation = Environment.internalGetEnvironmentVariable("MONO_DISABLE_MANAGED_COLLATION") != "yes" && MSCompatUnicodeTable.IsReady;
				managedCollationChecked = true;
			}
			return managedCollation;
		}
	}

	internal unsafe static int InvariantIndexOf(string source, string value, int startIndex, int count, bool ignoreCase)
	{
		fixed (char* ptr = source)
		{
			fixed (char* value2 = value)
			{
				int num = InvariantFindString(ptr + startIndex, count, value2, value.Length, ignoreCase, start: true);
				if (num >= 0)
				{
					return num + startIndex;
				}
				return -1;
			}
		}
	}

	internal unsafe static int InvariantIndexOf(ReadOnlySpan<char> source, ReadOnlySpan<char> value, bool ignoreCase)
	{
		fixed (char* reference = &MemoryMarshal.GetReference(source))
		{
			fixed (char* reference2 = &MemoryMarshal.GetReference(value))
			{
				return InvariantFindString(reference, source.Length, reference2, value.Length, ignoreCase, start: true);
			}
		}
	}

	internal unsafe static int InvariantLastIndexOf(string source, string value, int startIndex, int count, bool ignoreCase)
	{
		fixed (char* ptr = source)
		{
			fixed (char* value2 = value)
			{
				int num = InvariantFindString(ptr + (startIndex - count + 1), count, value2, value.Length, ignoreCase, start: false);
				if (num >= 0)
				{
					return num + startIndex - count + 1;
				}
				return -1;
			}
		}
	}

	private unsafe static int InvariantFindString(char* source, int sourceCount, char* value, int valueCount, bool ignoreCase, bool start)
	{
		int num = 0;
		int num2 = 0;
		if (valueCount == 0)
		{
			if (!start)
			{
				return sourceCount - 1;
			}
			return 0;
		}
		if (sourceCount < valueCount)
		{
			return -1;
		}
		if (start)
		{
			int num3 = sourceCount - valueCount;
			if (ignoreCase)
			{
				char c = InvariantToUpper(*value);
				for (num = 0; num <= num3; num++)
				{
					if (InvariantToUpper(source[num]) != c)
					{
						continue;
					}
					for (num2 = 1; num2 < valueCount; num2++)
					{
						char num4 = InvariantToUpper(source[num + num2]);
						char c2 = InvariantToUpper(value[num2]);
						if (num4 != c2)
						{
							break;
						}
					}
					if (num2 == valueCount)
					{
						return num;
					}
				}
			}
			else
			{
				char c3 = *value;
				for (num = 0; num <= num3; num++)
				{
					if (source[num] != c3)
					{
						continue;
					}
					for (num2 = 1; num2 < valueCount; num2++)
					{
						char num5 = source[num + num2];
						char c2 = value[num2];
						if (num5 != c2)
						{
							break;
						}
					}
					if (num2 == valueCount)
					{
						return num;
					}
				}
			}
		}
		else
		{
			int num3 = sourceCount - valueCount;
			if (ignoreCase)
			{
				char c4 = InvariantToUpper(*value);
				for (num = num3; num >= 0; num--)
				{
					if (InvariantToUpper(source[num]) == c4)
					{
						for (num2 = 1; num2 < valueCount; num2++)
						{
							char num6 = InvariantToUpper(source[num + num2]);
							char c2 = InvariantToUpper(value[num2]);
							if (num6 != c2)
							{
								break;
							}
						}
						if (num2 == valueCount)
						{
							return num;
						}
					}
				}
			}
			else
			{
				char c5 = *value;
				for (num = num3; num >= 0; num--)
				{
					if (source[num] == c5)
					{
						for (num2 = 1; num2 < valueCount; num2++)
						{
							char num7 = source[num + num2];
							char c2 = value[num2];
							if (num7 != c2)
							{
								break;
							}
						}
						if (num2 == valueCount)
						{
							return num;
						}
					}
				}
			}
		}
		return -1;
	}

	private static char InvariantToUpper(char c)
	{
		if ((uint)(c - 97) > 25u)
		{
			return c;
		}
		return (char)(c - 32);
	}

	private unsafe SortKey InvariantCreateSortKey(string source, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort)) != CompareOptions.None)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		byte[] array;
		if (source.Length == 0)
		{
			array = Array.Empty<byte>();
		}
		else
		{
			array = new byte[source.Length * 2];
			fixed (char* source2 = source)
			{
				fixed (byte* ptr = array)
				{
					if ((options & (CompareOptions.IgnoreCase | CompareOptions.OrdinalIgnoreCase)) != CompareOptions.None)
					{
						short* ptr2 = (short*)ptr;
						for (int i = 0; i < source.Length; i++)
						{
							ptr2[i] = (short)InvariantToUpper(source[i]);
						}
					}
					else
					{
						Buffer.MemoryCopy(source2, ptr, array.Length, array.Length);
					}
				}
			}
		}
		return new SortKey(Name, source, options, array);
	}

	internal CompareInfo(CultureInfo culture)
	{
		m_name = culture._name;
		InitSort(culture);
	}

	public static CompareInfo GetCompareInfo(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		return CultureInfo.GetCultureInfo(name).CompareInfo;
	}

	[OnDeserializing]
	private void OnDeserializing(StreamingContext ctx)
	{
		m_name = null;
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		OnDeserialized();
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext ctx)
	{
		OnDeserialized();
	}

	private void OnDeserialized()
	{
		if (m_name == null)
		{
			CultureInfo cultureInfo = CultureInfo.GetCultureInfo(culture);
			m_name = cultureInfo._name;
		}
		else
		{
			InitSort(CultureInfo.GetCultureInfo(m_name));
		}
	}

	[OnSerializing]
	private void OnSerializing(StreamingContext ctx)
	{
		culture = CultureInfo.GetCultureInfo(Name).LCID;
	}

	public virtual int Compare(string string1, string string2)
	{
		return Compare(string1, string2, CompareOptions.None);
	}

	public virtual int Compare(string string1, string string2, CompareOptions options)
	{
		if (options == CompareOptions.OrdinalIgnoreCase)
		{
			return string.Compare(string1, string2, StringComparison.OrdinalIgnoreCase);
		}
		if ((options & CompareOptions.Ordinal) != CompareOptions.None)
		{
			if (options != CompareOptions.Ordinal)
			{
				throw new ArgumentException("CompareOption.Ordinal cannot be used with other options.", "options");
			}
			return string.CompareOrdinal(string1, string2);
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort)) != CompareOptions.None)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		if (string1 == null)
		{
			if (string2 == null)
			{
				return 0;
			}
			return -1;
		}
		if (string2 == null)
		{
			return 1;
		}
		if (GlobalizationMode.Invariant)
		{
			if ((options & CompareOptions.IgnoreCase) != CompareOptions.None)
			{
				return CompareOrdinalIgnoreCase(string1, string2);
			}
			return string.CompareOrdinal(string1, string2);
		}
		return internal_compare_switch(string1, 0, string1.Length, string2, 0, string2.Length, options);
	}

	internal int Compare(ReadOnlySpan<char> string1, string string2, CompareOptions options)
	{
		if (options == CompareOptions.OrdinalIgnoreCase)
		{
			return CompareOrdinalIgnoreCase(string1, string2.AsSpan());
		}
		if ((options & CompareOptions.Ordinal) != CompareOptions.None)
		{
			if (options != CompareOptions.Ordinal)
			{
				throw new ArgumentException("CompareOption.Ordinal cannot be used with other options.", "options");
			}
			return string.CompareOrdinal(string1, string2.AsSpan());
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort)) != CompareOptions.None)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		if (string2 == null)
		{
			return 1;
		}
		if (GlobalizationMode.Invariant)
		{
			if ((options & CompareOptions.IgnoreCase) == 0)
			{
				return string.CompareOrdinal(string1, string2.AsSpan());
			}
			return CompareOrdinalIgnoreCase(string1, string2.AsSpan());
		}
		return CompareString(string1, string2, options);
	}

	internal int CompareOptionIgnoreCase(ReadOnlySpan<char> string1, ReadOnlySpan<char> string2)
	{
		if (string1.Length == 0 || string2.Length == 0)
		{
			return string1.Length - string2.Length;
		}
		if (!GlobalizationMode.Invariant)
		{
			return CompareString(string1, string2, CompareOptions.IgnoreCase);
		}
		return CompareOrdinalIgnoreCase(string1, string2);
	}

	public virtual int Compare(string string1, int offset1, int length1, string string2, int offset2, int length2, CompareOptions options)
	{
		if (options == CompareOptions.OrdinalIgnoreCase)
		{
			int num = string.Compare(string1, offset1, string2, offset2, (length1 < length2) ? length1 : length2, StringComparison.OrdinalIgnoreCase);
			if (length1 != length2 && num == 0)
			{
				if (length1 <= length2)
				{
					return -1;
				}
				return 1;
			}
			return num;
		}
		if (length1 < 0 || length2 < 0)
		{
			throw new ArgumentOutOfRangeException((length1 < 0) ? "length1" : "length2", "Positive number required.");
		}
		if (offset1 < 0 || offset2 < 0)
		{
			throw new ArgumentOutOfRangeException((offset1 < 0) ? "offset1" : "offset2", "Positive number required.");
		}
		if (offset1 > (string1?.Length ?? 0) - length1)
		{
			throw new ArgumentOutOfRangeException("string1", "Offset and length must refer to a position in the string.");
		}
		if (offset2 > (string2?.Length ?? 0) - length2)
		{
			throw new ArgumentOutOfRangeException("string2", "Offset and length must refer to a position in the string.");
		}
		if ((options & CompareOptions.Ordinal) != CompareOptions.None)
		{
			if (options != CompareOptions.Ordinal)
			{
				throw new ArgumentException("CompareOption.Ordinal cannot be used with other options.", "options");
			}
		}
		else if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort)) != CompareOptions.None)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		if (string1 == null)
		{
			if (string2 == null)
			{
				return 0;
			}
			return -1;
		}
		if (string2 == null)
		{
			return 1;
		}
		ReadOnlySpan<char> strA = string1.AsSpan(offset1, length1);
		ReadOnlySpan<char> strB = string2.AsSpan(offset2, length2);
		if (options == CompareOptions.Ordinal)
		{
			return string.CompareOrdinal(strA, strB);
		}
		if (GlobalizationMode.Invariant)
		{
			if ((options & CompareOptions.IgnoreCase) != CompareOptions.None)
			{
				return CompareOrdinalIgnoreCase(strA, strB);
			}
			return string.CompareOrdinal(strA, strB);
		}
		return internal_compare_switch(string1, offset1, length1, string2, offset2, length2, options);
	}

	internal static int CompareOrdinalIgnoreCase(string strA, int indexA, int lengthA, string strB, int indexB, int lengthB)
	{
		return CompareOrdinalIgnoreCase(strA.AsSpan(indexA, lengthA), strB.AsSpan(indexB, lengthB));
	}

	internal unsafe static int CompareOrdinalIgnoreCase(ReadOnlySpan<char> strA, ReadOnlySpan<char> strB)
	{
		int num = Math.Min(strA.Length, strB.Length);
		int num2 = num;
		fixed (char* reference = &MemoryMarshal.GetReference(strA))
		{
			fixed (char* reference2 = &MemoryMarshal.GetReference(strB))
			{
				char* ptr = reference;
				char* ptr2 = reference2;
				char c = (char)(GlobalizationMode.Invariant ? 65535u : 127u);
				while (num != 0 && *ptr <= c && *ptr2 <= c)
				{
					int num3 = *ptr;
					int num4 = *ptr2;
					if (num3 == num4)
					{
						ptr++;
						ptr2++;
						num--;
						continue;
					}
					if ((uint)(num3 - 97) <= 25u)
					{
						num3 -= 32;
					}
					if ((uint)(num4 - 97) <= 25u)
					{
						num4 -= 32;
					}
					if (num3 != num4)
					{
						return num3 - num4;
					}
					ptr++;
					ptr2++;
					num--;
				}
				if (num == 0)
				{
					return strA.Length - strB.Length;
				}
				num2 -= num;
				return CompareStringOrdinalIgnoreCase(ptr, strA.Length - num2, ptr2, strB.Length - num2);
			}
		}
	}

	public virtual bool IsPrefix(string source, string prefix, CompareOptions options)
	{
		if (source == null || prefix == null)
		{
			throw new ArgumentNullException((source == null) ? "source" : "prefix", "String reference not set to an instance of a String.");
		}
		if (prefix.Length == 0)
		{
			return true;
		}
		if (source.Length == 0)
		{
			return false;
		}
		switch (options)
		{
		case CompareOptions.OrdinalIgnoreCase:
			return source.StartsWith(prefix, StringComparison.OrdinalIgnoreCase);
		case CompareOptions.Ordinal:
			return source.StartsWith(prefix, StringComparison.Ordinal);
		default:
			if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth)) != CompareOptions.None)
			{
				throw new ArgumentException("Value of flags is invalid.", "options");
			}
			if (GlobalizationMode.Invariant)
			{
				return source.StartsWith(prefix, ((options & CompareOptions.IgnoreCase) != CompareOptions.None) ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal);
			}
			return StartsWith(source, prefix, options);
		}
	}

	internal bool IsPrefix(ReadOnlySpan<char> source, ReadOnlySpan<char> prefix, CompareOptions options)
	{
		return StartsWith(source, prefix, options);
	}

	public virtual bool IsSuffix(string source, string suffix, CompareOptions options)
	{
		if (source == null || suffix == null)
		{
			throw new ArgumentNullException((source == null) ? "source" : "suffix", "String reference not set to an instance of a String.");
		}
		if (suffix.Length == 0)
		{
			return true;
		}
		if (source.Length == 0)
		{
			return false;
		}
		switch (options)
		{
		case CompareOptions.OrdinalIgnoreCase:
			return source.EndsWith(suffix, StringComparison.OrdinalIgnoreCase);
		case CompareOptions.Ordinal:
			return source.EndsWith(suffix, StringComparison.Ordinal);
		default:
			if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth)) != CompareOptions.None)
			{
				throw new ArgumentException("Value of flags is invalid.", "options");
			}
			if (GlobalizationMode.Invariant)
			{
				return source.EndsWith(suffix, ((options & CompareOptions.IgnoreCase) != CompareOptions.None) ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal);
			}
			return EndsWith(source, suffix, options);
		}
	}

	internal bool IsSuffix(ReadOnlySpan<char> source, ReadOnlySpan<char> suffix, CompareOptions options)
	{
		return EndsWith(source, suffix, options);
	}

	public virtual int IndexOf(string source, char value, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		return IndexOf(source, value, 0, source.Length, options);
	}

	public virtual int IndexOf(string source, string value, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		return IndexOf(source, value, 0, source.Length, options);
	}

	public unsafe virtual int IndexOf(string source, char value, int startIndex, int count, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (startIndex < 0 || startIndex > source.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex > source.Length - count)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		if (source.Length == 0)
		{
			return -1;
		}
		if (options == CompareOptions.OrdinalIgnoreCase)
		{
			return source.IndexOf(value.ToString(), startIndex, count, StringComparison.OrdinalIgnoreCase);
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth)) != CompareOptions.None && options != CompareOptions.Ordinal)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		if (GlobalizationMode.Invariant)
		{
			return IndexOfOrdinal(source, new string(value, 1), startIndex, count, (options & (CompareOptions.IgnoreCase | CompareOptions.OrdinalIgnoreCase)) != 0);
		}
		return IndexOfCore(source, new string(value, 1), startIndex, count, options, null);
	}

	public unsafe virtual int IndexOf(string source, string value, int startIndex, int count, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (startIndex > source.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (source.Length == 0)
		{
			if (value.Length == 0)
			{
				return 0;
			}
			return -1;
		}
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex > source.Length - count)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		if (options == CompareOptions.OrdinalIgnoreCase)
		{
			return IndexOfOrdinal(source, value, startIndex, count, ignoreCase: true);
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth)) != CompareOptions.None && options != CompareOptions.Ordinal)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		if (GlobalizationMode.Invariant)
		{
			return IndexOfOrdinal(source, value, startIndex, count, (options & (CompareOptions.IgnoreCase | CompareOptions.OrdinalIgnoreCase)) != 0);
		}
		return IndexOfCore(source, value, startIndex, count, options, null);
	}

	internal int IndexOfOrdinal(ReadOnlySpan<char> source, ReadOnlySpan<char> value, bool ignoreCase)
	{
		return IndexOfOrdinalCore(source, value, ignoreCase);
	}

	internal unsafe int IndexOf(ReadOnlySpan<char> source, ReadOnlySpan<char> value, CompareOptions options)
	{
		return IndexOfCore(source, value, options, null);
	}

	internal unsafe int IndexOf(string source, string value, int startIndex, int count, CompareOptions options, int* matchLengthPtr)
	{
		*matchLengthPtr = 0;
		if (source.Length == 0)
		{
			if (value.Length == 0)
			{
				return 0;
			}
			return -1;
		}
		if (startIndex >= source.Length)
		{
			return -1;
		}
		if (options == CompareOptions.OrdinalIgnoreCase)
		{
			int num = IndexOfOrdinal(source, value, startIndex, count, ignoreCase: true);
			if (num >= 0)
			{
				*matchLengthPtr = value.Length;
			}
			return num;
		}
		if (GlobalizationMode.Invariant)
		{
			int num2 = IndexOfOrdinal(source, value, startIndex, count, (options & (CompareOptions.IgnoreCase | CompareOptions.OrdinalIgnoreCase)) != 0);
			if (num2 >= 0)
			{
				*matchLengthPtr = value.Length;
			}
			return num2;
		}
		return IndexOfCore(source, value, startIndex, count, options, matchLengthPtr);
	}

	internal int IndexOfOrdinal(string source, string value, int startIndex, int count, bool ignoreCase)
	{
		if (GlobalizationMode.Invariant)
		{
			return InvariantIndexOf(source, value, startIndex, count, ignoreCase);
		}
		return IndexOfOrdinalCore(source, value, startIndex, count, ignoreCase);
	}

	public virtual int LastIndexOf(string source, string value, int startIndex, int count, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth)) != CompareOptions.None && options != CompareOptions.Ordinal && options != CompareOptions.OrdinalIgnoreCase)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		if (source.Length == 0 && (startIndex == -1 || startIndex == 0))
		{
			if (value.Length != 0)
			{
				return -1;
			}
			return 0;
		}
		if (startIndex < 0 || startIndex > source.Length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (startIndex == source.Length)
		{
			startIndex--;
			if (count > 0)
			{
				count--;
			}
			if (value.Length == 0 && count >= 0 && startIndex - count + 1 >= 0)
			{
				return startIndex;
			}
		}
		if (count < 0 || startIndex - count + 1 < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		if (options == CompareOptions.OrdinalIgnoreCase)
		{
			return LastIndexOfOrdinal(source, value, startIndex, count, ignoreCase: true);
		}
		if (GlobalizationMode.Invariant)
		{
			return InvariantLastIndexOf(source, value, startIndex, count, (options & (CompareOptions.IgnoreCase | CompareOptions.OrdinalIgnoreCase)) != 0);
		}
		return LastIndexOfCore(source, value, startIndex, count, options);
	}

	internal int LastIndexOfOrdinal(string source, string value, int startIndex, int count, bool ignoreCase)
	{
		if (GlobalizationMode.Invariant)
		{
			return InvariantLastIndexOf(source, value, startIndex, count, ignoreCase);
		}
		return LastIndexOfOrdinalCore(source, value, startIndex, count, ignoreCase);
	}

	public virtual SortKey GetSortKey(string source, CompareOptions options)
	{
		if (GlobalizationMode.Invariant)
		{
			return InvariantCreateSortKey(source, options);
		}
		return CreateSortKey(source, options);
	}

	public override bool Equals(object value)
	{
		if (value is CompareInfo compareInfo)
		{
			return Name == compareInfo.Name;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return Name.GetHashCode();
	}

	internal static int GetIgnoreCaseHash(string source)
	{
		if (source.Length == 0)
		{
			return source.GetHashCode();
		}
		char[] array = null;
		Span<char> span = ((source.Length > 255) ? ((Span<char>)(array = ArrayPool<char>.Shared.Rent(source.Length))) : stackalloc char[255]);
		Span<char> destination = span;
		int length = source.AsSpan().ToUpperInvariant(destination);
		int result = Marvin.ComputeHash32(MemoryMarshal.AsBytes(destination.Slice(0, length)), Marvin.DefaultSeed);
		if (array != null)
		{
			ArrayPool<char>.Shared.Return(array);
		}
		return result;
	}

	internal int GetHashCodeOfString(string source, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth)) != CompareOptions.None)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		if (GlobalizationMode.Invariant)
		{
			if ((options & CompareOptions.IgnoreCase) == 0)
			{
				return source.GetHashCode();
			}
			return GetIgnoreCaseHash(source);
		}
		return GetHashCodeOfStringCore(source, options);
	}

	public virtual int GetHashCode(string source, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		return options switch
		{
			CompareOptions.Ordinal => source.GetHashCode(), 
			CompareOptions.OrdinalIgnoreCase => GetIgnoreCaseHash(source), 
			_ => GetHashCodeOfString(source, options), 
		};
	}

	public override string ToString()
	{
		return "CompareInfo - " + Name;
	}

	private ISimpleCollator GetCollator()
	{
		if (collator != null)
		{
			return collator;
		}
		if (collators == null)
		{
			Interlocked.CompareExchange(ref collators, new Dictionary<string, ISimpleCollator>(StringComparer.Ordinal), null);
		}
		lock (collators)
		{
			if (!collators.TryGetValue(_sortName, out collator))
			{
				collator = new SimpleCollator(CultureInfo.GetCultureInfo(m_name));
				collators[_sortName] = collator;
			}
		}
		return collator;
	}

	private SortKey CreateSortKeyCore(string source, CompareOptions options)
	{
		if (UseManagedCollation)
		{
			return GetCollator().GetSortKey(source, options);
		}
		return new SortKey(culture, source, options);
	}

	private int internal_index_switch(string s1, int sindex, int count, string s2, CompareOptions opt, bool first)
	{
		if (opt == CompareOptions.Ordinal)
		{
			if (!first)
			{
				return s1.LastIndexOfUnchecked(s2, sindex, count);
			}
			return s1.IndexOfUnchecked(s2, sindex, count);
		}
		if (!UseManagedCollation)
		{
			return internal_index(s1, sindex, count, s2, first);
		}
		return internal_index_managed(s1, sindex, count, s2, opt, first);
	}

	private int internal_compare_switch(string str1, int offset1, int length1, string str2, int offset2, int length2, CompareOptions options)
	{
		if (!UseManagedCollation)
		{
			return internal_compare(str1, offset1, length1, str2, offset2, length2, options);
		}
		return internal_compare_managed(str1, offset1, length1, str2, offset2, length2, options);
	}

	private int internal_compare_managed(string str1, int offset1, int length1, string str2, int offset2, int length2, CompareOptions options)
	{
		return GetCollator().Compare(str1, offset1, length1, str2, offset2, length2, options);
	}

	private int internal_index_managed(string s1, int sindex, int count, string s2, CompareOptions opt, bool first)
	{
		if (!first)
		{
			return GetCollator().LastIndexOf(s1, s2, sindex, count, opt);
		}
		return GetCollator().IndexOf(s1, s2, sindex, count, opt);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int internal_compare_icall(char* str1, int length1, char* str2, int length2, CompareOptions options);

	private unsafe static int internal_compare(string str1, int offset1, int length1, string str2, int offset2, int length2, CompareOptions options)
	{
		fixed (char* ptr = str1)
		{
			fixed (char* ptr2 = str2)
			{
				return internal_compare_icall(ptr + offset1, length1, ptr2 + offset2, length2, options);
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int internal_index_icall(char* source, int sindex, int count, char* value, int value_length, bool first);

	private unsafe static int internal_index(string source, int sindex, int count, string value, bool first)
	{
		fixed (char* source2 = source)
		{
			fixed (char* value2 = value)
			{
				return internal_index_icall(source2, sindex, count, value2, value?.Length ?? 0, first);
			}
		}
	}

	private void InitSort(CultureInfo culture)
	{
		_sortName = culture.SortName;
	}

	private unsafe static int CompareStringOrdinalIgnoreCase(char* pString1, int length1, char* pString2, int length2)
	{
		TextInfo textInfo = CultureInfo.InvariantCulture.TextInfo;
		int num = 0;
		while (num < length1 && num < length2 && textInfo.ToUpper(*pString1) == textInfo.ToUpper(*pString2))
		{
			num++;
			pString1++;
			pString2++;
		}
		if (num >= length1)
		{
			if (num >= length2)
			{
				return 0;
			}
			return -1;
		}
		if (num >= length2)
		{
			return 1;
		}
		return textInfo.ToUpper(*pString1) - textInfo.ToUpper(*pString2);
	}

	internal static int IndexOfOrdinalCore(string source, string value, int startIndex, int count, bool ignoreCase)
	{
		if (!ignoreCase)
		{
			return source.IndexOfUnchecked(value, startIndex, count);
		}
		return source.IndexOfUncheckedIgnoreCase(value, startIndex, count);
	}

	internal static int LastIndexOfOrdinalCore(string source, string value, int startIndex, int count, bool ignoreCase)
	{
		if (!ignoreCase)
		{
			return source.LastIndexOfUnchecked(value, startIndex, count);
		}
		return source.LastIndexOfUncheckedIgnoreCase(value, startIndex, count);
	}

	private int LastIndexOfCore(string source, string target, int startIndex, int count, CompareOptions options)
	{
		return internal_index_switch(source, startIndex, count, target, options, first: false);
	}

	private unsafe int IndexOfCore(string source, string target, int startIndex, int count, CompareOptions options, int* matchLengthPtr)
	{
		if (matchLengthPtr != null)
		{
			throw new NotImplementedException();
		}
		return internal_index_switch(source, startIndex, count, target, options, first: true);
	}

	private unsafe int IndexOfCore(ReadOnlySpan<char> source, ReadOnlySpan<char> target, CompareOptions options, int* matchLengthPtr)
	{
		string text = new string(source);
		string target2 = new string(target);
		return IndexOfCore(text, target2, 0, text.Length, options, matchLengthPtr);
	}

	private int IndexOfOrdinalCore(ReadOnlySpan<char> source, ReadOnlySpan<char> value, bool ignoreCase)
	{
		string text = new string(source);
		string value2 = new string(value);
		if (!ignoreCase)
		{
			return text.IndexOfUnchecked(value2, 0, text.Length);
		}
		return text.IndexOfUncheckedIgnoreCase(value2, 0, text.Length);
	}

	private int CompareString(ReadOnlySpan<char> string1, string string2, CompareOptions options)
	{
		string text = new string(string1);
		return internal_compare_switch(text, 0, text.Length, string2, 0, string2.Length, options);
	}

	private int CompareString(ReadOnlySpan<char> string1, ReadOnlySpan<char> string2, CompareOptions options)
	{
		string text = new string(string1);
		string text2 = new string(string2);
		return internal_compare_switch(text, 0, text.Length, new string(text2), 0, text2.Length, options);
	}

	private SortKey CreateSortKey(string source, CompareOptions options)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort)) != CompareOptions.None)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		return CreateSortKeyCore(source, options);
	}

	private bool StartsWith(string source, string prefix, CompareOptions options)
	{
		if (UseManagedCollation)
		{
			return GetCollator().IsPrefix(source, prefix, options);
		}
		if (source.Length < prefix.Length)
		{
			return false;
		}
		return Compare(source, 0, prefix.Length, prefix, 0, prefix.Length, options) == 0;
	}

	private bool StartsWith(ReadOnlySpan<char> source, ReadOnlySpan<char> prefix, CompareOptions options)
	{
		return StartsWith(new string(source), new string(prefix), options);
	}

	private bool EndsWith(string source, string suffix, CompareOptions options)
	{
		if (UseManagedCollation)
		{
			return GetCollator().IsSuffix(source, suffix, options);
		}
		if (source.Length < suffix.Length)
		{
			return false;
		}
		return Compare(source, source.Length - suffix.Length, suffix.Length, suffix, 0, suffix.Length, options) == 0;
	}

	private bool EndsWith(ReadOnlySpan<char> source, ReadOnlySpan<char> suffix, CompareOptions options)
	{
		return EndsWith(new string(source), new string(suffix), options);
	}

	internal int GetHashCodeOfStringCore(string source, CompareOptions options)
	{
		return GetSortKey(source, options).GetHashCode();
	}

	internal CompareInfo()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}

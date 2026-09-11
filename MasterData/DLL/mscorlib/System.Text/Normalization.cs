using System.Runtime.CompilerServices;
using Mono.Globalization.Unicode;

namespace System.Text;

internal class Normalization
{
	private unsafe static byte* props;

	private unsafe static int* mappedChars;

	private unsafe static short* charMapIndex;

	private unsafe static short* helperIndex;

	private unsafe static ushort* mapIdxToComposite;

	private unsafe static byte* combiningClass;

	private static object forLock;

	public static readonly bool isReady;

	private unsafe static uint PropValue(int cp)
	{
		return props[NormalizationTableUtil.PropIdx(cp)];
	}

	private unsafe static int CharMapIdx(int cp)
	{
		return charMapIndex[NormalizationTableUtil.MapIdx(cp)];
	}

	private unsafe static byte GetCombiningClass(int c)
	{
		return combiningClass[NormalizationTableUtil.Combining.ToIndex(c)];
	}

	private unsafe static int GetPrimaryCompositeFromMapIndex(int src)
	{
		return mapIdxToComposite[NormalizationTableUtil.Composite.ToIndex(src)];
	}

	private unsafe static int GetPrimaryCompositeHelperIndex(int cp)
	{
		return helperIndex[NormalizationTableUtil.Helper.ToIndex(cp)];
	}

	private static string Compose(string source, int checkType)
	{
		StringBuilder sb = null;
		Decompose(source, ref sb, (checkType != 2) ? 1 : 3);
		if (sb == null)
		{
			sb = Combine(source, 0, checkType);
		}
		else
		{
			Combine(sb, 0, checkType);
		}
		if (sb == null)
		{
			return source;
		}
		return sb.ToString();
	}

	private static StringBuilder Combine(string source, int start, int checkType)
	{
		for (int i = 0; i < source.Length; i++)
		{
			if (QuickCheck(source[i], checkType) != NormalizationCheck.Yes)
			{
				StringBuilder stringBuilder = new StringBuilder(source.Length + source.Length / 10);
				stringBuilder.Append(source);
				Combine(stringBuilder, i, checkType);
				return stringBuilder;
			}
		}
		return null;
	}

	private static void Combine(StringBuilder sb, int i, int checkType)
	{
		CombineHangul(sb, null, (i > 0) ? (i - 1) : i);
		while (i < sb.Length)
		{
			i = ((QuickCheck(sb[i], checkType) != NormalizationCheck.Yes) ? TryComposeWithPreviousStarter(sb, null, i) : (i + 1));
		}
	}

	private static int CombineHangul(StringBuilder sb, string s, int current)
	{
		int num = sb?.Length ?? s.Length;
		int num2 = Fetch(sb, s, current);
		for (int i = current + 1; i < num; i++)
		{
			int num3 = Fetch(sb, s, i);
			int num4 = num2 - 4352;
			if (0 <= num4 && num4 < 19)
			{
				int num5 = num3 - 4449;
				if (0 <= num5 && num5 < 21)
				{
					if (sb == null)
					{
						return -1;
					}
					num2 = 44032 + (num4 * 21 + num5) * 28;
					sb[i - 1] = (char)num2;
					sb.Remove(i, 1);
					i--;
					num--;
					continue;
				}
			}
			int num6 = num2 - 44032;
			if (0 <= num6 && num6 < 11172 && num6 % 28 == 0)
			{
				int num7 = num3 - 4519;
				if (0 < num7 && num7 < 28)
				{
					if (sb == null)
					{
						return -1;
					}
					num2 += num7;
					sb[i - 1] = (char)num2;
					sb.Remove(i, 1);
					i--;
					num--;
					continue;
				}
			}
			num2 = num3;
		}
		return num;
	}

	private static int Fetch(StringBuilder sb, string s, int i)
	{
		return sb?[i] ?? s[i];
	}

	private static int TryComposeWithPreviousStarter(StringBuilder sb, string s, int current)
	{
		int num = current - 1;
		if (GetCombiningClass(Fetch(sb, s, current)) == 0)
		{
			if (num < 0 || GetCombiningClass(Fetch(sb, s, num)) != 0)
			{
				return current + 1;
			}
		}
		else
		{
			while (num >= 0 && GetCombiningClass(Fetch(sb, s, num)) != 0)
			{
				num--;
			}
			if (num < 0)
			{
				return current + 1;
			}
		}
		int num2 = Fetch(sb, s, num);
		int primaryCompositeHelperIndex = GetPrimaryCompositeHelperIndex(num2);
		if (primaryCompositeHelperIndex == 0)
		{
			return current + 1;
		}
		int num3 = sb?.Length ?? s.Length;
		int num4 = -1;
		for (int i = num + 1; i < num3; i++)
		{
			int num5 = Fetch(sb, s, i);
			int num6 = GetCombiningClass(num5);
			if (num6 == num4)
			{
				continue;
			}
			int num7 = TryCompose(primaryCompositeHelperIndex, num2, num5);
			if (num7 != 0)
			{
				if (sb == null)
				{
					return -1;
				}
				sb[num] = (char)num7;
				sb.Remove(i, 1);
				return current;
			}
			if (num6 == 0)
			{
				return i + 1;
			}
			num4 = num6;
		}
		return num3;
	}

	private unsafe static int TryCompose(int i, int starter, int candidate)
	{
		while (mappedChars[i] == starter)
		{
			if (mappedChars[i + 1] == candidate && mappedChars[i + 2] == 0)
			{
				int primaryCompositeFromMapIndex = GetPrimaryCompositeFromMapIndex(i);
				if ((PropValue(primaryCompositeFromMapIndex) & 0x40) == 0)
				{
					return primaryCompositeFromMapIndex;
				}
			}
			while (mappedChars[i] != 0)
			{
				i++;
			}
			i++;
		}
		return 0;
	}

	private static string Decompose(string source, int checkType)
	{
		StringBuilder sb = null;
		Decompose(source, ref sb, checkType);
		if (sb == null)
		{
			return source;
		}
		return sb.ToString();
	}

	private static void Decompose(string source, ref StringBuilder sb, int checkType)
	{
		int[] buf = null;
		int start = 0;
		for (int i = 0; i < source.Length; i++)
		{
			if (QuickCheck(source[i], checkType) == NormalizationCheck.No)
			{
				DecomposeChar(ref sb, ref buf, source, i, checkType, ref start);
			}
		}
		if (sb != null)
		{
			sb.Append(source, start, source.Length - start);
		}
		ReorderCanonical(source, ref sb, 1);
	}

	private static void ReorderCanonical(string src, ref StringBuilder sb, int start)
	{
		if (sb == null)
		{
			for (int i = 1; i < src.Length; i++)
			{
				int num = GetCombiningClass(src[i]);
				if (num != 0 && GetCombiningClass(src[i - 1]) > num)
				{
					sb = new StringBuilder(src.Length);
					sb.Append(src, 0, src.Length);
					ReorderCanonical(src, ref sb, i);
					break;
				}
			}
			return;
		}
		int num2 = start;
		while (num2 < sb.Length)
		{
			int num3 = GetCombiningClass(sb[num2]);
			if (num3 == 0 || GetCombiningClass(sb[num2 - 1]) <= num3)
			{
				num2++;
				continue;
			}
			char value = sb[num2 - 1];
			sb[num2 - 1] = sb[num2];
			sb[num2] = value;
			if (num2 > 1)
			{
				num2--;
			}
		}
	}

	private static void DecomposeChar(ref StringBuilder sb, ref int[] buf, string s, int i, int checkType, ref int start)
	{
		if (sb == null)
		{
			sb = new StringBuilder(s.Length + 100);
		}
		sb.Append(s, start, i - start);
		if (buf == null)
		{
			buf = new int[19];
		}
		int canonical = GetCanonical(s[i], buf, 0, checkType);
		for (int j = 0; j < canonical; j++)
		{
			if (buf[j] < 65535)
			{
				sb.Append((char)buf[j]);
				continue;
			}
			sb.Append((char)(buf[j] >> 10));
			sb.Append((char)((buf[j] & 0xFFF) + 56320));
		}
		start = i + 1;
	}

	public static NormalizationCheck QuickCheck(char c, int type)
	{
		switch (type)
		{
		default:
		{
			uint num = PropValue(c);
			if ((num & 4) != 0)
			{
				return NormalizationCheck.No;
			}
			if ((num & 8) != 0)
			{
				return NormalizationCheck.Maybe;
			}
			return NormalizationCheck.Yes;
		}
		case 1:
			if ('가' <= c && c <= '힣')
			{
				return NormalizationCheck.No;
			}
			if ((PropValue(c) & 1) == 0)
			{
				return NormalizationCheck.Yes;
			}
			return NormalizationCheck.No;
		case 2:
		{
			uint num = PropValue(c);
			if ((num & 0x10) == 0)
			{
				if ((num & 0x20) == 0)
				{
					return NormalizationCheck.Yes;
				}
				return NormalizationCheck.Maybe;
			}
			return NormalizationCheck.No;
		}
		case 3:
			if ('가' <= c && c <= '힣')
			{
				return NormalizationCheck.No;
			}
			if ((PropValue(c) & 2) == 0)
			{
				return NormalizationCheck.Yes;
			}
			return NormalizationCheck.No;
		}
	}

	private static int GetCanonicalHangul(int s, int[] buf, int bufIdx)
	{
		int num = s - 44032;
		if (num < 0 || num >= 11172)
		{
			return bufIdx;
		}
		int num2 = 4352 + num / 588;
		int num3 = 4449 + num % 588 / 28;
		int num4 = 4519 + num % 28;
		buf[bufIdx++] = num2;
		buf[bufIdx++] = num3;
		if (num4 != 4519)
		{
			buf[bufIdx++] = num4;
		}
		buf[bufIdx] = 0;
		return bufIdx;
	}

	private unsafe static int GetCanonical(int c, int[] buf, int bufIdx, int checkType)
	{
		int canonicalHangul = GetCanonicalHangul(c, buf, bufIdx);
		if (canonicalHangul > bufIdx)
		{
			return canonicalHangul;
		}
		int i = CharMapIdx(c);
		if (i == 0 || mappedChars[i] == c)
		{
			buf[bufIdx++] = c;
		}
		else
		{
			for (; mappedChars[i] != 0; i++)
			{
				int num = mappedChars[i];
				if (num <= 65535 && QuickCheck((char)num, checkType) == NormalizationCheck.Yes)
				{
					buf[bufIdx++] = num;
				}
				else
				{
					bufIdx = GetCanonical(num, buf, bufIdx, checkType);
				}
			}
		}
		return bufIdx;
	}

	public static bool IsNormalized(string source, NormalizationForm normalizationForm)
	{
		return normalizationForm switch
		{
			NormalizationForm.FormD => IsNormalized(source, 1), 
			NormalizationForm.FormKC => IsNormalized(source, 2), 
			NormalizationForm.FormKD => IsNormalized(source, 3), 
			_ => IsNormalized(source, 0), 
		};
	}

	public static bool IsNormalized(string source, int type)
	{
		int num = -1;
		int num2 = 0;
		while (num2 < source.Length)
		{
			int num3 = GetCombiningClass(source[num2]);
			if (num3 != 0 && num3 < num)
			{
				return false;
			}
			num = num3;
			switch (QuickCheck(source[num2], type))
			{
			case NormalizationCheck.Yes:
				num2++;
				break;
			case NormalizationCheck.No:
				return false;
			case NormalizationCheck.Maybe:
				if (type == 0 || type == 2)
				{
					return source == Normalize(source, type);
				}
				num2 = CombineHangul(null, source, (num2 > 0) ? (num2 - 1) : num2);
				if (num2 < 0)
				{
					return false;
				}
				num2 = TryComposeWithPreviousStarter(null, source, num2);
				if (num2 < 0)
				{
					return false;
				}
				break;
			}
		}
		return true;
	}

	public static string Normalize(string source, NormalizationForm normalizationForm)
	{
		return normalizationForm switch
		{
			NormalizationForm.FormD => Normalize(source, 1), 
			NormalizationForm.FormKC => Normalize(source, 2), 
			NormalizationForm.FormKD => Normalize(source, 3), 
			_ => Normalize(source, 0), 
		};
	}

	public static string Normalize(string source, int type)
	{
		switch (type)
		{
		default:
			return Compose(source, type);
		case 1:
		case 3:
			return Decompose(source, type);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void load_normalization_resource(out IntPtr props, out IntPtr mappedChars, out IntPtr charMapIndex, out IntPtr helperIndex, out IntPtr mapIdxToComposite, out IntPtr combiningClass);

	unsafe static Normalization()
	{
		forLock = new object();
		lock (forLock)
		{
			load_normalization_resource(out var intPtr, out var intPtr2, out var intPtr3, out var intPtr4, out var intPtr5, out var intPtr6);
			props = (byte*)(void*)intPtr;
			mappedChars = (int*)(void*)intPtr2;
			charMapIndex = (short*)(void*)intPtr3;
			helperIndex = (short*)(void*)intPtr4;
			mapIdxToComposite = (ushort*)(void*)intPtr5;
			combiningClass = (byte*)(void*)intPtr6;
		}
		isReady = true;
	}
}

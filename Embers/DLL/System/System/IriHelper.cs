using System.Runtime.InteropServices;
using System.Text;

namespace System;

internal static class IriHelper
{
	internal static bool CheckIriUnicodeRange(char unicode, bool isQuery)
	{
		if ((unicode < '\u00a0' || unicode > '\ud7ff') && (unicode < '豈' || unicode > '﷏') && (unicode < 'ﷰ' || unicode > '\uffef'))
		{
			if (isQuery && unicode >= '\ue000')
			{
				return unicode <= '\uf8ff';
			}
			return false;
		}
		return true;
	}

	internal static bool CheckIriUnicodeRange(char highSurr, char lowSurr, ref bool surrogatePair, bool isQuery)
	{
		bool result = false;
		surrogatePair = false;
		if (char.IsSurrogatePair(highSurr, lowSurr))
		{
			surrogatePair = true;
			string strA = new string(new char[2] { highSurr, lowSurr });
			if ((string.CompareOrdinal(strA, "\ud800\udc00") >= 0 && string.CompareOrdinal(strA, "\ud83f\udffd") <= 0) || (string.CompareOrdinal(strA, "\ud840\udc00") >= 0 && string.CompareOrdinal(strA, "\ud87f\udffd") <= 0) || (string.CompareOrdinal(strA, "\ud880\udc00") >= 0 && string.CompareOrdinal(strA, "\ud8bf\udffd") <= 0) || (string.CompareOrdinal(strA, "\ud8c0\udc00") >= 0 && string.CompareOrdinal(strA, "\ud8ff\udffd") <= 0) || (string.CompareOrdinal(strA, "\ud900\udc00") >= 0 && string.CompareOrdinal(strA, "\ud93f\udffd") <= 0) || (string.CompareOrdinal(strA, "\ud940\udc00") >= 0 && string.CompareOrdinal(strA, "\ud97f\udffd") <= 0) || (string.CompareOrdinal(strA, "\ud980\udc00") >= 0 && string.CompareOrdinal(strA, "\ud9bf\udffd") <= 0) || (string.CompareOrdinal(strA, "\ud9c0\udc00") >= 0 && string.CompareOrdinal(strA, "\ud9ff\udffd") <= 0) || (string.CompareOrdinal(strA, "\uda00\udc00") >= 0 && string.CompareOrdinal(strA, "\uda3f\udffd") <= 0) || (string.CompareOrdinal(strA, "\uda40\udc00") >= 0 && string.CompareOrdinal(strA, "\uda7f\udffd") <= 0) || (string.CompareOrdinal(strA, "\uda80\udc00") >= 0 && string.CompareOrdinal(strA, "\udabf\udffd") <= 0) || (string.CompareOrdinal(strA, "\udac0\udc00") >= 0 && string.CompareOrdinal(strA, "\udaff\udffd") <= 0) || (string.CompareOrdinal(strA, "\udb00\udc00") >= 0 && string.CompareOrdinal(strA, "\udb3f\udffd") <= 0) || (string.CompareOrdinal(strA, "\udb44\udc00") >= 0 && string.CompareOrdinal(strA, "\udb7f\udffd") <= 0) || (isQuery && ((string.CompareOrdinal(strA, "\udb80\udc00") >= 0 && string.CompareOrdinal(strA, "\udbbf\udffd") <= 0) || (string.CompareOrdinal(strA, "\udbc0\udc00") >= 0 && string.CompareOrdinal(strA, "\udbff\udffd") <= 0))))
			{
				result = true;
			}
		}
		return result;
	}

	internal static bool CheckIsReserved(char ch, UriComponents component)
	{
		switch (component)
		{
		default:
			return false;
		case (UriComponents)0:
			return Uri.IsGenDelim(ch);
		case UriComponents.Scheme:
		case UriComponents.UserInfo:
		case UriComponents.Host:
		case UriComponents.Port:
		case UriComponents.Path:
		case UriComponents.Query:
		case UriComponents.Fragment:
			switch (component)
			{
			case UriComponents.UserInfo:
				if (ch == '/' || ch == '?' || ch == '#' || ch == '[' || ch == ']' || ch == '@')
				{
					return true;
				}
				break;
			case UriComponents.Host:
				if (ch == ':' || ch == '/' || ch == '?' || ch == '#' || ch == '[' || ch == ']' || ch == '@')
				{
					return true;
				}
				break;
			case UriComponents.Path:
				if (ch == '/' || ch == '?' || ch == '#' || ch == '[' || ch == ']')
				{
					return true;
				}
				break;
			case UriComponents.Query:
				if (ch == '#' || ch == '[' || ch == ']')
				{
					return true;
				}
				break;
			case UriComponents.Fragment:
				if (ch == '#' || ch == '[' || ch == ']')
				{
					return true;
				}
				break;
			}
			return false;
		}
	}

	internal unsafe static string EscapeUnescapeIri(char* pInput, int start, int end, UriComponents component)
	{
		char[] array = new char[end - start];
		byte[] array2 = null;
		GCHandle gCHandle = GCHandle.Alloc(array, GCHandleType.Pinned);
		char* ptr = (char*)(void*)gCHandle.AddrOfPinnedObject();
		int num = 0;
		int i = start;
		int destOffset = 0;
		bool flag = false;
		bool flag2 = false;
		for (; i < end; i++)
		{
			flag = false;
			flag2 = false;
			char c;
			if ((c = pInput[i]) == '%')
			{
				if (i + 2 < end)
				{
					c = UriHelper.EscapedAscii(pInput[i + 1], pInput[i + 2]);
					if (c == '\uffff' || c == '%' || CheckIsReserved(c, component) || UriHelper.IsNotSafeForUnescape(c))
					{
						ptr[destOffset++] = pInput[i++];
						ptr[destOffset++] = pInput[i++];
						ptr[destOffset++] = pInput[i];
						continue;
					}
					if (c <= '\u007f')
					{
						ptr[destOffset++] = c;
						i += 2;
						continue;
					}
					int num2 = i;
					int byteCount = 1;
					if (array2 == null)
					{
						array2 = new byte[end - i];
					}
					array2[0] = (byte)c;
					for (i += 3; i < end; i += 3)
					{
						if ((c = pInput[i]) != '%')
						{
							break;
						}
						if (i + 2 >= end)
						{
							break;
						}
						c = UriHelper.EscapedAscii(pInput[i + 1], pInput[i + 2]);
						if (c == '\uffff' || c < '\u0080')
						{
							break;
						}
						array2[byteCount++] = (byte)c;
					}
					i--;
					Encoding obj = (Encoding)Encoding.UTF8.Clone();
					obj.EncoderFallback = new EncoderReplacementFallback("");
					obj.DecoderFallback = new DecoderReplacementFallback("");
					char[] array3 = new char[array2.Length];
					int chars = obj.GetChars(array2, 0, byteCount, array3, 0);
					if (chars != 0)
					{
						UriHelper.MatchUTF8Sequence(ptr, array, ref destOffset, array3, chars, array2, byteCount, component == UriComponents.Query, iriParsing: true);
					}
					else
					{
						for (int j = num2; j <= i; j++)
						{
							ptr[destOffset++] = pInput[j];
						}
					}
				}
				else
				{
					ptr[destOffset++] = pInput[i];
				}
			}
			else if (c > '\u007f')
			{
				if (char.IsHighSurrogate(c) && i + 1 < end)
				{
					char lowSurr = pInput[i + 1];
					flag = !CheckIriUnicodeRange(c, lowSurr, ref flag2, component == UriComponents.Query);
					if (!flag)
					{
						ptr[destOffset++] = pInput[i++];
						ptr[destOffset++] = pInput[i];
					}
				}
				else if (CheckIriUnicodeRange(c, component == UriComponents.Query))
				{
					if (!Uri.IsBidiControlCharacter(c))
					{
						ptr[destOffset++] = pInput[i];
					}
				}
				else
				{
					flag = true;
				}
			}
			else
			{
				ptr[destOffset++] = pInput[i];
			}
			if (!flag)
			{
				continue;
			}
			if (num < 12)
			{
				char[] array4;
				checked
				{
					int num3 = array.Length + 90;
					num += 90;
					array4 = new char[num3];
				}
				fixed (char* dest = array4)
				{
					Buffer.Memcpy((byte*)dest, (byte*)ptr, destOffset * 2);
				}
				if (gCHandle.IsAllocated)
				{
					gCHandle.Free();
				}
				array = array4;
				gCHandle = GCHandle.Alloc(array, GCHandleType.Pinned);
				ptr = (char*)(void*)gCHandle.AddrOfPinnedObject();
			}
			byte[] array5 = new byte[4];
			fixed (byte* bytes = array5)
			{
				int bytes2 = Encoding.UTF8.GetBytes(pInput + i, (!flag2) ? 1 : 2, bytes, 4);
				num -= bytes2 * 3;
				for (int k = 0; k < bytes2; k++)
				{
					UriHelper.EscapeAsciiChar((char)array5[k], array, ref destOffset);
				}
			}
		}
		if (gCHandle.IsAllocated)
		{
			gCHandle.Free();
		}
		return new string(array, 0, destOffset);
	}
}

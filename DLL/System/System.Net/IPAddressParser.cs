using System.Net.Sockets;
using System.Runtime.InteropServices;
using System.Text;

namespace System.Net;

internal class IPAddressParser
{
	internal unsafe static IPAddress Parse(ReadOnlySpan<char> ipSpan, bool tryParse)
	{
		long address;
		if (ipSpan.Contains(':'))
		{
			ushort* ptr = stackalloc ushort[8];
			new Span<ushort>(ptr, 8).Clear();
			if (Ipv6StringToAddress(ipSpan, ptr, 8, out var scope))
			{
				return new IPAddress(ptr, 8, scope);
			}
		}
		else if (Ipv4StringToAddress(ipSpan, out address))
		{
			return new IPAddress(address);
		}
		if (tryParse)
		{
			return null;
		}
		throw new FormatException("An invalid IP address was specified.", new SocketException(SocketError.InvalidArgument));
	}

	internal unsafe static string IPv4AddressToString(uint address)
	{
		char* ptr = stackalloc char[15];
		int length = IPv4AddressToStringHelper(address, ptr);
		return new string(ptr, 0, length);
	}

	internal unsafe static void IPv4AddressToString(uint address, StringBuilder destination)
	{
		char* ptr = stackalloc char[15];
		int valueCount = IPv4AddressToStringHelper(address, ptr);
		destination.Append(ptr, valueCount);
	}

	internal unsafe static bool IPv4AddressToString(uint address, Span<char> formatted, out int charsWritten)
	{
		if (formatted.Length < 15)
		{
			charsWritten = 0;
			return false;
		}
		fixed (char* reference = &MemoryMarshal.GetReference(formatted))
		{
			charsWritten = IPv4AddressToStringHelper(address, reference);
		}
		return true;
	}

	private unsafe static int IPv4AddressToStringHelper(uint address, char* addressString)
	{
		int offset = 0;
		FormatIPv4AddressNumber((int)(address & 0xFF), addressString, ref offset);
		addressString[offset++] = '.';
		FormatIPv4AddressNumber((int)((address >> 8) & 0xFF), addressString, ref offset);
		addressString[offset++] = '.';
		FormatIPv4AddressNumber((int)((address >> 16) & 0xFF), addressString, ref offset);
		addressString[offset++] = '.';
		FormatIPv4AddressNumber((int)((address >> 24) & 0xFF), addressString, ref offset);
		return offset;
	}

	internal static string IPv6AddressToString(ushort[] address, uint scopeId)
	{
		return System.Text.StringBuilderCache.GetStringAndRelease(IPv6AddressToStringHelper(address, scopeId));
	}

	internal static bool IPv6AddressToString(ushort[] address, uint scopeId, Span<char> destination, out int charsWritten)
	{
		StringBuilder stringBuilder = IPv6AddressToStringHelper(address, scopeId);
		if (destination.Length < stringBuilder.Length)
		{
			System.Text.StringBuilderCache.Release(stringBuilder);
			charsWritten = 0;
			return false;
		}
		stringBuilder.CopyTo(0, destination, stringBuilder.Length);
		charsWritten = stringBuilder.Length;
		System.Text.StringBuilderCache.Release(stringBuilder);
		return true;
	}

	internal static StringBuilder IPv6AddressToStringHelper(ushort[] address, uint scopeId)
	{
		StringBuilder stringBuilder = System.Text.StringBuilderCache.Acquire(65);
		if (IPv6AddressHelper.ShouldHaveIpv4Embedded(address))
		{
			AppendSections(address, 0, 6, stringBuilder);
			if (stringBuilder[stringBuilder.Length - 1] != ':')
			{
				stringBuilder.Append(':');
			}
			IPv4AddressToString(ExtractIPv4Address(address), stringBuilder);
		}
		else
		{
			AppendSections(address, 0, 8, stringBuilder);
		}
		if (scopeId != 0)
		{
			stringBuilder.Append('%').Append(scopeId);
		}
		return stringBuilder;
	}

	private unsafe static void FormatIPv4AddressNumber(int number, char* addressString, ref int offset)
	{
		offset += ((number > 99) ? 3 : ((number <= 9) ? 1 : 2));
		int num = offset;
		do
		{
			number = Math.DivRem(number, 10, out var result);
			addressString[--num] = (char)(48 + result);
		}
		while (number != 0);
	}

	public unsafe static bool Ipv4StringToAddress(ReadOnlySpan<char> ipSpan, out long address)
	{
		int end = ipSpan.Length;
		long num;
		fixed (char* reference = &MemoryMarshal.GetReference(ipSpan))
		{
			num = IPv4AddressHelper.ParseNonCanonical(reference, 0, ref end, notImplicitFile: true);
		}
		if (num != -1 && end == ipSpan.Length)
		{
			address = ((0xFF000000u & num) >> 24) | ((0xFF0000 & num) >> 8) | ((0xFF00 & num) << 8) | ((0xFF & num) << 24);
			return true;
		}
		address = 0L;
		return false;
	}

	public unsafe static bool Ipv6StringToAddress(ReadOnlySpan<char> ipSpan, ushort* numbers, int numbersLength, out uint scope)
	{
		int end = ipSpan.Length;
		bool num;
		fixed (char* reference = &MemoryMarshal.GetReference(ipSpan))
		{
			num = IPv6AddressHelper.IsValidStrict(reference, 0, ref end);
		}
		if (num || end != ipSpan.Length)
		{
			string scopeId = null;
			IPv6AddressHelper.Parse(ipSpan, numbers, 0, ref scopeId);
			long num2 = 0L;
			if (!string.IsNullOrEmpty(scopeId))
			{
				if (scopeId.Length < 2)
				{
					scope = 0u;
					return false;
				}
				for (int i = 1; i < scopeId.Length; i++)
				{
					char c = scopeId[i];
					if (c < '0' || c > '9')
					{
						scope = 0u;
						return true;
					}
					num2 = num2 * 10 + (c - 48);
					if (num2 > uint.MaxValue)
					{
						scope = 0u;
						return false;
					}
				}
			}
			scope = (uint)num2;
			return true;
		}
		scope = 0u;
		return false;
	}

	private static void AppendSections(ushort[] address, int fromInclusive, int toExclusive, StringBuilder buffer)
	{
		(int longestSequenceStart, int longestSequenceLength) tuple = IPv6AddressHelper.FindCompressionRange(new ReadOnlySpan<ushort>(address, fromInclusive, toExclusive - fromInclusive));
		int item = tuple.longestSequenceStart;
		int item2 = tuple.longestSequenceLength;
		bool flag = false;
		for (int i = fromInclusive; i < item; i++)
		{
			if (flag)
			{
				buffer.Append(':');
			}
			flag = true;
			AppendHex(address[i], buffer);
		}
		if (item >= 0)
		{
			buffer.Append("::");
			flag = false;
			fromInclusive = item2;
		}
		for (int j = fromInclusive; j < toExclusive; j++)
		{
			if (flag)
			{
				buffer.Append(':');
			}
			flag = true;
			AppendHex(address[j], buffer);
		}
	}

	private unsafe static void AppendHex(ushort value, StringBuilder buffer)
	{
		char* ptr = stackalloc char[4];
		int num = 4;
		do
		{
			int num2 = value % 16;
			value /= 16;
			ptr[--num] = ((num2 < 10) ? ((char)(48 + num2)) : ((char)(97 + (num2 - 10))));
		}
		while (value != 0);
		buffer.Append(ptr + num, 4 - num);
	}

	private static uint ExtractIPv4Address(ushort[] address)
	{
		return (uint)((Reverse(address[7]) << 16) | Reverse(address[6]));
	}

	private static ushort Reverse(ushort number)
	{
		return (ushort)(((number >> 8) & 0xFF) | ((number << 8) & 0xFF00));
	}
}

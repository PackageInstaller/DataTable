using System.Globalization;
using System.Numerics;
using System.Runtime;
using System.Runtime.CompilerServices;

namespace System;

internal static class SpanHelpers
{
	public static int IndexOfAny(ref byte searchSpace, int searchSpaceLength, ref byte value, int valueLength)
	{
		if (valueLength == 0)
		{
			return 0;
		}
		int num = -1;
		for (int i = 0; i < valueLength; i++)
		{
			int num2 = IndexOf(ref searchSpace, Unsafe.Add(ref value, i), searchSpaceLength);
			if ((uint)num2 < (uint)num)
			{
				num = num2;
				searchSpaceLength = num2;
				if (num == 0)
				{
					break;
				}
			}
		}
		return num;
	}

	public unsafe static int IndexOf(ref byte searchSpace, byte value, int length)
	{
		IntPtr intPtr = (IntPtr)0;
		IntPtr intPtr2 = (IntPtr)length;
		while (true)
		{
			if ((nuint)(void*)intPtr2 >= (nuint)8u)
			{
				intPtr2 -= 8;
				if (value != Unsafe.AddByteOffset(ref searchSpace, intPtr))
				{
					if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr + 1))
					{
						goto IL_0155;
					}
					if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr + 2))
					{
						goto IL_0163;
					}
					if (value != Unsafe.AddByteOffset(ref searchSpace, intPtr + 3))
					{
						if (value != Unsafe.AddByteOffset(ref searchSpace, intPtr + 4))
						{
							if (value != Unsafe.AddByteOffset(ref searchSpace, intPtr + 5))
							{
								if (value != Unsafe.AddByteOffset(ref searchSpace, intPtr + 6))
								{
									if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr + 7))
									{
										break;
									}
									intPtr += 8;
									continue;
								}
								return (int)(void*)(intPtr + 6);
							}
							return (int)(void*)(intPtr + 5);
						}
						return (int)(void*)(intPtr + 4);
					}
					goto IL_0171;
				}
			}
			else
			{
				if ((nuint)(void*)intPtr2 >= (nuint)4u)
				{
					intPtr2 -= 4;
					if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr))
					{
						goto IL_014d;
					}
					if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr + 1))
					{
						goto IL_0155;
					}
					if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr + 2))
					{
						goto IL_0163;
					}
					if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr + 3))
					{
						goto IL_0171;
					}
					intPtr += 4;
				}
				while (true)
				{
					if ((void*)intPtr2 != null)
					{
						intPtr2 -= 1;
						if (value == Unsafe.AddByteOffset(ref searchSpace, intPtr))
						{
							break;
						}
						intPtr += 1;
						continue;
					}
					return -1;
				}
			}
			goto IL_014d;
			IL_0163:
			return (int)(void*)(intPtr + 2);
			IL_014d:
			return (int)(void*)intPtr;
			IL_0155:
			return (int)(void*)(intPtr + 1);
			IL_0171:
			return (int)(void*)(intPtr + 3);
		}
		return (int)(void*)(intPtr + 7);
	}

	public unsafe static bool SequenceEqual(ref byte first, ref byte second, ulong length)
	{
		if (!Unsafe.AreSame(ref first, ref second))
		{
			IntPtr intPtr = (IntPtr)0;
			IntPtr intPtr2 = (IntPtr)(void*)length;
			if ((nuint)(void*)intPtr2 >= (nuint)sizeof(UIntPtr))
			{
				intPtr2 -= sizeof(UIntPtr);
				while (true)
				{
					if ((void*)intPtr2 > (void*)intPtr)
					{
						if (Unsafe.ReadUnaligned<UIntPtr>(ref Unsafe.AddByteOffset(ref first, intPtr)) != Unsafe.ReadUnaligned<UIntPtr>(ref Unsafe.AddByteOffset(ref second, intPtr)))
						{
							break;
						}
						intPtr += sizeof(UIntPtr);
						continue;
					}
					return Unsafe.ReadUnaligned<UIntPtr>(ref Unsafe.AddByteOffset(ref first, intPtr2)) == Unsafe.ReadUnaligned<UIntPtr>(ref Unsafe.AddByteOffset(ref second, intPtr2));
				}
				goto IL_00be;
			}
			while ((void*)intPtr2 > (void*)intPtr)
			{
				if (Unsafe.AddByteOffset(ref first, intPtr) == Unsafe.AddByteOffset(ref second, intPtr))
				{
					intPtr += 1;
					continue;
				}
				goto IL_00be;
			}
		}
		return true;
		IL_00be:
		return false;
	}

	public unsafe static int SequenceCompareTo(ref char first, int firstLength, ref char second, int secondLength)
	{
		int result = firstLength - secondLength;
		if (!Unsafe.AreSame(ref first, ref second))
		{
			IntPtr intPtr = (IntPtr)((firstLength < secondLength) ? firstLength : secondLength);
			IntPtr intPtr2 = (IntPtr)0;
			if ((nuint)(void*)intPtr >= (nuint)(sizeof(UIntPtr) / 2))
			{
				if (Vector.IsHardwareAccelerated && (nuint)(void*)intPtr >= (nuint)Vector<ushort>.Count)
				{
					IntPtr intPtr3 = intPtr - Vector<ushort>.Count;
					while (!(Unsafe.ReadUnaligned<Vector<ushort>>(ref Unsafe.As<char, byte>(ref Unsafe.Add(ref first, intPtr2))) != Unsafe.ReadUnaligned<Vector<ushort>>(ref Unsafe.As<char, byte>(ref Unsafe.Add(ref second, intPtr2)))))
					{
						intPtr2 += Vector<ushort>.Count;
						if ((void*)intPtr3 < (void*)intPtr2)
						{
							break;
						}
					}
				}
				for (; (void*)intPtr >= (void*)(intPtr2 + sizeof(UIntPtr) / 2) && !(Unsafe.ReadUnaligned<UIntPtr>(ref Unsafe.As<char, byte>(ref Unsafe.Add(ref first, intPtr2))) != Unsafe.ReadUnaligned<UIntPtr>(ref Unsafe.As<char, byte>(ref Unsafe.Add(ref second, intPtr2)))); intPtr2 += sizeof(UIntPtr) / 2)
				{
				}
			}
			if (sizeof(UIntPtr) > 4 && (void*)intPtr >= (void*)(intPtr2 + 2) && Unsafe.ReadUnaligned<int>(ref Unsafe.As<char, byte>(ref Unsafe.Add(ref first, intPtr2))) == Unsafe.ReadUnaligned<int>(ref Unsafe.As<char, byte>(ref Unsafe.Add(ref second, intPtr2))))
			{
				intPtr2 += 2;
			}
			for (; (void*)intPtr2 < (void*)intPtr; intPtr2 += 1)
			{
				int num = Unsafe.Add(ref first, intPtr2).CompareTo(Unsafe.Add(ref second, intPtr2));
				if (num != 0)
				{
					return num;
				}
			}
		}
		return result;
	}

	public unsafe static int IndexOf(ref char searchSpace, char value, int length)
	{
		fixed (char* ptr = &searchSpace)
		{
			char* ptr2 = ptr;
			char* ptr3 = ptr2 + length;
			if (Vector.IsHardwareAccelerated && length >= Vector<ushort>.Count * 2)
			{
				int num = ((int)ptr2 & (Unsafe.SizeOf<Vector<ushort>>() - 1)) / 2;
				length = (Vector<ushort>.Count - num) & (Vector<ushort>.Count - 1);
			}
			while (true)
			{
				if (length >= 4)
				{
					length -= 4;
					if (*ptr2 == value)
					{
						break;
					}
					if (ptr2[1] != value)
					{
						if (ptr2[2] != value)
						{
							if (ptr2[3] != value)
							{
								ptr2 += 4;
								continue;
							}
							ptr2++;
						}
						ptr2++;
					}
					ptr2++;
					break;
				}
				while (length > 0)
				{
					length--;
					if (*ptr2 == value)
					{
						goto end_IL_0079;
					}
					ptr2++;
				}
				if (Vector.IsHardwareAccelerated && ptr2 < ptr3)
				{
					length = (int)((ptr3 - ptr2) & ~(Vector<ushort>.Count - 1));
					Vector<ushort> left = new Vector<ushort>(value);
					while (length > 0)
					{
						Vector<ushort> vector = Vector.Equals(left, Unsafe.Read<Vector<ushort>>(ptr2));
						if (Vector<ushort>.Zero.Equals(vector))
						{
							ptr2 += Vector<ushort>.Count;
							length -= Vector<ushort>.Count;
							continue;
						}
						return (int)(ptr2 - ptr) + LocateFirstFoundChar(vector);
					}
					if (ptr2 < ptr3)
					{
						length = (int)(ptr3 - ptr2);
						continue;
					}
				}
				return -1;
				continue;
				end_IL_0079:
				break;
			}
			return (int)(ptr2 - ptr);
		}
	}

	public unsafe static int LastIndexOf(ref char searchSpace, char value, int length)
	{
		fixed (char* ptr = &searchSpace)
		{
			char* ptr2 = ptr + length;
			char* ptr3 = ptr;
			if (Vector.IsHardwareAccelerated && length >= Vector<ushort>.Count * 2)
			{
				length = ((int)ptr2 & (Unsafe.SizeOf<Vector<ushort>>() - 1)) / 2;
			}
			while (true)
			{
				if (length >= 4)
				{
					length -= 4;
					ptr2 -= 4;
					if (ptr2[3] == value)
					{
						break;
					}
					if (ptr2[2] != value)
					{
						if (ptr2[1] != value)
						{
							if (*ptr2 != value)
							{
								continue;
							}
							goto IL_011a;
						}
						return (int)(ptr2 - ptr3) + 1;
					}
					return (int)(ptr2 - ptr3) + 2;
				}
				while (length > 0)
				{
					length--;
					ptr2--;
					if (*ptr2 != value)
					{
						continue;
					}
					goto IL_011a;
				}
				if (Vector.IsHardwareAccelerated && ptr2 > ptr3)
				{
					length = (int)((ptr2 - ptr3) & ~(Vector<ushort>.Count - 1));
					Vector<ushort> left = new Vector<ushort>(value);
					while (length > 0)
					{
						char* ptr4 = ptr2 - Vector<ushort>.Count;
						Vector<ushort> vector = Vector.Equals(left, Unsafe.Read<Vector<ushort>>(ptr4));
						if (Vector<ushort>.Zero.Equals(vector))
						{
							ptr2 -= Vector<ushort>.Count;
							length -= Vector<ushort>.Count;
							continue;
						}
						return (int)(ptr4 - ptr3) + LocateLastFoundChar(vector);
					}
					if (ptr2 > ptr3)
					{
						length = (int)(ptr2 - ptr3);
						continue;
					}
				}
				return -1;
				IL_011a:
				return (int)(ptr2 - ptr3);
			}
			return (int)(ptr2 - ptr3) + 3;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private static int LocateFirstFoundChar(Vector<ushort> match)
	{
		Vector<ulong> vector = Vector.AsVectorUInt64(match);
		ulong num = 0uL;
		int i;
		for (i = 0; i < Vector<ulong>.Count; i++)
		{
			num = vector[i];
			if (num != 0L)
			{
				break;
			}
		}
		return i * 4 + LocateFirstFoundChar(num);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static int LocateFirstFoundChar(ulong match)
	{
		return (int)((match ^ (match - 1)) * 4295098372L >> 49);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static int LocateLastFoundChar(Vector<ushort> match)
	{
		Vector<ulong> vector = Vector.AsVectorUInt64(match);
		ulong num = 0uL;
		int num2;
		for (num2 = Vector<ulong>.Count - 1; num2 >= 0; num2--)
		{
			num = vector[num2];
			if (num != 0L)
			{
				break;
			}
		}
		return num2 * 4 + LocateLastFoundChar(num);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static int LocateLastFoundChar(ulong match)
	{
		int num = 3;
		while ((long)match > 0L)
		{
			match <<= 16;
			num--;
		}
		return num;
	}

	public unsafe static int IndexOf<T>(ref T searchSpace, T value, int length) where T : IEquatable<T>
	{
		IntPtr intPtr = (IntPtr)0;
		while (true)
		{
			if (length >= 8)
			{
				length -= 8;
				T other = Unsafe.Add(ref searchSpace, intPtr);
				if (!value.Equals(other))
				{
					T other2 = Unsafe.Add(ref searchSpace, intPtr + 1);
					if (value.Equals(other2))
					{
						goto IL_020a;
					}
					T other3 = Unsafe.Add(ref searchSpace, intPtr + 2);
					if (value.Equals(other3))
					{
						goto IL_0218;
					}
					T other4 = Unsafe.Add(ref searchSpace, intPtr + 3);
					if (!value.Equals(other4))
					{
						T other5 = Unsafe.Add(ref searchSpace, intPtr + 4);
						if (!value.Equals(other5))
						{
							T other6 = Unsafe.Add(ref searchSpace, intPtr + 5);
							if (!value.Equals(other6))
							{
								T other7 = Unsafe.Add(ref searchSpace, intPtr + 6);
								if (!value.Equals(other7))
								{
									T other8 = Unsafe.Add(ref searchSpace, intPtr + 7);
									if (value.Equals(other8))
									{
										break;
									}
									intPtr += 8;
									continue;
								}
								return (int)(void*)(intPtr + 6);
							}
							return (int)(void*)(intPtr + 5);
						}
						return (int)(void*)(intPtr + 4);
					}
					goto IL_0226;
				}
			}
			else
			{
				if (length >= 4)
				{
					length -= 4;
					T other9 = Unsafe.Add(ref searchSpace, intPtr);
					if (value.Equals(other9))
					{
						goto IL_0202;
					}
					T other10 = Unsafe.Add(ref searchSpace, intPtr + 1);
					if (value.Equals(other10))
					{
						goto IL_020a;
					}
					T other11 = Unsafe.Add(ref searchSpace, intPtr + 2);
					if (value.Equals(other11))
					{
						goto IL_0218;
					}
					T other12 = Unsafe.Add(ref searchSpace, intPtr + 3);
					if (value.Equals(other12))
					{
						goto IL_0226;
					}
					intPtr += 4;
				}
				while (true)
				{
					if (length > 0)
					{
						T other13 = Unsafe.Add(ref searchSpace, intPtr);
						if (value.Equals(other13))
						{
							break;
						}
						intPtr += 1;
						length--;
						continue;
					}
					return -1;
				}
			}
			goto IL_0202;
			IL_0218:
			return (int)(void*)(intPtr + 2);
			IL_0202:
			return (int)(void*)intPtr;
			IL_020a:
			return (int)(void*)(intPtr + 1);
			IL_0226:
			return (int)(void*)(intPtr + 3);
		}
		return (int)(void*)(intPtr + 7);
	}

	public static int IndexOfAny<T>(ref T searchSpace, int searchSpaceLength, ref T value, int valueLength) where T : IEquatable<T>
	{
		if (valueLength == 0)
		{
			return 0;
		}
		int num = -1;
		for (int i = 0; i < valueLength; i++)
		{
			int num2 = IndexOf(ref searchSpace, Unsafe.Add(ref value, i), searchSpaceLength);
			if ((uint)num2 < (uint)num)
			{
				num = num2;
				searchSpaceLength = num2;
				if (num == 0)
				{
					break;
				}
			}
		}
		return num;
	}

	public static bool SequenceEqual<T>(ref T first, ref T second, int length) where T : IEquatable<T>
	{
		if (!Unsafe.AreSame(ref first, ref second))
		{
			IntPtr intPtr = (IntPtr)0;
			while (true)
			{
				if (length >= 8)
				{
					length -= 8;
					ref T reference = ref Unsafe.Add(ref first, intPtr);
					T other = Unsafe.Add(ref second, intPtr);
					if (reference.Equals(other))
					{
						ref T reference2 = ref Unsafe.Add(ref first, intPtr + 1);
						T other2 = Unsafe.Add(ref second, intPtr + 1);
						if (reference2.Equals(other2))
						{
							ref T reference3 = ref Unsafe.Add(ref first, intPtr + 2);
							T other3 = Unsafe.Add(ref second, intPtr + 2);
							if (reference3.Equals(other3))
							{
								ref T reference4 = ref Unsafe.Add(ref first, intPtr + 3);
								T other4 = Unsafe.Add(ref second, intPtr + 3);
								if (reference4.Equals(other4))
								{
									ref T reference5 = ref Unsafe.Add(ref first, intPtr + 4);
									T other5 = Unsafe.Add(ref second, intPtr + 4);
									if (reference5.Equals(other5))
									{
										ref T reference6 = ref Unsafe.Add(ref first, intPtr + 5);
										T other6 = Unsafe.Add(ref second, intPtr + 5);
										if (reference6.Equals(other6))
										{
											ref T reference7 = ref Unsafe.Add(ref first, intPtr + 6);
											T other7 = Unsafe.Add(ref second, intPtr + 6);
											if (reference7.Equals(other7))
											{
												ref T reference8 = ref Unsafe.Add(ref first, intPtr + 7);
												T other8 = Unsafe.Add(ref second, intPtr + 7);
												if (reference8.Equals(other8))
												{
													intPtr += 8;
													continue;
												}
											}
										}
									}
								}
							}
						}
					}
				}
				else
				{
					if (length < 4)
					{
						goto IL_0285;
					}
					length -= 4;
					ref T reference9 = ref Unsafe.Add(ref first, intPtr);
					T other9 = Unsafe.Add(ref second, intPtr);
					if (reference9.Equals(other9))
					{
						ref T reference10 = ref Unsafe.Add(ref first, intPtr + 1);
						T other10 = Unsafe.Add(ref second, intPtr + 1);
						if (reference10.Equals(other10))
						{
							ref T reference11 = ref Unsafe.Add(ref first, intPtr + 2);
							T other11 = Unsafe.Add(ref second, intPtr + 2);
							if (reference11.Equals(other11))
							{
								ref T reference12 = ref Unsafe.Add(ref first, intPtr + 3);
								T other12 = Unsafe.Add(ref second, intPtr + 3);
								if (reference12.Equals(other12))
								{
									intPtr += 4;
									goto IL_0285;
								}
							}
						}
					}
				}
				goto IL_028b;
				IL_028b:
				return false;
				IL_0285:
				while (length > 0)
				{
					ref T reference13 = ref Unsafe.Add(ref first, intPtr);
					T other13 = Unsafe.Add(ref second, intPtr);
					if (reference13.Equals(other13))
					{
						intPtr += 1;
						length--;
						continue;
					}
					goto IL_028b;
				}
				break;
			}
		}
		return true;
	}

	public static int IndexOfCultureHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value, CompareInfo compareInfo)
	{
		if (GlobalizationMode.Invariant)
		{
			return CompareInfo.InvariantIndexOf(span, value, ignoreCase: false);
		}
		return compareInfo.IndexOf(span, value, CompareOptions.None);
	}

	public static int IndexOfCultureIgnoreCaseHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value, CompareInfo compareInfo)
	{
		if (GlobalizationMode.Invariant)
		{
			return CompareInfo.InvariantIndexOf(span, value, ignoreCase: true);
		}
		return compareInfo.IndexOf(span, value, CompareOptions.IgnoreCase);
	}

	public static int IndexOfOrdinalHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value, bool ignoreCase)
	{
		if (GlobalizationMode.Invariant)
		{
			return CompareInfo.InvariantIndexOf(span, value, ignoreCase);
		}
		return CompareInfo.Invariant.IndexOfOrdinal(span, value, ignoreCase);
	}

	public static bool StartsWithCultureHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value, CompareInfo compareInfo)
	{
		if (GlobalizationMode.Invariant)
		{
			return span.StartsWith(value);
		}
		if (span.Length == 0)
		{
			return false;
		}
		return compareInfo.IsPrefix(span, value, CompareOptions.None);
	}

	public static bool StartsWithCultureIgnoreCaseHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value, CompareInfo compareInfo)
	{
		if (GlobalizationMode.Invariant)
		{
			return StartsWithOrdinalIgnoreCaseHelper(span, value);
		}
		if (span.Length == 0)
		{
			return false;
		}
		return compareInfo.IsPrefix(span, value, CompareOptions.IgnoreCase);
	}

	public static bool StartsWithOrdinalIgnoreCaseHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value)
	{
		if (span.Length < value.Length)
		{
			return false;
		}
		return CompareInfo.CompareOrdinalIgnoreCase(span.Slice(0, value.Length), value) == 0;
	}

	public static bool EndsWithCultureHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value, CompareInfo compareInfo)
	{
		if (GlobalizationMode.Invariant)
		{
			return span.EndsWith(value);
		}
		if (span.Length == 0)
		{
			return false;
		}
		return compareInfo.IsSuffix(span, value, CompareOptions.None);
	}

	public static bool EndsWithCultureIgnoreCaseHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value, CompareInfo compareInfo)
	{
		if (GlobalizationMode.Invariant)
		{
			return EndsWithOrdinalIgnoreCaseHelper(span, value);
		}
		if (span.Length == 0)
		{
			return false;
		}
		return compareInfo.IsSuffix(span, value, CompareOptions.IgnoreCase);
	}

	public static bool EndsWithOrdinalIgnoreCaseHelper(ReadOnlySpan<char> span, ReadOnlySpan<char> value)
	{
		if (span.Length < value.Length)
		{
			return false;
		}
		return CompareInfo.CompareOrdinalIgnoreCase(span.Slice(span.Length - value.Length), value) == 0;
	}

	public static void ClearWithoutReferences(ref byte b, ulong byteLength)
	{
		if (byteLength == 0L)
		{
			return;
		}
		ulong num = byteLength - 1;
		if (num <= 21)
		{
			switch ((uint)num)
			{
			case 0u:
				b = 0;
				return;
			case 1u:
				Unsafe.As<byte, short>(ref b) = 0;
				return;
			case 2u:
				Unsafe.As<byte, short>(ref b) = 0;
				Unsafe.Add(ref b, 2) = 0;
				return;
			case 3u:
				Unsafe.As<byte, int>(ref b) = 0;
				return;
			case 4u:
				Unsafe.As<byte, int>(ref b) = 0;
				Unsafe.Add(ref b, 4) = 0;
				return;
			case 5u:
				Unsafe.As<byte, int>(ref b) = 0;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 4)) = 0;
				return;
			case 6u:
				Unsafe.As<byte, int>(ref b) = 0;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 4)) = 0;
				Unsafe.Add(ref b, 6) = 0;
				return;
			case 7u:
				Unsafe.As<byte, long>(ref b) = 0L;
				return;
			case 8u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.Add(ref b, 8) = 0;
				return;
			case 9u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 8)) = 0;
				return;
			case 10u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 8)) = 0;
				Unsafe.Add(ref b, 10) = 0;
				return;
			case 11u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, int>(ref Unsafe.Add(ref b, 8)) = 0;
				return;
			case 12u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, int>(ref Unsafe.Add(ref b, 8)) = 0;
				Unsafe.Add(ref b, 12) = 0;
				return;
			case 13u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, int>(ref Unsafe.Add(ref b, 8)) = 0;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 12)) = 0;
				return;
			case 14u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, int>(ref Unsafe.Add(ref b, 8)) = 0;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 12)) = 0;
				Unsafe.Add(ref b, 14) = 0;
				return;
			case 15u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, long>(ref Unsafe.Add(ref b, 8)) = 0L;
				return;
			case 16u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, long>(ref Unsafe.Add(ref b, 8)) = 0L;
				Unsafe.Add(ref b, 16) = 0;
				return;
			case 17u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, long>(ref Unsafe.Add(ref b, 8)) = 0L;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 16)) = 0;
				return;
			case 18u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, long>(ref Unsafe.Add(ref b, 8)) = 0L;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 16)) = 0;
				Unsafe.Add(ref b, 18) = 0;
				return;
			case 19u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, long>(ref Unsafe.Add(ref b, 8)) = 0L;
				Unsafe.As<byte, int>(ref Unsafe.Add(ref b, 16)) = 0;
				return;
			case 20u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, long>(ref Unsafe.Add(ref b, 8)) = 0L;
				Unsafe.As<byte, int>(ref Unsafe.Add(ref b, 16)) = 0;
				Unsafe.Add(ref b, 20) = 0;
				return;
			case 21u:
				Unsafe.As<byte, long>(ref b) = 0L;
				Unsafe.As<byte, long>(ref Unsafe.Add(ref b, 8)) = 0L;
				Unsafe.As<byte, int>(ref Unsafe.Add(ref b, 16)) = 0;
				Unsafe.As<byte, short>(ref Unsafe.Add(ref b, 20)) = 0;
				return;
			}
		}
		ulong num2;
		if (byteLength < 512)
		{
			num2 = 0uL;
			if ((Unsafe.As<byte, int>(ref b) & 3) != 0)
			{
				if ((Unsafe.As<byte, int>(ref b) & 1) != 0)
				{
					Unsafe.AddByteOffset(ref b, num2) = 0;
					num2++;
					if ((Unsafe.As<byte, int>(ref b) & 2) != 0)
					{
						goto IL_0349;
					}
				}
				Unsafe.As<byte, short>(ref Unsafe.AddByteOffset(ref b, num2)) = 0;
				num2 += 2;
			}
			goto IL_0349;
		}
		RuntimeImports.RhZeroMemory(ref b, byteLength);
		return;
		IL_0349:
		if (((Unsafe.As<byte, int>(ref b) - 1) & 4) == 0)
		{
			Unsafe.As<byte, int>(ref Unsafe.AddByteOffset(ref b, num2)) = 0;
			num2 += 4;
		}
		ulong num3 = byteLength - 16;
		byteLength -= num2;
		ulong num4;
		do
		{
			num4 = num2 + 16;
			Unsafe.As<byte, long>(ref Unsafe.AddByteOffset(ref b, num2)) = 0L;
			Unsafe.As<byte, long>(ref Unsafe.AddByteOffset(ref b, num2 + 8)) = 0L;
			num2 = num4;
		}
		while (num4 <= num3);
		if ((byteLength & 8) != 0L)
		{
			Unsafe.As<byte, long>(ref Unsafe.AddByteOffset(ref b, num2)) = 0L;
			num2 += 8;
		}
		if ((byteLength & 4) != 0L)
		{
			Unsafe.As<byte, int>(ref Unsafe.AddByteOffset(ref b, num2)) = 0;
			num2 += 4;
		}
		if ((byteLength & 2) != 0L)
		{
			Unsafe.As<byte, short>(ref Unsafe.AddByteOffset(ref b, num2)) = 0;
			num2 += 2;
		}
		if ((byteLength & 1) != 0L)
		{
			Unsafe.AddByteOffset(ref b, num2) = 0;
		}
	}

	public static void ClearWithReferences(ref IntPtr ip, ulong pointerSizeLength)
	{
		while (pointerSizeLength >= 8)
		{
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -1) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -2) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -3) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -4) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -5) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -6) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -7) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -8) = default(IntPtr);
			pointerSizeLength -= 8;
		}
		if (pointerSizeLength < 4)
		{
			if (pointerSizeLength < 2)
			{
				if (pointerSizeLength == 0)
				{
					return;
				}
				goto IL_015b;
			}
		}
		else
		{
			Unsafe.Add(ref ip, 2) = default(IntPtr);
			Unsafe.Add(ref ip, 3) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -3) = default(IntPtr);
			Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -2) = default(IntPtr);
		}
		Unsafe.Add(ref ip, 1) = default(IntPtr);
		Unsafe.Add(ref Unsafe.Add(ref ip, (IntPtr)(long)pointerSizeLength), -1) = default(IntPtr);
		goto IL_015b;
		IL_015b:
		ip = default(IntPtr);
	}
}

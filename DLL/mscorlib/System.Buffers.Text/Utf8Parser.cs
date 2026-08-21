namespace System.Buffers.Text;

public static class Utf8Parser
{
	[Flags]
	private enum ParseNumberOptions
	{
		AllowExponent = 1
	}

	private static readonly int[] s_daysToMonth365 = new int[13]
	{
		771751936, 774778414, 774778414, 774778414, 774778414, 774778414, 774778414, 151662126, 774766592, 774778414,
		774778414, 774778414, 774778414
	};

	private static readonly int[] s_daysToMonth366 = new int[13]
	{
		0, 2, 5, 22176, 4, 1, 25, 43736, 0, 2,
		13, 9680, 0
	};

	public static bool TryParse(ReadOnlySpan<byte> source, out decimal value, out int bytesConsumed, char standardFormat = '\0')
	{
		ParseNumberOptions options;
		switch (standardFormat)
		{
		case '\0':
		case 'E':
		case 'G':
		case 'e':
		case 'g':
			options = ParseNumberOptions.AllowExponent;
			break;
		case 'F':
		case 'f':
			options = (ParseNumberOptions)0;
			break;
		default:
			return ThrowHelper.TryParseThrowFormatException<decimal>(out value, out bytesConsumed);
		}
		NumberBuffer number = default(NumberBuffer);
		if (!TryParseNumber(source, ref number, out bytesConsumed, options, out var textUsedExponentNotation))
		{
			value = 0m;
			return false;
		}
		if (!textUsedExponentNotation && (standardFormat == 'E' || standardFormat == 'e'))
		{
			value = 0m;
			bytesConsumed = 0;
			return false;
		}
		if (number.Digits[0] == 0 && number.Scale == 0)
		{
			number.IsNegative = false;
		}
		value = 0m;
		if (!Number.NumberBufferToDecimal(ref number, ref value))
		{
			value = 0m;
			bytesConsumed = 0;
			return false;
		}
		return true;
	}

	private static bool TryParseUInt32D(ReadOnlySpan<byte> source, out uint value, out int bytesConsumed)
	{
		int num;
		int num3;
		int num2;
		if (source.Length >= 1)
		{
			num = 0;
			num2 = source[num];
			num3 = 0;
			if (ParserHelpers.IsDigit(num2))
			{
				if (num2 != 48)
				{
					goto IL_0056;
				}
				while (true)
				{
					num++;
					if ((uint)num >= (uint)source.Length)
					{
						break;
					}
					num2 = source[num];
					if (num2 == 48)
					{
						continue;
					}
					goto IL_004b;
				}
				goto IL_023d;
			}
		}
		goto IL_0235;
		IL_004b:
		if (ParserHelpers.IsDigit(num2))
		{
			goto IL_0056;
		}
		goto IL_023d;
		IL_0056:
		num3 = num2 - 48;
		num++;
		if ((uint)num < (uint)source.Length)
		{
			num2 = source[num];
			if (ParserHelpers.IsDigit(num2))
			{
				num++;
				num3 = 10 * num3 + num2 - 48;
				if ((uint)num < (uint)source.Length)
				{
					num2 = source[num];
					if (ParserHelpers.IsDigit(num2))
					{
						num++;
						num3 = 10 * num3 + num2 - 48;
						if ((uint)num < (uint)source.Length)
						{
							num2 = source[num];
							if (ParserHelpers.IsDigit(num2))
							{
								num++;
								num3 = 10 * num3 + num2 - 48;
								if ((uint)num < (uint)source.Length)
								{
									num2 = source[num];
									if (ParserHelpers.IsDigit(num2))
									{
										num++;
										num3 = 10 * num3 + num2 - 48;
										if ((uint)num < (uint)source.Length)
										{
											num2 = source[num];
											if (ParserHelpers.IsDigit(num2))
											{
												num++;
												num3 = 10 * num3 + num2 - 48;
												if ((uint)num < (uint)source.Length)
												{
													num2 = source[num];
													if (ParserHelpers.IsDigit(num2))
													{
														num++;
														num3 = 10 * num3 + num2 - 48;
														if ((uint)num < (uint)source.Length)
														{
															num2 = source[num];
															if (ParserHelpers.IsDigit(num2))
															{
																num++;
																num3 = 10 * num3 + num2 - 48;
																if ((uint)num < (uint)source.Length)
																{
																	num2 = source[num];
																	if (ParserHelpers.IsDigit(num2))
																	{
																		num++;
																		num3 = 10 * num3 + num2 - 48;
																		if ((uint)num < (uint)source.Length)
																		{
																			num2 = source[num];
																			if (ParserHelpers.IsDigit(num2))
																			{
																				num++;
																				if ((uint)num3 <= 429496729u && (num3 != 429496729 || num2 <= 53))
																				{
																					num3 = num3 * 10 + num2 - 48;
																					if ((uint)num >= (uint)source.Length || !ParserHelpers.IsDigit(source[num]))
																					{
																						goto IL_023d;
																					}
																				}
																				goto IL_0235;
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		goto IL_023d;
		IL_023d:
		bytesConsumed = num;
		value = (uint)num3;
		return true;
		IL_0235:
		bytesConsumed = 0;
		value = 0u;
		return false;
	}

	private static bool TryParseNumber(ReadOnlySpan<byte> source, ref NumberBuffer number, out int bytesConsumed, ParseNumberOptions options, out bool textUsedExponentNotation)
	{
		textUsedExponentNotation = false;
		if (source.Length == 0)
		{
			bytesConsumed = 0;
			return false;
		}
		Span<byte> digits = number.Digits;
		int i = 0;
		int num = 0;
		byte b = source[i];
		if (b != 43)
		{
			if (b != 45)
			{
				goto IL_0055;
			}
			number.IsNegative = true;
		}
		i++;
		if (i == source.Length)
		{
			bytesConsumed = 0;
			return false;
		}
		b = source[i];
		goto IL_0055;
		IL_0229:
		if (!TryParseUInt32D(source.Slice(i), out var value, out var bytesConsumed2))
		{
			bytesConsumed = 0;
			return false;
		}
		i += bytesConsumed2;
		bool flag;
		if (flag)
		{
			if (number.Scale < int.MinValue + value)
			{
				number.Scale = int.MinValue;
			}
			else
			{
				number.Scale -= (int)value;
			}
		}
		else
		{
			if (number.Scale > 2147483647L - (long)value)
			{
				bytesConsumed = 0;
				return false;
			}
			number.Scale += (int)value;
		}
		bytesConsumed = i;
		return true;
		IL_0055:
		int num2 = i;
		for (; i != source.Length; i++)
		{
			b = source[i];
			if (b != 48)
			{
				break;
			}
		}
		if (i == source.Length)
		{
			digits[0] = 0;
			number.Scale = 0;
			bytesConsumed = i;
			return true;
		}
		int num3 = i;
		for (; i != source.Length; i++)
		{
			b = source[i];
			if ((uint)(b - 48) > 9u)
			{
				break;
			}
		}
		int num4 = i - num2;
		int num5 = i - num3;
		int num6 = Math.Min(num5, 50);
		source.Slice(num3, num6).CopyTo(digits);
		num = num6;
		number.Scale = num5;
		if (i == source.Length)
		{
			bytesConsumed = i;
			return true;
		}
		int num7 = 0;
		if (b == 46)
		{
			i++;
			int num8 = i;
			for (; i != source.Length; i++)
			{
				b = source[i];
				if ((uint)(b - 48) > 9u)
				{
					break;
				}
			}
			num7 = i - num8;
			int j = num8;
			if (num == 0)
			{
				for (; j < i && source[j] == 48; j++)
				{
					number.Scale--;
				}
			}
			int num9 = Math.Min(i - j, 51 - num - 1);
			source.Slice(j, num9).CopyTo(digits.Slice(num));
			num += num9;
			if (i == source.Length)
			{
				if (num4 == 0 && num7 == 0)
				{
					bytesConsumed = 0;
					return false;
				}
				bytesConsumed = i;
				return true;
			}
		}
		if (num4 == 0 && num7 == 0)
		{
			bytesConsumed = 0;
			return false;
		}
		if ((b & -33) != 69)
		{
			bytesConsumed = i;
			return true;
		}
		textUsedExponentNotation = true;
		i++;
		if ((options & ParseNumberOptions.AllowExponent) == 0)
		{
			bytesConsumed = 0;
			return false;
		}
		if (i == source.Length)
		{
			bytesConsumed = 0;
			return false;
		}
		flag = false;
		b = source[i];
		if (b != 43)
		{
			if (b != 45)
			{
				goto IL_0229;
			}
			flag = true;
		}
		i++;
		if (i == source.Length)
		{
			bytesConsumed = 0;
			return false;
		}
		b = source[i];
		goto IL_0229;
	}
}

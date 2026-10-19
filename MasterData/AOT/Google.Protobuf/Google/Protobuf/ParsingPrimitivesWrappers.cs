using System;

namespace Google.Protobuf;

internal static class ParsingPrimitivesWrappers
{
	internal static float? ReadFloatWrapperLittleEndian(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		if (state.bufferPos + 6 <= state.bufferSize)
		{
			switch ((int)buffer[state.bufferPos])
			{
			case 0:
				state.bufferPos++;
				return 0f;
			case 5:
				if (buffer[state.bufferPos + 1] == 13)
				{
					state.bufferPos += 2;
					return ParsingPrimitives.ParseFloat(ref buffer, ref state);
				}
				goto default;
			default:
				return ReadFloatWrapperSlow(ref buffer, ref state);
			}
		}
		return ReadFloatWrapperSlow(ref buffer, ref state);
	}

	internal static float? ReadFloatWrapperSlow(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		int num = ParsingPrimitives.ParseLength(ref buffer, ref state);
		if (num == 0)
		{
			return 0f;
		}
		int num2 = state.totalBytesRetired + state.bufferPos + num;
		float value = 0f;
		do
		{
			if (ParsingPrimitives.ParseTag(ref buffer, ref state) == 13)
			{
				value = ParsingPrimitives.ParseFloat(ref buffer, ref state);
			}
			else
			{
				ParsingPrimitivesMessages.SkipLastField(ref buffer, ref state);
			}
		}
		while (state.totalBytesRetired + state.bufferPos < num2);
		return value;
	}

	internal static double? ReadDoubleWrapperLittleEndian(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		if (state.bufferPos + 10 <= state.bufferSize)
		{
			switch ((int)buffer[state.bufferPos])
			{
			case 0:
				state.bufferPos++;
				return 0.0;
			case 9:
				if (buffer[state.bufferPos + 1] == 9)
				{
					state.bufferPos += 2;
					return ParsingPrimitives.ParseDouble(ref buffer, ref state);
				}
				goto default;
			default:
				return ReadDoubleWrapperSlow(ref buffer, ref state);
			}
		}
		return ReadDoubleWrapperSlow(ref buffer, ref state);
	}

	internal static double? ReadDoubleWrapperSlow(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		int num = ParsingPrimitives.ParseLength(ref buffer, ref state);
		if (num == 0)
		{
			return 0.0;
		}
		int num2 = state.totalBytesRetired + state.bufferPos + num;
		double value = 0.0;
		do
		{
			if (ParsingPrimitives.ParseTag(ref buffer, ref state) == 9)
			{
				value = ParsingPrimitives.ParseDouble(ref buffer, ref state);
			}
			else
			{
				ParsingPrimitivesMessages.SkipLastField(ref buffer, ref state);
			}
		}
		while (state.totalBytesRetired + state.bufferPos < num2);
		return value;
	}

	internal static bool? ReadBoolWrapper(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		return ReadUInt64Wrapper(ref buffer, ref state) != 0;
	}

	internal static uint? ReadUInt32Wrapper(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		if (state.bufferPos + 12 <= state.bufferSize)
		{
			int bufferPos = state.bufferPos;
			int num = buffer[state.bufferPos++];
			if (num == 0)
			{
				return 0u;
			}
			if (num >= 128)
			{
				state.bufferPos = bufferPos;
				return ReadUInt32WrapperSlow(ref buffer, ref state);
			}
			int num2 = state.bufferPos + num;
			if (buffer[state.bufferPos++] != 8)
			{
				state.bufferPos = bufferPos;
				return ReadUInt32WrapperSlow(ref buffer, ref state);
			}
			uint value = ParsingPrimitives.ParseRawVarint32(ref buffer, ref state);
			if (state.bufferPos != num2)
			{
				state.bufferPos = bufferPos;
				return ReadUInt32WrapperSlow(ref buffer, ref state);
			}
			return value;
		}
		return ReadUInt32WrapperSlow(ref buffer, ref state);
	}

	internal static uint? ReadUInt32WrapperSlow(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		int num = ParsingPrimitives.ParseLength(ref buffer, ref state);
		if (num == 0)
		{
			return 0u;
		}
		int num2 = state.totalBytesRetired + state.bufferPos + num;
		uint value = 0u;
		do
		{
			if (ParsingPrimitives.ParseTag(ref buffer, ref state) == 8)
			{
				value = ParsingPrimitives.ParseRawVarint32(ref buffer, ref state);
			}
			else
			{
				ParsingPrimitivesMessages.SkipLastField(ref buffer, ref state);
			}
		}
		while (state.totalBytesRetired + state.bufferPos < num2);
		return value;
	}

	internal static int? ReadInt32Wrapper(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		return (int?)ReadUInt32Wrapper(ref buffer, ref state);
	}

	internal static ulong? ReadUInt64Wrapper(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		if (state.bufferPos + 12 <= state.bufferSize)
		{
			int bufferPos = state.bufferPos;
			int num = buffer[state.bufferPos++];
			if (num == 0)
			{
				return 0uL;
			}
			if (num >= 128)
			{
				state.bufferPos = bufferPos;
				return ReadUInt64WrapperSlow(ref buffer, ref state);
			}
			int num2 = state.bufferPos + num;
			if (buffer[state.bufferPos++] != 8)
			{
				state.bufferPos = bufferPos;
				return ReadUInt64WrapperSlow(ref buffer, ref state);
			}
			ulong value = ParsingPrimitives.ParseRawVarint64(ref buffer, ref state);
			if (state.bufferPos != num2)
			{
				state.bufferPos = bufferPos;
				return ReadUInt64WrapperSlow(ref buffer, ref state);
			}
			return value;
		}
		return ReadUInt64WrapperSlow(ref buffer, ref state);
	}

	internal static ulong? ReadUInt64WrapperSlow(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		int num = ParsingPrimitives.ParseLength(ref buffer, ref state);
		if (num == 0)
		{
			return 0uL;
		}
		int num2 = state.totalBytesRetired + state.bufferPos + num;
		ulong value = 0uL;
		do
		{
			if (ParsingPrimitives.ParseTag(ref buffer, ref state) == 8)
			{
				value = ParsingPrimitives.ParseRawVarint64(ref buffer, ref state);
			}
			else
			{
				ParsingPrimitivesMessages.SkipLastField(ref buffer, ref state);
			}
		}
		while (state.totalBytesRetired + state.bufferPos < num2);
		return value;
	}

	internal static long? ReadInt64Wrapper(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		return (long?)ReadUInt64Wrapper(ref buffer, ref state);
	}

	internal static float? ReadFloatWrapperLittleEndian(ref ParseContext ctx)
	{
		return ReadFloatWrapperLittleEndian(ref ctx.buffer, ref ctx.state);
	}

	internal static float? ReadFloatWrapperSlow(ref ParseContext ctx)
	{
		return ReadFloatWrapperSlow(ref ctx.buffer, ref ctx.state);
	}

	internal static double? ReadDoubleWrapperLittleEndian(ref ParseContext ctx)
	{
		return ReadDoubleWrapperLittleEndian(ref ctx.buffer, ref ctx.state);
	}

	internal static double? ReadDoubleWrapperSlow(ref ParseContext ctx)
	{
		return ReadDoubleWrapperSlow(ref ctx.buffer, ref ctx.state);
	}

	internal static bool? ReadBoolWrapper(ref ParseContext ctx)
	{
		return ReadBoolWrapper(ref ctx.buffer, ref ctx.state);
	}

	internal static uint? ReadUInt32Wrapper(ref ParseContext ctx)
	{
		return ReadUInt32Wrapper(ref ctx.buffer, ref ctx.state);
	}

	internal static int? ReadInt32Wrapper(ref ParseContext ctx)
	{
		return ReadInt32Wrapper(ref ctx.buffer, ref ctx.state);
	}

	internal static ulong? ReadUInt64Wrapper(ref ParseContext ctx)
	{
		return ReadUInt64Wrapper(ref ctx.buffer, ref ctx.state);
	}

	internal static long? ReadInt64Wrapper(ref ParseContext ctx)
	{
		return ReadInt64Wrapper(ref ctx.buffer, ref ctx.state);
	}
}

namespace MemoryPack;

internal static class VarIntCodes
{
	public const byte MaxSingleValue = 127;

	public const sbyte MinSingleValue = -120;

	public const sbyte Byte = -121;

	public const sbyte SByte = -122;

	public const sbyte UInt16 = -123;

	public const sbyte Int16 = -124;

	public const sbyte UInt32 = -125;

	public const sbyte Int32 = -126;

	public const sbyte UInt64 = -127;

	public const sbyte Int64 = sbyte.MinValue;
}

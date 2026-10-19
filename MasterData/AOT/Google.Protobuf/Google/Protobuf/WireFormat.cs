namespace Google.Protobuf;

public static class WireFormat
{
	public enum WireType : uint
	{
		Varint,
		Fixed64,
		LengthDelimited,
		StartGroup,
		EndGroup,
		Fixed32
	}

	public static WireType GetTagWireType(uint tag)
	{
		return (WireType)(tag & 7);
	}

	public static int GetTagFieldNumber(uint tag)
	{
		return (int)tag >> 3;
	}

	public static uint MakeTag(int fieldNumber, WireType wireType)
	{
		return (uint)(fieldNumber << 3) | (uint)wireType;
	}
}

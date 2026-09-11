namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class MemberPrimitiveTyped
{
	internal InternalPrimitiveTypeE primitiveTypeEnum;

	internal object value;

	internal MemberPrimitiveTyped()
	{
	}

	internal void Set(InternalPrimitiveTypeE primitiveTypeEnum, object value)
	{
		this.primitiveTypeEnum = primitiveTypeEnum;
		this.value = value;
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte(8);
		sout.WriteByte((byte)primitiveTypeEnum);
		sout.WriteValue(primitiveTypeEnum, value);
	}

	public void Read(__BinaryParser input)
	{
		primitiveTypeEnum = (InternalPrimitiveTypeE)input.ReadByte();
		value = input.ReadValue(primitiveTypeEnum);
	}

	public void Dump()
	{
	}
}

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class MemberPrimitiveUnTyped
{
	internal InternalPrimitiveTypeE typeInformation;

	internal object value;

	internal MemberPrimitiveUnTyped()
	{
	}

	internal void Set(InternalPrimitiveTypeE typeInformation, object value)
	{
		this.typeInformation = typeInformation;
		this.value = value;
	}

	internal void Set(InternalPrimitiveTypeE typeInformation)
	{
		this.typeInformation = typeInformation;
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteValue(typeInformation, value);
	}

	public void Read(__BinaryParser input)
	{
		value = input.ReadValue(typeInformation);
	}

	public void Dump()
	{
	}
}

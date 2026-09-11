namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ObjectNull
{
	internal int nullCount;

	internal ObjectNull()
	{
	}

	internal void SetNullCount(int nullCount)
	{
		this.nullCount = nullCount;
	}

	public void Write(__BinaryWriter sout)
	{
		if (nullCount == 1)
		{
			sout.WriteByte(10);
		}
		else if (nullCount < 256)
		{
			sout.WriteByte(13);
			sout.WriteByte((byte)nullCount);
		}
		else
		{
			sout.WriteByte(14);
			sout.WriteInt32(nullCount);
		}
	}

	public void Read(__BinaryParser input, BinaryHeaderEnum binaryHeaderEnum)
	{
		switch (binaryHeaderEnum)
		{
		case BinaryHeaderEnum.ObjectNull:
			nullCount = 1;
			break;
		case BinaryHeaderEnum.ObjectNullMultiple256:
			nullCount = input.ReadByte();
			break;
		case BinaryHeaderEnum.ObjectNullMultiple:
			nullCount = input.ReadInt32();
			break;
		case BinaryHeaderEnum.MessageEnd:
		case BinaryHeaderEnum.Assembly:
			break;
		}
	}

	public void Dump()
	{
	}
}

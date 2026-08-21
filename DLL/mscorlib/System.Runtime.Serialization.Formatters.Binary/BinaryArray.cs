namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryArray
{
	internal int objectId;

	internal int rank;

	internal int[] lengthA;

	internal int[] lowerBoundA;

	internal BinaryTypeEnum binaryTypeEnum;

	internal object typeInformation;

	internal int assemId;

	private BinaryHeaderEnum binaryHeaderEnum;

	internal BinaryArrayTypeEnum binaryArrayTypeEnum;

	internal BinaryArray()
	{
	}

	internal BinaryArray(BinaryHeaderEnum binaryHeaderEnum)
	{
		this.binaryHeaderEnum = binaryHeaderEnum;
	}

	internal void Set(int objectId, int rank, int[] lengthA, int[] lowerBoundA, BinaryTypeEnum binaryTypeEnum, object typeInformation, BinaryArrayTypeEnum binaryArrayTypeEnum, int assemId)
	{
		this.objectId = objectId;
		this.binaryArrayTypeEnum = binaryArrayTypeEnum;
		this.rank = rank;
		this.lengthA = lengthA;
		this.lowerBoundA = lowerBoundA;
		this.binaryTypeEnum = binaryTypeEnum;
		this.typeInformation = typeInformation;
		this.assemId = assemId;
		binaryHeaderEnum = BinaryHeaderEnum.Array;
		if (binaryArrayTypeEnum == BinaryArrayTypeEnum.Single)
		{
			switch (binaryTypeEnum)
			{
			case BinaryTypeEnum.Primitive:
				binaryHeaderEnum = BinaryHeaderEnum.ArraySinglePrimitive;
				break;
			case BinaryTypeEnum.String:
				binaryHeaderEnum = BinaryHeaderEnum.ArraySingleString;
				break;
			case BinaryTypeEnum.Object:
				binaryHeaderEnum = BinaryHeaderEnum.ArraySingleObject;
				break;
			}
		}
	}

	public void Write(__BinaryWriter sout)
	{
		switch (binaryHeaderEnum)
		{
		case BinaryHeaderEnum.ArraySinglePrimitive:
			sout.WriteByte((byte)binaryHeaderEnum);
			sout.WriteInt32(objectId);
			sout.WriteInt32(lengthA[0]);
			sout.WriteByte((byte)(InternalPrimitiveTypeE)typeInformation);
			return;
		case BinaryHeaderEnum.ArraySingleString:
			sout.WriteByte((byte)binaryHeaderEnum);
			sout.WriteInt32(objectId);
			sout.WriteInt32(lengthA[0]);
			return;
		case BinaryHeaderEnum.ArraySingleObject:
			sout.WriteByte((byte)binaryHeaderEnum);
			sout.WriteInt32(objectId);
			sout.WriteInt32(lengthA[0]);
			return;
		}
		sout.WriteByte((byte)binaryHeaderEnum);
		sout.WriteInt32(objectId);
		sout.WriteByte((byte)binaryArrayTypeEnum);
		sout.WriteInt32(rank);
		for (int i = 0; i < rank; i++)
		{
			sout.WriteInt32(lengthA[i]);
		}
		if (binaryArrayTypeEnum == BinaryArrayTypeEnum.SingleOffset || binaryArrayTypeEnum == BinaryArrayTypeEnum.JaggedOffset || binaryArrayTypeEnum == BinaryArrayTypeEnum.RectangularOffset)
		{
			for (int j = 0; j < rank; j++)
			{
				sout.WriteInt32(lowerBoundA[j]);
			}
		}
		sout.WriteByte((byte)binaryTypeEnum);
		BinaryConverter.WriteTypeInfo(binaryTypeEnum, typeInformation, assemId, sout);
	}

	public void Read(__BinaryParser input)
	{
		switch (binaryHeaderEnum)
		{
		case BinaryHeaderEnum.ArraySinglePrimitive:
			objectId = input.ReadInt32();
			lengthA = new int[1];
			lengthA[0] = input.ReadInt32();
			binaryArrayTypeEnum = BinaryArrayTypeEnum.Single;
			rank = 1;
			lowerBoundA = new int[rank];
			binaryTypeEnum = BinaryTypeEnum.Primitive;
			typeInformation = (InternalPrimitiveTypeE)input.ReadByte();
			return;
		case BinaryHeaderEnum.ArraySingleString:
			objectId = input.ReadInt32();
			lengthA = new int[1];
			lengthA[0] = input.ReadInt32();
			binaryArrayTypeEnum = BinaryArrayTypeEnum.Single;
			rank = 1;
			lowerBoundA = new int[rank];
			binaryTypeEnum = BinaryTypeEnum.String;
			typeInformation = null;
			return;
		case BinaryHeaderEnum.ArraySingleObject:
			objectId = input.ReadInt32();
			lengthA = new int[1];
			lengthA[0] = input.ReadInt32();
			binaryArrayTypeEnum = BinaryArrayTypeEnum.Single;
			rank = 1;
			lowerBoundA = new int[rank];
			binaryTypeEnum = BinaryTypeEnum.Object;
			typeInformation = null;
			return;
		}
		objectId = input.ReadInt32();
		binaryArrayTypeEnum = (BinaryArrayTypeEnum)input.ReadByte();
		rank = input.ReadInt32();
		lengthA = new int[rank];
		lowerBoundA = new int[rank];
		for (int i = 0; i < rank; i++)
		{
			lengthA[i] = input.ReadInt32();
		}
		if (binaryArrayTypeEnum == BinaryArrayTypeEnum.SingleOffset || binaryArrayTypeEnum == BinaryArrayTypeEnum.JaggedOffset || binaryArrayTypeEnum == BinaryArrayTypeEnum.RectangularOffset)
		{
			for (int j = 0; j < rank; j++)
			{
				lowerBoundA[j] = input.ReadInt32();
			}
		}
		binaryTypeEnum = (BinaryTypeEnum)input.ReadByte();
		typeInformation = BinaryConverter.ReadTypeInfo(binaryTypeEnum, input, out assemId);
	}
}

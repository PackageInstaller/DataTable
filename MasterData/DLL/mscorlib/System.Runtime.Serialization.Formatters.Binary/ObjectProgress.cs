namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ObjectProgress
{
	internal static int opRecordIdCount = 1;

	internal bool isInitial;

	internal int count;

	internal BinaryTypeEnum expectedType = BinaryTypeEnum.ObjectUrt;

	internal object expectedTypeInformation;

	internal string name;

	internal InternalObjectTypeE objectTypeEnum;

	internal InternalMemberTypeE memberTypeEnum;

	internal InternalMemberValueE memberValueEnum;

	internal Type dtType;

	internal int numItems;

	internal BinaryTypeEnum binaryTypeEnum;

	internal object typeInformation;

	internal int nullCount;

	internal int memberLength;

	internal BinaryTypeEnum[] binaryTypeEnumA;

	internal object[] typeInformationA;

	internal string[] memberNames;

	internal Type[] memberTypes;

	internal ParseRecord pr = new ParseRecord();

	internal ObjectProgress()
	{
	}

	internal void Init()
	{
		isInitial = false;
		count = 0;
		expectedType = BinaryTypeEnum.ObjectUrt;
		expectedTypeInformation = null;
		name = null;
		objectTypeEnum = InternalObjectTypeE.Empty;
		memberTypeEnum = InternalMemberTypeE.Empty;
		memberValueEnum = InternalMemberValueE.Empty;
		dtType = null;
		numItems = 0;
		nullCount = 0;
		typeInformation = null;
		memberLength = 0;
		binaryTypeEnumA = null;
		typeInformationA = null;
		memberNames = null;
		memberTypes = null;
		pr.Init();
	}

	internal void ArrayCountIncrement(int value)
	{
		count += value;
	}

	internal bool GetNext(out BinaryTypeEnum outBinaryTypeEnum, out object outTypeInformation)
	{
		outBinaryTypeEnum = BinaryTypeEnum.Primitive;
		outTypeInformation = null;
		if (objectTypeEnum == InternalObjectTypeE.Array)
		{
			if (count == numItems)
			{
				return false;
			}
			outBinaryTypeEnum = binaryTypeEnum;
			outTypeInformation = typeInformation;
			if (count == 0)
			{
				isInitial = false;
			}
			count++;
			return true;
		}
		if (count == memberLength && !isInitial)
		{
			return false;
		}
		outBinaryTypeEnum = binaryTypeEnumA[count];
		outTypeInformation = typeInformationA[count];
		if (count == 0)
		{
			isInitial = false;
		}
		name = memberNames[count];
		_ = memberTypes;
		dtType = memberTypes[count];
		count++;
		return true;
	}
}

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ParseRecord
{
	internal static int parseRecordIdCount = 1;

	internal InternalParseTypeE PRparseTypeEnum;

	internal InternalObjectTypeE PRobjectTypeEnum;

	internal InternalArrayTypeE PRarrayTypeEnum;

	internal InternalMemberTypeE PRmemberTypeEnum;

	internal InternalMemberValueE PRmemberValueEnum;

	internal InternalObjectPositionE PRobjectPositionEnum;

	internal string PRname;

	internal string PRvalue;

	internal object PRvarValue;

	internal string PRkeyDt;

	internal Type PRdtType;

	internal InternalPrimitiveTypeE PRdtTypeCode;

	internal bool PRisEnum;

	internal long PRobjectId;

	internal long PRidRef;

	internal string PRarrayElementTypeString;

	internal Type PRarrayElementType;

	internal bool PRisArrayVariant;

	internal InternalPrimitiveTypeE PRarrayElementTypeCode;

	internal int PRrank;

	internal int[] PRlengthA;

	internal int[] PRpositionA;

	internal int[] PRlowerBoundA;

	internal int[] PRupperBoundA;

	internal int[] PRindexMap;

	internal int PRmemberIndex;

	internal int PRlinearlength;

	internal int[] PRrectangularMap;

	internal bool PRisLowerBound;

	internal long PRtopId;

	internal long PRheaderId;

	internal ReadObjectInfo PRobjectInfo;

	internal bool PRisValueTypeFixup;

	internal object PRnewObj;

	internal object[] PRobjectA;

	internal PrimitiveArray PRprimitiveArray;

	internal bool PRisRegistered;

	internal object[] PRmemberData;

	internal SerializationInfo PRsi;

	internal int PRnullCount;

	internal ParseRecord()
	{
	}

	internal void Init()
	{
		PRparseTypeEnum = InternalParseTypeE.Empty;
		PRobjectTypeEnum = InternalObjectTypeE.Empty;
		PRarrayTypeEnum = InternalArrayTypeE.Empty;
		PRmemberTypeEnum = InternalMemberTypeE.Empty;
		PRmemberValueEnum = InternalMemberValueE.Empty;
		PRobjectPositionEnum = InternalObjectPositionE.Empty;
		PRname = null;
		PRvalue = null;
		PRkeyDt = null;
		PRdtType = null;
		PRdtTypeCode = InternalPrimitiveTypeE.Invalid;
		PRisEnum = false;
		PRobjectId = 0L;
		PRidRef = 0L;
		PRarrayElementTypeString = null;
		PRarrayElementType = null;
		PRisArrayVariant = false;
		PRarrayElementTypeCode = InternalPrimitiveTypeE.Invalid;
		PRrank = 0;
		PRlengthA = null;
		PRpositionA = null;
		PRlowerBoundA = null;
		PRupperBoundA = null;
		PRindexMap = null;
		PRmemberIndex = 0;
		PRlinearlength = 0;
		PRrectangularMap = null;
		PRisLowerBound = false;
		PRtopId = 0L;
		PRheaderId = 0L;
		PRisValueTypeFixup = false;
		PRnewObj = null;
		PRobjectA = null;
		PRprimitiveArray = null;
		PRobjectInfo = null;
		PRisRegistered = false;
		PRmemberData = null;
		PRsi = null;
		PRnullCount = 0;
	}
}

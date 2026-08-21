using System.Globalization;
using System.IO;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.Remoting.Messaging;
using System.Threading;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ObjectReader
{
	internal class TypeNAssembly
	{
		public Type type;

		public string assemblyName;
	}

	internal sealed class TopLevelAssemblyTypeResolver
	{
		private Assembly m_topLevelAssembly;

		public TopLevelAssemblyTypeResolver(Assembly topLevelAssembly)
		{
			m_topLevelAssembly = topLevelAssembly;
		}

		public Type ResolveType(Assembly assembly, string simpleTypeName, bool ignoreCase)
		{
			if (assembly == null)
			{
				assembly = m_topLevelAssembly;
			}
			return assembly.GetType(simpleTypeName, throwOnError: false, ignoreCase);
		}
	}

	internal Stream m_stream;

	internal ISurrogateSelector m_surrogates;

	internal StreamingContext m_context;

	internal ObjectManager m_objectManager;

	internal InternalFE formatterEnums;

	internal SerializationBinder m_binder;

	internal long topId;

	internal bool bSimpleAssembly;

	internal object handlerObject;

	internal object m_topObject;

	internal Header[] headers;

	internal HeaderHandler handler;

	internal SerObjectInfoInit serObjectInfoInit;

	internal IFormatterConverter m_formatterConverter;

	internal SerStack stack;

	private SerStack valueFixupStack;

	internal object[] crossAppDomainArray;

	private bool bFullDeserialization;

	private bool bOldFormatDetected;

	private IntSizedArray valTypeObjectIdTable;

	private NameCache typeCache = new NameCache();

	private string previousAssemblyString;

	private string previousName;

	private Type previousType;

	private SerStack ValueFixupStack
	{
		get
		{
			if (valueFixupStack == null)
			{
				valueFixupStack = new SerStack("ValueType Fixup Stack");
			}
			return valueFixupStack;
		}
	}

	internal object TopObject
	{
		get
		{
			return m_topObject;
		}
		set
		{
			m_topObject = value;
			if (m_objectManager != null)
			{
				m_objectManager.TopObject = value;
			}
		}
	}

	internal ObjectReader(Stream stream, ISurrogateSelector selector, StreamingContext context, InternalFE formatterEnums, SerializationBinder binder)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream", Environment.GetResourceString("Stream cannot be null."));
		}
		m_stream = stream;
		m_surrogates = selector;
		m_context = context;
		m_binder = binder;
		this.formatterEnums = formatterEnums;
	}

	internal object Deserialize(HeaderHandler handler, __BinaryParser serParser, bool fCheck)
	{
		if (serParser == null)
		{
			throw new ArgumentNullException("serParser", Environment.GetResourceString("Parameter '{0}' cannot be null.", serParser));
		}
		bFullDeserialization = false;
		TopObject = null;
		topId = 0L;
		bSimpleAssembly = formatterEnums.FEassemblyFormat == FormatterAssemblyStyle.Simple;
		this.handler = handler;
		if (bFullDeserialization)
		{
			m_objectManager = new ObjectManager(m_surrogates, m_context, checkSecurity: false, isCrossAppDomain: false);
			serObjectInfoInit = new SerObjectInfoInit();
		}
		serParser.Run();
		if (bFullDeserialization)
		{
			m_objectManager.DoFixups();
		}
		if (TopObject == null)
		{
			throw new SerializationException(Environment.GetResourceString("No top object."));
		}
		if (HasSurrogate(TopObject.GetType()) && topId != 0L)
		{
			TopObject = m_objectManager.GetObject(topId);
		}
		if (TopObject is IObjectReference)
		{
			TopObject = ((IObjectReference)TopObject).GetRealObject(m_context);
		}
		if (bFullDeserialization)
		{
			m_objectManager.RaiseDeserializationEvent();
		}
		if (handler != null)
		{
			handlerObject = handler(headers);
		}
		return TopObject;
	}

	private bool HasSurrogate(Type t)
	{
		if (m_surrogates == null)
		{
			return false;
		}
		ISurrogateSelector selector;
		return m_surrogates.GetSurrogate(t, m_context, out selector) != null;
	}

	private void CheckSerializable(Type t)
	{
		if (!t.IsSerializable && !HasSurrogate(t))
		{
			throw new SerializationException(string.Format(CultureInfo.InvariantCulture, Environment.GetResourceString("Type '{0}' in Assembly '{1}' is not marked as serializable."), t.FullName, t.Assembly.FullName));
		}
	}

	private void InitFullDeserialization()
	{
		bFullDeserialization = true;
		stack = new SerStack("ObjectReader Object Stack");
		m_objectManager = new ObjectManager(m_surrogates, m_context, checkSecurity: false, isCrossAppDomain: false);
		if (m_formatterConverter == null)
		{
			m_formatterConverter = new FormatterConverter();
		}
	}

	internal object CrossAppDomainArray(int index)
	{
		return crossAppDomainArray[index];
	}

	internal ReadObjectInfo CreateReadObjectInfo(Type objectType)
	{
		return ReadObjectInfo.Create(objectType, m_surrogates, m_context, m_objectManager, serObjectInfoInit, m_formatterConverter, bSimpleAssembly);
	}

	internal ReadObjectInfo CreateReadObjectInfo(Type objectType, string[] memberNames, Type[] memberTypes)
	{
		return ReadObjectInfo.Create(objectType, memberNames, memberTypes, m_surrogates, m_context, m_objectManager, serObjectInfoInit, m_formatterConverter, bSimpleAssembly);
	}

	internal void Parse(ParseRecord pr)
	{
		switch (pr.PRparseTypeEnum)
		{
		case InternalParseTypeE.SerializedStreamHeader:
			ParseSerializedStreamHeader(pr);
			break;
		case InternalParseTypeE.SerializedStreamHeaderEnd:
			ParseSerializedStreamHeaderEnd(pr);
			break;
		case InternalParseTypeE.Object:
			ParseObject(pr);
			break;
		case InternalParseTypeE.ObjectEnd:
			ParseObjectEnd(pr);
			break;
		case InternalParseTypeE.Member:
			ParseMember(pr);
			break;
		case InternalParseTypeE.MemberEnd:
			ParseMemberEnd(pr);
			break;
		default:
			throw new SerializationException(Environment.GetResourceString("Invalid element '{0}'.", pr.PRname));
		case InternalParseTypeE.Envelope:
		case InternalParseTypeE.EnvelopeEnd:
		case InternalParseTypeE.Body:
		case InternalParseTypeE.BodyEnd:
			break;
		}
	}

	private void ParseError(ParseRecord processing, ParseRecord onStack)
	{
		throw new SerializationException(Environment.GetResourceString("Parse error. Current element is not compatible with the next element, {0}.", onStack.PRname + " " + ((object)onStack.PRparseTypeEnum)?.ToString() + " " + processing.PRname + " " + (object)processing.PRparseTypeEnum));
	}

	private void ParseSerializedStreamHeader(ParseRecord pr)
	{
		stack.Push(pr);
	}

	private void ParseSerializedStreamHeaderEnd(ParseRecord pr)
	{
		stack.Pop();
	}

	private void ParseObject(ParseRecord pr)
	{
		if (!bFullDeserialization)
		{
			InitFullDeserialization();
		}
		if (pr.PRobjectPositionEnum == InternalObjectPositionE.Top)
		{
			topId = pr.PRobjectId;
		}
		if (pr.PRparseTypeEnum == InternalParseTypeE.Object)
		{
			stack.Push(pr);
		}
		if (pr.PRobjectTypeEnum == InternalObjectTypeE.Array)
		{
			ParseArray(pr);
			return;
		}
		if ((object)pr.PRdtType == null)
		{
			pr.PRnewObj = new TypeLoadExceptionHolder(pr.PRkeyDt);
			return;
		}
		if ((object)pr.PRdtType == Converter.typeofString)
		{
			if (pr.PRvalue != null)
			{
				pr.PRnewObj = pr.PRvalue;
				if (pr.PRobjectPositionEnum == InternalObjectPositionE.Top)
				{
					TopObject = pr.PRnewObj;
					return;
				}
				stack.Pop();
				RegisterObject(pr.PRnewObj, pr, (ParseRecord)stack.Peek());
			}
			return;
		}
		CheckSerializable(pr.PRdtType);
		pr.PRnewObj = FormatterServices.GetUninitializedObject(pr.PRdtType);
		m_objectManager.RaiseOnDeserializingEvent(pr.PRnewObj);
		if (pr.PRnewObj == null)
		{
			throw new SerializationException(Environment.GetResourceString("Top object cannot be instantiated for element '{0}'.", pr.PRdtType));
		}
		if (pr.PRobjectPositionEnum == InternalObjectPositionE.Top)
		{
			TopObject = pr.PRnewObj;
		}
		if (pr.PRobjectInfo == null)
		{
			pr.PRobjectInfo = ReadObjectInfo.Create(pr.PRdtType, m_surrogates, m_context, m_objectManager, serObjectInfoInit, m_formatterConverter, bSimpleAssembly);
		}
	}

	private void ParseObjectEnd(ParseRecord pr)
	{
		ParseRecord parseRecord = (ParseRecord)stack.Peek();
		if (parseRecord == null)
		{
			parseRecord = pr;
		}
		if (parseRecord.PRobjectPositionEnum == InternalObjectPositionE.Top && (object)parseRecord.PRdtType == Converter.typeofString)
		{
			parseRecord.PRnewObj = parseRecord.PRvalue;
			TopObject = parseRecord.PRnewObj;
			return;
		}
		stack.Pop();
		ParseRecord parseRecord2 = (ParseRecord)stack.Peek();
		if (parseRecord.PRnewObj == null)
		{
			return;
		}
		if (parseRecord.PRobjectTypeEnum == InternalObjectTypeE.Array)
		{
			if (parseRecord.PRobjectPositionEnum == InternalObjectPositionE.Top)
			{
				TopObject = parseRecord.PRnewObj;
			}
			RegisterObject(parseRecord.PRnewObj, parseRecord, parseRecord2);
			return;
		}
		parseRecord.PRobjectInfo.PopulateObjectMembers(parseRecord.PRnewObj, parseRecord.PRmemberData);
		if (!parseRecord.PRisRegistered && parseRecord.PRobjectId > 0)
		{
			RegisterObject(parseRecord.PRnewObj, parseRecord, parseRecord2);
		}
		if (parseRecord.PRisValueTypeFixup)
		{
			((ValueFixup)ValueFixupStack.Pop()).Fixup(parseRecord, parseRecord2);
		}
		if (parseRecord.PRobjectPositionEnum == InternalObjectPositionE.Top)
		{
			TopObject = parseRecord.PRnewObj;
		}
		parseRecord.PRobjectInfo.ObjectEnd();
	}

	private void ParseArray(ParseRecord pr)
	{
		if (pr.PRarrayTypeEnum == InternalArrayTypeE.Base64)
		{
			if (pr.PRvalue.Length > 0)
			{
				pr.PRnewObj = Convert.FromBase64String(pr.PRvalue);
			}
			else
			{
				pr.PRnewObj = new byte[0];
			}
			if (stack.Peek() == pr)
			{
				stack.Pop();
			}
			if (pr.PRobjectPositionEnum == InternalObjectPositionE.Top)
			{
				TopObject = pr.PRnewObj;
			}
			ParseRecord objectPr = (ParseRecord)stack.Peek();
			RegisterObject(pr.PRnewObj, pr, objectPr);
			return;
		}
		if (pr.PRnewObj != null && Converter.IsWriteAsByteArray(pr.PRarrayElementTypeCode))
		{
			if (pr.PRobjectPositionEnum == InternalObjectPositionE.Top)
			{
				TopObject = pr.PRnewObj;
			}
			ParseRecord objectPr2 = (ParseRecord)stack.Peek();
			RegisterObject(pr.PRnewObj, pr, objectPr2);
			return;
		}
		if (pr.PRarrayTypeEnum == InternalArrayTypeE.Jagged || pr.PRarrayTypeEnum == InternalArrayTypeE.Single)
		{
			bool flag = true;
			if (pr.PRlowerBoundA == null || pr.PRlowerBoundA[0] == 0)
			{
				if ((object)pr.PRarrayElementType == Converter.typeofString)
				{
					object[] pRobjectA = new string[pr.PRlengthA[0]];
					pr.PRobjectA = pRobjectA;
					pr.PRnewObj = pr.PRobjectA;
					flag = false;
				}
				else if ((object)pr.PRarrayElementType == Converter.typeofObject)
				{
					pr.PRobjectA = new object[pr.PRlengthA[0]];
					pr.PRnewObj = pr.PRobjectA;
					flag = false;
				}
				else if ((object)pr.PRarrayElementType != null)
				{
					pr.PRnewObj = Array.UnsafeCreateInstance(pr.PRarrayElementType, pr.PRlengthA[0]);
				}
				pr.PRisLowerBound = false;
			}
			else
			{
				if ((object)pr.PRarrayElementType != null)
				{
					pr.PRnewObj = Array.UnsafeCreateInstance(pr.PRarrayElementType, pr.PRlengthA, pr.PRlowerBoundA);
				}
				pr.PRisLowerBound = true;
			}
			if (pr.PRarrayTypeEnum == InternalArrayTypeE.Single)
			{
				if (!pr.PRisLowerBound && Converter.IsWriteAsByteArray(pr.PRarrayElementTypeCode))
				{
					pr.PRprimitiveArray = new PrimitiveArray(pr.PRarrayElementTypeCode, (Array)pr.PRnewObj);
				}
				else if (flag && (object)pr.PRarrayElementType != null && !pr.PRarrayElementType.IsValueType && !pr.PRisLowerBound)
				{
					pr.PRobjectA = (object[])pr.PRnewObj;
				}
			}
			if (pr.PRobjectPositionEnum == InternalObjectPositionE.Headers)
			{
				headers = (Header[])pr.PRnewObj;
			}
			pr.PRindexMap = new int[1];
			return;
		}
		if (pr.PRarrayTypeEnum == InternalArrayTypeE.Rectangular)
		{
			pr.PRisLowerBound = false;
			if (pr.PRlowerBoundA != null)
			{
				for (int i = 0; i < pr.PRrank; i++)
				{
					if (pr.PRlowerBoundA[i] != 0)
					{
						pr.PRisLowerBound = true;
					}
				}
			}
			if ((object)pr.PRarrayElementType != null)
			{
				if (!pr.PRisLowerBound)
				{
					pr.PRnewObj = Array.UnsafeCreateInstance(pr.PRarrayElementType, pr.PRlengthA);
				}
				else
				{
					pr.PRnewObj = Array.UnsafeCreateInstance(pr.PRarrayElementType, pr.PRlengthA, pr.PRlowerBoundA);
				}
			}
			int num = 1;
			for (int j = 0; j < pr.PRrank; j++)
			{
				num *= pr.PRlengthA[j];
			}
			pr.PRindexMap = new int[pr.PRrank];
			pr.PRrectangularMap = new int[pr.PRrank];
			pr.PRlinearlength = num;
			return;
		}
		throw new SerializationException(Environment.GetResourceString("Invalid array type '{0}'.", pr.PRarrayTypeEnum));
	}

	private void NextRectangleMap(ParseRecord pr)
	{
		for (int num = pr.PRrank - 1; num > -1; num--)
		{
			if (pr.PRrectangularMap[num] < pr.PRlengthA[num] - 1)
			{
				pr.PRrectangularMap[num]++;
				if (num < pr.PRrank - 1)
				{
					for (int i = num + 1; i < pr.PRrank; i++)
					{
						pr.PRrectangularMap[i] = 0;
					}
				}
				Array.Copy(pr.PRrectangularMap, pr.PRindexMap, pr.PRrank);
				break;
			}
		}
	}

	private void ParseArrayMember(ParseRecord pr)
	{
		ParseRecord parseRecord = (ParseRecord)stack.Peek();
		if (parseRecord.PRarrayTypeEnum == InternalArrayTypeE.Rectangular)
		{
			if (parseRecord.PRmemberIndex > 0)
			{
				NextRectangleMap(parseRecord);
			}
			if (parseRecord.PRisLowerBound)
			{
				for (int i = 0; i < parseRecord.PRrank; i++)
				{
					parseRecord.PRindexMap[i] = parseRecord.PRrectangularMap[i] + parseRecord.PRlowerBoundA[i];
				}
			}
		}
		else if (!parseRecord.PRisLowerBound)
		{
			parseRecord.PRindexMap[0] = parseRecord.PRmemberIndex;
		}
		else
		{
			parseRecord.PRindexMap[0] = parseRecord.PRlowerBoundA[0] + parseRecord.PRmemberIndex;
		}
		if (pr.PRmemberValueEnum == InternalMemberValueE.Reference)
		{
			object obj = m_objectManager.GetObject(pr.PRidRef);
			if (obj == null)
			{
				int[] array = new int[parseRecord.PRrank];
				Array.Copy(parseRecord.PRindexMap, 0, array, 0, parseRecord.PRrank);
				m_objectManager.RecordArrayElementFixup(parseRecord.PRobjectId, array, pr.PRidRef);
			}
			else if (parseRecord.PRobjectA != null)
			{
				parseRecord.PRobjectA[parseRecord.PRindexMap[0]] = obj;
			}
			else
			{
				((Array)parseRecord.PRnewObj).SetValue(obj, parseRecord.PRindexMap);
			}
		}
		else if (pr.PRmemberValueEnum == InternalMemberValueE.Nested)
		{
			if ((object)pr.PRdtType == null)
			{
				pr.PRdtType = parseRecord.PRarrayElementType;
			}
			ParseObject(pr);
			stack.Push(pr);
			if ((object)parseRecord.PRarrayElementType != null)
			{
				if (parseRecord.PRarrayElementType.IsValueType && pr.PRarrayElementTypeCode == InternalPrimitiveTypeE.Invalid)
				{
					pr.PRisValueTypeFixup = true;
					ValueFixupStack.Push(new ValueFixup((Array)parseRecord.PRnewObj, parseRecord.PRindexMap));
				}
				else if (parseRecord.PRobjectA != null)
				{
					parseRecord.PRobjectA[parseRecord.PRindexMap[0]] = pr.PRnewObj;
				}
				else
				{
					((Array)parseRecord.PRnewObj).SetValue(pr.PRnewObj, parseRecord.PRindexMap);
				}
			}
		}
		else if (pr.PRmemberValueEnum == InternalMemberValueE.InlineValue)
		{
			if ((object)parseRecord.PRarrayElementType == Converter.typeofString || (object)pr.PRdtType == Converter.typeofString)
			{
				ParseString(pr, parseRecord);
				if (parseRecord.PRobjectA != null)
				{
					parseRecord.PRobjectA[parseRecord.PRindexMap[0]] = pr.PRvalue;
				}
				else
				{
					((Array)parseRecord.PRnewObj).SetValue(pr.PRvalue, parseRecord.PRindexMap);
				}
			}
			else if (parseRecord.PRisArrayVariant)
			{
				if (pr.PRkeyDt == null)
				{
					throw new SerializationException(Environment.GetResourceString("Array element type is Object, 'dt' attribute is null."));
				}
				object obj2 = null;
				if ((object)pr.PRdtType == Converter.typeofString)
				{
					ParseString(pr, parseRecord);
					obj2 = pr.PRvalue;
				}
				else if ((object)pr.PRdtTypeCode != (object)InternalPrimitiveTypeE.Invalid)
				{
					obj2 = ((pr.PRvarValue == null) ? Converter.FromString(pr.PRvalue, pr.PRdtTypeCode) : pr.PRvarValue);
				}
				else
				{
					CheckSerializable(pr.PRdtType);
					obj2 = FormatterServices.GetUninitializedObject(pr.PRdtType);
				}
				if (parseRecord.PRobjectA != null)
				{
					parseRecord.PRobjectA[parseRecord.PRindexMap[0]] = obj2;
				}
				else
				{
					((Array)parseRecord.PRnewObj).SetValue(obj2, parseRecord.PRindexMap);
				}
			}
			else if (parseRecord.PRprimitiveArray != null)
			{
				parseRecord.PRprimitiveArray.SetValue(pr.PRvalue, parseRecord.PRindexMap[0]);
			}
			else
			{
				object obj3 = null;
				obj3 = ((pr.PRvarValue == null) ? Converter.FromString(pr.PRvalue, parseRecord.PRarrayElementTypeCode) : pr.PRvarValue);
				if (parseRecord.PRobjectA != null)
				{
					parseRecord.PRobjectA[parseRecord.PRindexMap[0]] = obj3;
				}
				else
				{
					((Array)parseRecord.PRnewObj).SetValue(obj3, parseRecord.PRindexMap);
				}
			}
		}
		else if (pr.PRmemberValueEnum == InternalMemberValueE.Null)
		{
			parseRecord.PRmemberIndex += pr.PRnullCount - 1;
		}
		else
		{
			ParseError(pr, parseRecord);
		}
		parseRecord.PRmemberIndex++;
	}

	private void ParseArrayMemberEnd(ParseRecord pr)
	{
		if (pr.PRmemberValueEnum == InternalMemberValueE.Nested)
		{
			ParseObjectEnd(pr);
		}
	}

	private void ParseMember(ParseRecord pr)
	{
		ParseRecord parseRecord = (ParseRecord)stack.Peek();
		InternalMemberTypeE pRmemberTypeEnum = pr.PRmemberTypeEnum;
		if (pRmemberTypeEnum != InternalMemberTypeE.Field && pRmemberTypeEnum == InternalMemberTypeE.Item)
		{
			ParseArrayMember(pr);
			return;
		}
		if ((object)pr.PRdtType == null && parseRecord.PRobjectInfo.isTyped)
		{
			pr.PRdtType = parseRecord.PRobjectInfo.GetType(pr.PRname);
			if ((object)pr.PRdtType != null)
			{
				pr.PRdtTypeCode = Converter.ToCode(pr.PRdtType);
			}
		}
		if (pr.PRmemberValueEnum == InternalMemberValueE.Null)
		{
			parseRecord.PRobjectInfo.AddValue(pr.PRname, null, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
		}
		else if (pr.PRmemberValueEnum == InternalMemberValueE.Nested)
		{
			ParseObject(pr);
			stack.Push(pr);
			if (pr.PRobjectInfo != null && (object)pr.PRobjectInfo.objectType != null && pr.PRobjectInfo.objectType.IsValueType)
			{
				pr.PRisValueTypeFixup = true;
				ValueFixupStack.Push(new ValueFixup(parseRecord.PRnewObj, pr.PRname, parseRecord.PRobjectInfo));
			}
			else
			{
				parseRecord.PRobjectInfo.AddValue(pr.PRname, pr.PRnewObj, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
			}
		}
		else if (pr.PRmemberValueEnum == InternalMemberValueE.Reference)
		{
			object obj = m_objectManager.GetObject(pr.PRidRef);
			if (obj == null)
			{
				parseRecord.PRobjectInfo.AddValue(pr.PRname, null, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
				parseRecord.PRobjectInfo.RecordFixup(parseRecord.PRobjectId, pr.PRname, pr.PRidRef);
			}
			else
			{
				parseRecord.PRobjectInfo.AddValue(pr.PRname, obj, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
			}
		}
		else if (pr.PRmemberValueEnum == InternalMemberValueE.InlineValue)
		{
			if ((object)pr.PRdtType == Converter.typeofString)
			{
				ParseString(pr, parseRecord);
				parseRecord.PRobjectInfo.AddValue(pr.PRname, pr.PRvalue, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
			}
			else if (pr.PRdtTypeCode == InternalPrimitiveTypeE.Invalid)
			{
				if (pr.PRarrayTypeEnum == InternalArrayTypeE.Base64)
				{
					parseRecord.PRobjectInfo.AddValue(pr.PRname, Convert.FromBase64String(pr.PRvalue), ref parseRecord.PRsi, ref parseRecord.PRmemberData);
					return;
				}
				if ((object)pr.PRdtType == Converter.typeofObject)
				{
					throw new SerializationException(Environment.GetResourceString("Type is missing for member of type Object '{0}'.", pr.PRname));
				}
				ParseString(pr, parseRecord);
				if ((object)pr.PRdtType == Converter.typeofSystemVoid)
				{
					parseRecord.PRobjectInfo.AddValue(pr.PRname, pr.PRdtType, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
				}
				else if (parseRecord.PRobjectInfo.isSi)
				{
					parseRecord.PRobjectInfo.AddValue(pr.PRname, pr.PRvalue, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
				}
			}
			else
			{
				object obj2 = null;
				obj2 = ((pr.PRvarValue == null) ? Converter.FromString(pr.PRvalue, pr.PRdtTypeCode) : pr.PRvarValue);
				parseRecord.PRobjectInfo.AddValue(pr.PRname, obj2, ref parseRecord.PRsi, ref parseRecord.PRmemberData);
			}
		}
		else
		{
			ParseError(pr, parseRecord);
		}
	}

	private void ParseMemberEnd(ParseRecord pr)
	{
		switch (pr.PRmemberTypeEnum)
		{
		case InternalMemberTypeE.Item:
			ParseArrayMemberEnd(pr);
			break;
		case InternalMemberTypeE.Field:
			if (pr.PRmemberValueEnum == InternalMemberValueE.Nested)
			{
				ParseObjectEnd(pr);
			}
			break;
		default:
			ParseError(pr, (ParseRecord)stack.Peek());
			break;
		}
	}

	private void ParseString(ParseRecord pr, ParseRecord parentPr)
	{
		if (!pr.PRisRegistered && pr.PRobjectId > 0)
		{
			RegisterObject(pr.PRvalue, pr, parentPr, bIsString: true);
		}
	}

	private void RegisterObject(object obj, ParseRecord pr, ParseRecord objectPr)
	{
		RegisterObject(obj, pr, objectPr, bIsString: false);
	}

	private void RegisterObject(object obj, ParseRecord pr, ParseRecord objectPr, bool bIsString)
	{
		if (pr.PRisRegistered)
		{
			return;
		}
		pr.PRisRegistered = true;
		SerializationInfo serializationInfo = null;
		long idOfContainingObj = 0L;
		MemberInfo member = null;
		int[] arrayIndex = null;
		if (objectPr != null)
		{
			arrayIndex = objectPr.PRindexMap;
			idOfContainingObj = objectPr.PRobjectId;
			if (objectPr.PRobjectInfo != null && !objectPr.PRobjectInfo.isSi)
			{
				member = objectPr.PRobjectInfo.GetMemberInfo(pr.PRname);
			}
		}
		serializationInfo = pr.PRsi;
		if (bIsString)
		{
			m_objectManager.RegisterString((string)obj, pr.PRobjectId, serializationInfo, idOfContainingObj, member);
		}
		else
		{
			m_objectManager.RegisterObject(obj, pr.PRobjectId, serializationInfo, idOfContainingObj, member, arrayIndex);
		}
	}

	internal long GetId(long objectId)
	{
		if (!bFullDeserialization)
		{
			InitFullDeserialization();
		}
		if (objectId > 0)
		{
			return objectId;
		}
		if (bOldFormatDetected || objectId == -1)
		{
			bOldFormatDetected = true;
			if (valTypeObjectIdTable == null)
			{
				valTypeObjectIdTable = new IntSizedArray();
			}
			long num = 0L;
			if ((num = valTypeObjectIdTable[(int)objectId]) == 0L)
			{
				num = int.MaxValue + objectId;
				valTypeObjectIdTable[(int)objectId] = (int)num;
			}
			return num;
		}
		return -1 * objectId;
	}

	internal Type Bind(string assemblyString, string typeString)
	{
		Type type = null;
		if (m_binder != null)
		{
			type = m_binder.BindToType(assemblyString, typeString);
		}
		if ((object)type == null)
		{
			type = FastBindToType(assemblyString, typeString);
		}
		return type;
	}

	internal Type FastBindToType(string assemblyName, string typeName)
	{
		Type type = null;
		TypeNAssembly typeNAssembly = (TypeNAssembly)typeCache.GetCachedValue(typeName);
		if (typeNAssembly == null || typeNAssembly.assemblyName != assemblyName)
		{
			Assembly assembly = null;
			if (bSimpleAssembly)
			{
				try
				{
					assembly = ResolveSimpleAssemblyName(new AssemblyName(assemblyName));
				}
				catch (Exception)
				{
				}
				if (assembly == null)
				{
					return null;
				}
				GetSimplyNamedTypeFromAssembly(assembly, typeName, ref type);
			}
			else
			{
				try
				{
					assembly = Assembly.Load(assemblyName);
				}
				catch (Exception)
				{
				}
				if (assembly == null)
				{
					return null;
				}
				type = FormatterServices.GetTypeFromAssembly(assembly, typeName);
			}
			if ((object)type == null)
			{
				return null;
			}
			CheckTypeForwardedTo(assembly, type.Assembly, type);
			typeNAssembly = new TypeNAssembly();
			typeNAssembly.type = type;
			typeNAssembly.assemblyName = assemblyName;
			typeCache.SetCachedValue(typeNAssembly);
		}
		return typeNAssembly.type;
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Assembly ResolveSimpleAssemblyName(AssemblyName assemblyName)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMe;
		Assembly assembly = RuntimeAssembly.LoadWithPartialNameInternal(assemblyName, null, ref stackMark);
		if (assembly == null && assemblyName != null)
		{
			assembly = RuntimeAssembly.LoadWithPartialNameInternal(assemblyName.Name, null, ref stackMark);
		}
		return assembly;
	}

	private static void GetSimplyNamedTypeFromAssembly(Assembly assm, string typeName, ref Type type)
	{
		try
		{
			type = FormatterServices.GetTypeFromAssembly(assm, typeName);
		}
		catch (TypeLoadException)
		{
		}
		catch (FileNotFoundException)
		{
		}
		catch (FileLoadException)
		{
		}
		catch (BadImageFormatException)
		{
		}
		if ((object)type == null)
		{
			type = Type.GetType(typeName, ResolveSimpleAssemblyName, new TopLevelAssemblyTypeResolver(assm).ResolveType, throwOnError: false);
		}
	}

	internal Type GetType(BinaryAssemblyInfo assemblyInfo, string name)
	{
		Type type = null;
		if (previousName != null && previousName.Length == name.Length && previousName.Equals(name) && previousAssemblyString != null && previousAssemblyString.Length == assemblyInfo.assemblyString.Length && previousAssemblyString.Equals(assemblyInfo.assemblyString))
		{
			type = previousType;
		}
		else
		{
			type = Bind(assemblyInfo.assemblyString, name);
			if ((object)type == null)
			{
				Assembly assembly = assemblyInfo.GetAssembly();
				if (bSimpleAssembly)
				{
					GetSimplyNamedTypeFromAssembly(assembly, name, ref type);
				}
				else
				{
					type = FormatterServices.GetTypeFromAssembly(assembly, name);
				}
				if (type != null)
				{
					CheckTypeForwardedTo(assembly, type.Assembly, type);
				}
			}
			previousAssemblyString = assemblyInfo.assemblyString;
			previousName = name;
			previousType = type;
		}
		return type;
	}

	private static void CheckTypeForwardedTo(Assembly sourceAssembly, Assembly destAssembly, Type resolvedType)
	{
		if (FormatterServices.UnsafeTypeForwardersIsEnabled() || !(sourceAssembly != destAssembly))
		{
			return;
		}
		TypeInformation typeInformation = BinaryFormatter.GetTypeInformation(resolvedType);
		if (typeInformation.HasTypeForwardedFrom)
		{
			try
			{
				Assembly.Load(typeInformation.AssemblyString);
			}
			catch
			{
			}
		}
	}
}

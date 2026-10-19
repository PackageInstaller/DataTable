using System.Reflection;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ValueFixup
{
	internal ValueFixupEnum valueFixupEnum;

	internal Array arrayObj;

	internal int[] indexMap;

	internal object header;

	internal object memberObject;

	internal static volatile MemberInfo valueInfo;

	internal ReadObjectInfo objectInfo;

	internal string memberName;

	internal ValueFixup(Array arrayObj, int[] indexMap)
	{
		valueFixupEnum = ValueFixupEnum.Array;
		this.arrayObj = arrayObj;
		this.indexMap = indexMap;
	}

	internal ValueFixup(object memberObject, string memberName, ReadObjectInfo objectInfo)
	{
		valueFixupEnum = ValueFixupEnum.Member;
		this.memberObject = memberObject;
		this.memberName = memberName;
		this.objectInfo = objectInfo;
	}

	internal void Fixup(ParseRecord record, ParseRecord parent)
	{
		object pRnewObj = record.PRnewObj;
		switch (valueFixupEnum)
		{
		case ValueFixupEnum.Array:
			arrayObj.SetValue(pRnewObj, indexMap);
			break;
		case ValueFixupEnum.Header:
		{
			Type typeFromHandle = typeof(Header);
			if (valueInfo == null)
			{
				MemberInfo[] member = typeFromHandle.GetMember("Value");
				if (member.Length != 1)
				{
					throw new SerializationException(Environment.GetResourceString("Header reflection error: number of value members: {0}.", member.Length));
				}
				valueInfo = member[0];
			}
			FormatterServices.SerializationSetValue(valueInfo, header, pRnewObj);
			break;
		}
		case ValueFixupEnum.Member:
		{
			if (objectInfo.isSi)
			{
				objectInfo.objectManager.RecordDelayedFixup(parent.PRobjectId, memberName, record.PRobjectId);
				break;
			}
			MemberInfo memberInfo = objectInfo.GetMemberInfo(memberName);
			if (memberInfo != null)
			{
				objectInfo.objectManager.RecordFixup(parent.PRobjectId, memberInfo, record.PRobjectId);
			}
			break;
		}
		}
	}
}

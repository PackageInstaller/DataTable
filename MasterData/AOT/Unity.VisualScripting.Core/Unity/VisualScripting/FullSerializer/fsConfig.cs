using System;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting.FullSerializer;

public class fsConfig
{
	public Type[] SerializeAttributes = new Type[4]
	{
		typeof(SerializeField),
		typeof(fsPropertyAttribute),
		typeof(SerializeAttribute),
		typeof(SerializeAsAttribute)
	};

	public Type[] IgnoreSerializeAttributes = new Type[3]
	{
		typeof(NonSerializedAttribute),
		typeof(fsIgnoreAttribute),
		typeof(DoNotSerializeAttribute)
	};

	public fsMemberSerialization DefaultMemberSerialization = fsMemberSerialization.Default;

	public Func<string, MemberInfo, string> GetJsonNameFromMemberName = (string name, MemberInfo info) => name;

	public bool EnablePropertySerialization = true;

	public bool SerializeNonAutoProperties;

	public bool SerializeNonPublicSetProperties = true;

	public string CustomDateTimeFormatString;

	public bool Serialize64BitIntegerAsString;

	public bool SerializeEnumsAsInteger;
}

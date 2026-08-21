using System;
using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer;

public class fsConfig
{
	public Type[] SerializeAttributes = new Type[2]
	{
		typeof(SerializeField),
		typeof(fsPropertyAttribute)
	};

	public Type[] IgnoreSerializeAttributes = new Type[2]
	{
		typeof(NonSerializedAttribute),
		typeof(fsIgnoreAttribute)
	};

	public fsMemberSerialization DefaultMemberSerialization = fsMemberSerialization.Default;

	public Func<string, MemberInfo, string> GetJsonNameFromMemberName = (string name, MemberInfo info) => name;

	public bool SerializeNonAutoProperties;

	public bool SerializeNonPublicSetProperties;

	public string CustomDateTimeFormatString;

	public bool Serialize64BitIntegerAsString;

	public bool SerializeEnumsAsInteger;
}

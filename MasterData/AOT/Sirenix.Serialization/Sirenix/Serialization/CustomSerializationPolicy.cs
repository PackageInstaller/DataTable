using System;
using System.Reflection;

namespace Sirenix.Serialization;

public class CustomSerializationPolicy : ISerializationPolicy
{
	private string id;

	private bool allowNonSerializableTypes;

	private Func<MemberInfo, bool> shouldSerializeFunc;

	public string ID => id;

	public bool AllowNonSerializableTypes => allowNonSerializableTypes;

	public CustomSerializationPolicy(string id, bool allowNonSerializableTypes, Func<MemberInfo, bool> shouldSerializeFunc)
	{
		if (id == null)
		{
			throw new ArgumentNullException("id");
		}
		if (shouldSerializeFunc == null)
		{
			throw new ArgumentNullException("shouldSerializeFunc");
		}
		this.id = id;
		this.allowNonSerializableTypes = allowNonSerializableTypes;
		this.shouldSerializeFunc = shouldSerializeFunc;
	}

	public bool ShouldSerializeMember(MemberInfo member)
	{
		return shouldSerializeFunc(member);
	}
}

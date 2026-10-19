using System;
using System.Reflection;
using System.Runtime.CompilerServices;
using Sirenix.Serialization.Utilities;
using UnityEngine;

namespace Sirenix.Serialization;

public static class SerializationPolicies
{
	private static readonly object LOCK = new object();

	private static volatile ISerializationPolicy everythingPolicy;

	private static volatile ISerializationPolicy unityPolicy;

	private static volatile ISerializationPolicy strictPolicy;

	public static ISerializationPolicy Everything
	{
		get
		{
			if (everythingPolicy == null)
			{
				lock (LOCK)
				{
					if (everythingPolicy == null)
					{
						everythingPolicy = new CustomSerializationPolicy("OdinSerializerPolicies.Everything", allowNonSerializableTypes: true, (MemberInfo member) =>
						{
							if (!(member is FieldInfo))
							{
								return false;
							}
							return member.IsDefined<OdinSerializeAttribute>(inherit: true) || !member.IsDefined<NonSerializedAttribute>(inherit: true);
						});
					}
				}
			}
			return everythingPolicy;
		}
	}

	public static ISerializationPolicy Unity
	{
		get
		{
			if (unityPolicy == null)
			{
				lock (LOCK)
				{
					if (unityPolicy == null)
					{
						Type tupleInterface = typeof(string).Assembly.GetType("System.ITuple") ?? typeof(string).Assembly.GetType("System.ITupleInternal");
						unityPolicy = new CustomSerializationPolicy("OdinSerializerPolicies.Unity", allowNonSerializableTypes: true, (MemberInfo member) =>
						{
							if (member is PropertyInfo)
							{
								PropertyInfo propertyInfo = member as PropertyInfo;
								if (propertyInfo.GetGetMethod(nonPublic: true) == null || propertyInfo.GetSetMethod(nonPublic: true) == null)
								{
									return false;
								}
							}
							if (member.IsDefined<NonSerializedAttribute>(inherit: true) && !member.IsDefined<OdinSerializeAttribute>())
							{
								return false;
							}
							if (member is FieldInfo && ((member as FieldInfo).IsPublic || (member.DeclaringType.IsNestedPrivate && member.DeclaringType.IsDefined<CompilerGeneratedAttribute>()) || (tupleInterface != null && tupleInterface.IsAssignableFrom(member.DeclaringType))))
							{
								return true;
							}
							return member.IsDefined<SerializeField>(inherit: false) || member.IsDefined<OdinSerializeAttribute>(inherit: false) || (UnitySerializationUtility.SerializeReferenceAttributeType != null && member.IsDefined(UnitySerializationUtility.SerializeReferenceAttributeType, inherit: false));
						});
					}
				}
			}
			return unityPolicy;
		}
	}

	public static ISerializationPolicy Strict
	{
		get
		{
			if (strictPolicy == null)
			{
				lock (LOCK)
				{
					if (strictPolicy == null)
					{
						strictPolicy = new CustomSerializationPolicy("OdinSerializerPolicies.Strict", allowNonSerializableTypes: true, (MemberInfo member) =>
						{
							if (member is PropertyInfo && !((PropertyInfo)member).IsAutoProperty())
							{
								return false;
							}
							if (member.IsDefined<NonSerializedAttribute>())
							{
								return false;
							}
							if (member is FieldInfo && member.DeclaringType.IsNestedPrivate && member.DeclaringType.IsDefined<CompilerGeneratedAttribute>())
							{
								return true;
							}
							return member.IsDefined<SerializeField>(inherit: false) || member.IsDefined<OdinSerializeAttribute>(inherit: false) || (UnitySerializationUtility.SerializeReferenceAttributeType != null && member.IsDefined(UnitySerializationUtility.SerializeReferenceAttributeType, inherit: false));
						});
					}
				}
			}
			return strictPolicy;
		}
	}

	public static bool TryGetByID(string name, out ISerializationPolicy policy)
	{
		switch (name)
		{
		case "OdinSerializerPolicies.Everything":
			policy = Everything;
			break;
		case "OdinSerializerPolicies.Unity":
			policy = Unity;
			break;
		case "OdinSerializerPolicies.Strict":
			policy = Strict;
			break;
		default:
			policy = null;
			break;
		}
		return policy != null;
	}
}

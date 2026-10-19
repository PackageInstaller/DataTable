using System;
using System.Reflection;
using Unity.VisualScripting.FullSerializer.Internal;

namespace Unity.VisualScripting.FullSerializer;

public class fsMetaProperty
{
	internal MemberInfo _memberInfo;

	public Type StorageType { get; private set; }

	public Type OverrideConverterType { get; private set; }

	public bool CanRead { get; private set; }

	public bool CanWrite { get; private set; }

	public string JsonName { get; private set; }

	public string MemberName { get; private set; }

	public bool IsPublic { get; private set; }

	public bool IsReadOnly { get; private set; }

	internal fsMetaProperty(fsConfig config, FieldInfo field)
	{
		_memberInfo = field;
		StorageType = field.FieldType;
		MemberName = field.Name;
		IsPublic = field.IsPublic;
		IsReadOnly = field.IsInitOnly;
		CanRead = true;
		CanWrite = true;
		CommonInitialize(config);
	}

	internal fsMetaProperty(fsConfig config, PropertyInfo property)
	{
		_memberInfo = property;
		StorageType = property.PropertyType;
		MemberName = property.Name;
		IsPublic = property.GetGetMethod() != null && property.GetGetMethod().IsPublic && property.GetSetMethod() != null && property.GetSetMethod().IsPublic;
		IsReadOnly = false;
		CanRead = property.CanRead;
		CanWrite = property.CanWrite;
		CommonInitialize(config);
	}

	private void CommonInitialize(fsConfig config)
	{
		fsPropertyAttribute attribute = fsPortableReflection.GetAttribute<fsPropertyAttribute>(_memberInfo);
		if (attribute != null)
		{
			JsonName = attribute.Name;
			OverrideConverterType = attribute.Converter;
		}
		if (string.IsNullOrEmpty(JsonName))
		{
			JsonName = config.GetJsonNameFromMemberName(MemberName, _memberInfo);
		}
	}

	public void Write(object context, object value)
	{
		FieldInfo fieldInfo = _memberInfo as FieldInfo;
		PropertyInfo propertyInfo = _memberInfo as PropertyInfo;
		if (fieldInfo != null)
		{
			if (PlatformUtility.supportsJit)
			{
				fieldInfo.SetValueOptimized(context, value);
			}
			else
			{
				fieldInfo.SetValue(context, value);
			}
		}
		else
		{
			if (!(propertyInfo != null))
			{
				return;
			}
			if (PlatformUtility.supportsJit)
			{
				if (propertyInfo.CanWrite)
				{
					propertyInfo.SetValueOptimized(context, value);
				}
				return;
			}
			MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
			if (setMethod != null)
			{
				setMethod.Invoke(context, new object[1] { value });
			}
		}
	}

	public object Read(object context)
	{
		if (_memberInfo is PropertyInfo)
		{
			return ((PropertyInfo)_memberInfo).GetValue(context, null);
		}
		return ((FieldInfo)_memberInfo).GetValue(context);
	}
}

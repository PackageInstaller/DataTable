using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace System.Reflection;

[Serializable]
[ComDefaultInterface(typeof(_ParameterInfo))]
[ComVisible(true)]
[ClassInterface(ClassInterfaceType.None)]
internal class RuntimeParameterInfo : ParameterInfo
{
	internal MarshalAsAttribute marshalAs;

	public override object DefaultValue
	{
		get
		{
			if (ClassImpl == typeof(decimal) || ClassImpl == typeof(decimal?))
			{
				DecimalConstantAttribute[] array = (DecimalConstantAttribute[])GetCustomAttributes(typeof(DecimalConstantAttribute), inherit: false);
				if (array.Length != 0)
				{
					return array[0].Value;
				}
			}
			else if (ClassImpl == typeof(DateTime) || ClassImpl == typeof(DateTime?))
			{
				DateTimeConstantAttribute[] array2 = (DateTimeConstantAttribute[])GetCustomAttributes(typeof(DateTimeConstantAttribute), inherit: false);
				if (array2.Length != 0)
				{
					return array2[0].Value;
				}
			}
			return DefaultValueImpl;
		}
	}

	public override object RawDefaultValue
	{
		get
		{
			if (DefaultValue != null && DefaultValue.GetType().IsEnum)
			{
				return ((Enum)DefaultValue).GetValue();
			}
			return DefaultValue;
		}
	}

	public override int MetadataToken
	{
		get
		{
			if (MemberImpl is PropertyInfo)
			{
				PropertyInfo propertyInfo = (PropertyInfo)MemberImpl;
				MethodInfo methodInfo = propertyInfo.GetGetMethod(nonPublic: true);
				if (methodInfo == null)
				{
					methodInfo = propertyInfo.GetSetMethod(nonPublic: true);
				}
				return methodInfo.GetParametersInternal()[PositionImpl].MetadataToken;
			}
			if (MemberImpl is MethodBase)
			{
				return GetMetadataToken();
			}
			throw new ArgumentException("Can't produce MetadataToken for member of type " + MemberImpl.GetType());
		}
	}

	public override bool HasDefaultValue
	{
		get
		{
			object defaultValue = DefaultValue;
			if (defaultValue == null)
			{
				return true;
			}
			if (defaultValue.GetType() == typeof(DBNull) || defaultValue.GetType() == typeof(Missing))
			{
				return false;
			}
			return true;
		}
	}

	internal RuntimeParameterInfo(string name, Type type, int position, int attrs, object defaultValue, MemberInfo member, MarshalAsAttribute marshalAs)
	{
		NameImpl = name;
		ClassImpl = type;
		PositionImpl = position;
		AttrsImpl = (ParameterAttributes)attrs;
		DefaultValueImpl = defaultValue;
		MemberImpl = member;
		this.marshalAs = marshalAs;
	}

	internal static void FormatParameters(StringBuilder sb, ParameterInfo[] p, CallingConventions callingConvention, bool serialization)
	{
		for (int i = 0; i < p.Length; i++)
		{
			if (i > 0)
			{
				sb.Append(", ");
			}
			Type parameterType = p[i].ParameterType;
			string text = parameterType.FormatTypeName(serialization);
			if (parameterType.IsByRef && !serialization)
			{
				sb.Append(text.TrimEnd(new char[1] { '&' }));
				sb.Append(" ByRef");
			}
			else
			{
				sb.Append(text);
			}
		}
		if ((callingConvention & CallingConventions.VarArgs) != 0)
		{
			if (p.Length != 0)
			{
				sb.Append(", ");
			}
			sb.Append("...");
		}
	}

	internal RuntimeParameterInfo(ParameterInfo pinfo, MemberInfo member)
	{
		ClassImpl = pinfo.ParameterType;
		MemberImpl = member;
		NameImpl = pinfo.Name;
		PositionImpl = pinfo.Position;
		AttrsImpl = pinfo.Attributes;
		DefaultValueImpl = GetDefaultValueImpl(pinfo);
	}

	internal RuntimeParameterInfo(Type type, MemberInfo member, MarshalAsAttribute marshalAs)
	{
		ClassImpl = type;
		MemberImpl = member;
		NameImpl = null;
		PositionImpl = -1;
		AttrsImpl = ParameterAttributes.Retval;
		this.marshalAs = marshalAs;
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, inherit: false);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, attributeType, inherit: false);
	}

	internal object GetDefaultValueImpl(ParameterInfo pinfo)
	{
		return typeof(ParameterInfo).GetField("DefaultValueImpl", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(pinfo);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.IsDefined(this, attributeType, inherit);
	}

	public override IList<CustomAttributeData> GetCustomAttributesData()
	{
		return CustomAttributeData.GetCustomAttributes(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern int GetMetadataToken();

	public override Type[] GetOptionalCustomModifiers()
	{
		return GetCustomModifiers(optional: true);
	}

	internal object[] GetPseudoCustomAttributes()
	{
		int num = 0;
		if (base.IsIn)
		{
			num++;
		}
		if (base.IsOut)
		{
			num++;
		}
		if (base.IsOptional)
		{
			num++;
		}
		if (marshalAs != null)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		object[] array = new object[num];
		num = 0;
		if (base.IsIn)
		{
			array[num++] = new InAttribute();
		}
		if (base.IsOut)
		{
			array[num++] = new OutAttribute();
		}
		if (base.IsOptional)
		{
			array[num++] = new OptionalAttribute();
		}
		if (marshalAs != null)
		{
			array[num++] = marshalAs.Copy();
		}
		return array;
	}

	internal CustomAttributeData[] GetPseudoCustomAttributesData()
	{
		int num = 0;
		if (base.IsIn)
		{
			num++;
		}
		if (base.IsOut)
		{
			num++;
		}
		if (base.IsOptional)
		{
			num++;
		}
		if (marshalAs != null)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		CustomAttributeData[] array = new CustomAttributeData[num];
		num = 0;
		if (base.IsIn)
		{
			array[num++] = new CustomAttributeData(typeof(InAttribute).GetConstructor(Type.EmptyTypes));
		}
		if (base.IsOut)
		{
			array[num++] = new CustomAttributeData(typeof(OutAttribute).GetConstructor(Type.EmptyTypes));
		}
		if (base.IsOptional)
		{
			array[num++] = new CustomAttributeData(typeof(OptionalAttribute).GetConstructor(Type.EmptyTypes));
		}
		if (marshalAs != null)
		{
			CustomAttributeTypedArgument[] ctorArgs = new CustomAttributeTypedArgument[1]
			{
				new CustomAttributeTypedArgument(typeof(UnmanagedType), marshalAs.Value)
			};
			array[num++] = new CustomAttributeData(typeof(MarshalAsAttribute).GetConstructor(new Type[1] { typeof(UnmanagedType) }), ctorArgs, EmptyArray<CustomAttributeNamedArgument>.Value);
		}
		return array;
	}

	public override Type[] GetRequiredCustomModifiers()
	{
		return GetCustomModifiers(optional: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Type[] GetTypeModifiers(Type type, MemberInfo member, int position, bool optional);

	internal static ParameterInfo New(ParameterInfo pinfo, MemberInfo member)
	{
		return new RuntimeParameterInfo(pinfo, member);
	}

	internal static ParameterInfo New(Type type, MemberInfo member, MarshalAsAttribute marshalAs)
	{
		return new RuntimeParameterInfo(type, member, marshalAs);
	}

	private Type[] GetCustomModifiers(bool optional)
	{
		return GetTypeModifiers(ParameterType, Member, Position, optional) ?? Type.EmptyTypes;
	}
}

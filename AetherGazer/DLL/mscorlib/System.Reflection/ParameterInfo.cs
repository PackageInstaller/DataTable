using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using Unity;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
public class ParameterInfo : ICustomAttributeProvider, IObjectReference, _ParameterInfo
{
	protected ParameterAttributes AttrsImpl;

	protected Type ClassImpl;

	protected object DefaultValueImpl;

	protected MemberInfo MemberImpl;

	protected string NameImpl;

	protected int PositionImpl;

	private const int MetadataToken_ParamDef = 134217728;

	public virtual ParameterAttributes Attributes => AttrsImpl;

	public virtual MemberInfo Member => MemberImpl;

	public virtual string Name => NameImpl;

	public virtual Type ParameterType => ClassImpl;

	public virtual int Position => PositionImpl;

	public bool IsIn => (Attributes & ParameterAttributes.In) != 0;

	public bool IsLcid => (Attributes & ParameterAttributes.Lcid) != 0;

	public bool IsOptional => (Attributes & ParameterAttributes.Optional) != 0;

	public bool IsOut => (Attributes & ParameterAttributes.Out) != 0;

	public bool IsRetval => (Attributes & ParameterAttributes.Retval) != 0;

	public virtual object DefaultValue
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual object RawDefaultValue
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual bool HasDefaultValue
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual IEnumerable<CustomAttributeData> CustomAttributes => GetCustomAttributesData();

	public virtual int MetadataToken => 134217728;

	protected ParameterInfo()
	{
	}

	public virtual bool IsDefined(Type attributeType, bool inherit)
	{
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		return false;
	}

	public virtual IList<CustomAttributeData> GetCustomAttributesData()
	{
		throw NotImplemented.ByDesign;
	}

	public virtual object[] GetCustomAttributes(bool inherit)
	{
		return Array.Empty<object>();
	}

	public virtual object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		return Array.Empty<object>();
	}

	public virtual Type[] GetOptionalCustomModifiers()
	{
		return Array.Empty<Type>();
	}

	public virtual Type[] GetRequiredCustomModifiers()
	{
		return Array.Empty<Type>();
	}

	public object GetRealObject(StreamingContext context)
	{
		if (MemberImpl == null)
		{
			throw new SerializationException("Insufficient state to return the real object.");
		}
		ParameterInfo[] array = null;
		switch (MemberImpl.MemberType)
		{
		case MemberTypes.Constructor:
		case MemberTypes.Method:
			if (PositionImpl == -1)
			{
				if (MemberImpl.MemberType == MemberTypes.Method)
				{
					return ((MethodInfo)MemberImpl).ReturnParameter;
				}
				throw new SerializationException("Non existent ParameterInfo. Position bigger than member's parameters length.");
			}
			array = ((MethodBase)MemberImpl).GetParametersNoCopy();
			if (array != null && PositionImpl < array.Length)
			{
				return array[PositionImpl];
			}
			throw new SerializationException("Non existent ParameterInfo. Position bigger than member's parameters length.");
		case MemberTypes.Property:
			array = ((PropertyInfo)MemberImpl).GetIndexParameters();
			if (array != null && PositionImpl > -1 && PositionImpl < array.Length)
			{
				return array[PositionImpl];
			}
			throw new SerializationException("Non existent ParameterInfo. Position bigger than member's parameters length.");
		default:
			throw new SerializationException("Serialized member does not have a ParameterInfo.");
		}
	}

	public override string ToString()
	{
		return ParameterType.FormatTypeName() + " " + Name;
	}

	void _ParameterInfo.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _ParameterInfo.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _ParameterInfo.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _ParameterInfo.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}

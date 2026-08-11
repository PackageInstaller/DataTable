using System.Collections.Generic;
using System.Runtime.InteropServices;
using Unity;

namespace System.Reflection;

[Serializable]
public abstract class MemberInfo : ICustomAttributeProvider, _MemberInfo
{
	public abstract MemberTypes MemberType { get; }

	public abstract string Name { get; }

	public abstract Type DeclaringType { get; }

	public abstract Type ReflectedType { get; }

	public virtual Module Module
	{
		get
		{
			Type type = this as Type;
			if (type != null)
			{
				return type.Module;
			}
			throw NotImplemented.ByDesign;
		}
	}

	public virtual IEnumerable<CustomAttributeData> CustomAttributes => GetCustomAttributesData();

	public virtual int MetadataToken
	{
		get
		{
			throw new InvalidOperationException();
		}
	}

	public virtual bool HasSameMetadataDefinitionAs(MemberInfo other)
	{
		throw NotImplemented.ByDesign;
	}

	public abstract bool IsDefined(Type attributeType, bool inherit);

	public abstract object[] GetCustomAttributes(bool inherit);

	public abstract object[] GetCustomAttributes(Type attributeType, bool inherit);

	public virtual IList<CustomAttributeData> GetCustomAttributesData()
	{
		throw NotImplemented.ByDesign;
	}

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(MemberInfo left, MemberInfo right)
	{
		if ((object)left == right)
		{
			return true;
		}
		if ((object)left == null || (object)right == null)
		{
			return false;
		}
		Type type;
		Type type2;
		if ((type = left as Type) != null && (type2 = right as Type) != null)
		{
			return type == type2;
		}
		MethodBase methodBase;
		MethodBase methodBase2;
		if ((methodBase = left as MethodBase) != null && (methodBase2 = right as MethodBase) != null)
		{
			return methodBase == methodBase2;
		}
		FieldInfo fieldInfo;
		FieldInfo fieldInfo2;
		if ((fieldInfo = left as FieldInfo) != null && (fieldInfo2 = right as FieldInfo) != null)
		{
			return fieldInfo == fieldInfo2;
		}
		EventInfo eventInfo;
		EventInfo eventInfo2;
		if ((eventInfo = left as EventInfo) != null && (eventInfo2 = right as EventInfo) != null)
		{
			return eventInfo == eventInfo2;
		}
		PropertyInfo propertyInfo;
		PropertyInfo propertyInfo2;
		if ((propertyInfo = left as PropertyInfo) != null && (propertyInfo2 = right as PropertyInfo) != null)
		{
			return propertyInfo == propertyInfo2;
		}
		return false;
	}

	public static bool operator !=(MemberInfo left, MemberInfo right)
	{
		return !(left == right);
	}

	internal virtual bool CacheEquals(object o)
	{
		throw new NotImplementedException();
	}

	internal bool HasSameMetadataDefinitionAsCore<TOther>(MemberInfo other) where TOther : MemberInfo
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (!(other is TOther))
		{
			return false;
		}
		if (MetadataToken != other.MetadataToken)
		{
			return false;
		}
		if (!Module.Equals(other.Module))
		{
			return false;
		}
		return true;
	}

	void _MemberInfo.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	Type _MemberInfo.GetType()
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	void _MemberInfo.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _MemberInfo.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _MemberInfo.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}

using System.Collections.Generic;
using System.Globalization;
using System.Runtime.InteropServices;

namespace System.Reflection;

internal abstract class SignatureType : Type
{
	public sealed override bool IsSignatureType => true;

	public abstract override bool IsTypeDefinition { get; }

	public abstract override bool IsSZArray { get; }

	public abstract override bool IsVariableBoundArray { get; }

	public abstract override bool IsByRefLike { get; }

	public sealed override bool IsGenericType
	{
		get
		{
			if (!IsGenericTypeDefinition)
			{
				return IsConstructedGenericType;
			}
			return true;
		}
	}

	public abstract override bool IsGenericTypeDefinition { get; }

	public abstract override bool IsConstructedGenericType { get; }

	public abstract override bool IsGenericParameter { get; }

	public abstract override bool IsGenericTypeParameter { get; }

	public abstract override bool IsGenericMethodParameter { get; }

	public abstract override bool ContainsGenericParameters { get; }

	public sealed override MemberTypes MemberType => MemberTypes.TypeInfo;

	public abstract override Type[] GenericTypeArguments { get; }

	public abstract override int GenericParameterPosition { get; }

	internal abstract SignatureType ElementType { get; }

	public sealed override Type UnderlyingSystemType => this;

	public abstract override string Name { get; }

	public abstract override string Namespace { get; }

	public sealed override string FullName => null;

	public sealed override string AssemblyQualifiedName => null;

	public sealed override Assembly Assembly
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override Module Module
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override Type ReflectedType
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override Type BaseType
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override int MetadataToken
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override Type DeclaringType
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override MethodBase DeclaringMethod
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override GenericParameterAttributes GenericParameterAttributes
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override Guid GUID
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override IEnumerable<CustomAttributeData> CustomAttributes
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override bool IsEnum
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override bool IsSecurityCritical
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override bool IsSecuritySafeCritical
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override bool IsSecurityTransparent
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override bool IsSerializable
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override StructLayoutAttribute StructLayoutAttribute
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	public sealed override RuntimeTypeHandle TypeHandle
	{
		get
		{
			throw new NotSupportedException("This method is not supported on signature types.");
		}
	}

	protected abstract override bool HasElementTypeImpl();

	protected abstract override bool IsArrayImpl();

	protected abstract override bool IsByRefImpl();

	protected abstract override bool IsPointerImpl();

	public sealed override Type MakeArrayType()
	{
		return new SignatureArrayType(this, 1, isMultiDim: false);
	}

	public sealed override Type MakeArrayType(int rank)
	{
		if (rank <= 0)
		{
			throw new IndexOutOfRangeException();
		}
		return new SignatureArrayType(this, rank, isMultiDim: true);
	}

	public sealed override Type MakeByRefType()
	{
		return new SignatureByRefType(this);
	}

	public sealed override Type MakePointerType()
	{
		return new SignaturePointerType(this);
	}

	public sealed override Type MakeGenericType(params Type[] typeArguments)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Type GetElementType()
	{
		return ElementType;
	}

	public abstract override int GetArrayRank();

	public abstract override Type GetGenericTypeDefinition();

	public abstract override Type[] GetGenericArguments();

	public abstract override string ToString();

	public sealed override Type[] GetInterfaces()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override bool IsAssignableFrom(Type c)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override bool HasSameMetadataDefinitionAs(MemberInfo other)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Type[] GetGenericParameterConstraints()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override bool IsEnumDefined(object value)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override string GetEnumName(object value)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override string[] GetEnumNames()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Type GetEnumUnderlyingType()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Array GetEnumValues()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override TypeCode GetTypeCodeImpl()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override TypeAttributes GetAttributeFlagsImpl()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override ConstructorInfo[] GetConstructors(BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override EventInfo GetEvent(string name, BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override EventInfo[] GetEvents(BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override FieldInfo GetField(string name, BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override FieldInfo[] GetFields(BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override MemberInfo[] GetMembers(BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override MethodInfo[] GetMethods(BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Type GetNestedType(string name, BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Type[] GetNestedTypes(BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override PropertyInfo[] GetProperties(BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override object InvokeMember(string name, BindingFlags invokeAttr, Binder binder, object target, object[] args, ParameterModifier[] modifiers, CultureInfo culture, string[] namedParameters)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override MethodInfo GetMethodImpl(string name, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override MethodInfo GetMethodImpl(string name, int genericParameterCount, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override PropertyInfo GetPropertyImpl(string name, BindingFlags bindingAttr, Binder binder, Type returnType, Type[] types, ParameterModifier[] modifiers)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override MemberInfo[] FindMembers(MemberTypes memberType, BindingFlags bindingAttr, MemberFilter filter, object filterCriteria)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override MemberInfo[] GetMember(string name, BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override MemberInfo[] GetMember(string name, MemberTypes type, BindingFlags bindingAttr)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override MemberInfo[] GetDefaultMembers()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override EventInfo[] GetEvents()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override object[] GetCustomAttributes(bool inherit)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override bool IsDefined(Type attributeType, bool inherit)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override IList<CustomAttributeData> GetCustomAttributesData()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Type GetInterface(string name, bool ignoreCase)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override ConstructorInfo GetConstructorImpl(BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override bool IsCOMObjectImpl()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override bool IsPrimitiveImpl()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override Type[] FindInterfaces(TypeFilter filter, object filterCriteria)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override InterfaceMapping GetInterfaceMap(Type interfaceType)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override bool IsContextfulImpl()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override bool IsEquivalentTo(Type other)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override bool IsInstanceOfType(object o)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override bool IsMarshalByRefImpl()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	public sealed override bool IsSubclassOf(Type c)
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}

	protected sealed override bool IsValueTypeImpl()
	{
		throw new NotSupportedException("This method is not supported on signature types.");
	}
}

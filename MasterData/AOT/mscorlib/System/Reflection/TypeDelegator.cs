using System.Globalization;
using System.Runtime.InteropServices;

namespace System.Reflection;

public class TypeDelegator : TypeInfo
{
	protected Type typeImpl;

	public override Guid GUID => typeImpl.GUID;

	public override int MetadataToken => typeImpl.MetadataToken;

	public override Module Module => typeImpl.Module;

	public override Assembly Assembly => typeImpl.Assembly;

	public override RuntimeTypeHandle TypeHandle => typeImpl.TypeHandle;

	public override string Name => typeImpl.Name;

	public override string FullName => typeImpl.FullName;

	public override string Namespace => typeImpl.Namespace;

	public override string AssemblyQualifiedName => typeImpl.AssemblyQualifiedName;

	public override Type BaseType => typeImpl.BaseType;

	public override bool IsTypeDefinition => typeImpl.IsTypeDefinition;

	public override bool IsSZArray => typeImpl.IsSZArray;

	public override bool IsGenericTypeParameter => typeImpl.IsGenericTypeParameter;

	public override bool IsGenericMethodParameter => typeImpl.IsGenericMethodParameter;

	public override bool IsByRefLike => typeImpl.IsByRefLike;

	public override bool IsConstructedGenericType => typeImpl.IsConstructedGenericType;

	public override bool IsCollectible => typeImpl.IsCollectible;

	public override Type UnderlyingSystemType => typeImpl.UnderlyingSystemType;

	public override bool IsAssignableFrom(TypeInfo typeInfo)
	{
		if (typeInfo == null)
		{
			return false;
		}
		return IsAssignableFrom(typeInfo.AsType());
	}

	public TypeDelegator(Type delegatingType)
	{
		if (delegatingType == null)
		{
			throw new ArgumentNullException("delegatingType");
		}
		typeImpl = delegatingType;
	}

	public override object InvokeMember(string name, BindingFlags invokeAttr, Binder binder, object target, object[] args, ParameterModifier[] modifiers, CultureInfo culture, string[] namedParameters)
	{
		return typeImpl.InvokeMember(name, invokeAttr, binder, target, args, modifiers, culture, namedParameters);
	}

	protected override ConstructorInfo GetConstructorImpl(BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		return typeImpl.GetConstructor(bindingAttr, binder, callConvention, types, modifiers);
	}

	[ComVisible(true)]
	public override ConstructorInfo[] GetConstructors(BindingFlags bindingAttr)
	{
		return typeImpl.GetConstructors(bindingAttr);
	}

	protected override MethodInfo GetMethodImpl(string name, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		if (types == null)
		{
			return typeImpl.GetMethod(name, bindingAttr);
		}
		return typeImpl.GetMethod(name, bindingAttr, binder, callConvention, types, modifiers);
	}

	public override MethodInfo[] GetMethods(BindingFlags bindingAttr)
	{
		return typeImpl.GetMethods(bindingAttr);
	}

	public override FieldInfo GetField(string name, BindingFlags bindingAttr)
	{
		return typeImpl.GetField(name, bindingAttr);
	}

	public override FieldInfo[] GetFields(BindingFlags bindingAttr)
	{
		return typeImpl.GetFields(bindingAttr);
	}

	public override Type GetInterface(string name, bool ignoreCase)
	{
		return typeImpl.GetInterface(name, ignoreCase);
	}

	public override Type[] GetInterfaces()
	{
		return typeImpl.GetInterfaces();
	}

	public override EventInfo GetEvent(string name, BindingFlags bindingAttr)
	{
		return typeImpl.GetEvent(name, bindingAttr);
	}

	public override EventInfo[] GetEvents()
	{
		return typeImpl.GetEvents();
	}

	protected override PropertyInfo GetPropertyImpl(string name, BindingFlags bindingAttr, Binder binder, Type returnType, Type[] types, ParameterModifier[] modifiers)
	{
		if (returnType == null && types == null)
		{
			return typeImpl.GetProperty(name, bindingAttr);
		}
		return typeImpl.GetProperty(name, bindingAttr, binder, returnType, types, modifiers);
	}

	public override PropertyInfo[] GetProperties(BindingFlags bindingAttr)
	{
		return typeImpl.GetProperties(bindingAttr);
	}

	public override EventInfo[] GetEvents(BindingFlags bindingAttr)
	{
		return typeImpl.GetEvents(bindingAttr);
	}

	public override Type[] GetNestedTypes(BindingFlags bindingAttr)
	{
		return typeImpl.GetNestedTypes(bindingAttr);
	}

	public override Type GetNestedType(string name, BindingFlags bindingAttr)
	{
		return typeImpl.GetNestedType(name, bindingAttr);
	}

	public override MemberInfo[] GetMember(string name, MemberTypes type, BindingFlags bindingAttr)
	{
		return typeImpl.GetMember(name, type, bindingAttr);
	}

	public override MemberInfo[] GetMembers(BindingFlags bindingAttr)
	{
		return typeImpl.GetMembers(bindingAttr);
	}

	protected override TypeAttributes GetAttributeFlagsImpl()
	{
		return typeImpl.Attributes;
	}

	protected override bool IsArrayImpl()
	{
		return typeImpl.IsArray;
	}

	protected override bool IsPrimitiveImpl()
	{
		return typeImpl.IsPrimitive;
	}

	protected override bool IsByRefImpl()
	{
		return typeImpl.IsByRef;
	}

	protected override bool IsPointerImpl()
	{
		return typeImpl.IsPointer;
	}

	protected override bool IsValueTypeImpl()
	{
		return typeImpl.IsValueType;
	}

	protected override bool IsCOMObjectImpl()
	{
		return typeImpl.IsCOMObject;
	}

	public override Type GetElementType()
	{
		return typeImpl.GetElementType();
	}

	protected override bool HasElementTypeImpl()
	{
		return typeImpl.HasElementType;
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return typeImpl.GetCustomAttributes(inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return typeImpl.GetCustomAttributes(attributeType, inherit);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return typeImpl.IsDefined(attributeType, inherit);
	}

	[ComVisible(true)]
	public override InterfaceMapping GetInterfaceMap(Type interfaceType)
	{
		return typeImpl.GetInterfaceMap(interfaceType);
	}
}

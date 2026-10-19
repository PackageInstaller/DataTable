using System.Globalization;
using System.Runtime.InteropServices;
using System.Security;
using System.Security.Permissions;
using Unity;

namespace System.Reflection.Emit;

public sealed class TypeBuilder : TypeInfo, _TypeBuilder
{
	public const int UnspecifiedTypeSize = 0;

	public override Assembly Assembly
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override string AssemblyQualifiedName
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override Type BaseType
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool ContainsGenericParameters
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override MethodBase DeclaringMethod
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override Type DeclaringType
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override string FullName
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override GenericParameterAttributes GenericParameterAttributes
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override int GenericParameterPosition
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override Guid GUID
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool IsConstructedGenericType
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool IsGenericParameter
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool IsGenericType
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool IsGenericTypeDefinition
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool IsTypeDefinition
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override Module Module
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override string Name
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override string Namespace
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public PackingSize PackingSize
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override Type ReflectedType
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public int Size
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override RuntimeTypeHandle TypeHandle
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public TypeToken TypeToken
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override Type UnderlyingSystemType
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	internal TypeBuilder()
	{
		throw new PlatformNotSupportedException();
	}

	public void AddDeclarativeSecurity(SecurityAction action, PermissionSet pset)
	{
		throw new PlatformNotSupportedException();
	}

	public void AddInterfaceImplementation(Type interfaceType)
	{
		throw new PlatformNotSupportedException();
	}

	public Type CreateType()
	{
		throw new PlatformNotSupportedException();
	}

	public TypeInfo CreateTypeInfo()
	{
		throw new PlatformNotSupportedException();
	}

	public ConstructorBuilder DefineConstructor(MethodAttributes attributes, CallingConventions callingConvention, Type[] parameterTypes)
	{
		throw new PlatformNotSupportedException();
	}

	public ConstructorBuilder DefineConstructor(MethodAttributes attributes, CallingConventions callingConvention, Type[] parameterTypes, Type[][] requiredCustomModifiers, Type[][] optionalCustomModifiers)
	{
		throw new PlatformNotSupportedException();
	}

	public ConstructorBuilder DefineDefaultConstructor(MethodAttributes attributes)
	{
		throw new PlatformNotSupportedException();
	}

	public EventBuilder DefineEvent(string name, EventAttributes attributes, Type eventtype)
	{
		throw new PlatformNotSupportedException();
	}

	public FieldBuilder DefineField(string fieldName, Type type, FieldAttributes attributes)
	{
		throw new PlatformNotSupportedException();
	}

	public FieldBuilder DefineField(string fieldName, Type type, Type[] requiredCustomModifiers, Type[] optionalCustomModifiers, FieldAttributes attributes)
	{
		throw new PlatformNotSupportedException();
	}

	public GenericTypeParameterBuilder[] DefineGenericParameters(params string[] names)
	{
		throw new PlatformNotSupportedException();
	}

	public FieldBuilder DefineInitializedData(string name, byte[] data, FieldAttributes attributes)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefineMethod(string name, MethodAttributes attributes)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefineMethod(string name, MethodAttributes attributes, CallingConventions callingConvention)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefineMethod(string name, MethodAttributes attributes, CallingConventions callingConvention, Type returnType, Type[] parameterTypes)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefineMethod(string name, MethodAttributes attributes, CallingConventions callingConvention, Type returnType, Type[] returnTypeRequiredCustomModifiers, Type[] returnTypeOptionalCustomModifiers, Type[] parameterTypes, Type[][] parameterTypeRequiredCustomModifiers, Type[][] parameterTypeOptionalCustomModifiers)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefineMethod(string name, MethodAttributes attributes, Type returnType, Type[] parameterTypes)
	{
		throw new PlatformNotSupportedException();
	}

	public void DefineMethodOverride(MethodInfo methodInfoBody, MethodInfo methodInfoDeclaration)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineNestedType(string name)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineNestedType(string name, TypeAttributes attr)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineNestedType(string name, TypeAttributes attr, Type parent)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineNestedType(string name, TypeAttributes attr, Type parent, int typeSize)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineNestedType(string name, TypeAttributes attr, Type parent, PackingSize packSize)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineNestedType(string name, TypeAttributes attr, Type parent, PackingSize packSize, int typeSize)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineNestedType(string name, TypeAttributes attr, Type parent, Type[] interfaces)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefinePInvokeMethod(string name, string dllName, MethodAttributes attributes, CallingConventions callingConvention, Type returnType, Type[] parameterTypes, CallingConvention nativeCallConv, CharSet nativeCharSet)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefinePInvokeMethod(string name, string dllName, string entryName, MethodAttributes attributes, CallingConventions callingConvention, Type returnType, Type[] parameterTypes, CallingConvention nativeCallConv, CharSet nativeCharSet)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefinePInvokeMethod(string name, string dllName, string entryName, MethodAttributes attributes, CallingConventions callingConvention, Type returnType, Type[] returnTypeRequiredCustomModifiers, Type[] returnTypeOptionalCustomModifiers, Type[] parameterTypes, Type[][] parameterTypeRequiredCustomModifiers, Type[][] parameterTypeOptionalCustomModifiers, CallingConvention nativeCallConv, CharSet nativeCharSet)
	{
		throw new PlatformNotSupportedException();
	}

	public PropertyBuilder DefineProperty(string name, PropertyAttributes attributes, CallingConventions callingConvention, Type returnType, Type[] parameterTypes)
	{
		throw new PlatformNotSupportedException();
	}

	public PropertyBuilder DefineProperty(string name, PropertyAttributes attributes, CallingConventions callingConvention, Type returnType, Type[] returnTypeRequiredCustomModifiers, Type[] returnTypeOptionalCustomModifiers, Type[] parameterTypes, Type[][] parameterTypeRequiredCustomModifiers, Type[][] parameterTypeOptionalCustomModifiers)
	{
		throw new PlatformNotSupportedException();
	}

	public PropertyBuilder DefineProperty(string name, PropertyAttributes attributes, Type returnType, Type[] parameterTypes)
	{
		throw new PlatformNotSupportedException();
	}

	public PropertyBuilder DefineProperty(string name, PropertyAttributes attributes, Type returnType, Type[] returnTypeRequiredCustomModifiers, Type[] returnTypeOptionalCustomModifiers, Type[] parameterTypes, Type[][] parameterTypeRequiredCustomModifiers, Type[][] parameterTypeOptionalCustomModifiers)
	{
		throw new PlatformNotSupportedException();
	}

	public ConstructorBuilder DefineTypeInitializer()
	{
		throw new PlatformNotSupportedException();
	}

	public FieldBuilder DefineUninitializedData(string name, int size, FieldAttributes attributes)
	{
		throw new PlatformNotSupportedException();
	}

	protected override TypeAttributes GetAttributeFlagsImpl()
	{
		throw new PlatformNotSupportedException();
	}

	public static ConstructorInfo GetConstructor(Type type, ConstructorInfo constructor)
	{
		throw new PlatformNotSupportedException();
	}

	protected override ConstructorInfo GetConstructorImpl(BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		throw new PlatformNotSupportedException();
	}

	[ComVisible(true)]
	public override ConstructorInfo[] GetConstructors(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		throw new PlatformNotSupportedException();
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type GetElementType()
	{
		throw new PlatformNotSupportedException();
	}

	public override EventInfo GetEvent(string name, BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override EventInfo[] GetEvents()
	{
		throw new PlatformNotSupportedException();
	}

	public override EventInfo[] GetEvents(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override FieldInfo GetField(string name, BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public static FieldInfo GetField(Type type, FieldInfo field)
	{
		throw new PlatformNotSupportedException();
	}

	public override FieldInfo[] GetFields(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type[] GetGenericArguments()
	{
		throw new PlatformNotSupportedException();
	}

	public override Type GetGenericTypeDefinition()
	{
		throw new PlatformNotSupportedException();
	}

	public override Type GetInterface(string name, bool ignoreCase)
	{
		throw new PlatformNotSupportedException();
	}

	[ComVisible(true)]
	public override InterfaceMapping GetInterfaceMap(Type interfaceType)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type[] GetInterfaces()
	{
		throw new PlatformNotSupportedException();
	}

	public override MemberInfo[] GetMember(string name, MemberTypes type, BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override MemberInfo[] GetMembers(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public static MethodInfo GetMethod(Type type, MethodInfo method)
	{
		throw new PlatformNotSupportedException();
	}

	protected override MethodInfo GetMethodImpl(string name, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		throw new PlatformNotSupportedException();
	}

	public override MethodInfo[] GetMethods(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type GetNestedType(string name, BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type[] GetNestedTypes(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override PropertyInfo[] GetProperties(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	protected override PropertyInfo GetPropertyImpl(string name, BindingFlags bindingAttr, Binder binder, Type returnType, Type[] types, ParameterModifier[] modifiers)
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool HasElementTypeImpl()
	{
		throw new PlatformNotSupportedException();
	}

	public override object InvokeMember(string name, BindingFlags invokeAttr, Binder binder, object target, object[] args, ParameterModifier[] modifiers, CultureInfo culture, string[] namedParameters)
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool IsArrayImpl()
	{
		throw new PlatformNotSupportedException();
	}

	public override bool IsAssignableFrom(Type c)
	{
		throw new PlatformNotSupportedException();
	}

	public override bool IsAssignableFrom(TypeInfo typeInfo)
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool IsByRefImpl()
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool IsCOMObjectImpl()
	{
		throw new PlatformNotSupportedException();
	}

	public bool IsCreated()
	{
		throw new PlatformNotSupportedException();
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool IsPointerImpl()
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool IsPrimitiveImpl()
	{
		throw new PlatformNotSupportedException();
	}

	[ComVisible(true)]
	public override bool IsSubclassOf(Type c)
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool IsValueTypeImpl()
	{
		throw new PlatformNotSupportedException();
	}

	public override Type MakeArrayType()
	{
		throw new PlatformNotSupportedException();
	}

	public override Type MakeArrayType(int rank)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type MakeByRefType()
	{
		throw new PlatformNotSupportedException();
	}

	public override Type MakeGenericType(params Type[] typeArguments)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type MakePointerType()
	{
		throw new PlatformNotSupportedException();
	}

	public void SetCustomAttribute(ConstructorInfo con, byte[] binaryAttribute)
	{
		throw new PlatformNotSupportedException();
	}

	public void SetCustomAttribute(CustomAttributeBuilder customBuilder)
	{
		throw new PlatformNotSupportedException();
	}

	public void SetParent(Type parent)
	{
		throw new PlatformNotSupportedException();
	}

	public override string ToString()
	{
		throw new PlatformNotSupportedException();
	}

	void _TypeBuilder.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _TypeBuilder.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _TypeBuilder.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _TypeBuilder.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}

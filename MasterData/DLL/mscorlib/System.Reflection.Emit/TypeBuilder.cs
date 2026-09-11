using System.Globalization;
using System.Runtime.InteropServices;

namespace System.Reflection.Emit;

public sealed class TypeBuilder : TypeInfo
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

	public override string FullName
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

	public override Type UnderlyingSystemType
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public TypeInfo CreateTypeInfo()
	{
		throw new PlatformNotSupportedException();
	}

	public ConstructorBuilder DefineConstructor(MethodAttributes attributes, CallingConventions callingConvention, Type[] parameterTypes)
	{
		throw new PlatformNotSupportedException();
	}

	public FieldBuilder DefineField(string fieldName, Type type, FieldAttributes attributes)
	{
		throw new PlatformNotSupportedException();
	}

	public MethodBuilder DefineMethod(string name, MethodAttributes attributes, Type returnType, Type[] parameterTypes)
	{
		throw new PlatformNotSupportedException();
	}

	protected override TypeAttributes GetAttributeFlagsImpl()
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

	public override EventInfo[] GetEvents(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override FieldInfo GetField(string name, BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override FieldInfo[] GetFields(BindingFlags bindingAttr)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type GetInterface(string name, bool ignoreCase)
	{
		throw new PlatformNotSupportedException();
	}

	public override Type[] GetInterfaces()
	{
		throw new PlatformNotSupportedException();
	}

	public override MemberInfo[] GetMembers(BindingFlags bindingAttr)
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

	protected override bool IsByRefImpl()
	{
		throw new PlatformNotSupportedException();
	}

	protected override bool IsCOMObjectImpl()
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
}

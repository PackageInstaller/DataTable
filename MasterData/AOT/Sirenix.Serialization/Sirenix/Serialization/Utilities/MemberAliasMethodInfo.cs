using System;
using System.Globalization;
using System.Reflection;

namespace Sirenix.Serialization.Utilities;

internal sealed class MemberAliasMethodInfo : MethodInfo
{
	private const string FAKE_NAME_SEPARATOR_STRING = "+";

	private MethodInfo aliasedMethod;

	private string mangledName;

	public MethodInfo AliasedMethod => aliasedMethod;

	public override ICustomAttributeProvider ReturnTypeCustomAttributes => aliasedMethod.ReturnTypeCustomAttributes;

	public override RuntimeMethodHandle MethodHandle => aliasedMethod.MethodHandle;

	public override MethodAttributes Attributes => aliasedMethod.Attributes;

	public override Type ReturnType => aliasedMethod.ReturnType;

	public override Type DeclaringType => aliasedMethod.DeclaringType;

	public override string Name => mangledName;

	public override Type ReflectedType => aliasedMethod.ReflectedType;

	public MemberAliasMethodInfo(MethodInfo method, string namePrefix)
	{
		aliasedMethod = method;
		mangledName = namePrefix + "+" + aliasedMethod.Name;
	}

	public MemberAliasMethodInfo(MethodInfo method, string namePrefix, string separatorString)
	{
		aliasedMethod = method;
		mangledName = namePrefix + separatorString + aliasedMethod.Name;
	}

	public override MethodInfo GetBaseDefinition()
	{
		return aliasedMethod.GetBaseDefinition();
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return aliasedMethod.GetCustomAttributes(inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return aliasedMethod.GetCustomAttributes(attributeType, inherit);
	}

	public override MethodImplAttributes GetMethodImplementationFlags()
	{
		return aliasedMethod.GetMethodImplementationFlags();
	}

	public override ParameterInfo[] GetParameters()
	{
		return aliasedMethod.GetParameters();
	}

	public override object Invoke(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		return aliasedMethod.Invoke(obj, invokeAttr, binder, parameters, culture);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return aliasedMethod.IsDefined(attributeType, inherit);
	}
}

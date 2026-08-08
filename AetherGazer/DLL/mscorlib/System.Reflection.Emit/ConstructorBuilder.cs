using System.Globalization;

namespace System.Reflection.Emit;

public class ConstructorBuilder : ConstructorInfo
{
	public override MethodAttributes Attributes
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

	public override string Name
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override RuntimeMethodHandle MethodHandle
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

	public ILGenerator GetILGenerator()
	{
		throw new PlatformNotSupportedException();
	}

	public override ParameterInfo[] GetParameters()
	{
		throw new PlatformNotSupportedException();
	}

	public override MethodImplAttributes GetMethodImplementationFlags()
	{
		throw new PlatformNotSupportedException();
	}

	public override object Invoke(BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		throw new PlatformNotSupportedException();
	}

	public override bool IsDefined(Type attributeType, bool inherit)
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

	public override object Invoke(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		throw new PlatformNotSupportedException();
	}
}

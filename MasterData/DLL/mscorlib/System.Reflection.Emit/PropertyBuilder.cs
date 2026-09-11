using System.Globalization;

namespace System.Reflection.Emit;

public sealed class PropertyBuilder : PropertyInfo
{
	public override PropertyAttributes Attributes
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool CanRead
	{
		get
		{
			throw new PlatformNotSupportedException();
		}
	}

	public override bool CanWrite
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

	public override Type PropertyType
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

	public override MethodInfo[] GetAccessors(bool nonPublic)
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

	public override MethodInfo GetGetMethod(bool nonPublic)
	{
		throw new PlatformNotSupportedException();
	}

	public override ParameterInfo[] GetIndexParameters()
	{
		throw new PlatformNotSupportedException();
	}

	public override MethodInfo GetSetMethod(bool nonPublic)
	{
		throw new PlatformNotSupportedException();
	}

	public override object GetValue(object obj, BindingFlags invokeAttr, Binder binder, object[] index, CultureInfo culture)
	{
		throw new PlatformNotSupportedException();
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		throw new PlatformNotSupportedException();
	}

	public override void SetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, object[] index, CultureInfo culture)
	{
		throw new PlatformNotSupportedException();
	}
}

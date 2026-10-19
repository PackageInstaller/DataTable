using System.Globalization;

namespace System.Reflection.Emit;

public sealed class FieldBuilder : FieldInfo
{
	public override FieldAttributes Attributes
	{
		get
		{
			throw null;
		}
	}

	public override Type DeclaringType
	{
		get
		{
			throw null;
		}
	}

	public override RuntimeFieldHandle FieldHandle
	{
		get
		{
			throw null;
		}
	}

	public override Type FieldType
	{
		get
		{
			throw null;
		}
	}

	public override string Name
	{
		get
		{
			throw null;
		}
	}

	public override Type ReflectedType
	{
		get
		{
			throw null;
		}
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		throw null;
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		throw null;
	}

	public override object GetValue(object obj)
	{
		throw null;
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		throw null;
	}

	public override void SetValue(object obj, object val, BindingFlags invokeAttr, Binder binder, CultureInfo culture)
	{
		throw new PlatformNotSupportedException();
	}
}

using System.ComponentModel.Design.Serialization;
using System.Globalization;
using System.Reflection;

namespace System.ComponentModel;

public class TimeSpanConverter : TypeConverter
{
	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (!(sourceType == typeof(string)))
		{
			return base.CanConvertFrom(context, sourceType);
		}
		return true;
	}

	public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		if (destinationType == typeof(InstanceDescriptor))
		{
			return true;
		}
		return base.CanConvertTo(context, destinationType);
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value is string text)
		{
			string input = text.Trim();
			try
			{
				return TimeSpan.Parse(input, culture);
			}
			catch (FormatException innerException)
			{
				throw new FormatException(global::SR.Format("{0} is not a valid value for {1}.", (string)value, "TimeSpan"), innerException);
			}
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(InstanceDescriptor) && value is TimeSpan)
		{
			MethodInfo method = typeof(TimeSpan).GetMethod("Parse", new Type[1] { typeof(string) });
			if (method != null)
			{
				return new InstanceDescriptor(method, new object[1] { value.ToString() });
			}
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}
}

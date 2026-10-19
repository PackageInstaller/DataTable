using System.Globalization;

namespace System.ComponentModel;

public class MultilineStringConverter : TypeConverter
{
	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(string) && value is string)
		{
			return "(Text)";
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override PropertyDescriptorCollection GetProperties(ITypeDescriptorContext context, object value, Attribute[] attributes)
	{
		return null;
	}

	public override bool GetPropertiesSupported(ITypeDescriptorContext context)
	{
		return false;
	}
}

using System.ComponentModel.Design.Serialization;
using System.Globalization;
using System.Reflection;

namespace System.ComponentModel;

public class DecimalConverter : BaseNumberConverter
{
	internal override bool AllowHex => false;

	internal override Type TargetType => typeof(decimal);

	public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		if (destinationType == typeof(InstanceDescriptor))
		{
			return true;
		}
		return base.CanConvertTo(context, destinationType);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(InstanceDescriptor) && value is decimal)
		{
			object[] arguments = new object[1] { decimal.GetBits((decimal)value) };
			MemberInfo constructor = typeof(decimal).GetConstructor(new Type[1] { typeof(int[]) });
			if (constructor != null)
			{
				return new InstanceDescriptor(constructor, arguments);
			}
			return null;
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	internal override object FromString(string value, int radix)
	{
		return Convert.ToDecimal(value, CultureInfo.CurrentCulture);
	}

	internal override object FromString(string value, NumberFormatInfo formatInfo)
	{
		return decimal.Parse(value, NumberStyles.Float, formatInfo);
	}

	internal override string ToString(object value, NumberFormatInfo formatInfo)
	{
		return ((decimal)value).ToString("G", formatInfo);
	}
}

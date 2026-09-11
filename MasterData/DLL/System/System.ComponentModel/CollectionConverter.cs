using System.Collections;
using System.Globalization;

namespace System.ComponentModel;

public class CollectionConverter : TypeConverter
{
	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(string) && value is ICollection)
		{
			return global::SR.GetString("(Collection)");
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}
}

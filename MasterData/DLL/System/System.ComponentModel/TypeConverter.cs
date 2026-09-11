using System.Collections;
using System.ComponentModel.Design.Serialization;
using System.Globalization;
using System.Reflection;
using System.Runtime.InteropServices;

namespace System.ComponentModel;

[ComVisible(true)]
public class TypeConverter
{
	[DefaultMember("Item")]
	public class StandardValuesCollection : ICollection, IEnumerable
	{
		private ICollection values;

		private Array valueArray;

		public int Count
		{
			get
			{
				if (valueArray != null)
				{
					return valueArray.Length;
				}
				return values.Count;
			}
		}

		int ICollection.Count => Count;

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot => null;

		public StandardValuesCollection(ICollection values)
		{
			if (values == null)
			{
				values = new object[0];
			}
			if (values is Array array)
			{
				valueArray = array;
			}
			this.values = values;
		}

		public void CopyTo(Array array, int index)
		{
			values.CopyTo(array, index);
		}

		public IEnumerator GetEnumerator()
		{
			return values.GetEnumerator();
		}

		void ICollection.CopyTo(Array array, int index)
		{
			CopyTo(array, index);
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}
	}

	private const string s_UseCompatibleTypeConverterBehavior = "UseCompatibleTypeConverterBehavior";

	private static volatile bool useCompatibleTypeConversion;

	public bool CanConvertFrom(Type sourceType)
	{
		return CanConvertFrom(null, sourceType);
	}

	public virtual bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (sourceType == typeof(InstanceDescriptor))
		{
			return true;
		}
		return false;
	}

	public bool CanConvertTo(Type destinationType)
	{
		return CanConvertTo(null, destinationType);
	}

	public virtual bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		return destinationType == typeof(string);
	}

	public virtual object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value is InstanceDescriptor instanceDescriptor)
		{
			return instanceDescriptor.Invoke();
		}
		throw GetConvertFromException(value);
	}

	public object ConvertFromInvariantString(string text)
	{
		return ConvertFromString(null, CultureInfo.InvariantCulture, text);
	}

	public object ConvertFromString(ITypeDescriptorContext context, CultureInfo culture, string text)
	{
		return ConvertFrom(context, culture, text);
	}

	public object ConvertTo(object value, Type destinationType)
	{
		return ConvertTo(null, null, value, destinationType);
	}

	public virtual object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(string))
		{
			if (value == null)
			{
				return string.Empty;
			}
			if (culture != null && culture != CultureInfo.CurrentCulture && value is IFormattable formattable)
			{
				return formattable.ToString(null, culture);
			}
			return value.ToString();
		}
		throw GetConvertToException(value, destinationType);
	}

	public string ConvertToInvariantString(object value)
	{
		return ConvertToString(null, CultureInfo.InvariantCulture, value);
	}

	public string ConvertToInvariantString(ITypeDescriptorContext context, object value)
	{
		return ConvertToString(context, CultureInfo.InvariantCulture, value);
	}

	public string ConvertToString(object value)
	{
		return (string)ConvertTo(null, CultureInfo.CurrentCulture, value, typeof(string));
	}

	public string ConvertToString(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		return (string)ConvertTo(context, culture, value, typeof(string));
	}

	protected Exception GetConvertFromException(object value)
	{
		string text = ((value != null) ? value.GetType().FullName : global::SR.GetString("(null)"));
		throw new NotSupportedException(global::SR.GetString("{0} cannot convert from {1}.", GetType().Name, text));
	}

	protected Exception GetConvertToException(object value, Type destinationType)
	{
		string text = ((value != null) ? value.GetType().FullName : global::SR.GetString("(null)"));
		throw new NotSupportedException(global::SR.GetString("'{0}' is unable to convert '{1}' to '{2}'.", GetType().Name, text, destinationType.FullName));
	}

	public virtual StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
	{
		return null;
	}

	public virtual bool GetStandardValuesSupported(ITypeDescriptorContext context)
	{
		return false;
	}
}

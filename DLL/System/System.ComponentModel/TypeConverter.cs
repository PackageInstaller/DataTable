using System.Collections;
using System.ComponentModel.Design.Serialization;
using System.Globalization;
using System.Runtime.InteropServices;

namespace System.ComponentModel;

[ComVisible(true)]
public class TypeConverter
{
	protected abstract class SimplePropertyDescriptor : PropertyDescriptor
	{
		private Type componentType;

		private Type propertyType;

		public override Type ComponentType => componentType;

		public override bool IsReadOnly => Attributes.Contains(ReadOnlyAttribute.Yes);

		public override Type PropertyType => propertyType;

		protected SimplePropertyDescriptor(Type componentType, string name, Type propertyType)
			: this(componentType, name, propertyType, new Attribute[0])
		{
		}

		protected SimplePropertyDescriptor(Type componentType, string name, Type propertyType, Attribute[] attributes)
			: base(name, attributes)
		{
			this.componentType = componentType;
			this.propertyType = propertyType;
		}

		public override bool CanResetValue(object component)
		{
			return ((DefaultValueAttribute)Attributes[typeof(DefaultValueAttribute)])?.Value.Equals(GetValue(component)) ?? false;
		}

		public override void ResetValue(object component)
		{
			DefaultValueAttribute defaultValueAttribute = (DefaultValueAttribute)Attributes[typeof(DefaultValueAttribute)];
			if (defaultValueAttribute != null)
			{
				SetValue(component, defaultValueAttribute.Value);
			}
		}

		public override bool ShouldSerializeValue(object component)
		{
			return false;
		}
	}

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

		public object this[int index]
		{
			get
			{
				if (valueArray != null)
				{
					return valueArray.GetValue(index);
				}
				if (values is IList list)
				{
					return list[index];
				}
				valueArray = new object[values.Count];
				values.CopyTo(valueArray, 0);
				return valueArray.GetValue(index);
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

	private static bool UseCompatibleTypeConversion => useCompatibleTypeConversion;

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

	public object ConvertFrom(object value)
	{
		return ConvertFrom(null, CultureInfo.CurrentCulture, value);
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

	public object ConvertFromInvariantString(ITypeDescriptorContext context, string text)
	{
		return ConvertFromString(context, CultureInfo.InvariantCulture, text);
	}

	public object ConvertFromString(string text)
	{
		return ConvertFrom(null, null, text);
	}

	public object ConvertFromString(ITypeDescriptorContext context, string text)
	{
		return ConvertFrom(context, CultureInfo.CurrentCulture, text);
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

	public string ConvertToString(ITypeDescriptorContext context, object value)
	{
		return (string)ConvertTo(context, CultureInfo.CurrentCulture, value, typeof(string));
	}

	public string ConvertToString(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		return (string)ConvertTo(context, culture, value, typeof(string));
	}

	public object CreateInstance(IDictionary propertyValues)
	{
		return CreateInstance(null, propertyValues);
	}

	public virtual object CreateInstance(ITypeDescriptorContext context, IDictionary propertyValues)
	{
		return null;
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

	public bool GetCreateInstanceSupported()
	{
		return GetCreateInstanceSupported(null);
	}

	public virtual bool GetCreateInstanceSupported(ITypeDescriptorContext context)
	{
		return false;
	}

	public PropertyDescriptorCollection GetProperties(object value)
	{
		return GetProperties(null, value);
	}

	public PropertyDescriptorCollection GetProperties(ITypeDescriptorContext context, object value)
	{
		return GetProperties(context, value, new Attribute[1] { BrowsableAttribute.Yes });
	}

	public virtual PropertyDescriptorCollection GetProperties(ITypeDescriptorContext context, object value, Attribute[] attributes)
	{
		return null;
	}

	public bool GetPropertiesSupported()
	{
		return GetPropertiesSupported(null);
	}

	public virtual bool GetPropertiesSupported(ITypeDescriptorContext context)
	{
		return false;
	}

	public ICollection GetStandardValues()
	{
		return GetStandardValues(null);
	}

	public virtual StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
	{
		return null;
	}

	public bool GetStandardValuesExclusive()
	{
		return GetStandardValuesExclusive(null);
	}

	public virtual bool GetStandardValuesExclusive(ITypeDescriptorContext context)
	{
		return false;
	}

	public bool GetStandardValuesSupported()
	{
		return GetStandardValuesSupported(null);
	}

	public virtual bool GetStandardValuesSupported(ITypeDescriptorContext context)
	{
		return false;
	}

	public bool IsValid(object value)
	{
		return IsValid(null, value);
	}

	public virtual bool IsValid(ITypeDescriptorContext context, object value)
	{
		if (UseCompatibleTypeConversion)
		{
			return true;
		}
		bool result = true;
		try
		{
			if (value == null || CanConvertFrom(context, value.GetType()))
			{
				ConvertFrom(context, CultureInfo.InvariantCulture, value);
			}
			else
			{
				result = false;
			}
		}
		catch
		{
			result = false;
		}
		return result;
	}

	protected PropertyDescriptorCollection SortProperties(PropertyDescriptorCollection props, string[] names)
	{
		props.Sort(names);
		return props;
	}
}

using System.Globalization;

namespace System.ComponentModel;

public class ArrayConverter : CollectionConverter
{
	private class ArrayPropertyDescriptor : SimplePropertyDescriptor
	{
		private readonly int _index;

		public ArrayPropertyDescriptor(Type arrayType, Type elementType, int index)
			: base(arrayType, "[" + index + "]", elementType, null)
		{
			_index = index;
		}

		public override object GetValue(object instance)
		{
			if (instance is Array array && array.GetLength(0) > _index)
			{
				return array.GetValue(_index);
			}
			return null;
		}

		public override void SetValue(object instance, object value)
		{
			if (instance is Array)
			{
				Array array = (Array)instance;
				if (array.GetLength(0) > _index)
				{
					array.SetValue(value, _index);
				}
				OnValueChanged(instance, EventArgs.Empty);
			}
		}
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(string) && value is Array)
		{
			return global::SR.Format("{0} Array", value.GetType().Name);
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override PropertyDescriptorCollection GetProperties(ITypeDescriptorContext context, object value, Attribute[] attributes)
	{
		if (value == null)
		{
			return null;
		}
		PropertyDescriptor[] array = null;
		if (value.GetType().IsArray)
		{
			int length = ((Array)value).GetLength(0);
			array = new PropertyDescriptor[length];
			Type type = value.GetType();
			Type elementType = type.GetElementType();
			for (int i = 0; i < length; i++)
			{
				array[i] = new ArrayPropertyDescriptor(type, elementType, i);
			}
		}
		return new PropertyDescriptorCollection(array);
	}

	public override bool GetPropertiesSupported(ITypeDescriptorContext context)
	{
		return true;
	}
}

using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Globalization;
using System.Runtime.InteropServices;

namespace System.ComponentModel;

public class ReferenceConverter : TypeConverter
{
	private class ReferenceComparer : IComparer
	{
		private ReferenceConverter _converter;

		public ReferenceComparer(ReferenceConverter converter)
		{
			_converter = converter;
		}

		public int Compare(object item1, object item2)
		{
			string strA = _converter.ConvertToString(item1);
			string strB = _converter.ConvertToString(item2);
			return string.Compare(strA, strB, ignoreCase: false, CultureInfo.InvariantCulture);
		}
	}

	private static readonly string s_none = "(none)";

	private Type _type;

	public ReferenceConverter(Type type)
	{
		_type = type;
	}

	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (sourceType == typeof(string) && context != null)
		{
			return true;
		}
		return base.CanConvertFrom(context, sourceType);
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value is string)
		{
			string text = ((string)value).Trim();
			if (!string.Equals(text, s_none) && context != null)
			{
				IReferenceService referenceService = (IReferenceService)context.GetService(typeof(IReferenceService));
				if (referenceService != null)
				{
					object reference = referenceService.GetReference(text);
					if (reference != null)
					{
						return reference;
					}
				}
				IContainer container = context.Container;
				if (container != null)
				{
					object obj = container.Components[text];
					if (obj != null)
					{
						return obj;
					}
				}
			}
			return null;
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(string))
		{
			if (value != null)
			{
				IReferenceService referenceService = (IReferenceService)(context?.GetService(typeof(IReferenceService)));
				if (referenceService != null)
				{
					string name = referenceService.GetName(value);
					if (name != null)
					{
						return name;
					}
				}
				if (!Marshal.IsComObject(value) && value is IComponent)
				{
					string text = ((IComponent)value).Site?.Name;
					if (text != null)
					{
						return text;
					}
				}
				return string.Empty;
			}
			return s_none;
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
	{
		object[] array = null;
		if (context != null)
		{
			List<object> list = new List<object>();
			list.Add(null);
			IReferenceService referenceService = (IReferenceService)context.GetService(typeof(IReferenceService));
			if (referenceService != null)
			{
				object[] references = referenceService.GetReferences(_type);
				int num = references.Length;
				for (int i = 0; i < num; i++)
				{
					if (IsValueAllowed(context, references[i]))
					{
						list.Add(references[i]);
					}
				}
			}
			else
			{
				IContainer container = context.Container;
				if (container != null)
				{
					foreach (IComponent component in container.Components)
					{
						if (component != null && _type.IsInstanceOfType(component) && IsValueAllowed(context, component))
						{
							list.Add(component);
						}
					}
				}
			}
			array = list.ToArray();
			Array.Sort(array, 0, array.Length, new ReferenceComparer(this));
		}
		return new StandardValuesCollection(array);
	}

	public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
	{
		return true;
	}

	public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
	{
		return true;
	}

	protected virtual bool IsValueAllowed(ITypeDescriptorContext context, object value)
	{
		return true;
	}
}

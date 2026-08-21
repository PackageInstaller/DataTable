using System.Collections;
using System.Globalization;
using System.Reflection;

namespace System.ComponentModel.Design;

public abstract class DesignerOptionService
{
	[TypeConverter(typeof(DesignerOptionConverter))]
	[DefaultMember("Item")]
	[Editor("", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	public sealed class DesignerOptionCollection : ICollection
	{
		private sealed class WrappedPropertyDescriptor : PropertyDescriptor
		{
			private object target;

			private PropertyDescriptor property;

			public override AttributeCollection Attributes => property.Attributes;

			public override Type ComponentType => property.ComponentType;

			public override bool IsReadOnly => property.IsReadOnly;

			public override Type PropertyType => property.PropertyType;

			internal WrappedPropertyDescriptor(PropertyDescriptor property, object target)
				: base(property.Name, null)
			{
				this.property = property;
				this.target = target;
			}

			public override bool CanResetValue(object component)
			{
				return property.CanResetValue(target);
			}

			public override object GetValue(object component)
			{
				return property.GetValue(target);
			}

			public override void ResetValue(object component)
			{
				property.ResetValue(target);
			}

			public override void SetValue(object component, object value)
			{
				property.SetValue(target, value);
			}

			public override bool ShouldSerializeValue(object component)
			{
				return property.ShouldSerializeValue(target);
			}
		}

		private DesignerOptionService _service;

		private string _name;

		private object _value;

		private ArrayList _children;

		private PropertyDescriptorCollection _properties;

		public int Count
		{
			get
			{
				EnsurePopulated();
				return _children.Count;
			}
		}

		public string Name => _name;

		public PropertyDescriptorCollection Properties
		{
			get
			{
				if (_properties == null)
				{
					ArrayList arrayList;
					if (_value != null)
					{
						PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(_value);
						arrayList = new ArrayList(properties.Count);
						foreach (PropertyDescriptor item in properties)
						{
							arrayList.Add(new WrappedPropertyDescriptor(item, _value));
						}
					}
					else
					{
						arrayList = new ArrayList(1);
					}
					EnsurePopulated();
					foreach (DesignerOptionCollection child in _children)
					{
						arrayList.AddRange(child.Properties);
					}
					PropertyDescriptor[] properties2 = (PropertyDescriptor[])arrayList.ToArray(typeof(PropertyDescriptor));
					_properties = new PropertyDescriptorCollection(properties2, readOnly: true);
				}
				return _properties;
			}
		}

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot => this;

		public void CopyTo(Array array, int index)
		{
			EnsurePopulated();
			_children.CopyTo(array, index);
		}

		private void EnsurePopulated()
		{
			if (_children == null)
			{
				_service.PopulateOptionCollection(this);
				if (_children == null)
				{
					_children = new ArrayList(1);
				}
			}
		}

		public IEnumerator GetEnumerator()
		{
			EnsurePopulated();
			return _children.GetEnumerator();
		}
	}

	internal sealed class DesignerOptionConverter : TypeConverter
	{
		private class OptionPropertyDescriptor : PropertyDescriptor
		{
			private DesignerOptionCollection _option;

			public override Type ComponentType => _option.GetType();

			public override bool IsReadOnly => true;

			public override Type PropertyType => _option.GetType();

			internal OptionPropertyDescriptor(DesignerOptionCollection option)
				: base(option.Name, null)
			{
				_option = option;
			}

			public override bool CanResetValue(object component)
			{
				return false;
			}

			public override object GetValue(object component)
			{
				return _option;
			}

			public override void ResetValue(object component)
			{
			}

			public override void SetValue(object component, object value)
			{
			}

			public override bool ShouldSerializeValue(object component)
			{
				return false;
			}
		}

		public override bool GetPropertiesSupported(ITypeDescriptorContext cxt)
		{
			return true;
		}

		public override PropertyDescriptorCollection GetProperties(ITypeDescriptorContext cxt, object value, Attribute[] attributes)
		{
			PropertyDescriptorCollection propertyDescriptorCollection = new PropertyDescriptorCollection(null);
			if (!(value is DesignerOptionCollection designerOptionCollection))
			{
				return propertyDescriptorCollection;
			}
			foreach (DesignerOptionCollection item in designerOptionCollection)
			{
				propertyDescriptorCollection.Add(new OptionPropertyDescriptor(item));
			}
			foreach (PropertyDescriptor property in designerOptionCollection.Properties)
			{
				propertyDescriptorCollection.Add(property);
			}
			return propertyDescriptorCollection;
		}

		public override object ConvertTo(ITypeDescriptorContext cxt, CultureInfo culture, object value, Type destinationType)
		{
			if (destinationType == typeof(string))
			{
				return global::SR.GetString("(Collection)");
			}
			return base.ConvertTo(cxt, culture, value, destinationType);
		}
	}

	protected virtual void PopulateOptionCollection(DesignerOptionCollection options)
	{
	}
}

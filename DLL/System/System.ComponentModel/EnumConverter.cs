using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.Design.Serialization;
using System.Globalization;
using System.Reflection;

namespace System.ComponentModel;

public class EnumConverter : TypeConverter
{
	private StandardValuesCollection values;

	private Type type;

	protected Type EnumType => type;

	protected StandardValuesCollection Values
	{
		get
		{
			return values;
		}
		set
		{
			values = value;
		}
	}

	protected virtual IComparer Comparer => InvariantComparer.Default;

	public EnumConverter(Type type)
	{
		this.type = type;
	}

	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (sourceType == typeof(string) || sourceType == typeof(Enum[]))
		{
			return true;
		}
		return base.CanConvertFrom(context, sourceType);
	}

	public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		if (destinationType == typeof(InstanceDescriptor) || destinationType == typeof(Enum[]))
		{
			return true;
		}
		return base.CanConvertTo(context, destinationType);
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value is string)
		{
			try
			{
				string text = (string)value;
				if (text.IndexOf(',') != -1)
				{
					long num = 0L;
					string[] array = text.Split(new char[1] { ',' });
					foreach (string value2 in array)
					{
						num |= Convert.ToInt64((Enum)Enum.Parse(type, value2, ignoreCase: true), culture);
					}
					return Enum.ToObject(type, num);
				}
				return Enum.Parse(type, text, ignoreCase: true);
			}
			catch (Exception innerException)
			{
				throw new FormatException(global::SR.GetString("{0} is not a valid value for {1}.", (string)value, type.Name), innerException);
			}
		}
		if (value is Enum[])
		{
			long num2 = 0L;
			Enum[] array2 = (Enum[])value;
			foreach (Enum value3 in array2)
			{
				num2 |= Convert.ToInt64(value3, culture);
			}
			return Enum.ToObject(type, num2);
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(string) && value != null)
		{
			Type underlyingType = Enum.GetUnderlyingType(type);
			if (value is IConvertible && value.GetType() != underlyingType)
			{
				value = ((IConvertible)value).ToType(underlyingType, culture);
			}
			if (!type.IsDefined(typeof(FlagsAttribute), inherit: false) && !Enum.IsDefined(type, value))
			{
				throw new ArgumentException(global::SR.GetString("The value '{0}' is not a valid value for the enum '{1}'.", value.ToString(), type.Name));
			}
			return Enum.Format(type, value, "G");
		}
		if (destinationType == typeof(InstanceDescriptor) && value != null)
		{
			string text = ConvertToInvariantString(context, value);
			if (type.IsDefined(typeof(FlagsAttribute), inherit: false) && text.IndexOf(',') != -1)
			{
				Type underlyingType2 = Enum.GetUnderlyingType(type);
				if (value is IConvertible)
				{
					object obj = ((IConvertible)value).ToType(underlyingType2, culture);
					MethodInfo method = typeof(Enum).GetMethod("ToObject", new Type[2]
					{
						typeof(Type),
						underlyingType2
					});
					if (method != null)
					{
						return new InstanceDescriptor(method, new object[2] { type, obj });
					}
				}
			}
			else
			{
				FieldInfo field = type.GetField(text);
				if (field != null)
				{
					return new InstanceDescriptor(field, null);
				}
			}
		}
		if (destinationType == typeof(Enum[]) && value != null)
		{
			if (type.IsDefined(typeof(FlagsAttribute), inherit: false))
			{
				List<Enum> list = new List<Enum>();
				Array array = Enum.GetValues(type);
				long[] array2 = new long[array.Length];
				for (int i = 0; i < array.Length; i++)
				{
					array2[i] = Convert.ToInt64((Enum)array.GetValue(i), culture);
				}
				long num = Convert.ToInt64((Enum)value, culture);
				bool flag = true;
				while (flag)
				{
					flag = false;
					long[] array3 = array2;
					foreach (long num2 in array3)
					{
						if ((num2 != 0L && (num2 & num) == num2) || num2 == num)
						{
							list.Add((Enum)Enum.ToObject(type, num2));
							flag = true;
							num &= ~num2;
							break;
						}
					}
					if (num == 0L)
					{
						break;
					}
				}
				if (!flag && num != 0L)
				{
					list.Add((Enum)Enum.ToObject(type, num));
				}
				return list.ToArray();
			}
			return new Enum[1] { (Enum)Enum.ToObject(type, value) };
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
	{
		if (values == null)
		{
			Type reflectionType = TypeDescriptor.GetReflectionType(type);
			if (reflectionType == null)
			{
				reflectionType = type;
			}
			FieldInfo[] fields = reflectionType.GetFields(BindingFlags.Static | BindingFlags.Public);
			ArrayList arrayList = null;
			if (fields != null && fields.Length != 0)
			{
				arrayList = new ArrayList(fields.Length);
			}
			if (arrayList != null)
			{
				FieldInfo[] array = fields;
				foreach (FieldInfo fieldInfo in array)
				{
					BrowsableAttribute browsableAttribute = null;
					object[] customAttributes = fieldInfo.GetCustomAttributes(typeof(BrowsableAttribute), inherit: false);
					for (int j = 0; j < customAttributes.Length; j++)
					{
						browsableAttribute = ((Attribute)customAttributes[j]) as BrowsableAttribute;
					}
					if (browsableAttribute != null && !browsableAttribute.Browsable)
					{
						continue;
					}
					object obj = null;
					try
					{
						if (fieldInfo.Name != null)
						{
							obj = Enum.Parse(type, fieldInfo.Name);
						}
					}
					catch (ArgumentException)
					{
					}
					if (obj != null)
					{
						arrayList.Add(obj);
					}
				}
				IComparer comparer = Comparer;
				if (comparer != null)
				{
					arrayList.Sort(comparer);
				}
			}
			Array array2 = arrayList?.ToArray();
			values = new StandardValuesCollection(array2);
		}
		return values;
	}

	public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
	{
		return !type.IsDefined(typeof(FlagsAttribute), inherit: false);
	}

	public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
	{
		return true;
	}

	public override bool IsValid(ITypeDescriptorContext context, object value)
	{
		return Enum.IsDefined(type, value);
	}
}

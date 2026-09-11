using System.Collections.Generic;

namespace System.ComponentModel;

internal sealed class ExtendedPropertyDescriptor : PropertyDescriptor
{
	private readonly ReflectPropertyDescriptor _extenderInfo;

	private readonly IExtenderProvider _provider;

	public override Type ComponentType => _extenderInfo.ComponentType;

	public override bool IsReadOnly => Attributes[typeof(ReadOnlyAttribute)].Equals(ReadOnlyAttribute.Yes);

	public override Type PropertyType => _extenderInfo.ExtenderGetType(_provider);

	public override string DisplayName
	{
		get
		{
			string text = base.DisplayName;
			if (!(Attributes[typeof(DisplayNameAttribute)] is DisplayNameAttribute displayNameAttribute) || displayNameAttribute.IsDefaultAttribute())
			{
				string text2 = MemberDescriptor.GetSite(_provider)?.Name;
				if (text2 != null && text2.Length > 0)
				{
					text = $"{text} on {text2}";
				}
			}
			return text;
		}
	}

	public ExtendedPropertyDescriptor(ReflectPropertyDescriptor extenderInfo, Type receiverType, IExtenderProvider provider, Attribute[] attributes)
		: base(extenderInfo, attributes)
	{
		List<Attribute> list = new List<Attribute>(AttributeArray) { ExtenderProvidedPropertyAttribute.Create(extenderInfo, receiverType, provider) };
		if (extenderInfo.IsReadOnly)
		{
			list.Add(ReadOnlyAttribute.Yes);
		}
		Attribute[] array = new Attribute[list.Count];
		list.CopyTo(array, 0);
		AttributeArray = array;
		_extenderInfo = extenderInfo;
		_provider = provider;
	}

	public override bool CanResetValue(object comp)
	{
		return _extenderInfo.ExtenderCanResetValue(_provider, comp);
	}

	public override object GetValue(object comp)
	{
		return _extenderInfo.ExtenderGetValue(_provider, comp);
	}

	public override void ResetValue(object comp)
	{
		_extenderInfo.ExtenderResetValue(_provider, comp, this);
	}

	public override void SetValue(object component, object value)
	{
		_extenderInfo.ExtenderSetValue(_provider, component, value, this);
	}

	public override bool ShouldSerializeValue(object comp)
	{
		return _extenderInfo.ExtenderShouldSerializeValue(_provider, comp);
	}
}

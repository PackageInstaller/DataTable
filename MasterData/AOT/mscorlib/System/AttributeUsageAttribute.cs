namespace System;

[Serializable]
[AttributeUsage(AttributeTargets.Class, Inherited = true)]
public sealed class AttributeUsageAttribute : Attribute
{
	private AttributeTargets _attributeTarget = AttributeTargets.All;

	private bool _allowMultiple;

	private bool _inherited = true;

	internal static AttributeUsageAttribute Default = new AttributeUsageAttribute(AttributeTargets.All);

	public AttributeTargets ValidOn => _attributeTarget;

	public bool AllowMultiple
	{
		get
		{
			return _allowMultiple;
		}
		set
		{
			_allowMultiple = value;
		}
	}

	public bool Inherited
	{
		get
		{
			return _inherited;
		}
		set
		{
			_inherited = value;
		}
	}

	public AttributeUsageAttribute(AttributeTargets validOn)
	{
		_attributeTarget = validOn;
	}

	internal AttributeUsageAttribute(AttributeTargets validOn, bool allowMultiple, bool inherited)
	{
		_attributeTarget = validOn;
		_allowMultiple = allowMultiple;
		_inherited = inherited;
	}
}

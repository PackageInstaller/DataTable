using System;

namespace Unity.VisualScripting;

public sealed class ValueInputDefinition : ValuePortDefinition, IUnitInputPortDefinition, IUnitPortDefinition
{
	[SerializeAs("defaultValue")]
	private object _defaultvalue;

	[Inspectable]
	[DoNotSerialize]
	public override Type type
	{
		get
		{
			return base.type;
		}
		set
		{
			base.type = value;
			if (!type.IsAssignableFrom(defaultValue))
			{
				if (ValueInput.SupportsDefaultValue(type))
				{
					_defaultvalue = type.PseudoDefault();
					return;
				}
				hasDefaultValue = false;
				_defaultvalue = null;
			}
		}
	}

	[Inspectable]
	[Serialize]
	public bool hasDefaultValue { get; set; }

	[Inspectable]
	[DoNotSerialize]
	public object defaultValue
	{
		get
		{
			return _defaultvalue;
		}
		set
		{
			if (type == null)
			{
				throw new InvalidOperationException("A type must be defined before setting the default value.");
			}
			if (!ValueInput.SupportsDefaultValue(type))
			{
				throw new InvalidOperationException("The selected type does not support default values.");
			}
			Ensure.That("value").IsOfType(value, type);
			_defaultvalue = value;
		}
	}
}

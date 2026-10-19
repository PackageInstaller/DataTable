using System;

namespace Unity.VisualScripting;

public abstract class ValuePortDefinition : UnitPortDefinition, IUnitValuePortDefinition, IUnitPortDefinition
{
	[SerializeAs("_type")]
	private Type _type { get; set; }

	[DoNotSerialize]
	[Inspectable]
	public virtual Type type
	{
		get
		{
			return _type;
		}
		set
		{
			_type = value;
		}
	}

	public override bool isValid
	{
		get
		{
			if (base.isValid)
			{
				return type != null;
			}
			return false;
		}
	}
}

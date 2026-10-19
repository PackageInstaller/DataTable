using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.LogicParamNode")]
public abstract class LogicParamNode : VariadicNode<bool>
{
	public enum BranchType
	{
		And,
		Or,
		GreaterThan,
		LessThan,
		Equal
	}

	[SerializeAs("BranchingType")]
	private BranchType _branchingType;

	[Serialize]
	[InspectorLabel("[[<,>]] Allow Equals")]
	[Inspectable]
	[InspectorExpandTooltip]
	public bool AllowEquals;

	[InspectorLabel("[[ = ]] Numeric")]
	[Serialize]
	[Inspectable]
	[InspectableIf("supportsNumeric")]
	public bool Numeric;

	[Inspectable]
	[DoNotSerialize]
	[UnitHeaderInspectable("Condition")]
	public BranchType BranchingType
	{
		get
		{
			return _branchingType;
		}
		set
		{
			_branchingType = value;
		}
	}

	[DoNotSerialize]
	public bool supportsEqual
	{
		get
		{
			if (BranchingType != BranchType.LessThan)
			{
				return BranchingType == BranchType.GreaterThan;
			}
			return true;
		}
	}

	[DoNotSerialize]
	public bool supportsNumeric => BranchingType == BranchType.Equal;

	protected override void Definition()
	{
		arguments = new List<ValueInput>();
		switch (BranchingType)
		{
		case BranchType.And:
		case BranchType.Or:
			ConstructArgs<bool>();
			break;
		case BranchType.GreaterThan:
		case BranchType.LessThan:
			ConstructArgs<float>();
			break;
		case BranchType.Equal:
			if (Numeric)
			{
				ConstructArgs<float>();
			}
			else
			{
				ConstructArgs<object>();
			}
			break;
		}
	}

	protected override int ArgumentLimit()
	{
		if (BranchingType == BranchType.GreaterThan || BranchingType == BranchType.LessThan)
		{
			return 2;
		}
		return base.ArgumentLimit();
	}
}

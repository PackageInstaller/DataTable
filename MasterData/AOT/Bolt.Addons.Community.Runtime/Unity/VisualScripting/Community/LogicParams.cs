namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Logic")]
[UnitShortTitle("Logic")]
[UnitTitle("Logic (Params)")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.LogicParams")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.OrParam")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.LogicParams")]
public sealed class LogicParams : LogicParamNode
{
	[PortLabel("Result")]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		output = ValueOutput("output", GetValue);
		base.Definition();
	}

	protected override void BuildRelations(ValueInput arg)
	{
		Requirement(arg, output);
	}

	private bool GetValue(Flow flow)
	{
		foreach (ValueInput argument in arguments)
		{
			switch (BranchingType)
			{
			case BranchType.And:
				if (!flow.GetValue<bool>(argument))
				{
					return false;
				}
				break;
			case BranchType.Or:
				if (flow.GetValue<bool>(argument))
				{
					return true;
				}
				break;
			default:
				return false;
			}
		}
		if (BranchingType == BranchType.And)
		{
			return true;
		}
		_ = BranchingType;
		_ = 1;
		return false;
	}
}

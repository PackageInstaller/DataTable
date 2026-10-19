namespace Unity.VisualScripting;

public sealed class SetMember : MemberUnit
{
	[Serialize]
	[InspectableIf("supportsChaining")]
	public bool chainable { get; set; }

	[DoNotSerialize]
	public bool supportsChaining => member.requiresTarget;

	[DoNotSerialize]
	[MemberFilter(Fields = true, Properties = true, ReadOnly = false)]
	public Member setter
	{
		get
		{
			return member;
		}
		set
		{
			member = value;
		}
	}

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput assign { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	[PortLabel("Value")]
	public ValueInput input { get; private set; }

	[PortLabelHidden]
	[PortLabel("Value")]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	[PortLabel("Target")]
	public ValueOutput targetOutput { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput assigned { get; private set; }

	public SetMember()
	{
	}

	public SetMember(Member member)
		: base(member)
	{
	}

	protected override void Definition()
	{
		base.Definition();
		assign = ControlInput("assign", Assign);
		assigned = ControlOutput("assigned");
		Succession(assign, assigned);
		if (supportsChaining && chainable)
		{
			targetOutput = ValueOutput(member.targetType, "targetOutput");
			Assignment(assign, targetOutput);
		}
		output = ValueOutput(member.type, "output");
		Assignment(assign, output);
		if (member.requiresTarget)
		{
			Requirement(target, assign);
		}
		input = ValueInput(member.type, "input");
		Requirement(input, assign);
		if (member.allowsNull)
		{
			input.AllowsNull();
		}
		input.SetDefaultValue(member.type.PseudoDefault());
	}

	protected override bool IsMemberValid(Member member)
	{
		if (member.isAccessor)
		{
			return member.isSettable;
		}
		return false;
	}

	private object GetAndChainTarget(Flow flow)
	{
		if (member.requiresTarget)
		{
			object value = flow.GetValue(target, member.targetType);
			if (supportsChaining && chainable)
			{
				flow.SetValue(targetOutput, value);
			}
			return value;
		}
		return null;
	}

	private ControlOutput Assign(Flow flow)
	{
		object andChainTarget = GetAndChainTarget(flow);
		object convertedValue = flow.GetConvertedValue(input);
		flow.SetValue(output, member.Set(andChainTarget, convertedValue));
		return assigned;
	}

	public override AnalyticsIdentifier GetAnalyticsIdentifier()
	{
		AnalyticsIdentifier analyticsIdentifier = new AnalyticsIdentifier
		{
			Identifier = member.targetType.FullName + "." + member.name + "(Set)",
			Namespace = member.targetType.Namespace
		};
		analyticsIdentifier.Hashcode = analyticsIdentifier.Identifier.GetHashCode();
		return analyticsIdentifier;
	}
}

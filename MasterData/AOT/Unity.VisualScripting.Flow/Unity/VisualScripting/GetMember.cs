namespace Unity.VisualScripting;

public sealed class GetMember : MemberUnit
{
	[MemberFilter(Fields = true, Properties = true, WriteOnly = false)]
	[DoNotSerialize]
	public Member getter
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

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput value { get; private set; }

	public GetMember()
	{
	}

	public GetMember(Member member)
		: base(member)
	{
	}

	protected override void Definition()
	{
		base.Definition();
		value = ValueOutput(member.type, "value", Value);
		if (member.isPredictable)
		{
			value.Predictable();
		}
		if (member.requiresTarget)
		{
			Requirement(target, value);
		}
	}

	protected override bool IsMemberValid(Member member)
	{
		if (member.isAccessor)
		{
			return member.isGettable;
		}
		return false;
	}

	private object Value(Flow flow)
	{
		object obj = (member.requiresTarget ? flow.GetValue(target, member.targetType) : null);
		return member.Get(obj);
	}

	public override AnalyticsIdentifier GetAnalyticsIdentifier()
	{
		AnalyticsIdentifier analyticsIdentifier = new AnalyticsIdentifier
		{
			Identifier = member.targetType.FullName + "." + member.name + "(Get)",
			Namespace = member.targetType.Namespace
		};
		analyticsIdentifier.Hashcode = analyticsIdentifier.Identifier.GetHashCode();
		return analyticsIdentifier;
	}
}

using System;

namespace Unity.VisualScripting;

[SpecialUnit]
public sealed class Literal : Unit
{
	[SerializeAs("value")]
	private object _value;

	public override bool canDefine => type != null;

	[Serialize]
	public Type type { get; internal set; }

	[DoNotSerialize]
	public object value
	{
		get
		{
			return _value;
		}
		set
		{
			Ensure.That("value").IsOfType(value, type);
			_value = value;
		}
	}

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	public Literal()
	{
	}

	public Literal(Type type)
		: this(type, type.PseudoDefault())
	{
	}

	public Literal(Type type, object value)
	{
		Ensure.That("type").IsNotNull(type);
		Ensure.That("value").IsOfType(value, type);
		this.type = type;
		this.value = value;
	}

	protected override void Definition()
	{
		output = ValueOutput(type, "output", (Flow flow) => value).Predictable();
	}

	public override AnalyticsIdentifier GetAnalyticsIdentifier()
	{
		AnalyticsIdentifier analyticsIdentifier = new AnalyticsIdentifier
		{
			Identifier = GetType().FullName + "(" + type.Name + ")",
			Namespace = type.Namespace
		};
		analyticsIdentifier.Hashcode = analyticsIdentifier.Identifier.GetHashCode();
		return analyticsIdentifier;
	}
}

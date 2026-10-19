using System;

namespace Unity.VisualScripting;

[SpecialUnit]
public sealed class CreateStruct : Unit
{
	[Serialize]
	public Type type { get; internal set; }

	public override bool canDefine => type != null;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	public CreateStruct()
	{
	}

	public CreateStruct(Type type)
	{
		Ensure.That("type").IsNotNull(type);
		if (!type.IsStruct())
		{
			throw new ArgumentException($"Type {type} must be a struct.", "type");
		}
		this.type = type;
	}

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		exit = ControlOutput("exit");
		output = ValueOutput(type, "output", Create);
		Succession(enter, exit);
	}

	private ControlOutput Enter(Flow flow)
	{
		flow.SetValue(output, Activator.CreateInstance(type));
		return exit;
	}

	private object Create(Flow flow)
	{
		return Activator.CreateInstance(type);
	}
}

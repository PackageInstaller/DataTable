using System;

namespace Google.Protobuf;

public abstract class Extension
{
	internal abstract Type TargetType { get; }

	public int FieldNumber { get; }

	internal abstract bool IsRepeated { get; }

	protected Extension(int fieldNumber)
	{
		FieldNumber = fieldNumber;
	}

	internal abstract IExtensionValue CreateValue();
}
public sealed class Extension<TTarget, TValue> : Extension where TTarget : IExtendableMessage<TTarget>
{
	private readonly FieldCodec<TValue> codec;

	internal TValue DefaultValue => codec.DefaultValue;

	internal override Type TargetType => typeof(TTarget);

	internal override bool IsRepeated => false;

	internal override IExtensionValue CreateValue()
	{
		return new ExtensionValue<TValue>(codec);
	}
}

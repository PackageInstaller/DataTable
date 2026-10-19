using System;

namespace Google.Protobuf;

public sealed class RepeatedExtension<TTarget, TValue> : Extension where TTarget : IExtendableMessage<TTarget>
{
	private readonly FieldCodec<TValue> codec;

	internal override Type TargetType => typeof(TTarget);

	internal override bool IsRepeated => true;

	internal override IExtensionValue CreateValue()
	{
		return new RepeatedExtensionValue<TValue>(codec);
	}
}

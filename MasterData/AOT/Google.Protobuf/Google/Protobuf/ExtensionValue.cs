using System;

namespace Google.Protobuf;

internal sealed class ExtensionValue<T> : IExtensionValue, IEquatable<IExtensionValue>, IDeepCloneable<IExtensionValue>
{
	private T field;

	private FieldCodec<T> codec;

	internal ExtensionValue(FieldCodec<T> codec)
	{
		this.codec = codec;
		field = codec.DefaultValue;
	}

	public int CalculateSize()
	{
		return codec.CalculateUnconditionalSizeWithTag(field);
	}

	public IExtensionValue Clone()
	{
		return new ExtensionValue<T>(codec)
		{
			field = ((field is IDeepCloneable<T>) ? (field as IDeepCloneable<T>).Clone() : field)
		};
	}

	public bool Equals(IExtensionValue other)
	{
		if (this == other)
		{
			return true;
		}
		if (other is ExtensionValue<T> && codec.Equals((other as ExtensionValue<T>).codec))
		{
			return object.Equals(field, (other as ExtensionValue<T>).field);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (17 * 31 + field.GetHashCode()) * 31 + codec.GetHashCode();
	}

	public void MergeFrom(ref ParseContext ctx)
	{
		codec.ValueMerger(ref ctx, ref field);
	}

	public void MergeFrom(IExtensionValue value)
	{
		if (value is ExtensionValue<T>)
		{
			ExtensionValue<T> extensionValue = value as ExtensionValue<T>;
			codec.FieldMerger(ref field, extensionValue.field);
		}
	}

	public void WriteTo(ref WriteContext ctx)
	{
		ctx.WriteTag(codec.Tag);
		codec.ValueWriter(ref ctx, field);
		if (codec.EndTag != 0)
		{
			ctx.WriteTag(codec.EndTag);
		}
	}

	public T GetValue()
	{
		return field;
	}

	public void SetValue(T value)
	{
		field = value;
	}
}

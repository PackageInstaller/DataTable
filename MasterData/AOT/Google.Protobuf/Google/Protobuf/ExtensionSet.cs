using System.Collections.Generic;
using Google.Protobuf.Collections;

namespace Google.Protobuf;

public static class ExtensionSet
{
	private static bool TryGetValue<TTarget>(ref ExtensionSet<TTarget> set, Extension extension, out IExtensionValue value) where TTarget : IExtendableMessage<TTarget>
	{
		if (set == null)
		{
			value = null;
			return false;
		}
		return set.ValuesByNumber.TryGetValue(extension.FieldNumber, out value);
	}

	public static TValue Get<TTarget, TValue>(ref ExtensionSet<TTarget> set, Extension<TTarget, TValue> extension) where TTarget : IExtendableMessage<TTarget>
	{
		if (TryGetValue(ref set, extension, out var value))
		{
			return ((ExtensionValue<TValue>)value).GetValue();
		}
		return extension.DefaultValue;
	}

	public static RepeatedField<TValue> Get<TTarget, TValue>(ref ExtensionSet<TTarget> set, RepeatedExtension<TTarget, TValue> extension) where TTarget : IExtendableMessage<TTarget>
	{
		if (TryGetValue(ref set, extension, out var value))
		{
			return ((RepeatedExtensionValue<TValue>)value).GetValue();
		}
		return null;
	}

	public static RepeatedField<TValue> GetOrInitialize<TTarget, TValue>(ref ExtensionSet<TTarget> set, RepeatedExtension<TTarget, TValue> extension) where TTarget : IExtendableMessage<TTarget>
	{
		IExtensionValue value;
		if (set == null)
		{
			value = extension.CreateValue();
			set = new ExtensionSet<TTarget>();
			set.ValuesByNumber.Add(extension.FieldNumber, value);
		}
		else if (!set.ValuesByNumber.TryGetValue(extension.FieldNumber, out value))
		{
			value = extension.CreateValue();
			set.ValuesByNumber.Add(extension.FieldNumber, value);
		}
		return ((RepeatedExtensionValue<TValue>)value).GetValue();
	}

	public static void Set<TTarget, TValue>(ref ExtensionSet<TTarget> set, Extension<TTarget, TValue> extension, TValue value) where TTarget : IExtendableMessage<TTarget>
	{
		ProtoPreconditions.CheckNotNullUnconstrained(value, "value");
		IExtensionValue value2;
		if (set == null)
		{
			value2 = extension.CreateValue();
			set = new ExtensionSet<TTarget>();
			set.ValuesByNumber.Add(extension.FieldNumber, value2);
		}
		else if (!set.ValuesByNumber.TryGetValue(extension.FieldNumber, out value2))
		{
			value2 = extension.CreateValue();
			set.ValuesByNumber.Add(extension.FieldNumber, value2);
		}
		((ExtensionValue<TValue>)value2).SetValue(value);
	}

	public static bool Has<TTarget, TValue>(ref ExtensionSet<TTarget> set, Extension<TTarget, TValue> extension) where TTarget : IExtendableMessage<TTarget>
	{
		IExtensionValue value;
		return TryGetValue(ref set, extension, out value);
	}

	public static void Clear<TTarget, TValue>(ref ExtensionSet<TTarget> set, Extension<TTarget, TValue> extension) where TTarget : IExtendableMessage<TTarget>
	{
		if (set != null)
		{
			set.ValuesByNumber.Remove(extension.FieldNumber);
			if (set.ValuesByNumber.Count == 0)
			{
				set = null;
			}
		}
	}

	public static bool TryMergeFieldFrom<TTarget>(ref ExtensionSet<TTarget> set, ref ParseContext ctx) where TTarget : IExtendableMessage<TTarget>
	{
		int tagFieldNumber = WireFormat.GetTagFieldNumber(ctx.LastTag);
		if (set != null && set.ValuesByNumber.TryGetValue(tagFieldNumber, out var value))
		{
			value.MergeFrom(ref ctx);
			return true;
		}
		if (ctx.ExtensionRegistry != null && ctx.ExtensionRegistry.ContainsInputField(ctx.LastTag, typeof(TTarget), out var extension))
		{
			IExtensionValue extensionValue = extension.CreateValue();
			extensionValue.MergeFrom(ref ctx);
			set = set ?? new ExtensionSet<TTarget>();
			set.ValuesByNumber.Add(extension.FieldNumber, extensionValue);
			return true;
		}
		return false;
	}

	public static void MergeFrom<TTarget>(ref ExtensionSet<TTarget> first, ExtensionSet<TTarget> second) where TTarget : IExtendableMessage<TTarget>
	{
		if (second == null)
		{
			return;
		}
		if (first == null)
		{
			first = new ExtensionSet<TTarget>();
		}
		foreach (KeyValuePair<int, IExtensionValue> item in second.ValuesByNumber)
		{
			if (first.ValuesByNumber.TryGetValue(item.Key, out var value))
			{
				value.MergeFrom(item.Value);
				continue;
			}
			IExtensionValue value2 = item.Value.Clone();
			first.ValuesByNumber[item.Key] = value2;
		}
	}

	public static ExtensionSet<TTarget> Clone<TTarget>(ExtensionSet<TTarget> set) where TTarget : IExtendableMessage<TTarget>
	{
		if (set == null)
		{
			return null;
		}
		ExtensionSet<TTarget> extensionSet = new ExtensionSet<TTarget>();
		foreach (KeyValuePair<int, IExtensionValue> item in set.ValuesByNumber)
		{
			IExtensionValue value = item.Value.Clone();
			extensionSet.ValuesByNumber[item.Key] = value;
		}
		return extensionSet;
	}
}
public sealed class ExtensionSet<TTarget> where TTarget : IExtendableMessage<TTarget>
{
	internal Dictionary<int, IExtensionValue> ValuesByNumber { get; } = new Dictionary<int, IExtensionValue>();

	public override int GetHashCode()
	{
		int num = typeof(TTarget).GetHashCode();
		foreach (KeyValuePair<int, IExtensionValue> item in ValuesByNumber)
		{
			int num2 = item.Key.GetHashCode() ^ item.Value.GetHashCode();
			num ^= num2;
		}
		return num;
	}

	public override bool Equals(object other)
	{
		if (this == other)
		{
			return true;
		}
		ExtensionSet<TTarget> extensionSet = other as ExtensionSet<TTarget>;
		if (ValuesByNumber.Count != extensionSet.ValuesByNumber.Count)
		{
			return false;
		}
		foreach (KeyValuePair<int, IExtensionValue> item in ValuesByNumber)
		{
			if (!extensionSet.ValuesByNumber.TryGetValue(item.Key, out var value))
			{
				return false;
			}
			if (!item.Value.Equals(value))
			{
				return false;
			}
		}
		return true;
	}

	public int CalculateSize()
	{
		int num = 0;
		foreach (IExtensionValue value in ValuesByNumber.Values)
		{
			num += value.CalculateSize();
		}
		return num;
	}

	public void WriteTo(ref WriteContext ctx)
	{
		foreach (IExtensionValue value in ValuesByNumber.Values)
		{
			value.WriteTo(ref ctx);
		}
	}
}

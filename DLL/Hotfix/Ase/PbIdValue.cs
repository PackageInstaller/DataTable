using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(383)]
[MemoryPackable(GenerateType.Object)]
public class PbIdValue : MessageObject, IMemoryPackable<PbIdValue>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbIdValueFormatter : MemoryPackFormatter<PbIdValue>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbIdValue value)
		{
			PbIdValue.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbIdValue value)
		{
			PbIdValue.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Value { get; set; }

	public static PbIdValue Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbIdValue)) as PbIdValue;
		}
		return new PbIdValue();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Value = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbIdValue()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbIdValue>())
		{
			MemoryPackFormatterProvider.Register(new PbIdValueFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbIdValue[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbIdValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbIdValue? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.Id, value.Value);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbIdValue? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00be;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbIdValue), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00be;
			}
		}
		value = new PbIdValue
		{
			IsFromPool = value2,
			Id = value3,
			Value = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Value = value4;
	}
}

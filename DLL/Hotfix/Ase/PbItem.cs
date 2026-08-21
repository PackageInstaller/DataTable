using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(202)]
[MemoryPackable(GenerateType.Object)]
public class PbItem : MessageObject, IMemoryPackable<PbItem>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbItemFormatter : MemoryPackFormatter<PbItem>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbItem value)
		{
			PbItem.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbItem value)
		{
			PbItem.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ItemId { get; set; }

	[MemoryPackOrder(1)]
	public long Count { get; set; }

	public static PbItem Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbItem)) as PbItem;
		}
		return new PbItem();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ItemId = 0;
			Count = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbItem()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbItem>())
		{
			MemoryPackFormatterProvider.Register(new PbItemFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbItem[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbItem? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.ItemId, value.Count);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbItem? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ItemId;
				value4 = value.Count;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbItem), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ItemId;
				value4 = value.Count;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new PbItem
		{
			IsFromPool = value2,
			ItemId = value3,
			Count = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.ItemId = value3;
		value.Count = value4;
	}
}

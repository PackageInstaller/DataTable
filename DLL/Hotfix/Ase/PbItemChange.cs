using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(211)]
[MemoryPackable(GenerateType.Object)]
public class PbItemChange : MessageObject, IMemoryPackable<PbItemChange>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbItemChangeFormatter : MemoryPackFormatter<PbItemChange>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbItemChange value)
		{
			PbItemChange.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbItemChange value)
		{
			PbItemChange.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ItemId { get; set; }

	[MemoryPackOrder(1)]
	public long ItemDelta { get; set; }

	[MemoryPackOrder(2)]
	public long ItemTotal { get; set; }

	[MemoryPackOrder(3)]
	public int ItemType { get; set; }

	public static PbItemChange Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbItemChange)) as PbItemChange;
		}
		return new PbItemChange();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ItemId = 0;
			ItemDelta = 0L;
			ItemTotal = 0L;
			ItemType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbItemChange()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbItemChange>())
		{
			MemoryPackFormatterProvider.Register(new PbItemChangeFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbItemChange[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbItemChange? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, long, int>(5, value.IsFromPool, value.ItemId, value.ItemDelta, value.ItemTotal, value.ItemType);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbItemChange? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ItemId;
				value4 = value.ItemDelta;
				value5 = value.ItemTotal;
				value6 = value.ItemType;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, int, long, long, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbItemChange), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ItemId;
				value4 = value.ItemDelta;
				value5 = value.ItemTotal;
				value6 = value.ItemType;
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
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0119;
			}
		}
		value = new PbItemChange
		{
			IsFromPool = value2,
			ItemId = value3,
			ItemDelta = value4,
			ItemTotal = value5,
			ItemType = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.ItemId = value3;
		value.ItemDelta = value4;
		value.ItemTotal = value5;
		value.ItemType = value6;
	}
}

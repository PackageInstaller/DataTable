using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(416)]
[MemoryPackable(GenerateType.Object)]
public class PbExpireItem : MessageObject, IMemoryPackable<PbExpireItem>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbExpireItemFormatter : MemoryPackFormatter<PbExpireItem>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbExpireItem value)
		{
			PbExpireItem.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbExpireItem value)
		{
			PbExpireItem.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long Uuid { get; set; }

	[MemoryPackOrder(1)]
	public int ItemId { get; set; }

	[MemoryPackOrder(2)]
	public int ItemType { get; set; }

	[MemoryPackOrder(3)]
	public long Count { get; set; }

	[MemoryPackOrder(4)]
	public long ExpireTime { get; set; }

	public static PbExpireItem Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbExpireItem)) as PbExpireItem;
		}
		return new PbExpireItem();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Uuid = 0L;
			ItemId = 0;
			ItemType = 0;
			Count = 0L;
			ExpireTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbExpireItem()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbExpireItem>())
		{
			MemoryPackFormatterProvider.Register(new PbExpireItemFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbExpireItem[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbExpireItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbExpireItem? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, long, long>(6, value.IsFromPool, value.Uuid, value.ItemId, value.ItemType, value.Count, value.ExpireTime);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbExpireItem? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		long value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Uuid;
				value4 = value.ItemId;
				value5 = value.ItemType;
				value6 = value.Count;
				value7 = value.ExpireTime;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0148;
			}
			reader.ReadUnmanaged<bool, long, int, int, long, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbExpireItem), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Uuid;
				value4 = value.ItemId;
				value5 = value.ItemType;
				value6 = value.Count;
				value7 = value.ExpireTime;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0148;
			}
		}
		value = new PbExpireItem
		{
			IsFromPool = value2,
			Uuid = value3,
			ItemId = value4,
			ItemType = value5,
			Count = value6,
			ExpireTime = value7
		};
		return;
		IL_0148:
		value.IsFromPool = value2;
		value.Uuid = value3;
		value.ItemId = value4;
		value.ItemType = value5;
		value.Count = value6;
		value.ExpireTime = value7;
	}
}

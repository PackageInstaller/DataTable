using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(322)]
[MemoryPackable(GenerateType.Object)]
public class PbShopConsumeItem : MessageObject, IMemoryPackable<PbShopConsumeItem>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbShopConsumeItemFormatter : MemoryPackFormatter<PbShopConsumeItem>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbShopConsumeItem value)
		{
			PbShopConsumeItem.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbShopConsumeItem value)
		{
			PbShopConsumeItem.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<int> ConsumeItemCount { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public List<int> ConsumeItemId { get; set; } = new List<int>();

	[MemoryPackOrder(2)]
	public List<int> ConsumeItemType { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public List<int> ConsumeItemOriginalCount { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public long LastDiscountTime { get; set; }

	public static PbShopConsumeItem Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbShopConsumeItem)) as PbShopConsumeItem;
		}
		return new PbShopConsumeItem();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ConsumeItemCount.Clear();
			ConsumeItemId.Clear();
			ConsumeItemType.Clear();
			ConsumeItemOriginalCount.Clear();
			LastDiscountTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbShopConsumeItem()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbShopConsumeItem>())
		{
			MemoryPackFormatterProvider.Register(new PbShopConsumeItemFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbShopConsumeItem[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbShopConsumeItem>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbShopConsumeItem? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteValue<List<int>>(value.ConsumeItemCount);
		writer.WriteValue<List<int>>(value.ConsumeItemId);
		writer.WriteValue<List<int>>(value.ConsumeItemType);
		writer.WriteValue<List<int>>(value.ConsumeItemOriginalCount);
		writer.WriteUnmanaged<long>(value.LastDiscountTime);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbShopConsumeItem? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		List<int> value4;
		List<int> value5;
		List<int> value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ConsumeItemCount;
				value4 = value.ConsumeItemId;
				value5 = value.ConsumeItemType;
				value6 = value.ConsumeItemOriginalCount;
				value7 = value.LastDiscountTime;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadValue(ref value4);
				reader.ReadValue(ref value5);
				reader.ReadValue(ref value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0162;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			value4 = reader.ReadValue<List<int>>();
			value5 = reader.ReadValue<List<int>>();
			value6 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<long>(out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbShopConsumeItem), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ConsumeItemCount;
				value4 = value.ConsumeItemId;
				value5 = value.ConsumeItemType;
				value6 = value.ConsumeItemOriginalCount;
				value7 = value.LastDiscountTime;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
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
				goto IL_0162;
			}
		}
		value = new PbShopConsumeItem
		{
			IsFromPool = value2,
			ConsumeItemCount = value3,
			ConsumeItemId = value4,
			ConsumeItemType = value5,
			ConsumeItemOriginalCount = value6,
			LastDiscountTime = value7
		};
		return;
		IL_0162:
		value.IsFromPool = value2;
		value.ConsumeItemCount = value3;
		value.ConsumeItemId = value4;
		value.ConsumeItemType = value5;
		value.ConsumeItemOriginalCount = value6;
		value.LastDiscountTime = value7;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(365)]
[MemoryPackable(GenerateType.Object)]
public class PbHomeLandShopItem : MessageObject, IMemoryPackable<PbHomeLandShopItem>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbHomeLandShopItemFormatter : MemoryPackFormatter<PbHomeLandShopItem>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbHomeLandShopItem value)
		{
			PbHomeLandShopItem.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbHomeLandShopItem value)
		{
			PbHomeLandShopItem.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int GridId { get; set; }

	[MemoryPackOrder(2)]
	public int ConfigId { get; set; }

	[MemoryPackOrder(3)]
	public int BoughtCount { get; set; }

	public static PbHomeLandShopItem Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbHomeLandShopItem)) as PbHomeLandShopItem;
		}
		return new PbHomeLandShopItem();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			GridId = 0;
			ConfigId = 0;
			BoughtCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbHomeLandShopItem()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbHomeLandShopItem>())
		{
			MemoryPackFormatterProvider.Register(new PbHomeLandShopItemFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbHomeLandShopItem[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbHomeLandShopItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbHomeLandShopItem? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.GridId, value.ConfigId, value.BoughtCount);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbHomeLandShopItem? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.GridId;
				value4 = value.ConfigId;
				value5 = value.BoughtCount;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbHomeLandShopItem), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.GridId;
				value4 = value.ConfigId;
				value5 = value.BoughtCount;
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
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new PbHomeLandShopItem
		{
			IsFromPool = value2,
			GridId = value3,
			ConfigId = value4,
			BoughtCount = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.GridId = value3;
		value.ConfigId = value4;
		value.BoughtCount = value5;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(366)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendShopSingleItem : MessageObject, IMemoryPackable<PbFriendShopSingleItem>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendShopSingleItemFormatter : MemoryPackFormatter<PbFriendShopSingleItem>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendShopSingleItem value)
		{
			PbFriendShopSingleItem.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendShopSingleItem value)
		{
			PbFriendShopSingleItem.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(1)]
	public int GridId { get; set; }

	[MemoryPackOrder(2)]
	public int ConfigId { get; set; }

	public static PbFriendShopSingleItem Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendShopSingleItem)) as PbFriendShopSingleItem;
		}
		return new PbFriendShopSingleItem();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			GridId = 0;
			ConfigId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendShopSingleItem()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopSingleItem>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendShopSingleItemFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopSingleItem[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendShopSingleItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendShopSingleItem? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.GridId, value.ConfigId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendShopSingleItem? value)
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
				value3 = value.GridId;
				value4 = value.ConfigId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendShopSingleItem), 3, memberCount);
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
				value3 = value.GridId;
				value4 = value.ConfigId;
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
		value = new PbFriendShopSingleItem
		{
			IsFromPool = value2,
			GridId = value3,
			ConfigId = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.GridId = value3;
		value.ConfigId = value4;
	}
}

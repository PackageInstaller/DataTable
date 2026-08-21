using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(367)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendShopInfo : MessageObject, IMemoryPackable<PbFriendShopInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendShopInfoFormatter : MemoryPackFormatter<PbFriendShopInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendShopInfo value)
		{
			PbFriendShopInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendShopInfo value)
		{
			PbFriendShopInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long FriendId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbFriendShopSingleItem> ShopItems { get; set; } = new List<PbFriendShopSingleItem>();

	[MemoryPackOrder(2)]
	public long FriendAddTime { get; set; }

	public static PbFriendShopInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendShopInfo)) as PbFriendShopInfo;
		}
		return new PbFriendShopInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			FriendId = 0L;
			ShopItems.Clear();
			FriendAddTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendShopInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendShopInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendShopInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendShopSingleItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendShopSingleItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendShopInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.FriendId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendShopSingleItem>>(value.ShopItems));
		writer.WriteUnmanaged<long>(value.FriendAddTime);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendShopInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbFriendShopSingleItem> value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.ShopItems;
				value5 = value.FriendAddTime;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f6;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbFriendShopSingleItem>(ref reader);
			reader.ReadUnmanaged<long>(out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendShopInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.ShopItems;
				value5 = value.FriendAddTime;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f6;
			}
		}
		value = new PbFriendShopInfo
		{
			IsFromPool = value2,
			FriendId = value3,
			ShopItems = value4,
			FriendAddTime = value5
		};
		return;
		IL_00f6:
		value.IsFromPool = value2;
		value.FriendId = value3;
		value.ShopItems = value4;
		value.FriendAddTime = value5;
	}
}

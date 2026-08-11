using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10606)]
[MemoryPackable(GenerateType.Object)]
public class BuyFriendShopItemResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<BuyFriendShopItemResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BuyFriendShopItemResponseFormatter : MemoryPackFormatter<BuyFriendShopItemResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BuyFriendShopItemResponse value)
		{
			BuyFriendShopItemResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BuyFriendShopItemResponse value)
		{
			BuyFriendShopItemResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbItemChange> Goods { get; set; } = new List<PbItemChange>();

	[MemoryPackOrder(1)]
	public int BoughtCount { get; set; }

	public static BuyFriendShopItemResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BuyFriendShopItemResponse)) as BuyFriendShopItemResponse;
		}
		return new BuyFriendShopItemResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Goods.Clear();
			BoughtCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BuyFriendShopItemResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BuyFriendShopItemResponse>())
		{
			MemoryPackFormatterProvider.Register(new BuyFriendShopItemResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BuyFriendShopItemResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BuyFriendShopItemResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BuyFriendShopItemResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.Goods));
		writer.WriteUnmanaged<int, int, int>(value.BoughtCount, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BuyFriendShopItemResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbItemChange> value3;
		int value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Goods;
				value4 = value.BoughtCount;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BuyFriendShopItemResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Goods;
				value4 = value.BoughtCount;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0156;
			}
		}
		value = new BuyFriendShopItemResponse
		{
			IsFromPool = value2,
			Goods = value3,
			BoughtCount = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.Goods = value3;
		value.BoughtCount = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

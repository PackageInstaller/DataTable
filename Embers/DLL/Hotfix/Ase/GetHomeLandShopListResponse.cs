using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10598)]
[MemoryPackable(GenerateType.Object)]
public class GetHomeLandShopListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetHomeLandShopListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetHomeLandShopListResponseFormatter : MemoryPackFormatter<GetHomeLandShopListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetHomeLandShopListResponse value)
		{
			GetHomeLandShopListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetHomeLandShopListResponse value)
		{
			GetHomeLandShopListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbHomeLandShopItem> ShopItems { get; set; } = new List<PbHomeLandShopItem>();

	[MemoryPackOrder(0)]
	public int TodayBoughtCount { get; set; }

	[MemoryPackOrder(1)]
	public int TodayBuyLimit { get; set; }

	public static GetHomeLandShopListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetHomeLandShopListResponse)) as GetHomeLandShopListResponse;
		}
		return new GetHomeLandShopListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ShopItems.Clear();
			TodayBoughtCount = 0;
			TodayBuyLimit = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetHomeLandShopListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetHomeLandShopListResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetHomeLandShopListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetHomeLandShopListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetHomeLandShopListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbHomeLandShopItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbHomeLandShopItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetHomeLandShopListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbHomeLandShopItem>>(value.ShopItems));
		writer.WriteUnmanaged<int, int, int, int>(value.TodayBoughtCount, value.TodayBuyLimit, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetHomeLandShopListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbHomeLandShopItem> value3;
		int value4;
		int value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ShopItems;
				value4 = value.TodayBoughtCount;
				value5 = value.TodayBuyLimit;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0181;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbHomeLandShopItem>(ref reader);
			reader.ReadUnmanaged<int, int, int, int>(out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetHomeLandShopListResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ShopItems;
				value4 = value.TodayBoughtCount;
				value5 = value.TodayBuyLimit;
				value6 = value.RpcId;
				value7 = value.Error;
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
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0181;
			}
		}
		value = new GetHomeLandShopListResponse
		{
			IsFromPool = value2,
			ShopItems = value3,
			TodayBoughtCount = value4,
			TodayBuyLimit = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0181:
		value.IsFromPool = value2;
		value.ShopItems = value3;
		value.TodayBoughtCount = value4;
		value.TodayBuyLimit = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

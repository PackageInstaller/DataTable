using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10602)]
[MemoryPackable(GenerateType.Object)]
public class GetAllFriendShopListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetAllFriendShopListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetAllFriendShopListResponseFormatter : MemoryPackFormatter<GetAllFriendShopListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetAllFriendShopListResponse value)
		{
			GetAllFriendShopListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetAllFriendShopListResponse value)
		{
			GetAllFriendShopListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbFriendShopInfo> FriendShops { get; set; } = new List<PbFriendShopInfo>();

	[MemoryPackOrder(1)]
	public List<PbFriendShopBoughtState> FriendShopBoughtStates { get; set; } = new List<PbFriendShopBoughtState>();

	public static GetAllFriendShopListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetAllFriendShopListResponse)) as GetAllFriendShopListResponse;
		}
		return new GetAllFriendShopListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			FriendShops.Clear();
			FriendShopBoughtStates.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetAllFriendShopListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetAllFriendShopListResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetAllFriendShopListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetAllFriendShopListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetAllFriendShopListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendShopInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendShopInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendShopBoughtState>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendShopBoughtState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetAllFriendShopListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendShopInfo>>(value.FriendShops));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendShopBoughtState>>(value.FriendShopBoughtStates));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetAllFriendShopListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbFriendShopInfo> value3;
		List<PbFriendShopBoughtState> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendShops;
				value4 = value.FriendShopBoughtStates;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbFriendShopInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbFriendShopBoughtState>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetAllFriendShopListResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendShops;
				value4 = value.FriendShopBoughtStates;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
				goto IL_015b;
			}
		}
		value = new GetAllFriendShopListResponse
		{
			IsFromPool = value2,
			FriendShops = value3,
			FriendShopBoughtStates = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.FriendShops = value3;
		value.FriendShopBoughtStates = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

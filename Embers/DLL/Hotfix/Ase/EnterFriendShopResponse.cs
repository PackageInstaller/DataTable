using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10604)]
[MemoryPackable(GenerateType.Object)]
public class EnterFriendShopResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<EnterFriendShopResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class EnterFriendShopResponseFormatter : MemoryPackFormatter<EnterFriendShopResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref EnterFriendShopResponse value)
		{
			EnterFriendShopResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref EnterFriendShopResponse value)
		{
			EnterFriendShopResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbFriendShopInfo FriendShops { get; set; }

	[MemoryPackOrder(1)]
	public PbFriendShopBoughtState FriendShopBoughtStates { get; set; }

	public static EnterFriendShopResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(EnterFriendShopResponse)) as EnterFriendShopResponse;
		}
		return new EnterFriendShopResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			FriendShops = null;
			FriendShopBoughtStates = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static EnterFriendShopResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<EnterFriendShopResponse>())
		{
			MemoryPackFormatterProvider.Register(new EnterFriendShopResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<EnterFriendShopResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<EnterFriendShopResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref EnterFriendShopResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbFriendShopInfo>(value.FriendShops);
		writer.WritePackable<PbFriendShopBoughtState>(value.FriendShopBoughtStates);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref EnterFriendShopResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbFriendShopInfo value3;
		PbFriendShopBoughtState value4;
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
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbFriendShopInfo>();
			value4 = reader.ReadPackable<PbFriendShopBoughtState>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(EnterFriendShopResponse), 6, memberCount);
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
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
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
		value = new EnterFriendShopResponse
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

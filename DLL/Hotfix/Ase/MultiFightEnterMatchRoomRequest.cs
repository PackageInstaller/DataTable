using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10440)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightEnterMatchRoomRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MultiFightEnterMatchRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightEnterMatchRoomRequestFormatter : MemoryPackFormatter<MultiFightEnterMatchRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightEnterMatchRoomRequest value)
		{
			MultiFightEnterMatchRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightEnterMatchRoomRequest value)
		{
			MultiFightEnterMatchRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(2)]
	public long FriendUserId { get; set; }

	[MemoryPackOrder(7)]
	public string ClientVersion { get; set; }

	public static MultiFightEnterMatchRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightEnterMatchRoomRequest)) as MultiFightEnterMatchRoomRequest;
		}
		return new MultiFightEnterMatchRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			RoomId = 0L;
			SelectModel = 0;
			FriendUserId = 0L;
			ClientVersion = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightEnterMatchRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightEnterMatchRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightEnterMatchRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightEnterMatchRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightEnterMatchRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightEnterMatchRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, long>(9, value.IsFromPool, value.RoomId, value.SelectModel, value.FriendUserId);
		writer.WriteString(value.ClientVersion);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightEnterMatchRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		int value6;
		long value7;
		int value8;
		long value9;
		string clientVersion;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.SelectModel;
				value5 = value.FriendUserId;
				clientVersion = value.ClientVersion;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				clientVersion = reader.ReadString();
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01da;
			}
			reader.ReadUnmanaged<bool, long, int, long>(out value2, out value3, out value4, out value5);
			clientVersion = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long>(out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightEnterMatchRoomRequest), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
				clientVersion = null;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.SelectModel;
				value5 = value.FriendUserId;
				clientVersion = value.ClientVersion;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								clientVersion = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value9);
												_ = 9;
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01da;
			}
		}
		value = new MultiFightEnterMatchRoomRequest
		{
			IsFromPool = value2,
			RoomId = value3,
			SelectModel = value4,
			FriendUserId = value5,
			ClientVersion = clientVersion,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01da:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.SelectModel = value4;
		value.FriendUserId = value5;
		value.ClientVersion = clientVersion;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}

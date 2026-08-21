using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10446)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightLeaveRoomRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MultiFightLeaveRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightLeaveRoomRequestFormatter : MemoryPackFormatter<MultiFightLeaveRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightLeaveRoomRequest value)
		{
			MultiFightLeaveRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightLeaveRoomRequest value)
		{
			MultiFightLeaveRoomRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(91)]
	public long UserId { get; set; }

	[MemoryPackOrder(92)]
	public int ClientFlag { get; set; }

	public static MultiFightLeaveRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightLeaveRoomRequest)) as MultiFightLeaveRoomRequest;
		}
		return new MultiFightLeaveRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ClientFlag = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightLeaveRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightLeaveRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightLeaveRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightLeaveRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightLeaveRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightLeaveRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, long, long, int>(7, value.IsFromPool, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId, value.UserId, value.ClientFlag);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightLeaveRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		long value6;
		long value7;
		int value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
				value8 = value.ClientFlag;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_0173;
			}
			reader.ReadUnmanaged<bool, int, long, int, long, long, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightLeaveRoomRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
				value8 = value.ClientFlag;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
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
				goto IL_0173;
			}
		}
		value = new MultiFightLeaveRoomRequest
		{
			IsFromPool = value2,
			LoginServerId = value3,
			LoginSecretKey = value4,
			RpcId = value5,
			ActorId = value6,
			UserId = value7,
			ClientFlag = value8
		};
		return;
		IL_0173:
		value.IsFromPool = value2;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.RpcId = value5;
		value.ActorId = value6;
		value.UserId = value7;
		value.ClientFlag = value8;
	}
}

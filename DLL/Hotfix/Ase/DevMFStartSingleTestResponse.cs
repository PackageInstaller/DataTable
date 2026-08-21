using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10521)]
[MemoryPackable(GenerateType.Object)]
public class DevMFStartSingleTestResponse : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<DevMFStartSingleTestResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class DevMFStartSingleTestResponseFormatter : MemoryPackFormatter<DevMFStartSingleTestResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref DevMFStartSingleTestResponse value)
		{
			DevMFStartSingleTestResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref DevMFStartSingleTestResponse value)
		{
			DevMFStartSingleTestResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	public static DevMFStartSingleTestResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(DevMFStartSingleTestResponse)) as DevMFStartSingleTestResponse;
		}
		return new DevMFStartSingleTestResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0L;
			RoomId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static DevMFStartSingleTestResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<DevMFStartSingleTestResponse>())
		{
			MemoryPackFormatterProvider.Register(new DevMFStartSingleTestResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<DevMFStartSingleTestResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<DevMFStartSingleTestResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref DevMFStartSingleTestResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, long, int, int>(7, value.IsFromPool, value.UserId, value.RoomId, value.ActorId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref DevMFStartSingleTestResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		long value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.ActorId;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0179;
			}
			reader.ReadUnmanaged<bool, long, long, long, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(DevMFStartSingleTestResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.ActorId;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_0179;
			}
		}
		value = new DevMFStartSingleTestResponse
		{
			IsFromPool = value2,
			UserId = value3,
			RoomId = value4,
			ActorId = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0179:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoomId = value4;
		value.ActorId = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

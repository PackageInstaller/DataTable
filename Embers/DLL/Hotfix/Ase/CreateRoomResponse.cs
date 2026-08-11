using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10008)]
[MemoryPackable(GenerateType.Object)]
public class CreateRoomResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<CreateRoomResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CreateRoomResponseFormatter : MemoryPackFormatter<CreateRoomResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CreateRoomResponse value)
		{
			CreateRoomResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CreateRoomResponse value)
		{
			CreateRoomResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbMatchRoomInfo RoomInfo { get; set; }

	[MemoryPackOrder(8)]
	public long punishLeftTim { get; set; }

	public static CreateRoomResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CreateRoomResponse)) as CreateRoomResponse;
		}
		return new CreateRoomResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RoomInfo = null;
			punishLeftTim = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CreateRoomResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CreateRoomResponse>())
		{
			MemoryPackFormatterProvider.Register(new CreateRoomResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CreateRoomResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CreateRoomResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref CreateRoomResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbMatchRoomInfo>(value.RoomInfo);
		writer.WriteUnmanaged<long, int, int>(value.punishLeftTim, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CreateRoomResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbMatchRoomInfo value3;
		long value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomInfo;
				value4 = value.punishLeftTim;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0157;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbMatchRoomInfo>();
			reader.ReadUnmanaged<long, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CreateRoomResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomInfo;
				value4 = value.punishLeftTim;
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
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_0157;
			}
		}
		value = new CreateRoomResponse
		{
			IsFromPool = value2,
			RoomInfo = value3,
			punishLeftTim = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.RoomInfo = value3;
		value.punishLeftTim = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

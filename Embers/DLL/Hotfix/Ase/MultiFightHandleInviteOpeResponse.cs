using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10423)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightHandleInviteOpeResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<MultiFightHandleInviteOpeResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightHandleInviteOpeResponseFormatter : MemoryPackFormatter<MultiFightHandleInviteOpeResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightHandleInviteOpeResponse value)
		{
			MultiFightHandleInviteOpeResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightHandleInviteOpeResponse value)
		{
			MultiFightHandleInviteOpeResponse.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(1)]
	public long PunishLeftTim { get; set; }

	public static MultiFightHandleInviteOpeResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightHandleInviteOpeResponse)) as MultiFightHandleInviteOpeResponse;
		}
		return new MultiFightHandleInviteOpeResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RoomInfo = null;
			PunishLeftTim = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightHandleInviteOpeResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightHandleInviteOpeResponse>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightHandleInviteOpeResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightHandleInviteOpeResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightHandleInviteOpeResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightHandleInviteOpeResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbMatchRoomInfo>(value.RoomInfo);
		writer.WriteUnmanaged<long, int, int>(value.PunishLeftTim, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightHandleInviteOpeResponse? value)
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
				value4 = value.PunishLeftTim;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightHandleInviteOpeResponse), 6, memberCount);
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
				value4 = value.PunishLeftTim;
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
		value = new MultiFightHandleInviteOpeResponse
		{
			IsFromPool = value2,
			RoomInfo = value3,
			PunishLeftTim = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.RoomInfo = value3;
		value.PunishLeftTim = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

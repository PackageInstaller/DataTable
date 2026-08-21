using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10441)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightEnterMatchRoomResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<MultiFightEnterMatchRoomResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightEnterMatchRoomResponseFormatter : MemoryPackFormatter<MultiFightEnterMatchRoomResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightEnterMatchRoomResponse value)
		{
			MultiFightEnterMatchRoomResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightEnterMatchRoomResponse value)
		{
			MultiFightEnterMatchRoomResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbMatchRoomInfo MatchRoomInfo { get; set; }

	[MemoryPackOrder(1)]
	public int SelfSeatId { get; set; }

	[MemoryPackOrder(2)]
	public long PunishLeftTim { get; set; }

	public static MultiFightEnterMatchRoomResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightEnterMatchRoomResponse)) as MultiFightEnterMatchRoomResponse;
		}
		return new MultiFightEnterMatchRoomResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			MatchRoomInfo = null;
			SelfSeatId = 0;
			PunishLeftTim = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightEnterMatchRoomResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightEnterMatchRoomResponse>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightEnterMatchRoomResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightEnterMatchRoomResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightEnterMatchRoomResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightEnterMatchRoomResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbMatchRoomInfo>(value.MatchRoomInfo);
		writer.WriteUnmanaged<int, long, int, int>(value.SelfSeatId, value.PunishLeftTim, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightEnterMatchRoomResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbMatchRoomInfo value3;
		int value4;
		long value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MatchRoomInfo;
				value4 = value.SelfSeatId;
				value5 = value.PunishLeftTim;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0182;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbMatchRoomInfo>();
			reader.ReadUnmanaged<int, long, int, int>(out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightEnterMatchRoomResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MatchRoomInfo;
				value4 = value.SelfSeatId;
				value5 = value.PunishLeftTim;
				value6 = value.RpcId;
				value7 = value.Error;
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
						reader.ReadUnmanaged<int>(out value4);
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
				goto IL_0182;
			}
		}
		value = new MultiFightEnterMatchRoomResponse
		{
			IsFromPool = value2,
			MatchRoomInfo = value3,
			SelfSeatId = value4,
			PunishLeftTim = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0182:
		value.IsFromPool = value2;
		value.MatchRoomInfo = value3;
		value.SelfSeatId = value4;
		value.PunishLeftTim = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

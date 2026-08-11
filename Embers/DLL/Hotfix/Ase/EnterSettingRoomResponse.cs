using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10014)]
[MemoryPackable(GenerateType.Object)]
public class EnterSettingRoomResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<EnterSettingRoomResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class EnterSettingRoomResponseFormatter : MemoryPackFormatter<EnterSettingRoomResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref EnterSettingRoomResponse value)
		{
			EnterSettingRoomResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref EnterSettingRoomResponse value)
		{
			EnterSettingRoomResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbRoomInfo RoomInfo { get; set; }

	[MemoryPackOrder(1)]
	public int SelfSeatId { get; set; }

	[MemoryPackOrder(2)]
	public int AccountEnergy { get; set; }

	[MemoryPackOrder(3)]
	public long LastVitRecoverTime { get; set; }

	[MemoryPackOrder(4)]
	public int CopyTicketCount { get; set; }

	public static EnterSettingRoomResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(EnterSettingRoomResponse)) as EnterSettingRoomResponse;
		}
		return new EnterSettingRoomResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RoomInfo = null;
			SelfSeatId = 0;
			AccountEnergy = 0;
			LastVitRecoverTime = 0L;
			CopyTicketCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static EnterSettingRoomResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<EnterSettingRoomResponse>())
		{
			MemoryPackFormatterProvider.Register(new EnterSettingRoomResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<EnterSettingRoomResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<EnterSettingRoomResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref EnterSettingRoomResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(9, value.IsFromPool);
		writer.WritePackable<PbRoomInfo>(value.RoomInfo);
		writer.WriteUnmanaged<int, int, long, int, int, int>(value.SelfSeatId, value.AccountEnergy, value.LastVitRecoverTime, value.CopyTicketCount, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref EnterSettingRoomResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbRoomInfo value3;
		int value4;
		int value5;
		long value6;
		int value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomInfo;
				value4 = value.SelfSeatId;
				value5 = value.AccountEnergy;
				value6 = value.LastVitRecoverTime;
				value7 = value.CopyTicketCount;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01dc;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbRoomInfo>();
			reader.ReadUnmanaged<int, int, long, int, int, int>(out value4, out value5, out value6, out value7, out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(EnterSettingRoomResponse), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomInfo;
				value4 = value.SelfSeatId;
				value5 = value.AccountEnergy;
				value6 = value.LastVitRecoverTime;
				value7 = value.CopyTicketCount;
				value8 = value.RpcId;
				value9 = value.Error;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
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
				goto IL_01dc;
			}
		}
		value = new EnterSettingRoomResponse
		{
			IsFromPool = value2,
			RoomInfo = value3,
			SelfSeatId = value4,
			AccountEnergy = value5,
			LastVitRecoverTime = value6,
			CopyTicketCount = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01dc:
		value.IsFromPool = value2;
		value.RoomInfo = value3;
		value.SelfSeatId = value4;
		value.AccountEnergy = value5;
		value.LastVitRecoverTime = value6;
		value.CopyTicketCount = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}

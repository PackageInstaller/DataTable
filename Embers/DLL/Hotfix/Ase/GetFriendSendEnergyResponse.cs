using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10304)]
[MemoryPackable(GenerateType.Object)]
public class GetFriendSendEnergyResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetFriendSendEnergyResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetFriendSendEnergyResponseFormatter : MemoryPackFormatter<GetFriendSendEnergyResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetFriendSendEnergyResponse value)
		{
			GetFriendSendEnergyResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetFriendSendEnergyResponse value)
		{
			GetFriendSendEnergyResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int State { get; set; }

	[MemoryPackOrder(1)]
	public int EnergyDelta { get; set; }

	[MemoryPackOrder(2)]
	public int EnergyTotal { get; set; }

	[MemoryPackOrder(3)]
	public long LastVitRecoverTime { get; set; }

	public static GetFriendSendEnergyResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetFriendSendEnergyResponse)) as GetFriendSendEnergyResponse;
		}
		return new GetFriendSendEnergyResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			State = 0;
			EnergyDelta = 0;
			EnergyTotal = 0;
			LastVitRecoverTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetFriendSendEnergyResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendSendEnergyResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetFriendSendEnergyResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendSendEnergyResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetFriendSendEnergyResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetFriendSendEnergyResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, long, int, int>(8, value.IsFromPool, value.State, value.EnergyDelta, value.EnergyTotal, value.LastVitRecoverTime, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetFriendSendEnergyResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		long value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.State;
				value4 = value.EnergyDelta;
				value5 = value.EnergyTotal;
				value6 = value.LastVitRecoverTime;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01a2;
			}
			reader.ReadUnmanaged<bool, int, int, int, long, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetFriendSendEnergyResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.State;
				value4 = value.EnergyDelta;
				value5 = value.EnergyTotal;
				value6 = value.LastVitRecoverTime;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
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
											message = reader.ReadString();
											_ = 8;
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
				goto IL_01a2;
			}
		}
		value = new GetFriendSendEnergyResponse
		{
			IsFromPool = value2,
			State = value3,
			EnergyDelta = value4,
			EnergyTotal = value5,
			LastVitRecoverTime = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01a2:
		value.IsFromPool = value2;
		value.State = value3;
		value.EnergyDelta = value4;
		value.EnergyTotal = value5;
		value.LastVitRecoverTime = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}

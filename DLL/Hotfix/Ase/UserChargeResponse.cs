using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10316)]
[MemoryPackable(GenerateType.Object)]
public class UserChargeResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<UserChargeResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserChargeResponseFormatter : MemoryPackFormatter<UserChargeResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserChargeResponse value)
		{
			UserChargeResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserChargeResponse value)
		{
			UserChargeResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long FirstCharge { get; set; }

	[MemoryPackOrder(1)]
	public long TotalCharge { get; set; }

	[MemoryPackOrder(2)]
	public PbItemChange ItemChange { get; set; }

	public static UserChargeResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserChargeResponse)) as UserChargeResponse;
		}
		return new UserChargeResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			FirstCharge = 0L;
			TotalCharge = 0L;
			ItemChange = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserChargeResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserChargeResponse>())
		{
			MemoryPackFormatterProvider.Register(new UserChargeResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserChargeResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserChargeResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserChargeResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(7, value.IsFromPool, value.FirstCharge, value.TotalCharge);
		writer.WritePackable<PbItemChange>(value.ItemChange);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserChargeResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		PbItemChange value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FirstCharge;
				value4 = value.TotalCharge;
				value5 = value.ItemChange;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0184;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserChargeResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FirstCharge;
				value4 = value.TotalCharge;
				value5 = value.ItemChange;
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
							reader.ReadPackable(ref value5);
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
				goto IL_0184;
			}
		}
		value = new UserChargeResponse
		{
			IsFromPool = value2,
			FirstCharge = value3,
			TotalCharge = value4,
			ItemChange = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0184:
		value.IsFromPool = value2;
		value.FirstCharge = value3;
		value.TotalCharge = value4;
		value.ItemChange = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

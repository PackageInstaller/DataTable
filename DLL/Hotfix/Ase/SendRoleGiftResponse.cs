using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10578)]
[MemoryPackable(GenerateType.Object)]
public class SendRoleGiftResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<SendRoleGiftResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SendRoleGiftResponseFormatter : MemoryPackFormatter<SendRoleGiftResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SendRoleGiftResponse value)
		{
			SendRoleGiftResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SendRoleGiftResponse value)
		{
			SendRoleGiftResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int FinalFeeling { get; set; }

	[MemoryPackOrder(1)]
	public int TrustLevel { get; set; }

	[MemoryPackOrder(2)]
	public PbItemChange Gift { get; set; }

	public static SendRoleGiftResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SendRoleGiftResponse)) as SendRoleGiftResponse;
		}
		return new SendRoleGiftResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			FinalFeeling = 0;
			TrustLevel = 0;
			Gift = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SendRoleGiftResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SendRoleGiftResponse>())
		{
			MemoryPackFormatterProvider.Register(new SendRoleGiftResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SendRoleGiftResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SendRoleGiftResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SendRoleGiftResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(7, value.IsFromPool, value.FinalFeeling, value.TrustLevel);
		writer.WritePackable<PbItemChange>(value.Gift);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SendRoleGiftResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		PbItemChange value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FinalFeeling;
				value4 = value.TrustLevel;
				value5 = value.Gift;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0182;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SendRoleGiftResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FinalFeeling;
				value4 = value.TrustLevel;
				value5 = value.Gift;
				value6 = value.RpcId;
				value7 = value.Error;
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
				goto IL_0182;
			}
		}
		value = new SendRoleGiftResponse
		{
			IsFromPool = value2,
			FinalFeeling = value3,
			TrustLevel = value4,
			Gift = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0182:
		value.IsFromPool = value2;
		value.FinalFeeling = value3;
		value.TrustLevel = value4;
		value.Gift = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

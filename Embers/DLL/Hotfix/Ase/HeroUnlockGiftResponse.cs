using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10204)]
[MemoryPackable(GenerateType.Object)]
public class HeroUnlockGiftResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<HeroUnlockGiftResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class HeroUnlockGiftResponseFormatter : MemoryPackFormatter<HeroUnlockGiftResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref HeroUnlockGiftResponse value)
		{
			HeroUnlockGiftResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref HeroUnlockGiftResponse value)
		{
			HeroUnlockGiftResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int Success { get; set; }

	[MemoryPackOrder(1)]
	public int GiftId { get; set; }

	public static HeroUnlockGiftResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(HeroUnlockGiftResponse)) as HeroUnlockGiftResponse;
		}
		return new HeroUnlockGiftResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Success = 0;
			GiftId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static HeroUnlockGiftResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HeroUnlockGiftResponse>())
		{
			MemoryPackFormatterProvider.Register(new HeroUnlockGiftResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<HeroUnlockGiftResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<HeroUnlockGiftResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref HeroUnlockGiftResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(6, value.IsFromPool, value.Success, value.GiftId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref HeroUnlockGiftResponse? value)
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
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Success;
				value4 = value.GiftId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014b;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(HeroUnlockGiftResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Success;
				value4 = value.GiftId;
				value5 = value.RpcId;
				value6 = value.Error;
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
				goto IL_014b;
			}
		}
		value = new HeroUnlockGiftResponse
		{
			IsFromPool = value2,
			Success = value3,
			GiftId = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014b:
		value.IsFromPool = value2;
		value.Success = value3;
		value.GiftId = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

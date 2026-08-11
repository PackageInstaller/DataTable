using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10165)]
[MemoryPackable(GenerateType.Object)]
public class H2C_GetCurrencyDataResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_GetCurrencyDataResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_GetCurrencyDataResponseFormatter : MemoryPackFormatter<H2C_GetCurrencyDataResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_GetCurrencyDataResponse value)
		{
			H2C_GetCurrencyDataResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_GetCurrencyDataResponse value)
		{
			H2C_GetCurrencyDataResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long Gold { get; set; }

	[MemoryPackOrder(1)]
	public long Diamond { get; set; }

	public static H2C_GetCurrencyDataResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_GetCurrencyDataResponse)) as H2C_GetCurrencyDataResponse;
		}
		return new H2C_GetCurrencyDataResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Gold = 0L;
			Diamond = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_GetCurrencyDataResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetCurrencyDataResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_GetCurrencyDataResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetCurrencyDataResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_GetCurrencyDataResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_GetCurrencyDataResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, int>(6, value.IsFromPool, value.Gold, value.Diamond, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_GetCurrencyDataResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Gold;
				value4 = value.Diamond;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014d;
			}
			reader.ReadUnmanaged<bool, long, long, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_GetCurrencyDataResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Gold;
				value4 = value.Diamond;
				value5 = value.RpcId;
				value6 = value.Error;
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
				goto IL_014d;
			}
		}
		value = new H2C_GetCurrencyDataResponse
		{
			IsFromPool = value2,
			Gold = value3,
			Diamond = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014d:
		value.IsFromPool = value2;
		value.Gold = value3;
		value.Diamond = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

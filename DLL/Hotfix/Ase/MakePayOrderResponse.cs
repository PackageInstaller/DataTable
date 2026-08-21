using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10791)]
[MemoryPackable(GenerateType.Object)]
public class MakePayOrderResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<MakePayOrderResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MakePayOrderResponseFormatter : MemoryPackFormatter<MakePayOrderResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MakePayOrderResponse value)
		{
			MakePayOrderResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MakePayOrderResponse value)
		{
			MakePayOrderResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public string GameOrderId { get; set; }

	[MemoryPackOrder(1)]
	public string OrderSign { get; set; }

	public static MakePayOrderResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MakePayOrderResponse)) as MakePayOrderResponse;
		}
		return new MakePayOrderResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			GameOrderId = null;
			OrderSign = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MakePayOrderResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MakePayOrderResponse>())
		{
			MemoryPackFormatterProvider.Register(new MakePayOrderResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MakePayOrderResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MakePayOrderResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MakePayOrderResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteString(value.GameOrderId);
		writer.WriteString(value.OrderSign);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MakePayOrderResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		string gameOrderId;
		string orderSign;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				gameOrderId = value.GameOrderId;
				orderSign = value.OrderSign;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				gameOrderId = reader.ReadString();
				orderSign = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				message = reader.ReadString();
				goto IL_0157;
			}
			reader.ReadUnmanaged<bool>(out value2);
			gameOrderId = reader.ReadString();
			orderSign = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value3, out value4);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MakePayOrderResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				gameOrderId = null;
				orderSign = null;
				value3 = 0;
				value4 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				gameOrderId = value.GameOrderId;
				orderSign = value.OrderSign;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					gameOrderId = reader.ReadString();
					if (memberCount != 2)
					{
						orderSign = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value3);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value4);
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
		value = new MakePayOrderResponse
		{
			IsFromPool = value2,
			GameOrderId = gameOrderId,
			OrderSign = orderSign,
			RpcId = value3,
			Error = value4,
			Message = message
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.GameOrderId = gameOrderId;
		value.OrderSign = orderSign;
		value.RpcId = value3;
		value.Error = value4;
		value.Message = message;
	}
}

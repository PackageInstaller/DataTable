using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10746)]
[MemoryPackable(GenerateType.Object)]
public class PropWholeApartExchangeResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<PropWholeApartExchangeResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PropWholeApartExchangeResponseFormatter : MemoryPackFormatter<PropWholeApartExchangeResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PropWholeApartExchangeResponse value)
		{
			PropWholeApartExchangeResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PropWholeApartExchangeResponse value)
		{
			PropWholeApartExchangeResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbItemChange CostItem { get; set; }

	[MemoryPackOrder(1)]
	public PbItemChange GetItem { get; set; }

	public static PropWholeApartExchangeResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PropWholeApartExchangeResponse)) as PropWholeApartExchangeResponse;
		}
		return new PropWholeApartExchangeResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			CostItem = null;
			GetItem = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PropWholeApartExchangeResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PropWholeApartExchangeResponse>())
		{
			MemoryPackFormatterProvider.Register(new PropWholeApartExchangeResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PropWholeApartExchangeResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PropWholeApartExchangeResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PropWholeApartExchangeResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbItemChange>(value.CostItem);
		writer.WritePackable<PbItemChange>(value.GetItem);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PropWholeApartExchangeResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbItemChange value3;
		PbItemChange value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CostItem;
				value4 = value.GetItem;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbItemChange>();
			value4 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PropWholeApartExchangeResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CostItem;
				value4 = value.GetItem;
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
						reader.ReadPackable(ref value4);
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
				goto IL_015b;
			}
		}
		value = new PropWholeApartExchangeResponse
		{
			IsFromPool = value2,
			CostItem = value3,
			GetItem = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.CostItem = value3;
		value.GetItem = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

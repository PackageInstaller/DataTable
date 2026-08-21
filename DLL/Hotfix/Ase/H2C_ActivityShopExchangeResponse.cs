using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10837)]
[MemoryPackable(GenerateType.Object)]
public class H2C_ActivityShopExchangeResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_ActivityShopExchangeResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_ActivityShopExchangeResponseFormatter : MemoryPackFormatter<H2C_ActivityShopExchangeResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_ActivityShopExchangeResponse value)
		{
			H2C_ActivityShopExchangeResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_ActivityShopExchangeResponse value)
		{
			H2C_ActivityShopExchangeResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbItemChange> ItemChange { get; set; } = new List<PbItemChange>();

	[MemoryPackOrder(1)]
	public List<PbEquipBase> EquipChange { get; set; } = new List<PbEquipBase>();

	public static H2C_ActivityShopExchangeResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_ActivityShopExchangeResponse)) as H2C_ActivityShopExchangeResponse;
		}
		return new H2C_ActivityShopExchangeResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ItemChange.Clear();
			EquipChange.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_ActivityShopExchangeResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_ActivityShopExchangeResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_ActivityShopExchangeResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_ActivityShopExchangeResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_ActivityShopExchangeResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_ActivityShopExchangeResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.ItemChange));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.EquipChange));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_ActivityShopExchangeResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbItemChange> value3;
		List<PbEquipBase> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ItemChange;
				value4 = value.EquipChange;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_ActivityShopExchangeResponse), 6, memberCount);
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
				value3 = value.ItemChange;
				value4 = value.EquipChange;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
		value = new H2C_ActivityShopExchangeResponse
		{
			IsFromPool = value2,
			ItemChange = value3,
			EquipChange = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.ItemChange = value3;
		value.EquipChange = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}

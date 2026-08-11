using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10195)]
[MemoryPackable(GenerateType.Object)]
public class S2C_StarUpEquipmentResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_StarUpEquipmentResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_StarUpEquipmentResponseFormatter : MemoryPackFormatter<S2C_StarUpEquipmentResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_StarUpEquipmentResponse value)
		{
			S2C_StarUpEquipmentResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_StarUpEquipmentResponse value)
		{
			S2C_StarUpEquipmentResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbEquipBase Equip { get; set; }

	[MemoryPackOrder(1)]
	public int GoldCost { get; set; }

	[MemoryPackOrder(2)]
	public List<PbItemChange> ItemChange { get; set; } = new List<PbItemChange>();

	public static S2C_StarUpEquipmentResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_StarUpEquipmentResponse)) as S2C_StarUpEquipmentResponse;
		}
		return new S2C_StarUpEquipmentResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Equip = null;
			GoldCost = 0;
			ItemChange.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_StarUpEquipmentResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_StarUpEquipmentResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_StarUpEquipmentResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_StarUpEquipmentResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_StarUpEquipmentResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_StarUpEquipmentResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbEquipBase>(value.Equip);
		writer.WriteUnmanaged<int>(value.GoldCost);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.ItemChange));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_StarUpEquipmentResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbEquipBase value3;
		int value4;
		List<PbItemChange> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Equip;
				value4 = value.GoldCost;
				value5 = value.ItemChange;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018d;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbEquipBase>();
			reader.ReadUnmanaged<int>(out value4);
			value5 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_StarUpEquipmentResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Equip;
				value4 = value.GoldCost;
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
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
				goto IL_018d;
			}
		}
		value = new S2C_StarUpEquipmentResponse
		{
			IsFromPool = value2,
			Equip = value3,
			GoldCost = value4,
			ItemChange = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018d:
		value.IsFromPool = value2;
		value.Equip = value3;
		value.GoldCost = value4;
		value.ItemChange = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

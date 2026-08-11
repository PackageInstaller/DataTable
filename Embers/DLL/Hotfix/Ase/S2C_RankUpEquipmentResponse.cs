using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10197)]
[MemoryPackable(GenerateType.Object)]
public class S2C_RankUpEquipmentResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_RankUpEquipmentResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_RankUpEquipmentResponseFormatter : MemoryPackFormatter<S2C_RankUpEquipmentResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_RankUpEquipmentResponse value)
		{
			S2C_RankUpEquipmentResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_RankUpEquipmentResponse value)
		{
			S2C_RankUpEquipmentResponse.Deserialize(ref reader, ref value);
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
	public List<PbEquipBase> EquipChange { get; set; } = new List<PbEquipBase>();

	[MemoryPackOrder(2)]
	public int GoldCost { get; set; }

	public static S2C_RankUpEquipmentResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_RankUpEquipmentResponse)) as S2C_RankUpEquipmentResponse;
		}
		return new S2C_RankUpEquipmentResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Equip = null;
			EquipChange.Clear();
			GoldCost = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_RankUpEquipmentResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_RankUpEquipmentResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_RankUpEquipmentResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_RankUpEquipmentResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_RankUpEquipmentResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_RankUpEquipmentResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbEquipBase>(value.Equip);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.EquipChange));
		writer.WriteUnmanaged<int, int, int>(value.GoldCost, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_RankUpEquipmentResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbEquipBase value3;
		List<PbEquipBase> value4;
		int value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Equip;
				value4 = value.EquipChange;
				value5 = value.GoldCost;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0186;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbEquipBase>();
			value4 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_RankUpEquipmentResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Equip;
				value4 = value.EquipChange;
				value5 = value.GoldCost;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
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
				goto IL_0186;
			}
		}
		value = new S2C_RankUpEquipmentResponse
		{
			IsFromPool = value2,
			Equip = value3,
			EquipChange = value4,
			GoldCost = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0186:
		value.IsFromPool = value2;
		value.Equip = value3;
		value.EquipChange = value4;
		value.GoldCost = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

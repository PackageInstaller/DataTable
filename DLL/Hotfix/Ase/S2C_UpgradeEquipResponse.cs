using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10073)]
[MemoryPackable(GenerateType.Object)]
public class S2C_UpgradeEquipResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_UpgradeEquipResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_UpgradeEquipResponseFormatter : MemoryPackFormatter<S2C_UpgradeEquipResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_UpgradeEquipResponse value)
		{
			S2C_UpgradeEquipResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_UpgradeEquipResponse value)
		{
			S2C_UpgradeEquipResponse.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(2)]
	public long GoldCost { get; set; }

	[MemoryPackOrder(3)]
	public List<PbItemChange> ItemChange { get; set; } = new List<PbItemChange>();

	[MemoryPackOrder(4)]
	public List<PbEquipBase> EquipChange { get; set; } = new List<PbEquipBase>();

	public static S2C_UpgradeEquipResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_UpgradeEquipResponse)) as S2C_UpgradeEquipResponse;
		}
		return new S2C_UpgradeEquipResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Equip = null;
			GoldCost = 0L;
			ItemChange.Clear();
			EquipChange.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_UpgradeEquipResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_UpgradeEquipResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_UpgradeEquipResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_UpgradeEquipResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_UpgradeEquipResponse>());
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
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_UpgradeEquipResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WritePackable<PbEquipBase>(value.Equip);
		writer.WriteUnmanaged<long>(value.GoldCost);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.ItemChange));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.EquipChange));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_UpgradeEquipResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbEquipBase value3;
		long value4;
		List<PbItemChange> value5;
		List<PbEquipBase> value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Equip;
				value4 = value.GoldCost;
				value5 = value.ItemChange;
				value6 = value.EquipChange;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01bf;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbEquipBase>();
			reader.ReadUnmanaged<long>(out value4);
			value5 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			value6 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_UpgradeEquipResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Equip;
				value4 = value.GoldCost;
				value5 = value.ItemChange;
				value6 = value.EquipChange;
				value7 = value.RpcId;
				value8 = value.Error;
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
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
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
				goto IL_01bf;
			}
		}
		value = new S2C_UpgradeEquipResponse
		{
			IsFromPool = value2,
			Equip = value3,
			GoldCost = value4,
			ItemChange = value5,
			EquipChange = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01bf:
		value.IsFromPool = value2;
		value.Equip = value3;
		value.GoldCost = value4;
		value.ItemChange = value5;
		value.EquipChange = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}

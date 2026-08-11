using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10072)]
[MemoryPackable(GenerateType.Object)]
public class C2S_UpgradeEquipRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_UpgradeEquipRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_UpgradeEquipRequestFormatter : MemoryPackFormatter<C2S_UpgradeEquipRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_UpgradeEquipRequest value)
		{
			C2S_UpgradeEquipRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_UpgradeEquipRequest value)
		{
			C2S_UpgradeEquipRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int EquipId { get; set; }

	[MemoryPackOrder(1)]
	public long EquipUuid { get; set; }

	[MemoryPackOrder(2)]
	public int EquipType { get; set; }

	[MemoryPackOrder(3)]
	public List<PbItemBase> Items { get; set; } = new List<PbItemBase>();

	[MemoryPackOrder(4)]
	public List<long> Equips { get; set; } = new List<long>();

	[MemoryPackOrder(5)]
	public int SelectGold { get; set; }

	public static C2S_UpgradeEquipRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_UpgradeEquipRequest)) as C2S_UpgradeEquipRequest;
		}
		return new C2S_UpgradeEquipRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			EquipId = 0;
			EquipUuid = 0L;
			EquipType = 0;
			Items.Clear();
			Equips.Clear();
			SelectGold = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_UpgradeEquipRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_UpgradeEquipRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2S_UpgradeEquipRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_UpgradeEquipRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_UpgradeEquipRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemBase>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_UpgradeEquipRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long, int>(11, value.IsFromPool, value.EquipId, value.EquipUuid, value.EquipType);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemBase>>(value.Items));
		writer.WriteValue<List<long>>(value.Equips);
		writer.WriteUnmanaged<int, int, long, int, long>(value.SelectGold, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_UpgradeEquipRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		List<PbItemBase> value6;
		List<long> value7;
		int value8;
		int value9;
		long value10;
		int value11;
		long value12;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EquipId;
				value4 = value.EquipUuid;
				value5 = value.EquipType;
				value6 = value.Items;
				value7 = value.Equips;
				value8 = value.SelectGold;
				value9 = value.LoginServerId;
				value10 = value.LoginSecretKey;
				value11 = value.RpcId;
				value12 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadValue(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<long>(out value12);
				goto IL_023a;
			}
			reader.ReadUnmanaged<bool, int, long, int>(out value2, out value3, out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbItemBase>(ref reader);
			value7 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, int, long, int, long>(out value8, out value9, out value10, out value11, out value12);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_UpgradeEquipRequest), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = null;
				value7 = null;
				value8 = 0;
				value9 = 0;
				value10 = 0L;
				value11 = 0;
				value12 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EquipId;
				value4 = value.EquipUuid;
				value5 = value.EquipType;
				value6 = value.Items;
				value7 = value.Equips;
				value8 = value.SelectGold;
				value9 = value.LoginServerId;
				value10 = value.LoginSecretKey;
				value11 = value.RpcId;
				value12 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadValue(ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value12);
														_ = 11;
													}
												}
											}
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
				goto IL_023a;
			}
		}
		value = new C2S_UpgradeEquipRequest
		{
			IsFromPool = value2,
			EquipId = value3,
			EquipUuid = value4,
			EquipType = value5,
			Items = value6,
			Equips = value7,
			SelectGold = value8,
			LoginServerId = value9,
			LoginSecretKey = value10,
			RpcId = value11,
			ActorId = value12
		};
		return;
		IL_023a:
		value.IsFromPool = value2;
		value.EquipId = value3;
		value.EquipUuid = value4;
		value.EquipType = value5;
		value.Items = value6;
		value.Equips = value7;
		value.SelectGold = value8;
		value.LoginServerId = value9;
		value.LoginSecretKey = value10;
		value.RpcId = value11;
		value.ActorId = value12;
	}
}

using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10875)]
[MemoryPackable(GenerateType.Object)]
public class C2H_MakeCustomEquipment : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_MakeCustomEquipment>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_MakeCustomEquipmentFormatter : MemoryPackFormatter<C2H_MakeCustomEquipment>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_MakeCustomEquipment value)
		{
			C2H_MakeCustomEquipment.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_MakeCustomEquipment value)
		{
			C2H_MakeCustomEquipment.Deserialize(ref reader, ref value);
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
	public int UsedItemId { get; set; }

	[MemoryPackOrder(1)]
	public int EquipmentId { get; set; }

	[MemoryPackOrder(2)]
	public int MainAttributeId { get; set; }

	[MemoryPackOrder(3)]
	public List<int> SubAttributeIds { get; set; } = new List<int>();

	public static C2H_MakeCustomEquipment Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_MakeCustomEquipment)) as C2H_MakeCustomEquipment;
		}
		return new C2H_MakeCustomEquipment();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UsedItemId = 0;
			EquipmentId = 0;
			MainAttributeId = 0;
			SubAttributeIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_MakeCustomEquipment()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_MakeCustomEquipment>())
		{
			MemoryPackFormatterProvider.Register(new C2H_MakeCustomEquipmentFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_MakeCustomEquipment[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_MakeCustomEquipment>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_MakeCustomEquipment? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(9, value.IsFromPool, value.UsedItemId, value.EquipmentId, value.MainAttributeId);
		writer.WriteValue<List<int>>(value.SubAttributeIds);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_MakeCustomEquipment? value)
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
		List<int> value6;
		int value7;
		long value8;
		int value9;
		long value10;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UsedItemId;
				value4 = value.EquipmentId;
				value5 = value.MainAttributeId;
				value6 = value.SubAttributeIds;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadValue(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01d8;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			value6 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, long, int, long>(out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_MakeCustomEquipment), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UsedItemId;
				value4 = value.EquipmentId;
				value5 = value.MainAttributeId;
				value6 = value.SubAttributeIds;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
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
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												_ = 9;
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
				goto IL_01d8;
			}
		}
		value = new C2H_MakeCustomEquipment
		{
			IsFromPool = value2,
			UsedItemId = value3,
			EquipmentId = value4,
			MainAttributeId = value5,
			SubAttributeIds = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_01d8:
		value.IsFromPool = value2;
		value.UsedItemId = value3;
		value.EquipmentId = value4;
		value.MainAttributeId = value5;
		value.SubAttributeIds = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}

using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10342)]
[MemoryPackable(GenerateType.Object)]
public class AddEquipmentListNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<AddEquipmentListNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class AddEquipmentListNotifyFormatter : MemoryPackFormatter<AddEquipmentListNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref AddEquipmentListNotify value)
		{
			AddEquipmentListNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref AddEquipmentListNotify value)
		{
			AddEquipmentListNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbEquipBase> Equipments { get; set; } = new List<PbEquipBase>();

	public static AddEquipmentListNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(AddEquipmentListNotify)) as AddEquipmentListNotify;
		}
		return new AddEquipmentListNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Equipments.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static AddEquipmentListNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<AddEquipmentListNotify>())
		{
			MemoryPackFormatterProvider.Register(new AddEquipmentListNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<AddEquipmentListNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<AddEquipmentListNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref AddEquipmentListNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.Equipments));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref AddEquipmentListNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbEquipBase> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Equipments;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(AddEquipmentListNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Equipments;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new AddEquipmentListNotify
		{
			IsFromPool = value2,
			Equipments = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.Equipments = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}

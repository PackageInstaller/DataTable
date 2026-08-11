using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5008)]
[MemoryPackable(GenerateType.Object)]
public class M2C_CreateUnits : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<M2C_CreateUnits>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2C_CreateUnitsFormatter : MemoryPackFormatter<M2C_CreateUnits>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2C_CreateUnits value)
		{
			M2C_CreateUnits.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2C_CreateUnits value)
		{
			M2C_CreateUnits.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<UnitInfo> Units { get; set; } = new List<UnitInfo>();

	public static M2C_CreateUnits Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2C_CreateUnits)) as M2C_CreateUnits;
		}
		return new M2C_CreateUnits();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Units.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2C_CreateUnits()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_CreateUnits>())
		{
			MemoryPackFormatterProvider.Register(new M2C_CreateUnitsFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_CreateUnits[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2C_CreateUnits>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<UnitInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<UnitInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2C_CreateUnits? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<UnitInfo>>(value.Units));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2C_CreateUnits? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<UnitInfo> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Units;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<UnitInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2C_CreateUnits), 4, memberCount);
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
				value3 = value.Units;
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
		value = new M2C_CreateUnits
		{
			IsFromPool = value2,
			Units = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.Units = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1019)]
[MemoryPackable(GenerateType.Object)]
public class G2M_CreateUnit : MessageObject, IRequest, IMessage, IMemoryPackable<G2M_CreateUnit>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2M_CreateUnitFormatter : MemoryPackFormatter<G2M_CreateUnit>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2M_CreateUnit value)
		{
			G2M_CreateUnit.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2M_CreateUnit value)
		{
			G2M_CreateUnit.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long PlayerId { get; set; }

	[MemoryPackOrder(1)]
	public long GateSessionId { get; set; }

	[MemoryPackOrder(2)]
	public long BattleFieldRoomId { get; set; }

	[MemoryPackOrder(3)]
	public long UnitId { get; set; }

	public static G2M_CreateUnit Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2M_CreateUnit)) as G2M_CreateUnit;
		}
		return new G2M_CreateUnit();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			PlayerId = 0L;
			GateSessionId = 0L;
			BattleFieldRoomId = 0L;
			UnitId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2M_CreateUnit()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2M_CreateUnit>())
		{
			MemoryPackFormatterProvider.Register(new G2M_CreateUnitFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2M_CreateUnit[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2M_CreateUnit>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2M_CreateUnit? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, long, long, int>(6, value.IsFromPool, value.PlayerId, value.GateSessionId, value.BattleFieldRoomId, value.UnitId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2M_CreateUnit? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		long value5;
		long value6;
		int value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerId;
				value4 = value.GateSessionId;
				value5 = value.BattleFieldRoomId;
				value6 = value.UnitId;
				value7 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_0149;
			}
			reader.ReadUnmanaged<bool, long, long, long, long, int>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2M_CreateUnit), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0L;
				value6 = 0L;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerId;
				value4 = value.GateSessionId;
				value5 = value.BattleFieldRoomId;
				value6 = value.UnitId;
				value7 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0149;
			}
		}
		value = new G2M_CreateUnit
		{
			IsFromPool = value2,
			PlayerId = value3,
			GateSessionId = value4,
			BattleFieldRoomId = value5,
			UnitId = value6,
			RpcId = value7
		};
		return;
		IL_0149:
		value.IsFromPool = value2;
		value.PlayerId = value3;
		value.GateSessionId = value4;
		value.BattleFieldRoomId = value5;
		value.UnitId = value6;
		value.RpcId = value7;
	}
}

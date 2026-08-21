using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10771)]
[MemoryPackable(GenerateType.Object)]
public class BattleChangeBattlePropNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<BattleChangeBattlePropNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleChangeBattlePropNotifyFormatter : MemoryPackFormatter<BattleChangeBattlePropNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleChangeBattlePropNotify value)
		{
			BattleChangeBattlePropNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleChangeBattlePropNotify value)
		{
			BattleChangeBattlePropNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbRoomBattlePropInfo> NewBattleProps { get; set; } = new List<PbRoomBattlePropInfo>();

	public static BattleChangeBattlePropNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleChangeBattlePropNotify)) as BattleChangeBattlePropNotify;
		}
		return new BattleChangeBattlePropNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			NewBattleProps.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleChangeBattlePropNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleChangeBattlePropNotify>())
		{
			MemoryPackFormatterProvider.Register(new BattleChangeBattlePropNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleChangeBattlePropNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleChangeBattlePropNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRoomBattlePropInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRoomBattlePropInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleChangeBattlePropNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.UserId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoomBattlePropInfo>>(value.NewBattleProps));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleChangeBattlePropNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbRoomBattlePropInfo> value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.NewBattleProps;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbRoomBattlePropInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleChangeBattlePropNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.NewBattleProps;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0124;
			}
		}
		value = new BattleChangeBattlePropNotify
		{
			IsFromPool = value2,
			UserId = value3,
			NewBattleProps = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.NewBattleProps = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}

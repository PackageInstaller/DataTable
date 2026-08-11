using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10152)]
[MemoryPackable(GenerateType.Object)]
public class BattleFieldSettleNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<BattleFieldSettleNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleFieldSettleNotifyFormatter : MemoryPackFormatter<BattleFieldSettleNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleFieldSettleNotify value)
		{
			BattleFieldSettleNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleFieldSettleNotify value)
		{
			BattleFieldSettleNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int PassTime { get; set; }

	[MemoryPackOrder(1)]
	public int Star { get; set; }

	[MemoryPackOrder(2)]
	public PbDropThing PassRewards { get; set; }

	[MemoryPackOrder(3)]
	public PbDropThing StarRewards { get; set; }

	[MemoryPackOrder(4)]
	public List<PbNormalRoleInfo> Roles { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(5)]
	public int AccountLevel { get; set; }

	[MemoryPackOrder(6)]
	public long AccountExp { get; set; }

	public static BattleFieldSettleNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleFieldSettleNotify)) as BattleFieldSettleNotify;
		}
		return new BattleFieldSettleNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			PassTime = 0;
			Star = 0;
			PassRewards = null;
			StarRewards = null;
			Roles.Clear();
			AccountLevel = 0;
			AccountExp = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleFieldSettleNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldSettleNotify>())
		{
			MemoryPackFormatterProvider.Register(new BattleFieldSettleNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldSettleNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleFieldSettleNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleFieldSettleNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(10, value.IsFromPool, value.PassTime, value.Star);
		writer.WritePackable<PbDropThing>(value.PassRewards);
		writer.WritePackable<PbDropThing>(value.StarRewards);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.Roles));
		writer.WriteUnmanaged<int, long, int, long>(value.AccountLevel, value.AccountExp, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleFieldSettleNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		PbDropThing value5;
		PbDropThing value6;
		List<PbNormalRoleInfo> value7;
		int value8;
		long value9;
		int value10;
		long value11;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PassTime;
				value4 = value.Star;
				value5 = value.PassRewards;
				value6 = value.StarRewards;
				value7 = value.Roles;
				value8 = value.AccountLevel;
				value9 = value.AccountExp;
				value10 = value.RpcId;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadPackable(ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_0210;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbDropThing>();
			value6 = reader.ReadPackable<PbDropThing>();
			value7 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			reader.ReadUnmanaged<int, long, int, long>(out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleFieldSettleNotify), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = 0;
				value9 = 0L;
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PassTime;
				value4 = value.Star;
				value5 = value.PassRewards;
				value6 = value.StarRewards;
				value7 = value.Roles;
				value8 = value.AccountLevel;
				value9 = value.AccountExp;
				value10 = value.RpcId;
				value11 = value.ActorId;
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
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value11);
													_ = 10;
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
				goto IL_0210;
			}
		}
		value = new BattleFieldSettleNotify
		{
			IsFromPool = value2,
			PassTime = value3,
			Star = value4,
			PassRewards = value5,
			StarRewards = value6,
			Roles = value7,
			AccountLevel = value8,
			AccountExp = value9,
			RpcId = value10,
			ActorId = value11
		};
		return;
		IL_0210:
		value.IsFromPool = value2;
		value.PassTime = value3;
		value.Star = value4;
		value.PassRewards = value5;
		value.StarRewards = value6;
		value.Roles = value7;
		value.AccountLevel = value8;
		value.AccountExp = value9;
		value.RpcId = value10;
		value.ActorId = value11;
	}
}

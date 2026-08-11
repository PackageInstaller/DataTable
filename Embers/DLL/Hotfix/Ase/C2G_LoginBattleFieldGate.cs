using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10052)]
[MemoryPackable(GenerateType.Object)]
public class C2G_LoginBattleFieldGate : MessageObject, IRequest, IMessage, IMemoryPackable<C2G_LoginBattleFieldGate>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2G_LoginBattleFieldGateFormatter : MemoryPackFormatter<C2G_LoginBattleFieldGate>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2G_LoginBattleFieldGate value)
		{
			C2G_LoginBattleFieldGate.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2G_LoginBattleFieldGate value)
		{
			C2G_LoginBattleFieldGate.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	[MemoryPackOrder(2)]
	public bool ReConnect { get; set; }

	public static C2G_LoginBattleFieldGate Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2G_LoginBattleFieldGate)) as C2G_LoginBattleFieldGate;
		}
		return new C2G_LoginBattleFieldGate();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Key = 0L;
			UserId = 0L;
			ReConnect = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2G_LoginBattleFieldGate()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_LoginBattleFieldGate>())
		{
			MemoryPackFormatterProvider.Register(new C2G_LoginBattleFieldGateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_LoginBattleFieldGate[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2G_LoginBattleFieldGate>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2G_LoginBattleFieldGate? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, bool, int>(5, value.IsFromPool, value.Key, value.UserId, value.ReConnect, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2G_LoginBattleFieldGate? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		bool value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.UserId;
				value5 = value.ReConnect;
				value6 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, long, long, bool, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2G_LoginBattleFieldGate), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = false;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.UserId;
				value5 = value.ReConnect;
				value6 = value.RpcId;
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
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0119;
			}
		}
		value = new C2G_LoginBattleFieldGate
		{
			IsFromPool = value2,
			Key = value3,
			UserId = value4,
			ReConnect = value5,
			RpcId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.Key = value3;
		value.UserId = value4;
		value.ReConnect = value5;
		value.RpcId = value6;
	}
}

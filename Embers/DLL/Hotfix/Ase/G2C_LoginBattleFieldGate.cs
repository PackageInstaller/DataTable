using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10053)]
[MemoryPackable(GenerateType.Object)]
public class G2C_LoginBattleFieldGate : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<G2C_LoginBattleFieldGate>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2C_LoginBattleFieldGateFormatter : MemoryPackFormatter<G2C_LoginBattleFieldGate>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2C_LoginBattleFieldGate value)
		{
			G2C_LoginBattleFieldGate.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2C_LoginBattleFieldGate value)
		{
			G2C_LoginBattleFieldGate.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long PlayerId { get; set; }

	public static G2C_LoginBattleFieldGate Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2C_LoginBattleFieldGate)) as G2C_LoginBattleFieldGate;
		}
		return new G2C_LoginBattleFieldGate();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Error = 0;
			Message = null;
			UserId = 0L;
			PlayerId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2C_LoginBattleFieldGate()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_LoginBattleFieldGate>())
		{
			MemoryPackFormatterProvider.Register(new G2C_LoginBattleFieldGateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_LoginBattleFieldGate[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2C_LoginBattleFieldGate>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2C_LoginBattleFieldGate? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, long, int, int>(9, value.IsFromPool, value.UserId, value.PlayerId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.Error);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2C_LoginBattleFieldGate? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		long value6;
		int value7;
		int value8;
		long value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.PlayerId;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01da;
			}
			reader.ReadUnmanaged<bool, long, long, int, long, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
			message = reader.ReadString();
			reader.ReadUnmanaged<long>(out value9);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2C_LoginBattleFieldGate), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				message = null;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.PlayerId;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				value9 = value.ActorId;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value9);
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
				goto IL_01da;
			}
		}
		value = new G2C_LoginBattleFieldGate
		{
			IsFromPool = value2,
			UserId = value3,
			PlayerId = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			Error = value8,
			Message = message,
			ActorId = value9
		};
		return;
		IL_01da:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.PlayerId = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
		value.ActorId = value9;
	}
}

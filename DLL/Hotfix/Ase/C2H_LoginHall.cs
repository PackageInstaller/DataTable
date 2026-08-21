using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10005)]
[MemoryPackable(GenerateType.Object)]
public class C2H_LoginHall : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_LoginHall>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_LoginHallFormatter : MemoryPackFormatter<C2H_LoginHall>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_LoginHall value)
		{
			C2H_LoginHall.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_LoginHall value)
		{
			C2H_LoginHall.Deserialize(ref reader, ref value);
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
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public string distinctId { get; set; }

	public static C2H_LoginHall Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_LoginHall)) as C2H_LoginHall;
		}
		return new C2H_LoginHall();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Account = null;
			distinctId = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_LoginHall()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_LoginHall>())
		{
			MemoryPackFormatterProvider.Register(new C2H_LoginHallFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_LoginHall[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_LoginHall>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_LoginHall? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteString(value.distinctId);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_LoginHall? value)
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
		long value6;
		string account;
		string text;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				text = value.distinctId;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_017e;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			text = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long>(out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_LoginHall), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				text = null;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				text = value.distinctId;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					account = reader.ReadString();
					if (memberCount != 2)
					{
						text = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value3);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value4);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value6);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_017e;
			}
		}
		value = new C2H_LoginHall
		{
			IsFromPool = value2,
			Account = account,
			distinctId = text,
			LoginServerId = value3,
			LoginSecretKey = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_017e:
		value.IsFromPool = value2;
		value.Account = account;
		value.distinctId = text;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}

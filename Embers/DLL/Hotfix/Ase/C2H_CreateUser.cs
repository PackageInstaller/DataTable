using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10033)]
[MemoryPackable(GenerateType.Object)]
public class C2H_CreateUser : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_CreateUser>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_CreateUserFormatter : MemoryPackFormatter<C2H_CreateUser>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_CreateUser value)
		{
			C2H_CreateUser.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_CreateUser value)
		{
			C2H_CreateUser.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(0)]
	public string Name { get; set; }

	[MemoryPackOrder(1)]
	public string Account { get; set; }

	[MemoryPackOrder(2)]
	public int Gender { get; set; }

	[MemoryPackOrder(3)]
	public string distinctId { get; set; }

	public static C2H_CreateUser Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_CreateUser)) as C2H_CreateUser;
		}
		return new C2H_CreateUser();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Name = null;
			Account = null;
			Gender = 0;
			distinctId = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_CreateUser()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_CreateUser>())
		{
			MemoryPackFormatterProvider.Register(new C2H_CreateUserFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_CreateUser[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_CreateUser>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_CreateUser? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(9, value.IsFromPool);
		writer.WriteString(value.Name);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<int>(value.Gender);
		writer.WriteString(value.distinctId);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_CreateUser? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		int value6;
		long value7;
		string name;
		string account;
		string text;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				name = value.Name;
				account = value.Account;
				value3 = value.Gender;
				text = value.distinctId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				name = reader.ReadString();
				account = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_01e4;
			}
			reader.ReadUnmanaged<bool>(out value2);
			name = reader.ReadString();
			account = reader.ReadString();
			reader.ReadUnmanaged<int>(out value3);
			text = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long>(out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_CreateUser), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				name = null;
				account = null;
				value3 = 0;
				text = null;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				name = value.Name;
				account = value.Account;
				value3 = value.Gender;
				text = value.distinctId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					name = reader.ReadString();
					if (memberCount != 2)
					{
						account = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value3);
							if (memberCount != 4)
							{
								text = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value4);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value5);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value6);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value7);
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
				goto IL_01e4;
			}
		}
		value = new C2H_CreateUser
		{
			IsFromPool = value2,
			Name = name,
			Account = account,
			Gender = value3,
			distinctId = text,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_01e4:
		value.IsFromPool = value2;
		value.Name = name;
		value.Account = account;
		value.Gender = value3;
		value.distinctId = text;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}

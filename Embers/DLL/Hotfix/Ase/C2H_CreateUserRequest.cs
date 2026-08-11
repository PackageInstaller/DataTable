using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10003)]
[MemoryPackable(GenerateType.Object)]
public class C2H_CreateUserRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_CreateUserRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_CreateUserRequestFormatter : MemoryPackFormatter<C2H_CreateUserRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_CreateUserRequest value)
		{
			C2H_CreateUserRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_CreateUserRequest value)
		{
			C2H_CreateUserRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(2)]
	public long Key { get; set; }

	[MemoryPackOrder(3)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	[MemoryPackOrder(2)]
	public int Gender { get; set; }

	public static C2H_CreateUserRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_CreateUserRequest)) as C2H_CreateUserRequest;
		}
		return new C2H_CreateUserRequest();
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
			Key = 0L;
			UserId = 0L;
			Name = null;
			Gender = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_CreateUserRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_CreateUserRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2H_CreateUserRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_CreateUserRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_CreateUserRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_CreateUserRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<long, int, long, int, long, int, long>(value.Key, value.Gender, value.UserId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_CreateUserRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		int value6;
		long value7;
		int value8;
		long value9;
		string account;
		string name;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				name = value.Name;
				value3 = value.Key;
				value4 = value.Gender;
				value5 = value.UserId;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				name = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_0206;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			name = reader.ReadString();
			reader.ReadUnmanaged<long, int, long, int, long, int, long>(out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_CreateUserRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				name = null;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				name = value.Name;
				value3 = value.Key;
				value4 = value.Gender;
				value5 = value.UserId;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					account = reader.ReadString();
					if (memberCount != 2)
					{
						name = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value3);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value4);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value6);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value7);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value8);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value9);
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
				goto IL_0206;
			}
		}
		value = new C2H_CreateUserRequest
		{
			IsFromPool = value2,
			Account = account,
			Name = name,
			Key = value3,
			Gender = value4,
			UserId = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_0206:
		value.IsFromPool = value2;
		value.Account = account;
		value.Name = name;
		value.Key = value3;
		value.Gender = value4;
		value.UserId = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}

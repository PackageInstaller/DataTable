using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(50002)]
[MemoryPackable(GenerateType.Object)]
public class R2C_Login : MessageObject, IResponse, IMessage, IMemoryPackable<R2C_Login>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class R2C_LoginFormatter : MemoryPackFormatter<R2C_Login>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref R2C_Login value)
		{
			R2C_Login.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref R2C_Login value)
		{
			R2C_Login.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public string Address { get; set; }

	[MemoryPackOrder(1)]
	public long Key { get; set; }

	[MemoryPackOrder(2)]
	public long UserId { get; set; }

	[MemoryPackOrder(3)]
	public int IsRealName { get; set; }

	[MemoryPackOrder(4)]
	public string Token { get; set; }

	[MemoryPackOrder(5)]
	public string Account { get; set; }

	public static R2C_Login Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(R2C_Login)) as R2C_Login;
		}
		return new R2C_Login();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Address = null;
			Key = 0L;
			UserId = 0L;
			IsRealName = 0;
			Token = null;
			Account = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static R2C_Login()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<R2C_Login>())
		{
			MemoryPackFormatterProvider.Register(new R2C_LoginFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<R2C_Login[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<R2C_Login>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref R2C_Login? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		writer.WriteString(value.Address);
		writer.WriteUnmanaged<long, long, int>(value.Key, value.UserId, value.IsRealName);
		writer.WriteString(value.Token);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref R2C_Login? value)
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
		int value6;
		int value7;
		string address;
		string token;
		string account;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				address = value.Address;
				value3 = value.Key;
				value4 = value.UserId;
				value5 = value.IsRealName;
				token = value.Token;
				account = value.Account;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				address = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				token = reader.ReadString();
				account = reader.ReadString();
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0219;
			}
			reader.ReadUnmanaged<bool>(out value2);
			address = reader.ReadString();
			reader.ReadUnmanaged<long, long, int>(out value3, out value4, out value5);
			token = reader.ReadString();
			account = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(R2C_Login), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				address = null;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				token = null;
				account = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				address = value.Address;
				value3 = value.Key;
				value4 = value.UserId;
				value5 = value.IsRealName;
				token = value.Token;
				account = value.Account;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					address = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									token = reader.ReadString();
									if (memberCount != 6)
									{
										account = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value6);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value7);
												if (memberCount != 9)
												{
													message = reader.ReadString();
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
				goto IL_0219;
			}
		}
		value = new R2C_Login
		{
			IsFromPool = value2,
			Address = address,
			Key = value3,
			UserId = value4,
			IsRealName = value5,
			Token = token,
			Account = account,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0219:
		value.IsFromPool = value2;
		value.Address = address;
		value.Key = value3;
		value.UserId = value4;
		value.IsRealName = value5;
		value.Token = token;
		value.Account = account;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}

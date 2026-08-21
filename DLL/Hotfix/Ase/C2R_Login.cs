using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(50001)]
[MemoryPackable(GenerateType.Object)]
public class C2R_Login : MessageObject, IRequest, IMessage, IMemoryPackable<C2R_Login>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2R_LoginFormatter : MemoryPackFormatter<C2R_Login>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2R_Login value)
		{
			C2R_Login.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2R_Login value)
		{
			C2R_Login.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public string Password { get; set; }

	[MemoryPackOrder(2)]
	public string Token { get; set; }

	public static C2R_Login Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2R_Login)) as C2R_Login;
		}
		return new C2R_Login();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Account = null;
			Password = null;
			Token = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2R_Login()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2R_Login>())
		{
			MemoryPackFormatterProvider.Register(new C2R_LoginFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2R_Login[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2R_Login>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2R_Login? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteString(value.Password);
		writer.WriteString(value.Token);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2R_Login? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		string account;
		string password;
		string token;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				password = value.Password;
				token = value.Token;
				value3 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				password = reader.ReadString();
				token = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				goto IL_012c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			password = reader.ReadString();
			token = reader.ReadString();
			reader.ReadUnmanaged<int>(out value3);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2R_Login), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				password = null;
				token = null;
				value3 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				password = value.Password;
				token = value.Token;
				value3 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					account = reader.ReadString();
					if (memberCount != 2)
					{
						password = reader.ReadString();
						if (memberCount != 3)
						{
							token = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value3);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_012c;
			}
		}
		value = new C2R_Login
		{
			IsFromPool = value2,
			Account = account,
			Password = password,
			Token = token,
			RpcId = value3
		};
		return;
		IL_012c:
		value.IsFromPool = value2;
		value.Account = account;
		value.Password = password;
		value.Token = token;
		value.RpcId = value3;
	}
}

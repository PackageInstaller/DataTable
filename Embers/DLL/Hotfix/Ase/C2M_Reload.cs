using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5014)]
[MemoryPackable(GenerateType.Object)]
public class C2M_Reload : MessageObject, IRequest, IMessage, IMemoryPackable<C2M_Reload>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2M_ReloadFormatter : MemoryPackFormatter<C2M_Reload>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2M_Reload value)
		{
			C2M_Reload.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2M_Reload value)
		{
			C2M_Reload.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public string Password { get; set; }

	[MemoryPackOrder(2)]
	public int Typ { get; set; }

	public static C2M_Reload Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2M_Reload)) as C2M_Reload;
		}
		return new C2M_Reload();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Account = null;
			Password = null;
			Typ = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2M_Reload()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_Reload>())
		{
			MemoryPackFormatterProvider.Register(new C2M_ReloadFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_Reload[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2M_Reload>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2M_Reload? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteString(value.Password);
		writer.WriteUnmanaged<int, int>(value.Typ, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2M_Reload? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		string account;
		string password;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				password = value.Password;
				value3 = value.Typ;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				password = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			password = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value3, out value4);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2M_Reload), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				password = null;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				password = value.Password;
				value3 = value.Typ;
				value4 = value.RpcId;
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
							reader.ReadUnmanaged<int>(out value3);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value4);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0123;
			}
		}
		value = new C2M_Reload
		{
			IsFromPool = value2,
			Account = account,
			Password = password,
			Typ = value3,
			RpcId = value4
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.Account = account;
		value.Password = password;
		value.Typ = value3;
		value.RpcId = value4;
	}
}

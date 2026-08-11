using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1034)]
[MemoryPackable(GenerateType.Object)]
public class G2H_CreateUserRequest : MessageObject, IRequest, IMessage, IMemoryPackable<G2H_CreateUserRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2H_CreateUserRequestFormatter : MemoryPackFormatter<G2H_CreateUserRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2H_CreateUserRequest value)
		{
			G2H_CreateUserRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2H_CreateUserRequest value)
		{
			G2H_CreateUserRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public string Name { get; set; }

	[MemoryPackOrder(1)]
	public string Account { get; set; }

	public static G2H_CreateUserRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2H_CreateUserRequest)) as G2H_CreateUserRequest;
		}
		return new G2H_CreateUserRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Name = null;
			Account = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2H_CreateUserRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2H_CreateUserRequest>())
		{
			MemoryPackFormatterProvider.Register(new G2H_CreateUserRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2H_CreateUserRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2H_CreateUserRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2H_CreateUserRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WriteString(value.Name);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2H_CreateUserRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		string name;
		string account;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				name = value.Name;
				account = value.Account;
				value3 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				name = reader.ReadString();
				account = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			name = reader.ReadString();
			account = reader.ReadString();
			reader.ReadUnmanaged<int>(out value3);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2H_CreateUserRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				name = null;
				account = null;
				value3 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				name = value.Name;
				account = value.Account;
				value3 = value.RpcId;
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
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new G2H_CreateUserRequest
		{
			IsFromPool = value2,
			Name = name,
			Account = account,
			RpcId = value3
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.Name = name;
		value.Account = account;
		value.RpcId = value3;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1017)]
[MemoryPackable(GenerateType.Object)]
public class R2G_GetLoginKey : MessageObject, IRequest, IMessage, IMemoryPackable<R2G_GetLoginKey>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class R2G_GetLoginKeyFormatter : MemoryPackFormatter<R2G_GetLoginKey>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref R2G_GetLoginKey value)
		{
			R2G_GetLoginKey.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref R2G_GetLoginKey value)
		{
			R2G_GetLoginKey.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	public static R2G_GetLoginKey Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(R2G_GetLoginKey)) as R2G_GetLoginKey;
		}
		return new R2G_GetLoginKey();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Account = null;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static R2G_GetLoginKey()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<R2G_GetLoginKey>())
		{
			MemoryPackFormatterProvider.Register(new R2G_GetLoginKeyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<R2G_GetLoginKey[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<R2G_GetLoginKey>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref R2G_GetLoginKey? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<long, int>(value.UserId, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref R2G_GetLoginKey? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		string account;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				value3 = value.UserId;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00f3;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			reader.ReadUnmanaged<long, int>(out value3, out value4);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(R2G_GetLoginKey), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				value3 = value.UserId;
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
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f3;
			}
		}
		value = new R2G_GetLoginKey
		{
			IsFromPool = value2,
			Account = account,
			UserId = value3,
			RpcId = value4
		};
		return;
		IL_00f3:
		value.IsFromPool = value2;
		value.Account = account;
		value.UserId = value3;
		value.RpcId = value4;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1036)]
[MemoryPackable(GenerateType.Object)]
public class KickUserRequest : MessageObject, IRequest, IMessage, IMemoryPackable<KickUserRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class KickUserRequestFormatter : MemoryPackFormatter<KickUserRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref KickUserRequest value)
		{
			KickUserRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref KickUserRequest value)
		{
			KickUserRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Account { get; set; }

	[MemoryPackOrder(2)]
	public int Reason { get; set; }

	public static KickUserRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(KickUserRequest)) as KickUserRequest;
		}
		return new KickUserRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Account = null;
			Reason = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static KickUserRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<KickUserRequest>())
		{
			MemoryPackFormatterProvider.Register(new KickUserRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<KickUserRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<KickUserRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref KickUserRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.UserId);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<int, int>(value.Reason, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref KickUserRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		string account;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				account = value.Account;
				value4 = value.Reason;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				account = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_0121;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			account = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(KickUserRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				account = null;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				account = value.Account;
				value4 = value.Reason;
				value5 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						account = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0121;
			}
		}
		value = new KickUserRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Account = account,
			Reason = value4,
			RpcId = value5
		};
		return;
		IL_0121:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Account = account;
		value.Reason = value4;
		value.RpcId = value5;
	}
}

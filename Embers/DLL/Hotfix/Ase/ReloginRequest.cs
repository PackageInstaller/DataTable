using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10141)]
[MemoryPackable(GenerateType.Object)]
public class ReloginRequest : MessageObject, IRequest, IMessage, IMemoryPackable<ReloginRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ReloginRequestFormatter : MemoryPackFormatter<ReloginRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ReloginRequest value)
		{
			ReloginRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ReloginRequest value)
		{
			ReloginRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	[MemoryPackOrder(1)]
	public string Account { get; set; }

	[MemoryPackOrder(2)]
	public long UserId { get; set; }

	[MemoryPackOrder(3)]
	public string DeviceId { get; set; }

	public static ReloginRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ReloginRequest)) as ReloginRequest;
		}
		return new ReloginRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Key = 0L;
			Account = null;
			UserId = 0L;
			DeviceId = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ReloginRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ReloginRequest>())
		{
			MemoryPackFormatterProvider.Register(new ReloginRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ReloginRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ReloginRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ReloginRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.Key);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<long>(value.UserId);
		writer.WriteString(value.DeviceId);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ReloginRequest? value)
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
		string account;
		string deviceId;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				account = value.Account;
				value4 = value.UserId;
				deviceId = value.DeviceId;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				account = reader.ReadString();
				reader.ReadUnmanaged<long>(out value4);
				deviceId = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				goto IL_015c;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			account = reader.ReadString();
			reader.ReadUnmanaged<long>(out value4);
			deviceId = reader.ReadString();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ReloginRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				account = null;
				value4 = 0L;
				deviceId = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				account = value.Account;
				value4 = value.UserId;
				deviceId = value.DeviceId;
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
							reader.ReadUnmanaged<long>(out value4);
							if (memberCount != 4)
							{
								deviceId = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value5);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_015c;
			}
		}
		value = new ReloginRequest
		{
			IsFromPool = value2,
			Key = value3,
			Account = account,
			UserId = value4,
			DeviceId = deviceId,
			RpcId = value5
		};
		return;
		IL_015c:
		value.IsFromPool = value2;
		value.Key = value3;
		value.Account = account;
		value.UserId = value4;
		value.DeviceId = deviceId;
		value.RpcId = value5;
	}
}

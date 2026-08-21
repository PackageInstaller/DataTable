using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(50008)]
[MemoryPackable(GenerateType.Object)]
public class KiifLoginHallRequest : MessageObject, IRequest, IMessage, IMemoryPackable<KiifLoginHallRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class KiifLoginHallRequestFormatter : MemoryPackFormatter<KiifLoginHallRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref KiifLoginHallRequest value)
		{
			KiifLoginHallRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref KiifLoginHallRequest value)
		{
			KiifLoginHallRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(1)]
	public string Account { get; set; }

	[MemoryPackOrder(2)]
	public string Password { get; set; }

	[MemoryPackOrder(3)]
	public long Key { get; set; }

	[MemoryPackOrder(5)]
	public string DeviceId { get; set; }

	[MemoryPackOrder(6)]
	public string VersionId { get; set; }

	public static KiifLoginHallRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(KiifLoginHallRequest)) as KiifLoginHallRequest;
		}
		return new KiifLoginHallRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Account = null;
			Password = null;
			Key = 0L;
			DeviceId = null;
			VersionId = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static KiifLoginHallRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<KiifLoginHallRequest>())
		{
			MemoryPackFormatterProvider.Register(new KiifLoginHallRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<KiifLoginHallRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<KiifLoginHallRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref KiifLoginHallRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteString(value.Password);
		writer.WriteUnmanaged<long>(value.Key);
		writer.WriteString(value.DeviceId);
		writer.WriteString(value.VersionId);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref KiifLoginHallRequest? value)
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
		string account;
		string password;
		string deviceId;
		string versionId;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				password = value.Password;
				value3 = value.Key;
				deviceId = value.DeviceId;
				versionId = value.VersionId;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				password = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				deviceId = reader.ReadString();
				versionId = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_01bb;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			password = reader.ReadString();
			reader.ReadUnmanaged<long>(out value3);
			deviceId = reader.ReadString();
			versionId = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(KiifLoginHallRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				password = null;
				value3 = 0L;
				deviceId = null;
				versionId = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				password = value.Password;
				value3 = value.Key;
				deviceId = value.DeviceId;
				versionId = value.VersionId;
				value4 = value.RpcId;
				value5 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value3);
							if (memberCount != 4)
							{
								deviceId = reader.ReadString();
								if (memberCount != 5)
								{
									versionId = reader.ReadString();
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value4);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value5);
											_ = 8;
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
				goto IL_01bb;
			}
		}
		value = new KiifLoginHallRequest
		{
			IsFromPool = value2,
			Account = account,
			Password = password,
			Key = value3,
			DeviceId = deviceId,
			VersionId = versionId,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_01bb:
		value.IsFromPool = value2;
		value.Account = account;
		value.Password = password;
		value.Key = value3;
		value.DeviceId = deviceId;
		value.VersionId = versionId;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}

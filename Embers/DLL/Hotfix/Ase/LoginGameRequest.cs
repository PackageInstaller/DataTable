using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(50006)]
[MemoryPackable(GenerateType.Object)]
public class LoginGameRequest : MessageObject, IRequest, IMessage, IMemoryPackable<LoginGameRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class LoginGameRequestFormatter : MemoryPackFormatter<LoginGameRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref LoginGameRequest value)
		{
			LoginGameRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref LoginGameRequest value)
		{
			LoginGameRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public string PlatformName { get; set; }

	[MemoryPackOrder(2)]
	public string Token { get; set; }

	[MemoryPackOrder(3)]
	public long ChannelId { get; set; }

	[MemoryPackOrder(4)]
	public string DistinctId { get; set; }

	[MemoryPackOrder(5)]
	public string DeviceId { get; set; }

	[MemoryPackOrder(6)]
	public long SubChannelId { get; set; }

	[MemoryPackOrder(6)]
	public string VersionId { get; set; }

	public static LoginGameRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(LoginGameRequest)) as LoginGameRequest;
		}
		return new LoginGameRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Account = null;
			PlatformName = null;
			Token = null;
			ChannelId = 0L;
			DistinctId = null;
			DeviceId = null;
			SubChannelId = 0L;
			VersionId = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static LoginGameRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<LoginGameRequest>())
		{
			MemoryPackFormatterProvider.Register(new LoginGameRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<LoginGameRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<LoginGameRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref LoginGameRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(11, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteString(value.PlatformName);
		writer.WriteString(value.Token);
		writer.WriteUnmanaged<long>(value.ChannelId);
		writer.WriteString(value.DistinctId);
		writer.WriteString(value.DeviceId);
		writer.WriteUnmanaged<long>(value.SubChannelId);
		writer.WriteString(value.VersionId);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref LoginGameRequest? value)
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
		long value6;
		string account;
		string platformName;
		string token;
		string distinctId;
		string deviceId;
		string versionId;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				platformName = value.PlatformName;
				token = value.Token;
				value3 = value.ChannelId;
				distinctId = value.DistinctId;
				deviceId = value.DeviceId;
				value4 = value.SubChannelId;
				versionId = value.VersionId;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				platformName = reader.ReadString();
				token = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				distinctId = reader.ReadString();
				deviceId = reader.ReadString();
				reader.ReadUnmanaged<long>(out value4);
				versionId = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0258;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			platformName = reader.ReadString();
			token = reader.ReadString();
			reader.ReadUnmanaged<long>(out value3);
			distinctId = reader.ReadString();
			deviceId = reader.ReadString();
			reader.ReadUnmanaged<long>(out value4);
			versionId = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(LoginGameRequest), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				platformName = null;
				token = null;
				value3 = 0L;
				distinctId = null;
				deviceId = null;
				value4 = 0L;
				versionId = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				platformName = value.PlatformName;
				token = value.Token;
				value3 = value.ChannelId;
				distinctId = value.DistinctId;
				deviceId = value.DeviceId;
				value4 = value.SubChannelId;
				versionId = value.VersionId;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					account = reader.ReadString();
					if (memberCount != 2)
					{
						platformName = reader.ReadString();
						if (memberCount != 3)
						{
							token = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value3);
								if (memberCount != 5)
								{
									distinctId = reader.ReadString();
									if (memberCount != 6)
									{
										deviceId = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value4);
											if (memberCount != 8)
											{
												versionId = reader.ReadString();
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value5);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value6);
														_ = 11;
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
			}
			if (value != null)
			{
				goto IL_0258;
			}
		}
		value = new LoginGameRequest
		{
			IsFromPool = value2,
			Account = account,
			PlatformName = platformName,
			Token = token,
			ChannelId = value3,
			DistinctId = distinctId,
			DeviceId = deviceId,
			SubChannelId = value4,
			VersionId = versionId,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0258:
		value.IsFromPool = value2;
		value.Account = account;
		value.PlatformName = platformName;
		value.Token = token;
		value.ChannelId = value3;
		value.DistinctId = distinctId;
		value.DeviceId = deviceId;
		value.SubChannelId = value4;
		value.VersionId = versionId;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}

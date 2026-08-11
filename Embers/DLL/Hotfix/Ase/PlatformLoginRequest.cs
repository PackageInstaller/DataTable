using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(50005)]
[MemoryPackable(GenerateType.Object)]
public class PlatformLoginRequest : MessageObject, IRequest, IMessage, IMemoryPackable<PlatformLoginRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PlatformLoginRequestFormatter : MemoryPackFormatter<PlatformLoginRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PlatformLoginRequest value)
		{
			PlatformLoginRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PlatformLoginRequest value)
		{
			PlatformLoginRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public string CUid { get; set; }

	[MemoryPackOrder(1)]
	public string CName { get; set; }

	[MemoryPackOrder(2)]
	public string Token { get; set; }

	[MemoryPackOrder(3)]
	public long ChannelId { get; set; }

	public static PlatformLoginRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PlatformLoginRequest)) as PlatformLoginRequest;
		}
		return new PlatformLoginRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			CUid = null;
			CName = null;
			Token = null;
			ChannelId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PlatformLoginRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PlatformLoginRequest>())
		{
			MemoryPackFormatterProvider.Register(new PlatformLoginRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PlatformLoginRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PlatformLoginRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PlatformLoginRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteString(value.CUid);
		writer.WriteString(value.CName);
		writer.WriteString(value.Token);
		writer.WriteUnmanaged<long, int>(value.ChannelId, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PlatformLoginRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		string cUid;
		string cName;
		string token;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				cUid = value.CUid;
				cName = value.CName;
				token = value.Token;
				value3 = value.ChannelId;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				cUid = reader.ReadString();
				cName = reader.ReadString();
				token = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_0158;
			}
			reader.ReadUnmanaged<bool>(out value2);
			cUid = reader.ReadString();
			cName = reader.ReadString();
			token = reader.ReadString();
			reader.ReadUnmanaged<long, int>(out value3, out value4);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PlatformLoginRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				cUid = null;
				cName = null;
				token = null;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				cUid = value.CUid;
				cName = value.CName;
				token = value.Token;
				value3 = value.ChannelId;
				value4 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					cUid = reader.ReadString();
					if (memberCount != 2)
					{
						cName = reader.ReadString();
						if (memberCount != 3)
						{
							token = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value3);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value4);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0158;
			}
		}
		value = new PlatformLoginRequest
		{
			IsFromPool = value2,
			CUid = cUid,
			CName = cName,
			Token = token,
			ChannelId = value3,
			RpcId = value4
		};
		return;
		IL_0158:
		value.IsFromPool = value2;
		value.CUid = cUid;
		value.CName = cName;
		value.Token = token;
		value.ChannelId = value3;
		value.RpcId = value4;
	}
}

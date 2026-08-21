using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1129)]
[MemoryPackable(GenerateType.Object)]
public class InnerLoginOutGateRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerLoginOutGateRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerLoginOutGateRequestFormatter : MemoryPackFormatter<InnerLoginOutGateRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerLoginOutGateRequest value)
		{
			InnerLoginOutGateRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerLoginOutGateRequest value)
		{
			InnerLoginOutGateRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public string Account { get; set; }

	[MemoryPackOrder(1)]
	public string Token { get; set; }

	[MemoryPackOrder(2)]
	public int Reason { get; set; }

	public static InnerLoginOutGateRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerLoginOutGateRequest)) as InnerLoginOutGateRequest;
		}
		return new InnerLoginOutGateRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Account = null;
			Token = null;
			Reason = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerLoginOutGateRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerLoginOutGateRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerLoginOutGateRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerLoginOutGateRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerLoginOutGateRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerLoginOutGateRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.Account);
		writer.WriteString(value.Token);
		writer.WriteUnmanaged<int, int>(value.Reason, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerLoginOutGateRequest? value)
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
		string token;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				account = value.Account;
				token = value.Token;
				value3 = value.Reason;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				account = reader.ReadString();
				token = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool>(out value2);
			account = reader.ReadString();
			token = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value3, out value4);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerLoginOutGateRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				account = null;
				token = null;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				account = value.Account;
				token = value.Token;
				value3 = value.Reason;
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
						token = reader.ReadString();
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
		value = new InnerLoginOutGateRequest
		{
			IsFromPool = value2,
			Account = account,
			Token = token,
			Reason = value3,
			RpcId = value4
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.Account = account;
		value.Token = token;
		value.Reason = value3;
		value.RpcId = value4;
	}
}

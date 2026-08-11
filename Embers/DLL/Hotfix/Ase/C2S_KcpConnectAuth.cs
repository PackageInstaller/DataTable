using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10031)]
[MemoryPackable(GenerateType.Object)]
public class C2S_KcpConnectAuth : MessageObject, IRequest, IMessage, IMemoryPackable<C2S_KcpConnectAuth>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_KcpConnectAuthFormatter : MemoryPackFormatter<C2S_KcpConnectAuth>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_KcpConnectAuth value)
		{
			C2S_KcpConnectAuth.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_KcpConnectAuth value)
		{
			C2S_KcpConnectAuth.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int PlayerId { get; set; }

	[MemoryPackOrder(1)]
	public long Key { get; set; }

	public static C2S_KcpConnectAuth Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_KcpConnectAuth)) as C2S_KcpConnectAuth;
		}
		return new C2S_KcpConnectAuth();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			PlayerId = 0;
			Key = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_KcpConnectAuth()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_KcpConnectAuth>())
		{
			MemoryPackFormatterProvider.Register(new C2S_KcpConnectAuthFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_KcpConnectAuth[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_KcpConnectAuth>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_KcpConnectAuth? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, long>(5, value.IsFromPool, value.PlayerId, value.Key, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_KcpConnectAuth? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerId;
				value4 = value.Key;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, int, long, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_KcpConnectAuth), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerId;
				value4 = value.Key;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0119;
			}
		}
		value = new C2S_KcpConnectAuth
		{
			IsFromPool = value2,
			PlayerId = value3,
			Key = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.PlayerId = value3;
		value.Key = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}

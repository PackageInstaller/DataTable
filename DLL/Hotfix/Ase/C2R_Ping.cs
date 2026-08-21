using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5011)]
[MemoryPackable(GenerateType.Object)]
public class C2R_Ping : MessageObject, IRequest, IMessage, IMemoryPackable<C2R_Ping>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2R_PingFormatter : MemoryPackFormatter<C2R_Ping>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2R_Ping value)
		{
			C2R_Ping.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2R_Ping value)
		{
			C2R_Ping.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	public static C2R_Ping Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2R_Ping)) as C2R_Ping;
		}
		return new C2R_Ping();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2R_Ping()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2R_Ping>())
		{
			MemoryPackFormatterProvider.Register(new C2R_PingFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2R_Ping[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2R_Ping>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2R_Ping? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int>(2, value.IsFromPool, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2R_Ping? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		if (memberCount == 2)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				goto IL_0096;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
		}
		else
		{
			if (memberCount > 2)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2R_Ping), 2, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					_ = 2;
				}
			}
			if (value != null)
			{
				goto IL_0096;
			}
		}
		value = new C2R_Ping
		{
			IsFromPool = value2,
			RpcId = value3
		};
		return;
		IL_0096:
		value.IsFromPool = value2;
		value.RpcId = value3;
	}
}

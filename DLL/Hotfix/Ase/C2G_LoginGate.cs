using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10001)]
[MemoryPackable(GenerateType.Object)]
public class C2G_LoginGate : MessageObject, IRequest, IMessage, IMemoryPackable<C2G_LoginGate>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2G_LoginGateFormatter : MemoryPackFormatter<C2G_LoginGate>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2G_LoginGate value)
		{
			C2G_LoginGate.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2G_LoginGate value)
		{
			C2G_LoginGate.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	public static C2G_LoginGate Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2G_LoginGate)) as C2G_LoginGate;
		}
		return new C2G_LoginGate();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Key = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2G_LoginGate()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_LoginGate>())
		{
			MemoryPackFormatterProvider.Register(new C2G_LoginGateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_LoginGate[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2G_LoginGate>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2G_LoginGate? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.Key, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2G_LoginGate? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2G_LoginGate), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new C2G_LoginGate
		{
			IsFromPool = value2,
			Key = value3,
			RpcId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.Key = value3;
		value.RpcId = value4;
	}
}

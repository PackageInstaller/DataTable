using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1001)]
[MemoryPackable(GenerateType.Object)]
public class M2A_Reload : MessageObject, IRequest, IMessage, IMemoryPackable<M2A_Reload>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2A_ReloadFormatter : MemoryPackFormatter<M2A_Reload>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2A_Reload value)
		{
			M2A_Reload.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2A_Reload value)
		{
			M2A_Reload.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	public static M2A_Reload Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2A_Reload)) as M2A_Reload;
		}
		return new M2A_Reload();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2A_Reload()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2A_Reload>())
		{
			MemoryPackFormatterProvider.Register(new M2A_ReloadFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2A_Reload[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2A_Reload>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2A_Reload? value)
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
	public static void Deserialize(ref MemoryPackReader reader, ref M2A_Reload? value)
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2A_Reload), 2, memberCount);
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
		value = new M2A_Reload
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

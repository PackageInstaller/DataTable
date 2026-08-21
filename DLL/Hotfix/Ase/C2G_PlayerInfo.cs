using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10043)]
[MemoryPackable(GenerateType.Object)]
public class C2G_PlayerInfo : MessageObject, IRequest, IMessage, IMemoryPackable<C2G_PlayerInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2G_PlayerInfoFormatter : MemoryPackFormatter<C2G_PlayerInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2G_PlayerInfo value)
		{
			C2G_PlayerInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2G_PlayerInfo value)
		{
			C2G_PlayerInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	public static C2G_PlayerInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2G_PlayerInfo)) as C2G_PlayerInfo;
		}
		return new C2G_PlayerInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2G_PlayerInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_PlayerInfo>())
		{
			MemoryPackFormatterProvider.Register(new C2G_PlayerInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2G_PlayerInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2G_PlayerInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2G_PlayerInfo? value)
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
	public static void Deserialize(ref MemoryPackReader reader, ref C2G_PlayerInfo? value)
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2G_PlayerInfo), 2, memberCount);
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
		value = new C2G_PlayerInfo
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

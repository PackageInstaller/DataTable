using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(208)]
[MemoryPackable(GenerateType.Object)]
public class PlayerInfo : MessageObject, IMessage, IMemoryPackable<PlayerInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PlayerInfoFormatter : MemoryPackFormatter<PlayerInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PlayerInfo value)
		{
			PlayerInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PlayerInfo value)
		{
			PlayerInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long PlayerId { get; set; }

	public static PlayerInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PlayerInfo)) as PlayerInfo;
		}
		return new PlayerInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			PlayerId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PlayerInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PlayerInfo>())
		{
			MemoryPackFormatterProvider.Register(new PlayerInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PlayerInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PlayerInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PlayerInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.PlayerId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PlayerInfo? value)
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
				value3 = value.PlayerId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PlayerInfo), 3, memberCount);
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
				value3 = value.PlayerId;
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
		value = new PlayerInfo
		{
			IsFromPool = value2,
			PlayerId = value3,
			RpcId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.PlayerId = value3;
		value.RpcId = value4;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1090)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpgradeUnionLevelRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUpgradeUnionLevelRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpgradeUnionLevelRequestFormatter : MemoryPackFormatter<InnerUpgradeUnionLevelRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpgradeUnionLevelRequest value)
		{
			InnerUpgradeUnionLevelRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpgradeUnionLevelRequest value)
		{
			InnerUpgradeUnionLevelRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	public static InnerUpgradeUnionLevelRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpgradeUnionLevelRequest)) as InnerUpgradeUnionLevelRequest;
		}
		return new InnerUpgradeUnionLevelRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpgradeUnionLevelRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpgradeUnionLevelRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpgradeUnionLevelRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpgradeUnionLevelRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpgradeUnionLevelRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpgradeUnionLevelRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpgradeUnionLevelRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpgradeUnionLevelRequest), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.UserId;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new InnerUpgradeUnionLevelRequest
		{
			IsFromPool = value2,
			RpcId = value3,
			UserId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.RpcId = value3;
		value.UserId = value4;
	}
}

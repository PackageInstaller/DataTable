using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1113)]
[MemoryPackable(GenerateType.Object)]
public class InnerUserUnionChangeNotify : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUserUnionChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUserUnionChangeNotifyFormatter : MemoryPackFormatter<InnerUserUnionChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUserUnionChangeNotify value)
		{
			InnerUserUnionChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUserUnionChangeNotify value)
		{
			InnerUserUnionChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	public static InnerUserUnionChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUserUnionChangeNotify)) as InnerUserUnionChangeNotify;
		}
		return new InnerUserUnionChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUserUnionChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUserUnionChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new InnerUserUnionChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUserUnionChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUserUnionChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUserUnionChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, long>(4, value.IsFromPool, value.UnionId, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUserUnionChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, long, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUserUnionChangeNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.RpcId;
				value5 = value.UserId;
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
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00eb;
			}
		}
		value = new InnerUserUnionChangeNotify
		{
			IsFromPool = value2,
			UnionId = value3,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.RpcId = value4;
		value.UserId = value5;
	}
}

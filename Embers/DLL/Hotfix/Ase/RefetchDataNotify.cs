using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10138)]
[MemoryPackable(GenerateType.Object)]
public class RefetchDataNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<RefetchDataNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class RefetchDataNotifyFormatter : MemoryPackFormatter<RefetchDataNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref RefetchDataNotify value)
		{
			RefetchDataNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref RefetchDataNotify value)
		{
			RefetchDataNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public int Para { get; set; }

	[MemoryPackOrder(2)]
	public PbCopyInfo copyInfo { get; set; }

	public static RefetchDataNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(RefetchDataNotify)) as RefetchDataNotify;
		}
		return new RefetchDataNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Type = 0;
			Para = 0;
			copyInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static RefetchDataNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<RefetchDataNotify>())
		{
			MemoryPackFormatterProvider.Register(new RefetchDataNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<RefetchDataNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<RefetchDataNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref RefetchDataNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(6, value.IsFromPool, value.Type, value.Para);
		writer.WritePackable<PbCopyInfo>(value.copyInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref RefetchDataNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		PbCopyInfo value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Para;
				value5 = value.copyInfo;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbCopyInfo>();
			reader.ReadUnmanaged<int, long>(out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(RefetchDataNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Para;
				value5 = value.copyInfo;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0152;
			}
		}
		value = new RefetchDataNotify
		{
			IsFromPool = value2,
			Type = value3,
			Para = value4,
			copyInfo = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.Type = value3;
		value.Para = value4;
		value.copyInfo = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}

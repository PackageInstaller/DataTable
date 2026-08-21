using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10684)]
[MemoryPackable(GenerateType.Object)]
public class UnionEventNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UnionEventNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionEventNotifyFormatter : MemoryPackFormatter<UnionEventNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionEventNotify value)
		{
			UnionEventNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionEventNotify value)
		{
			UnionEventNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public List<string> Params { get; set; } = new List<string>();

	public static UnionEventNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionEventNotify)) as UnionEventNotify;
		}
		return new UnionEventNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Type = 0;
			Params.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionEventNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionEventNotify>())
		{
			MemoryPackFormatterProvider.Register(new UnionEventNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionEventNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionEventNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionEventNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(5, value.IsFromPool, value.Type);
		writer.WriteValue<List<string>>(value.Params);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionEventNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<string> value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Params;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadValue<List<string>>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionEventNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Params;
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
						reader.ReadValue(ref value4);
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
				goto IL_0123;
			}
		}
		value = new UnionEventNotify
		{
			IsFromPool = value2,
			Type = value3,
			Params = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.Type = value3;
		value.Params = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10848)]
[MemoryPackable(GenerateType.Object)]
public class BroadcastNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<BroadcastNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BroadcastNotifyFormatter : MemoryPackFormatter<BroadcastNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BroadcastNotify value)
		{
			BroadcastNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BroadcastNotify value)
		{
			BroadcastNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long ModelId { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(9)]
	public string Param1 { get; set; }

	public static BroadcastNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BroadcastNotify)) as BroadcastNotify;
		}
		return new BroadcastNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			ModelId = 0L;
			Content = null;
			Param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BroadcastNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BroadcastNotify>())
		{
			MemoryPackFormatterProvider.Register(new BroadcastNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BroadcastNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BroadcastNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BroadcastNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.ModelId);
		writer.WriteString(value.Content);
		writer.WriteString(value.Param1);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BroadcastNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		string content;
		string param;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ModelId;
				content = value.Content;
				param = value.Param1;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				content = reader.ReadString();
				param = reader.ReadString();
				reader.ReadUnmanaged<long>(out value4);
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			content = reader.ReadString();
			param = reader.ReadString();
			reader.ReadUnmanaged<long>(out value4);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BroadcastNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				content = null;
				param = null;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ModelId;
				content = value.Content;
				param = value.Param1;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						content = reader.ReadString();
						if (memberCount != 3)
						{
							param = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value4);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_012b;
			}
		}
		value = new BroadcastNotify
		{
			IsFromPool = value2,
			ModelId = value3,
			Content = content,
			Param1 = param,
			ActorId = value4
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.ModelId = value3;
		value.Content = content;
		value.Param1 = param;
		value.ActorId = value4;
	}
}

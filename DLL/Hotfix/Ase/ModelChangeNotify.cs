using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10828)]
[MemoryPackable(GenerateType.Object)]
public class ModelChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ModelChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ModelChangeNotifyFormatter : MemoryPackFormatter<ModelChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ModelChangeNotify value)
		{
			ModelChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ModelChangeNotify value)
		{
			ModelChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long ModelId { get; set; }

	[MemoryPackOrder(1)]
	public bool Change { get; set; }

	[MemoryPackOrder(2)]
	public bool RedPoint { get; set; }

	public static ModelChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ModelChangeNotify)) as ModelChangeNotify;
		}
		return new ModelChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			ModelId = 0L;
			Change = false;
			RedPoint = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ModelChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ModelChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new ModelChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ModelChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ModelChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ModelChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, bool, bool, int, long>(6, value.IsFromPool, value.ModelId, value.Change, value.RedPoint, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ModelChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		bool value4;
		bool value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ModelId;
				value4 = value.Change;
				value5 = value.RedPoint;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0147;
			}
			reader.ReadUnmanaged<bool, long, bool, bool, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ModelChangeNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = false;
				value5 = false;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ModelId;
				value4 = value.Change;
				value5 = value.RedPoint;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<bool>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<bool>(out value5);
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
				goto IL_0147;
			}
		}
		value = new ModelChangeNotify
		{
			IsFromPool = value2,
			ModelId = value3,
			Change = value4,
			RedPoint = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0147:
		value.IsFromPool = value2;
		value.ModelId = value3;
		value.Change = value4;
		value.RedPoint = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10816)]
[MemoryPackable(GenerateType.Object)]
public class UnionInfoChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UnionInfoChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionInfoChangeNotifyFormatter : MemoryPackFormatter<UnionInfoChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionInfoChangeNotify value)
		{
			UnionInfoChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionInfoChangeNotify value)
		{
			UnionInfoChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public int Value { get; set; }

	[MemoryPackOrder(2)]
	public string Param { get; set; }

	public static UnionInfoChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionInfoChangeNotify)) as UnionInfoChangeNotify;
		}
		return new UnionInfoChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			Type = 0;
			Value = 0;
			Param = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionInfoChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionInfoChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new UnionInfoChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionInfoChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionInfoChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionInfoChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(5, value.IsFromPool, value.Type, value.Value);
		writer.WriteString(value.Param);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionInfoChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		string param;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Value;
				param = value.Param;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				param = reader.ReadString();
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			param = reader.ReadString();
			reader.ReadUnmanaged<long>(out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionInfoChangeNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				param = null;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Value;
				param = value.Param;
				value5 = value.ActorId;
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
							param = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0124;
			}
		}
		value = new UnionInfoChangeNotify
		{
			IsFromPool = value2,
			Type = value3,
			Value = value4,
			Param = param,
			ActorId = value5
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.Type = value3;
		value.Value = value4;
		value.Param = param;
		value.ActorId = value5;
	}
}

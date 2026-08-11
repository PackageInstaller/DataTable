using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10218)]
[MemoryPackable(GenerateType.Object)]
public class NewsTickerNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<NewsTickerNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class NewsTickerNotifyFormatter : MemoryPackFormatter<NewsTickerNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref NewsTickerNotify value)
		{
			NewsTickerNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref NewsTickerNotify value)
		{
			NewsTickerNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbNewsTicker> NewsTickers { get; set; } = new List<PbNewsTicker>();

	public static NewsTickerNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(NewsTickerNotify)) as NewsTickerNotify;
		}
		return new NewsTickerNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			NewsTickers.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static NewsTickerNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<NewsTickerNotify>())
		{
			MemoryPackFormatterProvider.Register(new NewsTickerNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<NewsTickerNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<NewsTickerNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNewsTicker>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNewsTicker>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref NewsTickerNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNewsTicker>>(value.NewsTickers));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref NewsTickerNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbNewsTicker> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.NewsTickers;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbNewsTicker>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(NewsTickerNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.NewsTickers;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
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
				goto IL_00f5;
			}
		}
		value = new NewsTickerNotify
		{
			IsFromPool = value2,
			NewsTickers = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.NewsTickers = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}

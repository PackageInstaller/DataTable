using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(409)]
[MemoryPackable(GenerateType.Object)]
public class PbNewsTicker : MessageObject, IMemoryPackable<PbNewsTicker>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbNewsTickerFormatter : MemoryPackFormatter<PbNewsTicker>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbNewsTicker value)
		{
			PbNewsTicker.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbNewsTicker value)
		{
			PbNewsTicker.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long Id { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(2)]
	public long StartTS { get; set; }

	[MemoryPackOrder(3)]
	public long EndTS { get; set; }

	[MemoryPackOrder(4)]
	public long Interval { get; set; }

	[MemoryPackOrder(5)]
	public bool IsDelete { get; set; }

	public static PbNewsTicker Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbNewsTicker)) as PbNewsTicker;
		}
		return new PbNewsTicker();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0L;
			Content = null;
			StartTS = 0L;
			EndTS = 0L;
			Interval = 0L;
			IsDelete = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbNewsTicker()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbNewsTicker>())
		{
			MemoryPackFormatterProvider.Register(new PbNewsTickerFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbNewsTicker[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbNewsTicker>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbNewsTicker? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(7, value.IsFromPool, value.Id);
		writer.WriteString(value.Content);
		writer.WriteUnmanaged<long, long, long, bool>(value.StartTS, value.EndTS, value.Interval, value.IsDelete);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbNewsTicker? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		long value5;
		long value6;
		bool value7;
		string content;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				content = value.Content;
				value4 = value.StartTS;
				value5 = value.EndTS;
				value6 = value.Interval;
				value7 = value.IsDelete;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				content = reader.ReadString();
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<bool>(out value7);
				goto IL_017d;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			content = reader.ReadString();
			reader.ReadUnmanaged<long, long, long, bool>(out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbNewsTicker), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				content = null;
				value4 = 0L;
				value5 = 0L;
				value6 = 0L;
				value7 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				content = value.Content;
				value4 = value.StartTS;
				value5 = value.EndTS;
				value6 = value.Interval;
				value7 = value.IsDelete;
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
							reader.ReadUnmanaged<long>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<bool>(out value7);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_017d;
			}
		}
		value = new PbNewsTicker
		{
			IsFromPool = value2,
			Id = value3,
			Content = content,
			StartTS = value4,
			EndTS = value5,
			Interval = value6,
			IsDelete = value7
		};
		return;
		IL_017d:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Content = content;
		value.StartTS = value4;
		value.EndTS = value5;
		value.Interval = value6;
		value.IsDelete = value7;
	}
}

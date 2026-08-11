using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(323)]
[MemoryPackable(GenerateType.Object)]
public class PbNotice : MessageObject, IMemoryPackable<PbNotice>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbNoticeFormatter : MemoryPackFormatter<PbNotice>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbNotice value)
		{
			PbNotice.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbNotice value)
		{
			PbNotice.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long Id { get; set; }

	[MemoryPackOrder(2)]
	public int Priority { get; set; }

	[MemoryPackOrder(3)]
	public int Type { get; set; }

	[MemoryPackOrder(4)]
	public string Title { get; set; }

	[MemoryPackOrder(5)]
	public string Content { get; set; }

	[MemoryPackOrder(6)]
	public string Picture { get; set; }

	[MemoryPackOrder(7)]
	public bool Delete { get; set; }

	[MemoryPackOrder(8)]
	public string StartTime { get; set; }

	[MemoryPackOrder(9)]
	public long LastTime { get; set; }

	public static PbNotice Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbNotice)) as PbNotice;
		}
		return new PbNotice();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0L;
			Priority = 0;
			Type = 0;
			Title = null;
			Content = null;
			Picture = null;
			Delete = false;
			StartTime = null;
			LastTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbNotice()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbNotice>())
		{
			MemoryPackFormatterProvider.Register(new PbNoticeFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbNotice[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbNotice>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbNotice? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(10, value.IsFromPool, value.Id, value.Priority, value.Type);
		writer.WriteString(value.Title);
		writer.WriteString(value.Content);
		writer.WriteString(value.Picture);
		writer.WriteUnmanaged<bool>(value.Delete);
		writer.WriteString(value.StartTime);
		writer.WriteUnmanaged<long>(value.LastTime);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbNotice? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		bool value6;
		long value7;
		string title;
		string content;
		string picture;
		string startTime;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Priority;
				value5 = value.Type;
				title = value.Title;
				content = value.Content;
				picture = value.Picture;
				value6 = value.Delete;
				startTime = value.StartTime;
				value7 = value.LastTime;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				title = reader.ReadString();
				content = reader.ReadString();
				picture = reader.ReadString();
				reader.ReadUnmanaged<bool>(out value6);
				startTime = reader.ReadString();
				reader.ReadUnmanaged<long>(out value7);
				goto IL_021c;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			title = reader.ReadString();
			content = reader.ReadString();
			picture = reader.ReadString();
			reader.ReadUnmanaged<bool>(out value6);
			startTime = reader.ReadString();
			reader.ReadUnmanaged<long>(out value7);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbNotice), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				title = null;
				content = null;
				picture = null;
				value6 = false;
				startTime = null;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Priority;
				value5 = value.Type;
				title = value.Title;
				content = value.Content;
				picture = value.Picture;
				value6 = value.Delete;
				startTime = value.StartTime;
				value7 = value.LastTime;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								title = reader.ReadString();
								if (memberCount != 5)
								{
									content = reader.ReadString();
									if (memberCount != 6)
									{
										picture = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<bool>(out value6);
											if (memberCount != 8)
											{
												startTime = reader.ReadString();
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value7);
													_ = 10;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_021c;
			}
		}
		value = new PbNotice
		{
			IsFromPool = value2,
			Id = value3,
			Priority = value4,
			Type = value5,
			Title = title,
			Content = content,
			Picture = picture,
			Delete = value6,
			StartTime = startTime,
			LastTime = value7
		};
		return;
		IL_021c:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Priority = value4;
		value.Type = value5;
		value.Title = title;
		value.Content = content;
		value.Picture = picture;
		value.Delete = value6;
		value.StartTime = startTime;
		value.LastTime = value7;
	}
}

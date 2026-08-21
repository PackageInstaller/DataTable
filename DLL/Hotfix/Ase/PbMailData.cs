using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(317)]
[MemoryPackable(GenerateType.Object)]
public class PbMailData : MessageObject, IMemoryPackable<PbMailData>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMailDataFormatter : MemoryPackFormatter<PbMailData>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMailData value)
		{
			PbMailData.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMailData value)
		{
			PbMailData.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long Lid { get; set; }

	[MemoryPackOrder(1)]
	public string Title { get; set; }

	[MemoryPackOrder(2)]
	public string Content { get; set; }

	[MemoryPackOrder(3)]
	public int Typ { get; set; }

	[MemoryPackOrder(4)]
	public long SendTime { get; set; }

	[MemoryPackOrder(5)]
	public long ValidTime { get; set; }

	[MemoryPackOrder(6)]
	public int IsDelete { get; set; }

	[MemoryPackOrder(7)]
	public int IsRead { get; set; }

	[MemoryPackOrder(8)]
	public int IsReceive { get; set; }

	[MemoryPackOrder(9)]
	public string Attachment { get; set; }

	public static PbMailData Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMailData)) as PbMailData;
		}
		return new PbMailData();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Lid = 0L;
			Title = null;
			Content = null;
			Typ = 0;
			SendTime = 0L;
			ValidTime = 0L;
			IsDelete = 0;
			IsRead = 0;
			IsReceive = 0;
			Attachment = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMailData()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMailData>())
		{
			MemoryPackFormatterProvider.Register(new PbMailDataFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMailData[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMailData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMailData? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(11, value.IsFromPool, value.Lid);
		writer.WriteString(value.Title);
		writer.WriteString(value.Content);
		writer.WriteUnmanaged<int, long, long, int, int, int>(value.Typ, value.SendTime, value.ValidTime, value.IsDelete, value.IsRead, value.IsReceive);
		writer.WriteString(value.Attachment);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMailData? value)
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
		long value6;
		int value7;
		int value8;
		int value9;
		string title;
		string content;
		string attachment;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Lid;
				title = value.Title;
				content = value.Content;
				value4 = value.Typ;
				value5 = value.SendTime;
				value6 = value.ValidTime;
				value7 = value.IsDelete;
				value8 = value.IsRead;
				value9 = value.IsReceive;
				attachment = value.Attachment;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				title = reader.ReadString();
				content = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				attachment = reader.ReadString();
				goto IL_023d;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			title = reader.ReadString();
			content = reader.ReadString();
			reader.ReadUnmanaged<int, long, long, int, int, int>(out value4, out value5, out value6, out value7, out value8, out value9);
			attachment = reader.ReadString();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMailData), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				title = null;
				content = null;
				value4 = 0;
				value5 = 0L;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				attachment = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Lid;
				title = value.Title;
				content = value.Content;
				value4 = value.Typ;
				value5 = value.SendTime;
				value6 = value.ValidTime;
				value7 = value.IsDelete;
				value8 = value.IsRead;
				value9 = value.IsReceive;
				attachment = value.Attachment;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						title = reader.ReadString();
						if (memberCount != 3)
						{
							content = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value4);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value6);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value7);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value8);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value9);
													if (memberCount != 10)
													{
														attachment = reader.ReadString();
														_ = 11;
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
			}
			if (value != null)
			{
				goto IL_023d;
			}
		}
		value = new PbMailData
		{
			IsFromPool = value2,
			Lid = value3,
			Title = title,
			Content = content,
			Typ = value4,
			SendTime = value5,
			ValidTime = value6,
			IsDelete = value7,
			IsRead = value8,
			IsReceive = value9,
			Attachment = attachment
		};
		return;
		IL_023d:
		value.IsFromPool = value2;
		value.Lid = value3;
		value.Title = title;
		value.Content = content;
		value.Typ = value4;
		value.SendTime = value5;
		value.ValidTime = value6;
		value.IsDelete = value7;
		value.IsRead = value8;
		value.IsReceive = value9;
		value.Attachment = attachment;
	}
}

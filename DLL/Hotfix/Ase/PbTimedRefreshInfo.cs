using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(353)]
[MemoryPackable(GenerateType.Object)]
public class PbTimedRefreshInfo : MessageObject, IMemoryPackable<PbTimedRefreshInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbTimedRefreshInfoFormatter : MemoryPackFormatter<PbTimedRefreshInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbTimedRefreshInfo value)
		{
			PbTimedRefreshInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbTimedRefreshInfo value)
		{
			PbTimedRefreshInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int MainType { get; set; }

	[MemoryPackOrder(1)]
	public int SubType { get; set; }

	[MemoryPackOrder(2)]
	public long Count { get; set; }

	[MemoryPackOrder(3)]
	public long RecordTime { get; set; }

	public static PbTimedRefreshInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbTimedRefreshInfo)) as PbTimedRefreshInfo;
		}
		return new PbTimedRefreshInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			MainType = 0;
			SubType = 0;
			Count = 0L;
			RecordTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbTimedRefreshInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbTimedRefreshInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbTimedRefreshInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbTimedRefreshInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbTimedRefreshInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbTimedRefreshInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, long>(5, value.IsFromPool, value.MainType, value.SubType, value.Count, value.RecordTime);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbTimedRefreshInfo? value)
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
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MainType;
				value4 = value.SubType;
				value5 = value.Count;
				value6 = value.RecordTime;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, int, int, long, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbTimedRefreshInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MainType;
				value4 = value.SubType;
				value5 = value.Count;
				value6 = value.RecordTime;
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
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_0119;
			}
		}
		value = new PbTimedRefreshInfo
		{
			IsFromPool = value2,
			MainType = value3,
			SubType = value4,
			Count = value5,
			RecordTime = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.MainType = value3;
		value.SubType = value4;
		value.Count = value5;
		value.RecordTime = value6;
	}
}

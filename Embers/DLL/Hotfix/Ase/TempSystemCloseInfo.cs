using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(412)]
[MemoryPackable(GenerateType.Object)]
public class TempSystemCloseInfo : MessageObject, IMemoryPackable<TempSystemCloseInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class TempSystemCloseInfoFormatter : MemoryPackFormatter<TempSystemCloseInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref TempSystemCloseInfo value)
		{
			TempSystemCloseInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref TempSystemCloseInfo value)
		{
			TempSystemCloseInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long SystemId { get; set; }

	[MemoryPackOrder(1)]
	public long StartTime { get; set; }

	[MemoryPackOrder(2)]
	public long EndTime { get; set; }

	public static TempSystemCloseInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(TempSystemCloseInfo)) as TempSystemCloseInfo;
		}
		return new TempSystemCloseInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			SystemId = 0L;
			StartTime = 0L;
			EndTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static TempSystemCloseInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<TempSystemCloseInfo>())
		{
			MemoryPackFormatterProvider.Register(new TempSystemCloseInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<TempSystemCloseInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<TempSystemCloseInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref TempSystemCloseInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, long>(4, value.IsFromPool, value.SystemId, value.StartTime, value.EndTime);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref TempSystemCloseInfo? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SystemId;
				value4 = value.StartTime;
				value5 = value.EndTime;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ef;
			}
			reader.ReadUnmanaged<bool, long, long, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(TempSystemCloseInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SystemId;
				value4 = value.StartTime;
				value5 = value.EndTime;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_00ef;
			}
		}
		value = new TempSystemCloseInfo
		{
			IsFromPool = value2,
			SystemId = value3,
			StartTime = value4,
			EndTime = value5
		};
		return;
		IL_00ef:
		value.IsFromPool = value2;
		value.SystemId = value3;
		value.StartTime = value4;
		value.EndTime = value5;
	}
}

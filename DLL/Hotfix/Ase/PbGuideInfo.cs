using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(321)]
[MemoryPackable(GenerateType.Object)]
public class PbGuideInfo : MessageObject, IMemoryPackable<PbGuideInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbGuideInfoFormatter : MemoryPackFormatter<PbGuideInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbGuideInfo value)
		{
			PbGuideInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbGuideInfo value)
		{
			PbGuideInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int GuideId { get; set; }

	[MemoryPackOrder(1)]
	public int GuideStatus { get; set; }

	public static PbGuideInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbGuideInfo)) as PbGuideInfo;
		}
		return new PbGuideInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			GuideId = 0;
			GuideStatus = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbGuideInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbGuideInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbGuideInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbGuideInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbGuideInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbGuideInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.GuideId, value.GuideStatus);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbGuideInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.GuideId;
				value4 = value.GuideStatus;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00be;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbGuideInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.GuideId;
				value4 = value.GuideStatus;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00be;
			}
		}
		value = new PbGuideInfo
		{
			IsFromPool = value2,
			GuideId = value3,
			GuideStatus = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.GuideId = value3;
		value.GuideStatus = value4;
	}
}

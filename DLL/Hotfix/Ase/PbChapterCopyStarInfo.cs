using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(346)]
[MemoryPackable(GenerateType.Object)]
public class PbChapterCopyStarInfo : MessageObject, IMemoryPackable<PbChapterCopyStarInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbChapterCopyStarInfoFormatter : MemoryPackFormatter<PbChapterCopyStarInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbChapterCopyStarInfo value)
		{
			PbChapterCopyStarInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbChapterCopyStarInfo value)
		{
			PbChapterCopyStarInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int Dicfficulty { get; set; }

	[MemoryPackOrder(2)]
	public int Star { get; set; }

	public static PbChapterCopyStarInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbChapterCopyStarInfo)) as PbChapterCopyStarInfo;
		}
		return new PbChapterCopyStarInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyId = 0;
			Dicfficulty = 0;
			Star = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbChapterCopyStarInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbChapterCopyStarInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbChapterCopyStarInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbChapterCopyStarInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbChapterCopyStarInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbChapterCopyStarInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.CopyId, value.Dicfficulty, value.Star);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbChapterCopyStarInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Dicfficulty;
				value5 = value.Star;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbChapterCopyStarInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Dicfficulty;
				value5 = value.Star;
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
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new PbChapterCopyStarInfo
		{
			IsFromPool = value2,
			CopyId = value3,
			Dicfficulty = value4,
			Star = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Dicfficulty = value4;
		value.Star = value5;
	}
}

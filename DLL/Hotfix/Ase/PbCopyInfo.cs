using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(407)]
[MemoryPackable(GenerateType.Object)]
public class PbCopyInfo : MessageObject, IMemoryPackable<PbCopyInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopyInfoFormatter : MemoryPackFormatter<PbCopyInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopyInfo value)
		{
			PbCopyInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopyInfo value)
		{
			PbCopyInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int Star { get; set; }

	[MemoryPackOrder(2)]
	public int Score { get; set; }

	public static PbCopyInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopyInfo)) as PbCopyInfo;
		}
		return new PbCopyInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyId = 0;
			Star = 0;
			Score = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopyInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopyInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopyInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.CopyId, value.Star, value.Score);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopyInfo? value)
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
				value4 = value.Star;
				value5 = value.Score;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopyInfo), 4, memberCount);
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
				value4 = value.Star;
				value5 = value.Score;
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
		value = new PbCopyInfo
		{
			IsFromPool = value2,
			CopyId = value3,
			Star = value4,
			Score = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Star = value4;
		value.Score = value5;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(372)]
[MemoryPackable(GenerateType.Object)]
public class PbCopyDifficultyInfo : MessageObject, IMemoryPackable<PbCopyDifficultyInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopyDifficultyInfoFormatter : MemoryPackFormatter<PbCopyDifficultyInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopyDifficultyInfo value)
		{
			PbCopyDifficultyInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopyDifficultyInfo value)
		{
			PbCopyDifficultyInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int PassedDifficulty { get; set; }

	public static PbCopyDifficultyInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopyDifficultyInfo)) as PbCopyDifficultyInfo;
		}
		return new PbCopyDifficultyInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyId = 0;
			PassedDifficulty = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopyDifficultyInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyDifficultyInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopyDifficultyInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyDifficultyInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopyDifficultyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopyDifficultyInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.CopyId, value.PassedDifficulty);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopyDifficultyInfo? value)
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
				value3 = value.CopyId;
				value4 = value.PassedDifficulty;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopyDifficultyInfo), 3, memberCount);
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
				value3 = value.CopyId;
				value4 = value.PassedDifficulty;
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
		value = new PbCopyDifficultyInfo
		{
			IsFromPool = value2,
			CopyId = value3,
			PassedDifficulty = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.PassedDifficulty = value4;
	}
}

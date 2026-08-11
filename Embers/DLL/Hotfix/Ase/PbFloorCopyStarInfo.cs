using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(421)]
[MemoryPackable(GenerateType.Object)]
public class PbFloorCopyStarInfo : MessageObject, IMemoryPackable<PbFloorCopyStarInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFloorCopyStarInfoFormatter : MemoryPackFormatter<PbFloorCopyStarInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFloorCopyStarInfo value)
		{
			PbFloorCopyStarInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFloorCopyStarInfo value)
		{
			PbFloorCopyStarInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int MaxStar { get; set; }

	[MemoryPackOrder(2)]
	public int CurrentSettingStar { get; set; }

	public static PbFloorCopyStarInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFloorCopyStarInfo)) as PbFloorCopyStarInfo;
		}
		return new PbFloorCopyStarInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyId = 0;
			MaxStar = 0;
			CurrentSettingStar = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFloorCopyStarInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorCopyStarInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFloorCopyStarInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFloorCopyStarInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFloorCopyStarInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFloorCopyStarInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.CopyId, value.MaxStar, value.CurrentSettingStar);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFloorCopyStarInfo? value)
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
				value4 = value.MaxStar;
				value5 = value.CurrentSettingStar;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFloorCopyStarInfo), 4, memberCount);
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
				value4 = value.MaxStar;
				value5 = value.CurrentSettingStar;
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
		value = new PbFloorCopyStarInfo
		{
			IsFromPool = value2,
			CopyId = value3,
			MaxStar = value4,
			CurrentSettingStar = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.MaxStar = value4;
		value.CurrentSettingStar = value5;
	}
}

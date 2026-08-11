using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(401)]
[MemoryPackable(GenerateType.Object)]
public class PbMedalInfo : MessageObject, IMemoryPackable<PbMedalInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMedalInfoFormatter : MemoryPackFormatter<PbMedalInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMedalInfo value)
		{
			PbMedalInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMedalInfo value)
		{
			PbMedalInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int MedalId { get; set; }

	[MemoryPackOrder(1)]
	public int Rank { get; set; }

	[MemoryPackOrder(2)]
	public int Tag { get; set; }

	public static PbMedalInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMedalInfo)) as PbMedalInfo;
		}
		return new PbMedalInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			MedalId = 0;
			Rank = 0;
			Tag = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMedalInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMedalInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbMedalInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMedalInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMedalInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMedalInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.MedalId, value.Rank, value.Tag);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMedalInfo? value)
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
				value3 = value.MedalId;
				value4 = value.Rank;
				value5 = value.Tag;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMedalInfo), 4, memberCount);
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
				value3 = value.MedalId;
				value4 = value.Rank;
				value5 = value.Tag;
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
		value = new PbMedalInfo
		{
			IsFromPool = value2,
			MedalId = value3,
			Rank = value4,
			Tag = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.MedalId = value3;
		value.Rank = value4;
		value.Tag = value5;
	}
}

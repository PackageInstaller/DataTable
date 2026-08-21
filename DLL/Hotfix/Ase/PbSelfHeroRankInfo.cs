using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(405)]
[MemoryPackable(GenerateType.Object)]
public class PbSelfHeroRankInfo : MessageObject, IMemoryPackable<PbSelfHeroRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSelfHeroRankInfoFormatter : MemoryPackFormatter<PbSelfHeroRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSelfHeroRankInfo value)
		{
			PbSelfHeroRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSelfHeroRankInfo value)
		{
			PbSelfHeroRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int RoleId { get; set; }

	[MemoryPackOrder(1)]
	public int Score { get; set; }

	[MemoryPackOrder(2)]
	public int Rank { get; set; }

	[MemoryPackOrder(3)]
	public int Skin { get; set; }

	public static PbSelfHeroRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSelfHeroRankInfo)) as PbSelfHeroRankInfo;
		}
		return new PbSelfHeroRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RoleId = 0;
			Score = 0;
			Rank = 0;
			Skin = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSelfHeroRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSelfHeroRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSelfHeroRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSelfHeroRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSelfHeroRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSelfHeroRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(5, value.IsFromPool, value.RoleId, value.Score, value.Rank, value.Skin);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSelfHeroRankInfo? value)
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
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Score;
				value5 = value.Rank;
				value6 = value.Skin;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0117;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSelfHeroRankInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Score;
				value5 = value.Rank;
				value6 = value.Skin;
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
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0117;
			}
		}
		value = new PbSelfHeroRankInfo
		{
			IsFromPool = value2,
			RoleId = value3,
			Score = value4,
			Rank = value5,
			Skin = value6
		};
		return;
		IL_0117:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.Score = value4;
		value.Rank = value5;
		value.Skin = value6;
	}
}

using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10874)]
[MemoryPackable(GenerateType.Object)]
public class S2C_RankListNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<S2C_RankListNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_RankListNotifyFormatter : MemoryPackFormatter<S2C_RankListNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_RankListNotify value)
		{
			S2C_RankListNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_RankListNotify value)
		{
			S2C_RankListNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int PageIndex { get; set; }

	[MemoryPackOrder(1)]
	public int TotalPage { get; set; }

	[MemoryPackOrder(2)]
	public List<PbRaceCopyRankInfo> RaceCopyRankInfos { get; set; } = new List<PbRaceCopyRankInfo>();

	[MemoryPackOrder(3)]
	public List<PbSuitboxCopyRankInfo> SuitboxCopyRankInfos { get; set; } = new List<PbSuitboxCopyRankInfo>();

	[MemoryPackOrder(4)]
	public List<PbHeroRankInfo> HeroRankInfos { get; set; } = new List<PbHeroRankInfo>();

	[MemoryPackOrder(5)]
	public List<PbChallengeCopyRankInfo> ChallengeCopyRankInfos { get; set; } = new List<PbChallengeCopyRankInfo>();

	public static S2C_RankListNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_RankListNotify)) as S2C_RankListNotify;
		}
		return new S2C_RankListNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			PageIndex = 0;
			TotalPage = 0;
			RaceCopyRankInfos.Clear();
			SuitboxCopyRankInfos.Clear();
			HeroRankInfos.Clear();
			ChallengeCopyRankInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_RankListNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_RankListNotify>())
		{
			MemoryPackFormatterProvider.Register(new S2C_RankListNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_RankListNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_RankListNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRaceCopyRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRaceCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSuitboxCopyRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSuitboxCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbHeroRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbHeroRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbChallengeCopyRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbChallengeCopyRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_RankListNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(9, value.IsFromPool, value.PageIndex, value.TotalPage);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRaceCopyRankInfo>>(value.RaceCopyRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSuitboxCopyRankInfo>>(value.SuitboxCopyRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbHeroRankInfo>>(value.HeroRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbChallengeCopyRankInfo>>(value.ChallengeCopyRankInfos));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_RankListNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<PbRaceCopyRankInfo> value5;
		List<PbSuitboxCopyRankInfo> value6;
		List<PbHeroRankInfo> value7;
		List<PbChallengeCopyRankInfo> value8;
		int value9;
		long value10;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PageIndex;
				value4 = value.TotalPage;
				value5 = value.RaceCopyRankInfos;
				value6 = value.SuitboxCopyRankInfos;
				value7 = value.HeroRankInfos;
				value8 = value.ChallengeCopyRankInfos;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				ListFormatter.DeserializePackable(ref reader, ref value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01e9;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbRaceCopyRankInfo>(ref reader);
			value6 = ListFormatter.DeserializePackable<PbSuitboxCopyRankInfo>(ref reader);
			value7 = ListFormatter.DeserializePackable<PbHeroRankInfo>(ref reader);
			value8 = ListFormatter.DeserializePackable<PbChallengeCopyRankInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_RankListNotify), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = null;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PageIndex;
				value4 = value.TotalPage;
				value5 = value.RaceCopyRankInfos;
				value6 = value.SuitboxCopyRankInfos;
				value7 = value.HeroRankInfos;
				value8 = value.ChallengeCopyRankInfos;
				value9 = value.RpcId;
				value10 = value.ActorId;
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
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										ListFormatter.DeserializePackable(ref reader, ref value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												_ = 9;
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
				goto IL_01e9;
			}
		}
		value = new S2C_RankListNotify
		{
			IsFromPool = value2,
			PageIndex = value3,
			TotalPage = value4,
			RaceCopyRankInfos = value5,
			SuitboxCopyRankInfos = value6,
			HeroRankInfos = value7,
			ChallengeCopyRankInfos = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_01e9:
		value.IsFromPool = value2;
		value.PageIndex = value3;
		value.TotalPage = value4;
		value.RaceCopyRankInfos = value5;
		value.SuitboxCopyRankInfos = value6;
		value.HeroRankInfos = value7;
		value.ChallengeCopyRankInfos = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}

using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(415)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionMemberRankInfo : MessageObject, IMemoryPackable<PbUnionMemberRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionMemberRankInfoFormatter : MemoryPackFormatter<PbUnionMemberRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionMemberRankInfo value)
		{
			PbUnionMemberRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionMemberRankInfo value)
		{
			PbUnionMemberRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Icon { get; set; }

	[MemoryPackOrder(1)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	[MemoryPackOrder(3)]
	public long UserId { get; set; }

	[MemoryPackOrder(4)]
	public int CopyType { get; set; }

	[MemoryPackOrder(5)]
	public int Score { get; set; }

	[MemoryPackOrder(6)]
	public int Rank { get; set; }

	[MemoryPackOrder(7)]
	public string UserName { get; set; }

	[MemoryPackOrder(8)]
	public int Title { get; set; }

	public static PbUnionMemberRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionMemberRankInfo)) as PbUnionMemberRankInfo;
		}
		return new PbUnionMemberRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Icon = 0;
			IconFrame = 0;
			Level = 0;
			UserId = 0L;
			CopyType = 0;
			Score = 0;
			Rank = 0;
			UserName = null;
			Title = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionMemberRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionMemberRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionMemberRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionMemberRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionMemberRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionMemberRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, long, int, int, int>(10, value.IsFromPool, value.Icon, value.IconFrame, value.Level, value.UserId, value.CopyType, value.Score, value.Rank);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int>(value.Title);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionMemberRankInfo? value)
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
		long value6;
		int value7;
		int value8;
		int value9;
		int value10;
		string userName;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.UserId;
				value7 = value.CopyType;
				value8 = value.Score;
				value9 = value.Rank;
				userName = value.UserName;
				value10 = value.Title;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value10);
				goto IL_0203;
			}
			reader.ReadUnmanaged<bool, int, int, int, long, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int>(out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionMemberRankInfo), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				userName = null;
				value10 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.UserId;
				value7 = value.CopyType;
				value8 = value.Score;
				value9 = value.Rank;
				userName = value.UserName;
				value10 = value.Title;
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
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												userName = reader.ReadString();
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value10);
													_ = 10;
												}
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
				goto IL_0203;
			}
		}
		value = new PbUnionMemberRankInfo
		{
			IsFromPool = value2,
			Icon = value3,
			IconFrame = value4,
			Level = value5,
			UserId = value6,
			CopyType = value7,
			Score = value8,
			Rank = value9,
			UserName = userName,
			Title = value10
		};
		return;
		IL_0203:
		value.IsFromPool = value2;
		value.Icon = value3;
		value.IconFrame = value4;
		value.Level = value5;
		value.UserId = value6;
		value.CopyType = value7;
		value.Score = value8;
		value.Rank = value9;
		value.UserName = userName;
		value.Title = value10;
	}
}

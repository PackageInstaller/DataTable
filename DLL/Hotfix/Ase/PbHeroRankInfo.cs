using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(404)]
[MemoryPackable(GenerateType.Object)]
public class PbHeroRankInfo : MessageObject, IMemoryPackable<PbHeroRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbHeroRankInfoFormatter : MemoryPackFormatter<PbHeroRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbHeroRankInfo value)
		{
			PbHeroRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbHeroRankInfo value)
		{
			PbHeroRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Icon { get; set; }

	[MemoryPackOrder(1)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	[MemoryPackOrder(4)]
	public long UserId { get; set; }

	[MemoryPackOrder(5)]
	public int RoleId { get; set; }

	[MemoryPackOrder(6)]
	public int Score { get; set; }

	[MemoryPackOrder(7)]
	public int Rank { get; set; }

	[MemoryPackOrder(8)]
	public string UserName { get; set; }

	[MemoryPackOrder(9)]
	public int Title { get; set; }

	[MemoryPackOrder(10)]
	public int Skin { get; set; }

	public static PbHeroRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbHeroRankInfo)) as PbHeroRankInfo;
		}
		return new PbHeroRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Icon = 0;
			IconFrame = 0;
			Level = 0;
			UserId = 0L;
			RoleId = 0;
			Score = 0;
			Rank = 0;
			UserName = null;
			Title = 0;
			Skin = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbHeroRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbHeroRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbHeroRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbHeroRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbHeroRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbHeroRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, long, int, int, int>(11, value.IsFromPool, value.Icon, value.IconFrame, value.Level, value.UserId, value.RoleId, value.Score, value.Rank);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int>(value.Title, value.Skin);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbHeroRankInfo? value)
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
		int value11;
		string userName;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.UserId;
				value7 = value.RoleId;
				value8 = value.Score;
				value9 = value.Rank;
				userName = value.UserName;
				value10 = value.Title;
				value11 = value.Skin;
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
				reader.ReadUnmanaged<int>(out value11);
				goto IL_0232;
			}
			reader.ReadUnmanaged<bool, int, int, int, long, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value10, out value11);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbHeroRankInfo), 11, memberCount);
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
				value11 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.UserId;
				value7 = value.RoleId;
				value8 = value.Score;
				value9 = value.Rank;
				userName = value.UserName;
				value10 = value.Title;
				value11 = value.Skin;
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
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value11);
														_ = 11;
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
			}
			if (value != null)
			{
				goto IL_0232;
			}
		}
		value = new PbHeroRankInfo
		{
			IsFromPool = value2,
			Icon = value3,
			IconFrame = value4,
			Level = value5,
			UserId = value6,
			RoleId = value7,
			Score = value8,
			Rank = value9,
			UserName = userName,
			Title = value10,
			Skin = value11
		};
		return;
		IL_0232:
		value.IsFromPool = value2;
		value.Icon = value3;
		value.IconFrame = value4;
		value.Level = value5;
		value.UserId = value6;
		value.RoleId = value7;
		value.Score = value8;
		value.Rank = value9;
		value.UserName = userName;
		value.Title = value10;
		value.Skin = value11;
	}
}

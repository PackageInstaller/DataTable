using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(335)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendItemInfo : MessageObject, IMemoryPackable<PbFriendItemInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendItemInfoFormatter : MemoryPackFormatter<PbFriendItemInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendItemInfo value)
		{
			PbFriendItemInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendItemInfo value)
		{
			PbFriendItemInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	[MemoryPackOrder(2)]
	public int Icon { get; set; }

	[MemoryPackOrder(3)]
	public int Vip { get; set; }

	[MemoryPackOrder(4)]
	public int Level { get; set; }

	[MemoryPackOrder(5)]
	public int Online { get; set; }

	[MemoryPackOrder(6)]
	public long LastLoginTime { get; set; }

	[MemoryPackOrder(7)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(8)]
	public int TitleId { get; set; }

	[MemoryPackOrder(9)]
	public int UserExp { get; set; }

	[MemoryPackOrder(10)]
	public List<PbNormalRoleInfo> ShowHeroes { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(11)]
	public int State { get; set; }

	[MemoryPackOrder(12)]
	public int EnergyReceiveState { get; set; }

	[MemoryPackOrder(13)]
	public int EnergySendState { get; set; }

	[MemoryPackOrder(14)]
	public int ShowUserRank { get; set; }

	[MemoryPackOrder(15)]
	public int ShowChapterStar { get; set; }

	[MemoryPackOrder(16)]
	public int HomelandLevel { get; set; }

	[MemoryPackOrder(17)]
	public List<PbMedalInfo> WearMedal { get; set; } = new List<PbMedalInfo>();

	[MemoryPackOrder(18)]
	public int MaxCopyOpenIdx { get; set; }

	[MemoryPackOrder(19)]
	public int Gender { get; set; }

	[MemoryPackOrder(20)]
	public long CreateTime { get; set; }

	[MemoryPackOrder(21)]
	public string UnionName { get; set; }

	[MemoryPackOrder(22)]
	public List<PbCopyChallengeInfo> CopyChallengeInfo { get; set; } = new List<PbCopyChallengeInfo>();

	[MemoryPackOrder(23)]
	public List<PbAchievementInfo> Achievements { get; set; } = new List<PbAchievementInfo>();

	[MemoryPackOrder(24)]
	public int PosterGirl { get; set; }

	[MemoryPackOrder(25)]
	public int Background { get; set; }

	[MemoryPackOrder(26)]
	public bool IsShowCopyInfo { get; set; }

	[MemoryPackOrder(27)]
	public long Value2 { get; set; }

	[MemoryPackOrder(28)]
	public string Value3 { get; set; }

	public static PbFriendItemInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendItemInfo)) as PbFriendItemInfo;
		}
		return new PbFriendItemInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			Name = null;
			Icon = 0;
			Vip = 0;
			Level = 0;
			Online = 0;
			LastLoginTime = 0L;
			IconFrame = 0;
			TitleId = 0;
			UserExp = 0;
			ShowHeroes.Clear();
			State = 0;
			EnergyReceiveState = 0;
			EnergySendState = 0;
			ShowUserRank = 0;
			ShowChapterStar = 0;
			HomelandLevel = 0;
			WearMedal.Clear();
			MaxCopyOpenIdx = 0;
			Gender = 0;
			CreateTime = 0L;
			UnionName = null;
			CopyChallengeInfo.Clear();
			Achievements.Clear();
			PosterGirl = 0;
			Background = 0;
			IsShowCopyInfo = false;
			Value2 = 0L;
			Value3 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendItemInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendItemInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendItemInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendItemInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendItemInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMedalInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMedalInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyChallengeInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyChallengeInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbAchievementInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbAchievementInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendItemInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(30, value.IsFromPool, value.UserId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int, int, int, long, int, int, int>(value.Icon, value.Vip, value.Level, value.Online, value.LastLoginTime, value.IconFrame, value.TitleId, value.UserExp);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.ShowHeroes));
		writer.WriteUnmanaged<int, int, int, int, int, int>(value.State, value.EnergyReceiveState, value.EnergySendState, value.ShowUserRank, value.ShowChapterStar, value.HomelandLevel);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMedalInfo>>(value.WearMedal));
		writer.WriteUnmanaged<int, int, long>(value.MaxCopyOpenIdx, value.Gender, value.CreateTime);
		writer.WriteString(value.UnionName);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyChallengeInfo>>(value.CopyChallengeInfo));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbAchievementInfo>>(value.Achievements));
		writer.WriteUnmanaged<int, int, bool, long>(value.PosterGirl, value.Background, value.IsShowCopyInfo, value.Value2);
		writer.WriteString(value.Value3);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendItemInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		int value7;
		long value8;
		int value9;
		int value10;
		int value11;
		List<PbNormalRoleInfo> value12;
		int value13;
		int value14;
		int value15;
		int value16;
		int value17;
		int value18;
		List<PbMedalInfo> value19;
		int value20;
		int value21;
		long value22;
		List<PbCopyChallengeInfo> value23;
		List<PbAchievementInfo> value24;
		int value25;
		int value26;
		bool value27;
		long value28;
		string name;
		string unionName;
		string value29;
		if (memberCount == 30)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Icon;
				value5 = value.Vip;
				value6 = value.Level;
				value7 = value.Online;
				value8 = value.LastLoginTime;
				value9 = value.IconFrame;
				value10 = value.TitleId;
				value11 = value.UserExp;
				value12 = value.ShowHeroes;
				value13 = value.State;
				value14 = value.EnergyReceiveState;
				value15 = value.EnergySendState;
				value16 = value.ShowUserRank;
				value17 = value.ShowChapterStar;
				value18 = value.HomelandLevel;
				value19 = value.WearMedal;
				value20 = value.MaxCopyOpenIdx;
				value21 = value.Gender;
				value22 = value.CreateTime;
				unionName = value.UnionName;
				value23 = value.CopyChallengeInfo;
				value24 = value.Achievements;
				value25 = value.PosterGirl;
				value26 = value.Background;
				value27 = value.IsShowCopyInfo;
				value28 = value.Value2;
				value29 = value.Value3;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				ListFormatter.DeserializePackable(ref reader, ref value12);
				reader.ReadUnmanaged<int>(out value13);
				reader.ReadUnmanaged<int>(out value14);
				reader.ReadUnmanaged<int>(out value15);
				reader.ReadUnmanaged<int>(out value16);
				reader.ReadUnmanaged<int>(out value17);
				reader.ReadUnmanaged<int>(out value18);
				ListFormatter.DeserializePackable(ref reader, ref value19);
				reader.ReadUnmanaged<int>(out value20);
				reader.ReadUnmanaged<int>(out value21);
				reader.ReadUnmanaged<long>(out value22);
				unionName = reader.ReadString();
				ListFormatter.DeserializePackable(ref reader, ref value23);
				ListFormatter.DeserializePackable(ref reader, ref value24);
				reader.ReadUnmanaged<int>(out value25);
				reader.ReadUnmanaged<int>(out value26);
				reader.ReadUnmanaged<bool>(out value27);
				reader.ReadUnmanaged<long>(out value28);
				value29 = reader.ReadString();
				goto IL_05f1;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, long, int, int, int>(out value4, out value5, out value6, out value7, out value8, out value9, out value10, out value11);
			value12 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int, int, int, int>(out value13, out value14, out value15, out value16, out value17, out value18);
			value19 = ListFormatter.DeserializePackable<PbMedalInfo>(ref reader);
			reader.ReadUnmanaged<int, int, long>(out value20, out value21, out value22);
			unionName = reader.ReadString();
			value23 = ListFormatter.DeserializePackable<PbCopyChallengeInfo>(ref reader);
			value24 = ListFormatter.DeserializePackable<PbAchievementInfo>(ref reader);
			reader.ReadUnmanaged<int, int, bool, long>(out value25, out value26, out value27, out value28);
			value29 = reader.ReadString();
		}
		else
		{
			if (memberCount > 30)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendItemInfo), 30, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				name = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0;
				value11 = 0;
				value12 = null;
				value13 = 0;
				value14 = 0;
				value15 = 0;
				value16 = 0;
				value17 = 0;
				value18 = 0;
				value19 = null;
				value20 = 0;
				value21 = 0;
				value22 = 0L;
				unionName = null;
				value23 = null;
				value24 = null;
				value25 = 0;
				value26 = 0;
				value27 = false;
				value28 = 0L;
				value29 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Icon;
				value5 = value.Vip;
				value6 = value.Level;
				value7 = value.Online;
				value8 = value.LastLoginTime;
				value9 = value.IconFrame;
				value10 = value.TitleId;
				value11 = value.UserExp;
				value12 = value.ShowHeroes;
				value13 = value.State;
				value14 = value.EnergyReceiveState;
				value15 = value.EnergySendState;
				value16 = value.ShowUserRank;
				value17 = value.ShowChapterStar;
				value18 = value.HomelandLevel;
				value19 = value.WearMedal;
				value20 = value.MaxCopyOpenIdx;
				value21 = value.Gender;
				value22 = value.CreateTime;
				unionName = value.UnionName;
				value23 = value.CopyChallengeInfo;
				value24 = value.Achievements;
				value25 = value.PosterGirl;
				value26 = value.Background;
				value27 = value.IsShowCopyInfo;
				value28 = value.Value2;
				value29 = value.Value3;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						name = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value10);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value11);
														if (memberCount != 11)
														{
															ListFormatter.DeserializePackable(ref reader, ref value12);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<int>(out value13);
																if (memberCount != 13)
																{
																	reader.ReadUnmanaged<int>(out value14);
																	if (memberCount != 14)
																	{
																		reader.ReadUnmanaged<int>(out value15);
																		if (memberCount != 15)
																		{
																			reader.ReadUnmanaged<int>(out value16);
																			if (memberCount != 16)
																			{
																				reader.ReadUnmanaged<int>(out value17);
																				if (memberCount != 17)
																				{
																					reader.ReadUnmanaged<int>(out value18);
																					if (memberCount != 18)
																					{
																						ListFormatter.DeserializePackable(ref reader, ref value19);
																						if (memberCount != 19)
																						{
																							reader.ReadUnmanaged<int>(out value20);
																							if (memberCount != 20)
																							{
																								reader.ReadUnmanaged<int>(out value21);
																								if (memberCount != 21)
																								{
																									reader.ReadUnmanaged<long>(out value22);
																									if (memberCount != 22)
																									{
																										unionName = reader.ReadString();
																										if (memberCount != 23)
																										{
																											ListFormatter.DeserializePackable(ref reader, ref value23);
																											if (memberCount != 24)
																											{
																												ListFormatter.DeserializePackable(ref reader, ref value24);
																												if (memberCount != 25)
																												{
																													reader.ReadUnmanaged<int>(out value25);
																													if (memberCount != 26)
																													{
																														reader.ReadUnmanaged<int>(out value26);
																														if (memberCount != 27)
																														{
																															reader.ReadUnmanaged<bool>(out value27);
																															if (memberCount != 28)
																															{
																																reader.ReadUnmanaged<long>(out value28);
																																if (memberCount != 29)
																																{
																																	value29 = reader.ReadString();
																																	_ = 30;
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
				goto IL_05f1;
			}
		}
		value = new PbFriendItemInfo
		{
			IsFromPool = value2,
			UserId = value3,
			Name = name,
			Icon = value4,
			Vip = value5,
			Level = value6,
			Online = value7,
			LastLoginTime = value8,
			IconFrame = value9,
			TitleId = value10,
			UserExp = value11,
			ShowHeroes = value12,
			State = value13,
			EnergyReceiveState = value14,
			EnergySendState = value15,
			ShowUserRank = value16,
			ShowChapterStar = value17,
			HomelandLevel = value18,
			WearMedal = value19,
			MaxCopyOpenIdx = value20,
			Gender = value21,
			CreateTime = value22,
			UnionName = unionName,
			CopyChallengeInfo = value23,
			Achievements = value24,
			PosterGirl = value25,
			Background = value26,
			IsShowCopyInfo = value27,
			Value2 = value28,
			Value3 = value29
		};
		return;
		IL_05f1:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Name = name;
		value.Icon = value4;
		value.Vip = value5;
		value.Level = value6;
		value.Online = value7;
		value.LastLoginTime = value8;
		value.IconFrame = value9;
		value.TitleId = value10;
		value.UserExp = value11;
		value.ShowHeroes = value12;
		value.State = value13;
		value.EnergyReceiveState = value14;
		value.EnergySendState = value15;
		value.ShowUserRank = value16;
		value.ShowChapterStar = value17;
		value.HomelandLevel = value18;
		value.WearMedal = value19;
		value.MaxCopyOpenIdx = value20;
		value.Gender = value21;
		value.CreateTime = value22;
		value.UnionName = unionName;
		value.CopyChallengeInfo = value23;
		value.Achievements = value24;
		value.PosterGirl = value25;
		value.Background = value26;
		value.IsShowCopyInfo = value27;
		value.Value2 = value28;
		value.Value3 = value29;
	}
}

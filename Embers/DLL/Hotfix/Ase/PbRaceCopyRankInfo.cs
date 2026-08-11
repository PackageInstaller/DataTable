using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(394)]
[MemoryPackable(GenerateType.Object)]
public class PbRaceCopyRankInfo : MessageObject, IMemoryPackable<PbRaceCopyRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRaceCopyRankInfoFormatter : MemoryPackFormatter<PbRaceCopyRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRaceCopyRankInfo value)
		{
			PbRaceCopyRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRaceCopyRankInfo value)
		{
			PbRaceCopyRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Icon { get; set; }

	[MemoryPackOrder(1)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	[MemoryPackOrder(3)]
	public List<int> RoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public long UserId { get; set; }

	[MemoryPackOrder(5)]
	public int CopyType { get; set; }

	[MemoryPackOrder(6)]
	public int Score { get; set; }

	[MemoryPackOrder(7)]
	public int Rank { get; set; }

	[MemoryPackOrder(8)]
	public string UserName { get; set; }

	[MemoryPackOrder(9)]
	public int Title { get; set; }

	public static PbRaceCopyRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRaceCopyRankInfo)) as PbRaceCopyRankInfo;
		}
		return new PbRaceCopyRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Icon = 0;
			IconFrame = 0;
			Level = 0;
			RoleIds.Clear();
			UserId = 0L;
			CopyType = 0;
			Score = 0;
			Rank = 0;
			UserName = null;
			Title = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRaceCopyRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRaceCopyRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRaceCopyRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRaceCopyRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRaceCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRaceCopyRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(11, value.IsFromPool, value.Icon, value.IconFrame, value.Level);
		writer.WriteValue<List<int>>(value.RoleIds);
		writer.WriteUnmanaged<long, int, int, int>(value.UserId, value.CopyType, value.Score, value.Rank);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int>(value.Title);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRaceCopyRankInfo? value)
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
		List<int> value6;
		long value7;
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
				value6 = value.RoleIds;
				value7 = value.UserId;
				value8 = value.CopyType;
				value9 = value.Score;
				value10 = value.Rank;
				userName = value.UserName;
				value11 = value.Title;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadValue(ref value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value11);
				goto IL_023e;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			value6 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<long, int, int, int>(out value7, out value8, out value9, out value10);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int>(out value11);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRaceCopyRankInfo), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0L;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				userName = null;
				value11 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.RoleIds;
				value7 = value.UserId;
				value8 = value.CopyType;
				value9 = value.Score;
				value10 = value.Rank;
				userName = value.UserName;
				value11 = value.Title;
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
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													userName = reader.ReadString();
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
				goto IL_023e;
			}
		}
		value = new PbRaceCopyRankInfo
		{
			IsFromPool = value2,
			Icon = value3,
			IconFrame = value4,
			Level = value5,
			RoleIds = value6,
			UserId = value7,
			CopyType = value8,
			Score = value9,
			Rank = value10,
			UserName = userName,
			Title = value11
		};
		return;
		IL_023e:
		value.IsFromPool = value2;
		value.Icon = value3;
		value.IconFrame = value4;
		value.Level = value5;
		value.RoleIds = value6;
		value.UserId = value7;
		value.CopyType = value8;
		value.Score = value9;
		value.Rank = value10;
		value.UserName = userName;
		value.Title = value11;
	}
}

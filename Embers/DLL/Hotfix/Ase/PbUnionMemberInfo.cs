using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(380)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionMemberInfo : MessageObject, IMemoryPackable<PbUnionMemberInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionMemberInfoFormatter : MemoryPackFormatter<PbUnionMemberInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionMemberInfo value)
		{
			PbUnionMemberInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionMemberInfo value)
		{
			PbUnionMemberInfo.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(11)]
	public int State { get; set; }

	[MemoryPackOrder(17)]
	public int WeeklyActivePoint { get; set; }

	[MemoryPackOrder(18)]
	public int TotalActivePoint { get; set; }

	[MemoryPackOrder(19)]
	public int Position { get; set; }

	[MemoryPackOrder(20)]
	public long EnterTime { get; set; }

	public static PbUnionMemberInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionMemberInfo)) as PbUnionMemberInfo;
		}
		return new PbUnionMemberInfo();
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
			State = 0;
			WeeklyActivePoint = 0;
			TotalActivePoint = 0;
			Position = 0;
			EnterTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionMemberInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionMemberInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionMemberInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionMemberInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionMemberInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionMemberInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(15, value.IsFromPool, value.UserId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int, int, int, long, int, int, int, int, int, int, long>(value.Icon, value.Vip, value.Level, value.Online, value.LastLoginTime, value.IconFrame, value.TitleId, value.State, value.WeeklyActivePoint, value.TotalActivePoint, value.Position, value.EnterTime);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionMemberInfo? value)
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
		int value12;
		int value13;
		int value14;
		long value15;
		string name;
		if (memberCount == 15)
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
				value11 = value.State;
				value12 = value.WeeklyActivePoint;
				value13 = value.TotalActivePoint;
				value14 = value.Position;
				value15 = value.EnterTime;
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
				reader.ReadUnmanaged<int>(out value12);
				reader.ReadUnmanaged<int>(out value13);
				reader.ReadUnmanaged<int>(out value14);
				reader.ReadUnmanaged<long>(out value15);
				goto IL_02f3;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, long, int, int, int, int, int, int, long>(out value4, out value5, out value6, out value7, out value8, out value9, out value10, out value11, out value12, out value13, out value14, out value15);
		}
		else
		{
			if (memberCount > 15)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionMemberInfo), 15, memberCount);
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
				value12 = 0;
				value13 = 0;
				value14 = 0;
				value15 = 0L;
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
				value11 = value.State;
				value12 = value.WeeklyActivePoint;
				value13 = value.TotalActivePoint;
				value14 = value.Position;
				value15 = value.EnterTime;
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
															reader.ReadUnmanaged<int>(out value12);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<int>(out value13);
																if (memberCount != 13)
																{
																	reader.ReadUnmanaged<int>(out value14);
																	if (memberCount != 14)
																	{
																		reader.ReadUnmanaged<long>(out value15);
																		_ = 15;
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
				goto IL_02f3;
			}
		}
		value = new PbUnionMemberInfo
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
			State = value11,
			WeeklyActivePoint = value12,
			TotalActivePoint = value13,
			Position = value14,
			EnterTime = value15
		};
		return;
		IL_02f3:
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
		value.State = value11;
		value.WeeklyActivePoint = value12;
		value.TotalActivePoint = value13;
		value.Position = value14;
		value.EnterTime = value15;
	}
}

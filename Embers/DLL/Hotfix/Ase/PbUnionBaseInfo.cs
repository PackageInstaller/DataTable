using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(376)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionBaseInfo : MessageObject, IMemoryPackable<PbUnionBaseInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionBaseInfoFormatter : MemoryPackFormatter<PbUnionBaseInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionBaseInfo value)
		{
			PbUnionBaseInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionBaseInfo value)
		{
			PbUnionBaseInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	[MemoryPackOrder(2)]
	public int Flag { get; set; }

	[MemoryPackOrder(3)]
	public int Icon { get; set; }

	[MemoryPackOrder(4)]
	public int Level { get; set; }

	[MemoryPackOrder(5)]
	public int LevelLimit { get; set; }

	[MemoryPackOrder(6)]
	public int Examine { get; set; }

	[MemoryPackOrder(7)]
	public int MemberCount { get; set; }

	[MemoryPackOrder(8)]
	public string Declaration { get; set; }

	[MemoryPackOrder(9)]
	public PbUnionLeaderInfo LeaderInfo { get; set; }

	public static PbUnionBaseInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionBaseInfo)) as PbUnionBaseInfo;
		}
		return new PbUnionBaseInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UnionId = 0L;
			Name = null;
			Flag = 0;
			Icon = 0;
			Level = 0;
			LevelLimit = 0;
			Examine = 0;
			MemberCount = 0;
			Declaration = null;
			LeaderInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionBaseInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionBaseInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionBaseInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionBaseInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionBaseInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionBaseInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(11, value.IsFromPool, value.UnionId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int, int, int, int, int>(value.Flag, value.Icon, value.Level, value.LevelLimit, value.Examine, value.MemberCount);
		writer.WriteString(value.Declaration);
		writer.WritePackable<PbUnionLeaderInfo>(value.LeaderInfo);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionBaseInfo? value)
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
		int value8;
		int value9;
		PbUnionLeaderInfo value10;
		string name;
		string declaration;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				name = value.Name;
				value4 = value.Flag;
				value5 = value.Icon;
				value6 = value.Level;
				value7 = value.LevelLimit;
				value8 = value.Examine;
				value9 = value.MemberCount;
				declaration = value.Declaration;
				value10 = value.LeaderInfo;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				declaration = reader.ReadString();
				reader.ReadPackable(ref value10);
				goto IL_023b;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, int, int>(out value4, out value5, out value6, out value7, out value8, out value9);
			declaration = reader.ReadString();
			value10 = reader.ReadPackable<PbUnionLeaderInfo>();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionBaseInfo), 11, memberCount);
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
				value8 = 0;
				value9 = 0;
				declaration = null;
				value10 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				name = value.Name;
				value4 = value.Flag;
				value5 = value.Icon;
				value6 = value.Level;
				value7 = value.LevelLimit;
				value8 = value.Examine;
				value9 = value.MemberCount;
				declaration = value.Declaration;
				value10 = value.LeaderInfo;
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
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													declaration = reader.ReadString();
													if (memberCount != 10)
													{
														reader.ReadPackable(ref value10);
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
				goto IL_023b;
			}
		}
		value = new PbUnionBaseInfo
		{
			IsFromPool = value2,
			UnionId = value3,
			Name = name,
			Flag = value4,
			Icon = value5,
			Level = value6,
			LevelLimit = value7,
			Examine = value8,
			MemberCount = value9,
			Declaration = declaration,
			LeaderInfo = value10
		};
		return;
		IL_023b:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.Name = name;
		value.Flag = value4;
		value.Icon = value5;
		value.Level = value6;
		value.LevelLimit = value7;
		value.Examine = value8;
		value.MemberCount = value9;
		value.Declaration = declaration;
		value.LeaderInfo = value10;
	}
}

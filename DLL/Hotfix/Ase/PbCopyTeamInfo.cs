using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(319)]
[MemoryPackable(GenerateType.Object)]
public class PbCopyTeamInfo : MessageObject, IMemoryPackable<PbCopyTeamInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopyTeamInfoFormatter : MemoryPackFormatter<PbCopyTeamInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopyTeamInfo value)
		{
			PbCopyTeamInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopyTeamInfo value)
		{
			PbCopyTeamInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string UserName { get; set; }

	[MemoryPackOrder(2)]
	public int RoleId { get; set; }

	[MemoryPackOrder(3)]
	public int Level { get; set; }

	[MemoryPackOrder(4)]
	public int Icon { get; set; }

	[MemoryPackOrder(5)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(6)]
	public int Title { get; set; }

	[MemoryPackOrder(7)]
	public bool IsFrist { get; set; }

	[MemoryPackOrder(8)]
	public int Skin { get; set; }

	public static PbCopyTeamInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopyTeamInfo)) as PbCopyTeamInfo;
		}
		return new PbCopyTeamInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			UserName = null;
			RoleId = 0;
			Level = 0;
			Icon = 0;
			IconFrame = 0;
			Title = 0;
			IsFrist = false;
			Skin = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopyTeamInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyTeamInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopyTeamInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyTeamInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopyTeamInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopyTeamInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(10, value.IsFromPool, value.UserId);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int, int, int, int, bool, int>(value.RoleId, value.Level, value.Icon, value.IconFrame, value.Title, value.IsFrist, value.Skin);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopyTeamInfo? value)
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
		bool value9;
		int value10;
		string userName;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.RoleId;
				value5 = value.Level;
				value6 = value.Icon;
				value7 = value.IconFrame;
				value8 = value.Title;
				value9 = value.IsFrist;
				value10 = value.Skin;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<bool>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				goto IL_0200;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, int, bool, int>(out value4, out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopyTeamInfo), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				userName = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = false;
				value10 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.RoleId;
				value5 = value.Level;
				value6 = value.Icon;
				value7 = value.IconFrame;
				value8 = value.Title;
				value9 = value.IsFrist;
				value10 = value.Skin;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						userName = reader.ReadString();
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
												reader.ReadUnmanaged<bool>(out value9);
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
				goto IL_0200;
			}
		}
		value = new PbCopyTeamInfo
		{
			IsFromPool = value2,
			UserId = value3,
			UserName = userName,
			RoleId = value4,
			Level = value5,
			Icon = value6,
			IconFrame = value7,
			Title = value8,
			IsFrist = value9,
			Skin = value10
		};
		return;
		IL_0200:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserName = userName;
		value.RoleId = value4;
		value.Level = value5;
		value.Icon = value6;
		value.IconFrame = value7;
		value.Title = value8;
		value.IsFrist = value9;
		value.Skin = value10;
	}
}

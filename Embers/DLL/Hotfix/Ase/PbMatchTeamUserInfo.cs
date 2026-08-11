using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(343)]
[MemoryPackable(GenerateType.Object)]
public class PbMatchTeamUserInfo : MessageObject, IMemoryPackable<PbMatchTeamUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMatchTeamUserInfoFormatter : MemoryPackFormatter<PbMatchTeamUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMatchTeamUserInfo value)
		{
			PbMatchTeamUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMatchTeamUserInfo value)
		{
			PbMatchTeamUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public string Name { get; set; }

	[MemoryPackOrder(1)]
	public int Level { get; set; }

	[MemoryPackOrder(2)]
	public int SelectRoleId { get; set; }

	[MemoryPackOrder(3)]
	public int Vip { get; set; }

	[MemoryPackOrder(4)]
	public int Icon { get; set; }

	[MemoryPackOrder(5)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(6)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(7)]
	public int Title { get; set; }

	[MemoryPackOrder(8)]
	public long UserId { get; set; }

	public static PbMatchTeamUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMatchTeamUserInfo)) as PbMatchTeamUserInfo;
		}
		return new PbMatchTeamUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Name = null;
			Level = 0;
			SelectRoleId = 0;
			Vip = 0;
			Icon = 0;
			SelectModel = 0;
			IconFrame = 0;
			Title = 0;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMatchTeamUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMatchTeamUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbMatchTeamUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMatchTeamUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMatchTeamUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMatchTeamUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int, int, int, int, int, int, long>(value.Level, value.SelectRoleId, value.Vip, value.Icon, value.SelectModel, value.IconFrame, value.Title, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMatchTeamUserInfo? value)
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
		int value7;
		int value8;
		int value9;
		long value10;
		string name;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				name = value.Name;
				value3 = value.Level;
				value4 = value.SelectRoleId;
				value5 = value.Vip;
				value6 = value.Icon;
				value7 = value.SelectModel;
				value8 = value.IconFrame;
				value9 = value.Title;
				value10 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_0200;
			}
			reader.ReadUnmanaged<bool>(out value2);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, int, int, int, long>(out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMatchTeamUserInfo), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				name = null;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				name = value.Name;
				value3 = value.Level;
				value4 = value.SelectRoleId;
				value5 = value.Vip;
				value6 = value.Icon;
				value7 = value.SelectModel;
				value8 = value.IconFrame;
				value9 = value.Title;
				value10 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					name = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
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
													reader.ReadUnmanaged<long>(out value10);
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
		value = new PbMatchTeamUserInfo
		{
			IsFromPool = value2,
			Name = name,
			Level = value3,
			SelectRoleId = value4,
			Vip = value5,
			Icon = value6,
			SelectModel = value7,
			IconFrame = value8,
			Title = value9,
			UserId = value10
		};
		return;
		IL_0200:
		value.IsFromPool = value2;
		value.Name = name;
		value.Level = value3;
		value.SelectRoleId = value4;
		value.Vip = value5;
		value.Icon = value6;
		value.SelectModel = value7;
		value.IconFrame = value8;
		value.Title = value9;
		value.UserId = value10;
	}
}

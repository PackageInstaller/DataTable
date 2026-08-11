using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(398)]
[MemoryPackable(GenerateType.Object)]
public class PbSuitboxCopyRankSingleUserInfo : MessageObject, IMemoryPackable<PbSuitboxCopyRankSingleUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSuitboxCopyRankSingleUserInfoFormatter : MemoryPackFormatter<PbSuitboxCopyRankSingleUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSuitboxCopyRankSingleUserInfo value)
		{
			PbSuitboxCopyRankSingleUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSuitboxCopyRankSingleUserInfo value)
		{
			PbSuitboxCopyRankSingleUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	[MemoryPackOrder(2)]
	public int Title { get; set; }

	[MemoryPackOrder(3)]
	public int SelectRoleId { get; set; }

	[MemoryPackOrder(4)]
	public int Skin { get; set; }

	[MemoryPackOrder(5)]
	public int Icon { get; set; }

	[MemoryPackOrder(6)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(7)]
	public int Level { get; set; }

	[MemoryPackOrder(8)]
	public List<int> RoleIds { get; set; } = new List<int>();

	public static PbSuitboxCopyRankSingleUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSuitboxCopyRankSingleUserInfo)) as PbSuitboxCopyRankSingleUserInfo;
		}
		return new PbSuitboxCopyRankSingleUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			Name = null;
			Title = 0;
			SelectRoleId = 0;
			Skin = 0;
			Icon = 0;
			IconFrame = 0;
			Level = 0;
			RoleIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSuitboxCopyRankSingleUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitboxCopyRankSingleUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSuitboxCopyRankSingleUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitboxCopyRankSingleUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSuitboxCopyRankSingleUserInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSuitboxCopyRankSingleUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(10, value.IsFromPool, value.UserId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int, int, int, int, int>(value.Title, value.SelectRoleId, value.Skin, value.Icon, value.IconFrame, value.Level);
		writer.WriteValue<List<int>>(value.RoleIds);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSuitboxCopyRankSingleUserInfo? value)
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
		List<int> value10;
		string name;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Title;
				value5 = value.SelectRoleId;
				value6 = value.Skin;
				value7 = value.Icon;
				value8 = value.IconFrame;
				value9 = value.Level;
				value10 = value.RoleIds;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadValue(ref value10);
				goto IL_0206;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, int, int>(out value4, out value5, out value6, out value7, out value8, out value9);
			value10 = reader.ReadValue<List<int>>();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSuitboxCopyRankSingleUserInfo), 10, memberCount);
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
				value10 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Title;
				value5 = value.SelectRoleId;
				value6 = value.Skin;
				value7 = value.Icon;
				value8 = value.IconFrame;
				value9 = value.Level;
				value10 = value.RoleIds;
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
													reader.ReadValue(ref value10);
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
				goto IL_0206;
			}
		}
		value = new PbSuitboxCopyRankSingleUserInfo
		{
			IsFromPool = value2,
			UserId = value3,
			Name = name,
			Title = value4,
			SelectRoleId = value5,
			Skin = value6,
			Icon = value7,
			IconFrame = value8,
			Level = value9,
			RoleIds = value10
		};
		return;
		IL_0206:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Name = name;
		value.Title = value4;
		value.SelectRoleId = value5;
		value.Skin = value6;
		value.Icon = value7;
		value.IconFrame = value8;
		value.Level = value9;
		value.RoleIds = value10;
	}
}
